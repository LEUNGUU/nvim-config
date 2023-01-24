vim.api.nvim_exec([[
augroup badge_lua_cache
	autocmd!
	autocmd BufWritePre,FileChangedShellPost,TextChanged,InsertLeave * unlet! b:badge_cache_trails
	autocmd BufReadPost,BufFilePost,BufNewFile,BufWritePost * unlet! b:badge_cache_filepath | unlet! b:badge_cache_icon
augroup END
]], false)

local badge = {}

function badge.filepath(max_dirs, dir_max_chars)
	return function()
		local msg = ''
		-- local ft = vim.bo.filetype
		local name = vim.fn.expand('%:~:.')
		local cache_key = 'badge_cache_filepath' -- _'..ft
		local cache_ok, cache = pcall(vim.api.nvim_buf_get_var, 0, cache_key)

		if cache_ok then
			return cache
		elseif name:len() < 1 then
			return 'N/A'
		end

		local i = 0
		local parts = {}
		local iter = string.gmatch(name, '([^/]+)')
		for dir in iter do
			table.insert(parts, dir)
		end
		while #parts > 1 do
			local dir = table.remove(parts, 1)
			if #parts <= max_dirs then
				dir = string.sub(dir, 0, dir_max_chars)
				if i > 0 then
					msg = msg .. '/'
				end
				msg = msg .. dir
				i = i + 1
			end
		end
		if i > 0 then
			msg = msg .. '/'
		end
		msg = msg .. table.concat(parts, '/')
		vim.api.nvim_buf_set_var(0, cache_key, msg)

		return msg
	end
end

function badge.filemode(normal_symbol, readonly_symbol, zoom_symbol)
	return function()
		local msg = ''
		if not (vim.bo.readonly or vim.t.zoomed) then
			msg = msg .. normal_symbol
		end
		if vim.bo.buftype == '' and vim.bo.readonly then
			msg = msg .. readonly_symbol
		end
		if vim.t.zoomed then
			msg = msg .. zoom_symbol
		end
		return msg
	end
end

function badge.filemedia(separator)
	return function()
		local parts = {}
		if vim.bo.fileformat ~= '' and vim.bo.fileformat ~= 'unix' then
			table.insert(parts, vim.bo.fileformat)
		end
		if vim.bo.fileencoding ~= '' and vim.bo.fileencoding ~= 'utf-8' then
			table.insert(parts, vim.bo.fileencoding)
		end
		if vim.bo.filetype ~= '' then
			table.insert(parts, vim.bo.filetype)
		end
		return table.concat(parts, separator)
	end
end

function badge.modified(symbol)
	return function()
		if vim.bo.modified then
			return symbol
		end
		return ''
	end
end

function badge.icon()
	return function()
		local ft = vim.bo.filetype
		if #ft < 1 then
			return ''
		end

		local cache_key = 'badge_cache_icon' -- _'..ft
		local cache_ok, cache = pcall(vim.api.nvim_buf_get_var, 0, cache_key)
		if cache_ok then
			return cache
		end

		local icon = ''
		-- TODO: Add general utilities icons
		-- Try kyazdani42/nvim-web-devicons
		local ok, devicons = pcall(require, 'nvim-web-devicons')
		if ok then
			local f_name, f_extension = vim.fn.expand('%:t'), vim.fn.expand('%:e')
			icon, _ = devicons.get_icon(f_name, f_extension)
		else
			-- Try ryanoasis/vim-devicons
			ok = vim.fn.exists('*WebDevIconsGetFileTypeSymbol')
			if ok ~= 0 then
				icon = vim.fn.WebDevIconsGetFileTypeSymbol()
			else
				-- Try lambdalisue/nerdfont.vim
				ok = vim.fn.exists('*nerdfont#find')
				if ok ~= 0 then
					icon = vim.fn['nerdfont#find'](vim.fn.bufname())
				end
			end
		end
		if icon == nil then
			icon = ''
		end
		vim.api.nvim_buf_set_var(0, cache_key, icon)

		return icon
	end
end

-- Detect trailing whitespace and cache result per buffer
function badge.trails(symbol)
	return function()
		local cache_key = 'badge_cache_trails'
		local cache_ok, cache = pcall(vim.api.nvim_buf_get_var, 0, cache_key)
		if cache_ok then
			return cache
		end

		local msg = ''
		if
			not vim.bo.readonly
			and vim.bo.modifiable
			and vim.fn.line('$') < 9000
		then
			local trailing = vim.fn.search('\\s$', 'nw')
			if trailing > 0 then
				local label = symbol or 'WS:'
				msg = msg .. label .. trailing
			end
		end
		vim.api.nvim_buf_set_var(0, cache_key, msg)

		return msg
	end
