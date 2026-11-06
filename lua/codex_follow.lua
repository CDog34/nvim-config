vim.opt.autoread = true

_G.CodexFollow = function(path)
  vim.schedule(function()
    -- 手动暂停跟随
    if vim.g.codex_follow == false then
      return
    end

    -- 编辑过程中不抢走当前文件
    if vim.api.nvim_get_mode().mode ~= "n"
        or vim.bo.modified then
      return
    end

    if vim.fn.filereadable(path) ~= 1 then
      return
    end

    local buf = vim.fn.bufadd(path)

    -- 不覆盖目标文件中尚未保存的修改
    if vim.bo[buf].modified then
      return
    end

    vim.fn.bufload(buf)
    vim.bo[buf].autoread = true
    vim.api.nvim_set_current_buf(buf)
    vim.cmd("checktime")
  end)

  return 1
end
