-- nvim-bufjump

-------------------- VARIABLES -----------------------------
local fn, cmd, vim, api = vim.fn, vim.cmd, vim, vim.api
local g, o, wo, bo = vim.g, vim.o, vim.wo, vim.bo
local fmt = string.format
local M = {}

function M.jumpTo(name)
    if type(name) ~= 'string' then return end

    local cur_bufnr = api.nvim_get_current_buf()
    if not cur_bufnr or cur_bufnr < 0 then return end

    local cur_buf_name = api.nvim_buf_get_name(cur_bufnr)

    local buffers = vim.tbl_filter(
        function (buf)
            return api.nvim_buf_is_valid(buf) and
            bo[buf].buflisted and
            bo[buf].filetype ~= 'qt' and
            bo[buf].buftype ~= 'terminal' and
            string.find(api.nvim_buf_get_name(buf), name, 1, true)
        end,
        api.nvim_list_bufs()
    )

    if #buffers <= 0 then return end

    for _, buf in ipairs(buffers) do
        if api.nvim_buf_get_name(buf) ~= cur_buf_name then
            api.nvim_win_set_buf(0, buf)
            return
        end
    end
end

function M.close_current()
    local bufnr = api.nvim_get_current_buf()
    if not bufnr or bufnr < 0 then return end

    cmd(fmt("bd "..bufnr))
end

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