end

function badge.progress()
	return function()
		return '%l/%2c%4p%%'
	end
end

function badge.session(symbol)
	return function()
		if vim.v.this_session then
			return symbol
		end
		return ''
	end
end

function badge.utility_title()
	return function()
		local icons = {
			Trouble = '',
			DiffviewFiles = '',
			NeogitStatus = '',
			Outline = '',
			['mason.nvim'] = '',
			spectre_panel = '',
			['neo-tree'] = '',
			['neo-tree-popup'] = '',
		}
		local padding = vim.g.global_symbol_padding or ' '
		return icons[vim.bo.filetype] .. padding .. '%y'
	end
end

local lualine = require('lualine')

-- Color table for highlights
local colors = {
	active = {
		fg = '#a8a897', -- '#bbc2cf',
		bg = '#30302c',
		boundary = '#51afef',
		paste = '#98be65',
		filepath = '#D7D7BC',
		progress = '#4e4e43',
	},
	inactive = {
		fg = '#666656',
		bg = '#30302c',
	},
	filemode = {
		modified = '#ec5f67',
		readonly = '#ec5f67',
	},
	diagnostics = {
		error = '#ec5f67',
		warn = '#ECBE7B',
		info = '#008080',
		hint = '#006080',
	},
	git = {
		added = '#516C31',
		modified = '#974505',
		deleted = '#B73944',
	},
}

local palette_active = {
	a = { fg = colors.active.fg, bg = colors.active.bg },
	b = { fg = colors.active.fg, bg = colors.active.bg },
	c = { fg = colors.active.fg, bg = colors.active.bg },
	y = { fg = colors.active.fg, bg = colors.active.bg },
	z = { fg = colors.active.fg, bg = colors.active.progress },
}

local palette_inactive = {
	a = { fg = colors.inactive.fg, bg = colors.inactive.bg },
	b = { fg = colors.inactive.fg, bg = colors.inactive.bg },
	c = { fg = colors.inactive.fg, bg = colors.inactive.bg },
	y = { fg = colors.inactive.fg, bg = colors.inactive.bg },
	z = { fg = colors.inactive.fg, bg = colors.inactive.bg },
}

-- Reference
-- Explorer:                         
-- Misc: ﬘ ⌯ ☱ ♯ 
-- Analysis: ✖ ✘ ✗ ⬪ ▪ ▫
-- Quickfix:               
-- Location:            
-- Lock: ⚠  ⚿  � � � �
-- Version: 
-- Zoom: � �
-- Unknown: ⯑

-- Section conditions
local conditions = {
	hide_in_width = function(width)
		return function() return vim.fn.winwidth(0) > width end
	end,
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand('%:p:h')
		local gitdir = vim.fn.finddir('.git', filepath .. ';')
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end
}

-- Detect quickfix vs. location list
local function is_loclist()
	return vim.fn.getloclist(0, {filewinid = 1}).filewinid ~= 0
end

-- Extension: Quickfix
local extension_quickfix = {
	sections = {
		lualine_a = {
			{
				function()
					local pad = vim.g.global_symbol_padding or ' '
					local q = '' .. pad
					local l = '' .. pad
					return is_loclist() and l..'Location List' or q..'Quickfix List'
				end,
				padding = { left = 1, right = 0 },
			},
			{
				function()
					if is_loclist() then
						return vim.fn.getloclist(0, {title = 0}).title
					end
					return vim.fn.getqflist({title = 0}).title
				end
			},
		},
		lualine_z = { function() return '%l/%L' end },
	},
	filetypes = {'qf'},
}

-- Extension: File-explorer
local extension_file_explorer = {
	sections = {
		lualine_a = {
			{
				function() return '▊' end,
				color = { fg = colors.active.boundary },
				padding = 0,
			},
			{ function() return '' end, padding = 1 },
			{ function() return '%<' end, padding = { left = 1, right = 0 }},
			{
				function() return vim.fn.fnamemodify(vim.fn.getcwd(), ':~') end,
				padding = { left = 0, right = 1 },
			}
		},
		lualine_z = { function() return '%l/%L' end },
	},
	inactive_sections = {
		lualine_a = {
			{ function() return '' end, padding = 1 },
			{ function() return '%<' end, padding = { left = 1, right = 0 }},
			{
				function() return vim.fn.fnamemodify(vim.fn.getcwd(), ':~') end,
				padding = { left = 0, right = 1 },
			}
		},
		lualine_z = { function() return '%l/%L' end },
	},
	filetypes = {'neo-tree'},
}

