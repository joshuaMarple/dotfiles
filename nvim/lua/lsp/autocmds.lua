-- LSP-related autocommands
local group = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- LSP Import on Completion
_G.lsp_import_on_completion = function()
    local completed_item = vim.v.completed_item
    if not (completed_item and completed_item.user_data and
        completed_item.user_data.nvim and completed_item.user_data.nvim.lsp and
        completed_item.user_data.nvim.lsp.completion_item) then return end

    local item = completed_item.user_data.nvim.lsp.completion_item
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.buf_request(bufnr, "completionItem/resolve", item,
                    function(_, result)
        if result and result.additionalTextEdits then
            vim.lsp.util.apply_text_edits(result.additionalTextEdits, bufnr)
        end
    end)
end

local lsp_import_group = group('LSPImportOnCompletion', { clear = true })
autocmd('CompleteDone', {
  group = lsp_import_group,
  pattern = '*',
  callback = _G.lsp_import_on_completion,
})