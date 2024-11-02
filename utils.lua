local M = {}
local api = vim.api
local fn = vim.fn

M.get_v8_url = function (need_copy)
  -- Get the current file path and line number
  local filepath = fn.expand('%:p')  -- Absolute path of current file
  local line_number = fn.line('.')

  -- Search for "v8" directory in current or parent directories
  local v8_dir = filepath:match("(.*/v8/)") or filepath:match("(.*)/v8/")
  if not v8_dir then
    print("v8 directory not found in current or parent directories")
    return
  end

  -- Construct the relative path from "v8/" to current file
  local relative_path = filepath:sub(#v8_dir)
  local final_path = "v8" .. relative_path

  -- Construct the URL
  local url = string.format("https://source.chromium.org/chromium/chromium/src/+/main:%s;l=%d", final_path, line_number)

  -- Copy the URL to clipboard
  if need_copy then
    fn.setreg('+', url)
    print("URL copied to clipboard:", url)
  end
  return url
end

-- Function to open the URL in the browser
M.open_v8_url = function ()
  local url = M.get_v8_url() -- Get the URL from clipboard
  if url and url:match("^https://") then
    -- Open in the default web browser
    fn.jobstart({ "xdg-open", url }, { detach = true })
  else
    print("No valid URL in clipboard to open")
  end
end

return M
