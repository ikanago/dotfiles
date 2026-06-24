return {
  'dmtrKovalenko/fff.nvim',
  build = function()
    -- downloads a prebuilt binary or falls back to cargo build
    require("fff.download").download_or_build_binary()
  end,
  lazy = false, -- the plugin lazy-initialises itself
  config = function()
    require('fff').setup({
      layout = {
        prompt_position = 'top',
      }
    })
  end,
  keys = {
    { "<leader>ff", function() require('fff').find_files() end, desc = 'FFFind files' },
    { "<leader>fg", function() require('fff').live_grep() end, desc = 'LiFFFe grep' },
    { "<leader>fz",
      function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end,
      desc = 'Live fffuzy grep',
    },
    { "<leader>fc",
      function() require('fff').live_grep({ query = vim.fn.expand("<cword>") }) end,
      desc = 'Search current word',
    },
  },
}
