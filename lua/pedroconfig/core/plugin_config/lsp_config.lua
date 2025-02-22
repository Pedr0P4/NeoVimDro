require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		'lua_ls',
		'clangd',
		'jdtls',
	}
})

local on_attach = function(_, _)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
	vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local lua_capabilities = require('cmp_nvim_lsp').default_capabilities()

local html_capabilities = vim.lsp.protocol.make_client_capabilities()
html_capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")


lspconfig.lua_ls.setup {
	on_attach = on_attach,
	capabilities = lua_capabilities,
}

lspconfig.clangd.setup{}
lspconfig.html.setup{}

local home = os.getenv("HOME")
local mason_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local workspace_dir = home .. "/.workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

lspconfig.jdtls.setup {
  cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xms1g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  "-jar", mason_path .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
  "-configuration", mason_path .. "/config_linux",
  "-data", workspace_dir,
},
  root_dir = lspconfig.util.root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
  settings = {
    java = {
      home = "/usr/lib/jvm/jdk-23-oracle-x64", -- Opcional
      eclipse = { downloadSources = true },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-23",
            path = "/usr/lib/jvm/jdk-23-oracle-x64",
          },
          {
            name = "JavaSE-21",
            path = "/usr/lib/jvm/java-21-openjdk-amd64",
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk-amd64",
          },
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk-amd64",
          },
        },
      },
    },
  },
  init_options = {
    bundles = {},
  },
}

lspconfig.html.setup({
    on_attach = function(client, bufnr)
        -- Defina keybindings ou configurações adicionais aqui, se necessário
        local opts = { noremap = true, silent = true }
        local keymap = vim.api.nvim_buf_set_keymap
        keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

lspconfig.cssls.setup({
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
