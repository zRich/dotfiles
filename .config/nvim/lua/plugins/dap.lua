return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "jbyuki/one-small-step-for-vimkind",
        -- stylua: ignore
        config = function()
          local dap = require("dap")
          dap.adapters.nlua = function(callback, conf)
            local adapter = {
              type = "server",
              host = conf.host or "127.0.0.1",
              port = conf.port or 8086,
            }
            if conf.start_neovim then
              local dap_run = dap.run
              dap.run = function(c)
                adapter.port = c.port
                adapter.host = c.host
              end
              require("osv").run_this()
              dap.run = dap_run
            end
            callback(adapter)
          end
          -- dap.adapters.go = function(callback, _)
          --   local stdout = vim.loop.new_pipe(false)
          --   local handle
          --   local pid_or_err
          --   local port = 38697
          --   local opts = {
          --     stdio = { nil, stdout },
          --     args = { "dap", "-l", "127.0.0.1:" .. port },
          --     detached = true
          --   }
          --   handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
          --     stdout:close()
          --     handle:close()
          --     if code ~= 0 then
          --       print('dlv exited with code', code)
          --     end
          --   end)
          --   assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
          --   stdout:read_start(function(err, chunk)
          --     assert(not err, err)
          --     if chunk then
          --       vim.schedule(function()
          --         require('dap.repl').append(chunk)
          --       end)
          --     end
          --   end)
          --   -- Wait for delve to start
          --   vim.defer_fn(
          --     function()
          --       callback({ type = "server", host = "127.0.0.1", port = port })
          --     end,
          --     300)
          -- end
          dap.configurations.lua = {
            {
              type = "nlua",
              request = "attach",
              name = "Run this file",
              start_neovim = {},
            },
            {
              type = "nlua",
              request = "attach",
              name = "Attach to running Neovim instance (port = 8086)",
              port = 8086,
            },
          }
          -- dap.configurations.go = {
          --   {
          --     type = "go",
          --     name = "Launch Package",
          --     request = "launch",
          --     program = "${file}",
          --     showLog = true,
          --   },
          --   {
          --     type = "go",
          --     name = "Debug test",   -- configuration for debugging test files
          --     request = "launch",
          --     mode = "test",
          --     showLog = true,
          --     program = "${file}"
          --   },
          --   {
          --     type = "go",
          --     name = "Debug test (go.mod)",
          --     request = "launch",
          --     mode = "test",
          --     showLog = true,
          --     flags = { "-v" },
          --     program = "./${relativeFileDirname}"
          --   }
          -- }
        end
,
    },
  },
}
