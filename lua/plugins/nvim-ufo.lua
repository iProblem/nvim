local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end


return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
        local map = require('helpers.keys').map
        local ufo = require('ufo')
        map('n', 'zR', ufo.openAllFolds, 'Open all folds')
        map('n', 'zM', ufo.closeAllFolds, 'Close all folds')
        map('n', '<leader>zz', 'zA', 'Toggle fold')


--        vim.o.foldcolumn = '1' -- Mostra a coluna de dobras
--        vim.o.foldlevel = 99 -- Alto valor para garantir que as dobras sejam controladas corretamente
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

--        vim.o.statuscolumn='%=%l%s%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "▸" : "▾"): " ") : " " }'

        ufo.setup({
            provider_selector = function()
                return { 'treesitter', 'indent' }
            end,
            fold_virt_text_handler = handler
        })
    end
}
