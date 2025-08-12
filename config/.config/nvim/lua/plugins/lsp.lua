return {
  -- tools

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
      })
      opts.ui = {
        icons = {
          package_installed = "✓",
          package_pending = "",
          package_uninstalled = "✗",
        },
      }
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      ---@type lspconfig.options
      servers = {
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        html = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      setup = {},
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function()
      inlay_hints = { enabled = vim.fn.has("nvim-0.10") }
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(keys, {
        {
          "gd",
          function()
            -- DO NOT RESUSE WINDOW
            require("telescope.builtin").lsp_definitions({ reuse_win = false })
          end,
          desc = "Goto Definition",
          has = "definition",
        },
      })
    end,
  },

  -- JADI
  -- dap integration
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>de",
        function()
          require("dap.ui.widgets").centered_float(require("dap.ui.widgets").expression, { border = "none" })
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },
      {
        "<leader>dwf",
        function()
          require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames, { border = "none" })
        end,
        desc = "Frames",
      },
      {
        "<leader>dws",
        function()
          require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes, { border = "none" })
        end,
        desc = "Scopes",
      },
      {
        "<leader>dwt",
        function()
          require("dap.ui.widgets").centered_float(require("dap.ui.widgets").threads, { border = "none" })
        end,
        desc = "Threads",
      },
    },
    opts = function(_, opts)
      require("dap").defaults.fallback.terminal_win_cmd = "enew | set filetype=dap-terminal"
    end,
  },

  -- -- overwrite Rust tools inlay hints
  -- {
  --   "simrat39/rust-tools.nvim",
  --   optional = true,
  --   opts = {
  --     tools = {
  --       inlay_hints = {
  --         -- nvim >= 0.10 has native inlay hint support,
  --         -- so we don't need the rust-tools specific implementation any longer
  --         auto = not vim.fn.has('nvim-0.10')
  --       }
  --     }
  --   },
  -- },
  --
  -- -- overwrite Jdtls options
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   optional = true,
  --   opts = {
  --     settings = {
  --       java = {
  --         configuration = {
  --           updateBuildConfiguration = "automatic",
  --         },
  --         codeGeneration = {
  --           toString = {
  --             template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
  --           },
  --           useBlocks = true,
  --         },
  --         completion = {
  --           favoriteStaticMembers = {
  --             "org.assertj.core.api.Assertions.*",
  --             "org.junit.Assert.*",
  --             "org.junit.Assume.*",
  --             "org.junit.jupiter.api.Assertions.*",
  --             "org.junit.jupiter.api.Assumptions.*",
  --             "org.junit.jupiter.api.DynamicContainer.*",
  --             "org.junit.jupiter.api.DynamicTest.*",
  --             "org.mockito.Mockito.*",
  --             "org.mockito.ArgumentMatchers.*",
  --             "org.mockito.Answers.*"
  --           },
  --           importOrder = {
  --             "#",
  --             "java",
  --             "javax",
  --             "org",
  --             "com"
  --           },
  --         },
  --         contentProvider = { preferred = "fernflower" },
  --         eclipse = {
  --           downloadSources = true,
  --         },
  --         flags = {
  --           allow_incremental_sync = true,
  --           server_side_fuzzy_completion = true
  --         },
  --         implementationsCodeLens = {
  --           enabled = false, --Don"t automatically show implementations
  --         },
  --         inlayHints = {
  --           parameterNames = { enabled = "all" }
  --         },
  --         maven = {
  --           downloadSources = true,
  --         },
  --         referencesCodeLens = {
  --           enabled = false, --Don"t automatically show references
  --         },
  --         references = {
  --           includeDecompiledSources = true,
  --         },
  --         saveActions = {
  --           organizeImports = true,
  --         },
  --         signatureHelp = { enabled = true },
  --         sources = {
  --           organizeImports = {
  --             starThreshold = 9999,
  --             staticStarThreshold = 9999,
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = function() end
  -- },
}
