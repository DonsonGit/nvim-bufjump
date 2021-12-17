-- nvim-bufjump

-------------------- VARIABLES -----------------------------
local fn, cmd, vim, api = vim.fn, vim.cmd, vim, vim.api
local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo
local fmt = string.format
local M = {}

function M.close_others()

    local cur_bufnr = api.nvim_get_current_buf()

    local buffers = vim.tbl_filter(
        function (buf)
            return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
        end,
        api.nvim_list_bufs()
    )

    if #buffers <= 1 then
        return
    end

    local close_str = ""
    for _, nr in ipairs(buffers) do
        if nr ~= cur_bufnr then
            close_str = close_str..nr..' '
        end
    end
    cmd(fmt("bd %s", close_str))
end

return M