-- Extension: Only name and line-count
local extension_line_count = {
	sections = {
		lualine_a = {
			{
				function() return '▊' end,
				color = { fg = colors.active.boundary },
				padding = { left = 0, right = 1 },
			},
			{ badge.utility_title(), padding = 0 },
		},
		lualine_z = { function() return '%l/%L' end },
	},
	inactive_sections = {
		lualine_a = { badge.utility_title() },
		lualine_z = { function() return '%l/%L' end },
	},
	filetypes = {'Trouble', 'DiffviewFiles', 'NeogitStatus', 'Outline'},
}

-- Global Config
local config = {
	options = {
		always_divide_middle = false,
		component_separators = { left = '', right = ''},
		section_separators   = { left = '', right = ''},
		theme = {
			normal   = palette_active,
			inactive = palette_inactive,
			insert   = palette_active,
			visual   = palette_active,
			replace  = palette_active,
			command  = palette_active,
		},
	},

	extensions = {
		extension_quickfix,
		extension_file_explorer,
		extension_line_count,
	},

	-- ACTIVE STATE --
	sections = {
		lualine_a = {
			-- Box boundary
			{
				function() return '▊' end,
				color = { fg = colors.active.boundary },
				padding = { left = 0, right = 1 },
			},

			-- Paste mode sign
			{
				function() return vim.go.paste and '=' or '' end,
				padding = 0,
				color = { fg = colors.active.paste }
			},

			-- Readonly or zoomed
			{
				badge.filemode('%*#', '🔒', '🔎'),
				padding = 0,
				color = { fg = colors.filemode.readonly },
			},

			-- Buffer number
			{ function() return '%n' end, padding = 0 },

			-- Modified sign
			{
				badge.modified('+'),
				padding = 0,
				color = { fg = colors.filemode.modified }
			},

			-- File icon
			{ badge.icon() },

			-- File path
			{
				badge.filepath(3, 5),
				cond = conditions.buffer_not_empty,
				color = { fg = colors.active.filepath },
				padding = { left = 0, right = 0 },
			},

			-- Diagnostics
			{
				'diagnostics',
				sources = { 'nvim_diagnostic' },
				symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
				diagnostics_color = {
					error = { fg = colors.diagnostics.error },
					warn = { fg = colors.diagnostics.warn },
					info = { fg = colors.diagnostics.info },
					hint = { fg = colors.diagnostics.hint },
				},
				padding = { left = 1, right = 0 },
			},

			-- Start truncating here
			{ function() return '%<' end, padding = { left = 0, right = 0 }},

			-- Whitespace trails
			{ badge.trails('␣'), padding = { left = 1, right = 0 }},

			-- Git branch
			{
				'branch',
				icon = '',
				-- cond = conditions.check_git_workspace,
				padding = { left = 1, right = 0 },
			},

			-- Git status
			{
				'diff',
				symbols = { added = '₊', modified = '∗', removed = '₋' },
				diff_color = {
					added = { fg = colors.git.added },
					modified = { fg = colors.git.modified },
					removed = { fg = colors.git.deleted },
				},
				cond = conditions.hide_in_width(70),
				padding = { left = 1, right = 0 },
			},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { function() return '%=' end },
		lualine_y = {
			-- File format, encoding and type.
			{
				badge.filemedia('  '),
				cond = conditions.hide_in_width(60),
				padding = { left = 0, right = 1 },
			},
		},
		lualine_z = {
			-- Border
			{
				function () return '' end,
				padding = 0,
				color = { fg = colors.active.progress, bg = colors.active.bg }
			},

			{ badge.progress() },

			-- Box boundary
			-- {
			-- 	function() return '▐' end,
			-- 	color = { fg = colors.active.boundary },
			-- 	padding = 0
			-- },
		}
	},

	-- INACTIVE STATE --
	inactive_sections = {
		lualine_a = {
			{ badge.icon() },
			{ badge.filepath(3, 5), padding = { left = 0, right = 0 }},
			{ badge.modified('+'), color = { fg = colors.filemode.modified }},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {
			{ function() return vim.bo.filetype end },
		}
	}
}

vim.g.qf_disable_statusline = true

-- Initialize lualine
lualine.setup(config)

-- vim: set ts=2 sw=2 tw=80 noet :

