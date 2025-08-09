return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
    keys = {},
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local LazyVim = require("lazyvim.util")
      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({
          length = 0,
          relative = "cwd",
          modified_hl = "MatchParen",
          directory_hl = "",
          filename_hl = "Bold",
          modified_sign = "",
          readonly_icon = " 󰌾 ",
        }),
      }
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
          ███╗   ███╗ █████╗ ██╗  ██╗██████╗ ██╗
          ████╗ ████║██╔══██╗██║  ██║██╔══██╗██║
          ██╔████╔██║███████║███████║██║  ██║██║
          ██║╚██╔╝██║██╔══██║██╔══██║██║  ██║██║
          ██║ ╚═╝ ██║██║  ██║██║  ██║██████╔╝██║
          ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝
   ]],
        },
      },
    },
  },

  --JADI
  -- -- notify customization
  -- {
  --   "rcarriga/nvim-notify",
  --   opts = {
  --     stages = "fade_in_slide_out",
  --     timeout = 3000,
  --     render = "compact",
  --   }
  -- },
  --
  -- -- bufferline
  -- {
  --   "akinsho/bufferline.nvim",
  --   opts = {
  --     options = {
  --       numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
  --       close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
  --       right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
  --       max_name_length = 30,
  --       max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
  --       show_buffer_icons = true,
  --       show_buffer_close_icons = false,
  --       show_close_icon = false,
  --       show_tab_indicators = true,
  --       separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
  --       color_icons = false,
  --       diagnostics = false,
  --       highlights = {
  --         buffer_selected = {
  --           gui = "none"
  --         },
  --       },
  --       offsets = {
  --         {
  --           filetype = "neo-tree",
  --           text = "Neo-tree",
  --           highlight = "Directory",
  --           text_align = "left",
  --         },
  --         {
  --           filetype = "Outline",
  --           text = "Symbols Outline",
  --           highlight = "TSType",
  --           text_align = "left"
  --         }
  --       }
  --     }
  --   }
  -- },
  --
  -- -- statusline
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     local function lsp_name(msg)
  --       msg = msg or "Inactive"
  --       local buf_clients = vim.lsp.get_active_clients()
  --       if next(buf_clients) == nil then
  --         if type(msg) == "boolean" or #msg == 0 then
  --           return "Inactive"
  --         end
  --         return msg
  --       end
  --       local buf_client_names = {}
  --
  --       for _, client in pairs(buf_clients) do
  --         if client.name ~= "null-ls" then
  --           table.insert(buf_client_names, client.name)
  --         end
  --       end
  --
  --       return table.concat(buf_client_names, ", ")
  --     end
  --
  --     opts.sections = vim.tbl_deep_extend("force", opts.sections, {
  --       lualine_y = {
  --         {
  --           lsp_name,
  --           icon = "",
  --           color = { gui = "none" },
  --         },
  --         { "progress", separator = " ", padding = { left = 1, right = 0 } },
  --         { "location", padding = { left = 0, right = 1 } },
  --       },
  --     })
  --   end
  -- },
  --
  -- -- dashboard
  -- {
  --   "goolord/alpha-nvim",
  --   opts = function(_, dashboard)
  --     dashboard.config.opts.setup = function()
  --       local alpha_start_group = vim.api.nvim_create_augroup("AlphaStart", { clear = true })
  --       vim.api.nvim_create_autocmd("TabNewEntered", {
  --         callback = function()
  --           require("alpha").start()
  --         end,
  --         group = alpha_start_group,
  --       })
  --       vim.api.nvim_create_autocmd("User", {
  --         pattern = "AlphaReady",
  --         desc = "disable tabline for alpha",
  --         callback = function()
  --           vim.opt.showtabline = 0
  --         end,
  --       })
  --       vim.api.nvim_create_autocmd("BufUnload", {
  --         buffer = 0,
  --         desc = "enable tabline after alpha",
  --         callback = function()
  --           vim.opt.showtabline = 2
  --         end,
  --       })
  --     end
  --     local button = dashboard.button("m", " " .. " Mason", ":Mason<CR>")
  --     button.opts.hl = "AlphaButtons"
  --     button.opts.hl_shortcut = "AlphaShortcut"
  --     table.insert(dashboard.section.buttons.val, 9, button)
  --   end
  -- },
  --
  -- -- scrollbar for Neovim
  -- {
  --   "dstein64/nvim-scrollview",
  --   event = "BufReadPre",
  --   opts = {
  --     excluded_filetypes = { "alpha", "neo-tree" },
  --     current_only = true,
  --     winblend = 75,
  --   }
  -- },
  --
  -- -- git diff view
  -- {
  --   "sindrets/diffview.nvim",
  --   cmd = "DiffviewOpen",
  -- },
}
