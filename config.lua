-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
lvim.transparent_window = true


lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "catppuccin/nvim",       name = "catppuccin", priority = 1000 },
  { "rebelot/kanagawa.nvim", name = "kanagawa",   priority = 1000 },
  { 'rose-pine/neovim',      name = 'rose-pine' },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight"
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "tpope/vim-surround" },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "ggandor/leap.nvim",
    name = "leap",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  -- {
  --   'VonHeikemen/lsp-zero.nvim',
  --   branch = 'v3.x',
  --   lazy = true,
  --   config = false,
  -- },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    }
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'L3MON4D3/LuaSnip' }
    },
  },
  {
    "sheerun/vim-polyglot"
  },
  {
    "posva/vim-vue"
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "telescope.nvim",
  },
  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },
  { "nvim-treesitter/nvim-treesitter-context" },
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      lvim.format_on_save.enabled = true

      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.eslint_d,
        },
      })
    end
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
  },
  {
    "chentoast/marks.nvim"
  },

}

-- require('telescope').setup({
--   defaults = {
--     layout_strategy = "horizontal",
--     layout_config = {
--       height = 0.95
--     }
--   },
--   pickers = {
--     layout_config = {
--       horizontal = { width = 0.5 },
--       mirror = true,
--       prompt_position = 'bottom'
--     },
--     -- find_files = {
--     --   theme = "dropdown",
--     -- },
--   },
-- })
lvim.builtin.telescope = {
  active = true,
  defaults = {
    layout_strategy = "horizontal",
    path_display = { truncate = 2 }
  }
}


require('mini.animate').setup({
  cursor = {
    enable = true,
  },
  scroll = {
    -- Whether to enable this animation
    enable = false,
  }
})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

lvim.keys.normal_mode["<C-s>"] = ":w<Enter>"
lvim.keys.normal_mode["<C-a>"] = "ggVG"
lvim.keys.normal_mode["<C-y>"] = "bye"

-- vim.diagnostic.config({ virtual_text = false })
vim.keymap.set("n", "<C-i>", function() require("trouble").toggle() end)

lvim.colorscheme = "solarized-osaka"

vim.opt.relativenumber = true

lvim.builtin.lualine.options.theme = "powerline_dark"

vim.tbl_map(function(server)
  return server ~= "emmet_ls"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- console.log
vim.keymap.set("n", "<C-/>", function()
  local key = vim.api.nvim_replace_termcodes("o<esc>", true, false, true)
  vim.api.nvim_feedkeys(key, 'n', false)

  vim.schedule(function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0));
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { "console.log('>>>>', )" })
  end)
  vim.schedule(function()
    local key = vim.api.nvim_replace_termcodes("f)i", true, false, true)
    vim.api.nvim_feedkeys(key, 'n', false)
  end)
end)

-- lvim.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
