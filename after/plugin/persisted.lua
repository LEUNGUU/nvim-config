-- plugin: persisted
-- see: https://github.com/olimorris/persisted.nvim

local persisted = require('persisted')
local fn = vim.fn
local api = vim.api
local interface = {}

interface.win = {}

-- Close plugin owned windows.
interface.win.close_plugin_owned = function()
	-- Jump to preview window if current window is plugin owned.
	if interface.win.is_plugin_owned(0) then
		vim.cmd([[ wincmd p ]])
	end

	for _, win in ipairs(fn.getwininfo()) do
		if interface.win.is_plugin_owned(win.bufnr) then
			-- Delete plugin owned window buffers.
			api.nvim_buf_delete(win.bufnr, {})
		end
	end
end

-- Detect if window is owned by plugin by checking buftype.
interface.win.is_plugin_owned = function(bufid)
	local origin_type = api.nvim_buf_get_option(bufid, 'buftype')
	if origin_type == '' or origin_type == 'help' then
		return false
	end
	return true
end


persisted.setup({
    autosave = true,
    autoload = true,
    follow_cwd = false,
    use_git_branch = false,
    ignored_dirs = { '/tmp', '~/.cache' },
    before_save = function()
        interface.win.close_plugin_owned()
    end,

    telescope = {
        before_source = function()
            persisted.save()
            persisted.stop()
        end,
        after_source = function(session)
            persisted.start()
            print('Started session ' .. session.name)
        end
    }
})
