return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- [[ LazyVim ]]

      -- load mason-nvim-dap here, after all adapters have been setup
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      -- [[ LazyVim End ]]

      local dap = require("dap")
      -- local dapui = require("dapui")

      local notify_title = "DAP"

      -- 调试结束后不自动退出 UI
      dap.listeners.before.event_terminated["dapui_config"] = function()
        vim.notify("Program terminated.", "info", { title = notify_title })
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        vim.notify("Debug session exited.", "info", { title = notify_title })
      end
    end,
  },
}
