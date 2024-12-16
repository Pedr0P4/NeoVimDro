function start_browser_sync()
  local project_dir = vim.fn.expand('%:p:h')
  -- Verifica se o browser-sync já está rodando
  local result = vim.fn.system("pgrep -f 'browser-sync start'")
  
  -- Se não houver nenhum processo do browser-sync...
  if result == "" then
	-- Cria um terminal para manter o servidor ativo.
	vim.cmd('FloatermNew --name=server --height=30 --width=80 --position=topleft')
    vim.cmd("FloatermSend --name=server browser-sync start --server " .. project_dir .. " --files '" .. project_dir .. "/*.html," .. project_dir .. "/*.css," .. project_dir .. "/*.js' --port 3000 &")
	vim.cmd("FloatermToggle!")
    print("Servidor browser-sync iniciado.")	
  else
    print("O servidor browser-sync já está em execução.")
  end
end

-- Função para matar o processo do browser-sync ao sair do Neovim
function stop_browser_sync()
  -- Mata o processo do browser-sync (assumindo que ele foi iniciado com 'nohup' e 'browser-sync')
  vim.cmd("silent !pkill -f 'browser-sync start'")
  -- Mata todos os terminais do floaterm
  vim.cmd("FloatermKill!")
end

-- Autocmd para chamar a função quando abrir arquivos .html, .css ou .js
vim.api.nvim_exec([[
  augroup UpdateBSConfigAndStartSync &
    autocmd!
    autocmd BufRead *.html,*.css,*.js lua start_browser_sync()  -- Inicia o browser-sync
	autocmd VimLeave * lua stop_browser_sync() -- Mata o processo do browser-sync
  augroup END
]], true)
