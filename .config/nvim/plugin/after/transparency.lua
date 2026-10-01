-- -- transparent background
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Terminal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
-- vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "none" })
--
-- -- transparent background for neotree
-- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })
--
-- -- transparent background for nvim-tree
-- vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
--
-- -- transparent notify background
-- vim.api.nvim_set_hl(0, "NotifyINFOBody", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyERRORBody", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyWARNBody", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyTRACEBody", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyINFOTitle", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyERRORTitle", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyWARNTitle", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyTRACETitle", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyINFOBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyERRORBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyWARNBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { bg = "none" })

local groups = {
  -- core
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "FloatTitle",
  "SignColumn",
  "FoldColumn",
  "Folded",
  "EndOfBuffer",
  "WinSeparator",
  "VertSplit",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
  "WinBar",
  "WinBarNC",
  "MsgArea",
  "Pmenu",
  "Terminal",
  -- snacks (LazyVim's explorer / picker)
  "SnacksNormal",
  "SnacksNormalNC",
  "SnacksWinBar",
  "SnacksWinBarNC",
  "SnacksPicker",
  "SnacksPickerBorder",
  "SnacksPickerTitle",
  "SnacksPickerBox",
  "SnacksPickerBoxBorder",
  "SnacksPickerBoxTitle",
  "SnacksPickerInput",
  "SnacksPickerInputBorder",
  "SnacksPickerInputTitle",
  "SnacksPickerList",
  "SnacksPickerListBorder",
  "SnacksPickerListTitle",
  "SnacksPickerPreview",
  "SnacksPickerPreviewBorder",
  "SnacksPickerPreviewTitle",
  -- plugins you may still use
  "WhichKeyFloat",
  "TelescopeNormal",
  "TelescopeBorder",
  "TelescopePromptBorder",
  "TelescopePromptTitle",
  "NeoTreeNormal",
  "NeoTreeNormalNC",
  "NeoTreeVertSplit",
  "NeoTreeWinSeparator",
  "NeoTreeEndOfBuffer",
  "NvimTreeNormal",
  "NvimTreeVertSplit",
  "NvimTreeEndOfBuffer",
}

for _, lvl in ipairs({ "INFO", "WARN", "ERROR", "DEBUG", "TRACE" }) do
  for _, part in ipairs({ "Body", "Title", "Border" }) do
    table.insert(groups, "Notify" .. lvl .. part)
  end
end
for _, lvl in ipairs({ "Info", "Warn", "Error", "Debug", "Trace" }) do
  for _, part in ipairs({ "", "Border", "Title", "Icon", "Footer" }) do
    table.insert(groups, "SnacksNotifier" .. lvl .. part)
  end
end

local function clear_bg(name)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  if next(hl) == nil then
    return
  end -- not defined (yet), don't create an empty group
  hl.bg, hl.ctermbg = nil, nil
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.api.nvim_set_hl(0, name, hl) -- keeps fg, so borders keep their color
end

local function apply()
  for _, name in ipairs(groups) do
    clear_bg(name)
  end
  for name in pairs(vim.api.nvim_get_hl(0, {})) do
    if name:find("^BufferLine") then
      clear_bg(name)
    end
  end
end

apply()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.schedule(apply)
  end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.schedule(apply)
  end,
})
