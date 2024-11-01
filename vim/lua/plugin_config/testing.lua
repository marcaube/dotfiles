local g = vim.g

g['test#python#runner'] = 'pytest'
g['test#python#pytest#executable'] = 'pytest --ds=settings.test -x'
g['test#strategy'] = "neovim"
