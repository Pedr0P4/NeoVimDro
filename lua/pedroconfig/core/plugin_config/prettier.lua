vim.api.nvim_create_user_command(
    "Prettier",
    function()
        local prettier = vim.fn.stdpath("data") .. "/mason/bin/prettier"
        local file = vim.fn.expand("%:p") -- Caminho do arquivo atual
        if vim.fn.filereadable(prettier) == 0 then
            print("Prettier não encontrado! Verifique a instalação.")
            return
        end
        vim.fn.jobstart({ prettier, "--write", file }, {
            on_exit = function(_, code)
                if code == 0 then
                    print("Arquivo formatado com sucesso!")
                else
                    print("Erro ao formatar arquivo.")
                end
            end,
        })
    end,
    {}
)
