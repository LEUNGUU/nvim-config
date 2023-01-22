-- plugin: persisted
-- see: https://github.com/olimorris/persisted.nvim
-- rafi settings

local persisted = require('persisted')

persisted.setup({
    autosave = true,
    autoload = true,
    follow_cwd = false,
    use_git_branch = false,
    ignored_dirs = { '/tmp', '~/.cache' },
    before_save = function()
        require('interface').win.close_plugin_owned()
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
