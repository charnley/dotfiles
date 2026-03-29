-- notes.lua

local M = {}

local function float_pick(cmd)
  local tmp = vim.fn.tempname()
  local width = math.floor(vim.o.columns * 0.92)
  local height = math.floor(vim.o.lines * 0.88)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    style = "minimal",
    border = "rounded",
    width = width,
    height = height,
    col = col,
    row = row,
  })

  vim.api.nvim_create_autocmd("TermClose", {
    buffer = buf,
    once = true,
    callback = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
      vim.schedule(function()
        if vim.fn.filereadable(tmp) == 1 then
          for _, path in ipairs(vim.fn.readfile(tmp)) do
            if path ~= "" then
              vim.cmd("edit " .. vim.fn.fnameescape(path))
            end
          end
          vim.fn.delete(tmp)
        end
      end)
    end,
  })

  vim.fn.termopen(cmd .. " > " .. vim.fn.shellescape(tmp))
  vim.cmd("startinsert")
end

-- ,ol — list all notes, open selected as buffers
function M.ls()
  float_pick("zk list --interactive --sort created --quiet --format '{{absPath}}'")
end

-- ,ot — open (or create) a todo note for a given date
local date_completions = {
  "today",
  "yesterday",
  "tomorrow",
  "monday",
  "tuesday",
  "wednesday",
  "thursday",
  "friday",
  "saturday",
  "sunday",
  "last monday",
  "last tuesday",
  "last wednesday",
  "last thursday",
  "last friday",
  "next monday",
  "next tuesday",
  "next wednesday",
  "next thursday",
  "next friday",
}

_G._notes_date_complete = function(arglead)
  if arglead == "" then
    return date_completions
  end
  local lead = arglead:lower()
  return vim.tbl_filter(function(v)
    return v:sub(1, #lead):lower() == lead
  end, date_completions)
end

function M.todo()
  local nb = vim.fn.getenv("ZK_NOTEBOOK_DIR")
  if nb == vim.NIL or nb == "" then
    vim.notify("[notes] ZK_NOTEBOOK_DIR is not set", vim.log.levels.ERROR)
    return
  end

  local date_input = vim.fn.input({
    prompt = "Date: ",
    default = "",
    completion = "customlist,v:lua._notes_date_complete",
  })
  if date_input == "" then
    return
  end

  local date = vim.trim(vim.fn.system("date -d " .. vim.fn.shellescape(date_input) .. " +%Y-%m-%d"))
  if vim.v.shell_error ~= 0 then
    vim.notify("[notes] Could not parse date: " .. date_input, vim.log.levels.ERROR)
    return
  end

  local path = nb .. "/todo/" .. date .. ".md"

  if vim.fn.filereadable(path) == 0 then
    vim.fn.writefile({ "- [ ] Untitled" }, path)
  end

  vim.cmd("edit " .. vim.fn.fnameescape(path))
end

vim.keymap.set("n", "<Leader>ol", M.ls, { desc = "Notes: list all" })
vim.keymap.set("n", "<Leader>ot", M.todo, { desc = "Notes: todo" })

return M
