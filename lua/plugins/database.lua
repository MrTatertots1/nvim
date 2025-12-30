local db_connections = {
  {
    name = 'local_edp',
    url = 'postgres://api:supersecretpassword@localhost:5432/p3',
  },
}


return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true},
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.dadbod_filetypes = {
        sql = true,
        mysql = true,
        plsql = true,
      }

      vim.g.dbs = db_connections

      vim.keymap.set('n', '<leader>Du', '<cmd>DBUIToggle<cr>', { desc = 'Toggle Database UI' })
    end,

  },
}
