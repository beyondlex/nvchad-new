return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
   {
     "neovim/nvim-lspconfig",
     config = function()
       require("nvchad.configs.lspconfig").defaults()
       require "configs.lspconfig"
     end,
   },

  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
  			"lua-language-server", "stylua",
  			"html-lsp", "css-lsp" , "prettier", "java-language-server"
  		},
  	},
  },
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  {

    -- https://github.com/nvim-neo-tree/neo-tree.nvim
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = true,
        buffers = {
          follow_current_file = {
            enabled = true,
          }
        },
        -- copy file path:
        -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370
        commands = {
          copy_selector = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local vals = {
              ["ABSOLUTE PATH"] = filepath,
              ["FILENAME"] = filename,
              ["PATH (CWD)"] = modify(filepath, ":."),
              ["PATH (HOME)"] = modify(filepath, ":~"),
              ["URI"] = vim.uri_from_fname(filepath),
            }

            local options = vim.tbl_filter(
              function(val)
                return vals[val] ~= ""
              end,
              vim.tbl_keys(vals)
            )
            if vim.tbl_isempty(options) then
              vim.notify("No values to copy", vim.log.levels.WARN)
              return
            end
            table.sort(options)
            vim.ui.select(options, {
              prompt = "Choose to copy to clipboard:",
              format_item = function(item)
                return ("%s: %s"):format(item, vals[item])
              end,
            }, function(choice)
              local result = vals[choice]
              if result then
                vim.notify(("Copied: `%s`"):format(result))
                vim.fn.setreg("+", result)
              end
            end)
          end,


          -- Inspired by @adoyle-h <3, for anyone who wants one keystroke approach like me, and got used with nvim-tree ways (note that I remapped c to "copy_to_clipboard" instead):
          copy_path = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            vim.fn.setreg("+", filepath)
            vim.notify("Path copied: " .. filepath)
          end,
        },


        window = {
          mappings = {
            ["Y"] = {"copy_path", config={title="copy path"}},
            ["<M-k>"] = { "scroll_preview", config = {direction = 10} },
            ["<M-j>"] = { "scroll_preview", config = {direction = -10} },
          },
          filesystem = {
            filtered_items = {
              visible = true,
              hide_dotfiles = false,
              hide_gitignored = false,
            },
            follow_current_file = {
              enabled = true,
            }
          }, -- filesystem
          buffers = {
            follow_current_file = {
              enabled = true,
            }
          }, -- buffers
        }, -- setup.windwo
      }) -- setup()
    end, -- config function
  }, -- neo-tree

  -- https://michaelb.github.io/sniprun/sources/README.html#installation
  {
    "michaelb/sniprun",
    branch = "master",
    build = "sh install.sh",
    lazy = false,
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
    config = function()
      require("sniprun").setup({
        -- window = {
        --   mappings = {
        --     ["<leader>run"] = {"<Plug>SnipRun"},
        --   }, -- setup.window.mappings
        -- }, -- setup.window
      }) -- setup
    end,
  }, -- sniprun

  -- https://github.com/folke/noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
        presets = {
          bottom_search = true,
        },
        lsp = {
          hover = {
            enabled = false,
          },
          signature = {
            enabled = false,
          }
        },
      }) -- setup
    end,
  }, -- noice

  {
    "chrisgrieser/nvim-tinygit",
    lazy = false,
    ft = { "git_rebase", "gitcommit" }, -- so ftplugins are loaded
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim", -- either telescope or fzf-lua
      -- "ibhagwan/fzf-lua",
      "rcarriga/nvim-notify", -- optional, but will lack some features without it
    },
    config = function()
      -- :h vim.keymap.set
      vim.keymap.set("n", "<leader>gc", function() require("tinygit").smartCommit() end)
      vim.keymap.set("n", "<leader>gp", function() require("tinygit").push() end)
      -- setup(opts): https://github.com/chrisgrieser/nvim-tinygit#configuration
      require("tinygit").setup()
    end,
  },
}
