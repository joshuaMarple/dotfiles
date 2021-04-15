-- Bubble delimiters
-- left = '',
-- right = '',
-- left = '█',
-- right = '█',

local gl = require("galaxyline")
local gls = gl.section

gl.short_line_list = {'LuaTree','vista','dbui'}

local colors = {
    bg = "#fafafa",
    line_bg = "#fafafa",
    fg = "#3e4249",
    fg_green = "#50a14f",
    yellow = "#A3BE8C",
    cyan = "#0184bc",
    green = "#50a14f",
    orange = "#986801",
    purple = "#a626a4",
    magenta = "#c678dd",
    blue = "#61afef",
    red = "#DF8890",
    lightbg = "#d3d3d3",
    nord = "#81A1C1",
}

local treesitter_func_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local mode_color = {n = colors.blue, i = colors.fg_green,v=colors.purple,
  [''] = colors.purple,V=colors.purple,
  c = colors.red,no = colors.red,s = colors.orange,
  S=colors.orange,[''] = colors.orange,
  ic = colors.yellow,R = colors.orange,Rv = colors.orange,
  cv = colors.red,ce=colors.red, r = colors.cyan,
  rm = colors.cyan, ['r?'] = colors.cyan,
  ['!']  = colors.red,t = colors.cyan}


local is_term = function()
  return vim.bo.filetype == "neoterm"
end

gls.left[1] = {
    leftRounded = {
        provider = function()
            return ""
        end,
        highlight = {colors.fg, colors.bg}
    }
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            return "   "
        end,
        highlight = {colors.bg, colors.fg}
    }
}

gls.left[3] = {
    ViMode = {
        provider = function()
            local alias = {
                n = "normal ",
                i = "insert ",
                c = "command ",
                V = "visual ",
                [""] = "visual ",
                v = "visual ",
                R = "replace ",
                t = "terminal "
            }
            vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color[vim.fn.mode()])
            vim.api.nvim_command('hi GalaxystatusIcon guibg='..mode_color[vim.fn.mode()])
            vim.api.nvim_command('hi GalaxyleftRounded guifg='..mode_color[vim.fn.mode()])
            vim.api.nvim_command('hi GalaxyleftRounded guifg='..mode_color[vim.fn.mode()])
            if (not buffer_not_empty()) then
              vim.api.nvim_command('hi GalaxyleftRightRounded guifg='..mode_color[vim.fn.mode()])
            end
            return alias[vim.fn.mode()]
        end,
        -- separator = " ",
        -- separator_highlight = {colors.fg, buffer_not_empty() and colors.lightbg or mode_color[vim.fn.mode()]},
        separator_highlight = {colors.fg, colors.lightbg},
        highlight = {colors.bg, colors.fg}
    }
}

gls.left[4] = {
    FileSeparator = {
        provider = function ()
          return " "
        end,
        condition = buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
    }
}

gls.left[5] = {
    FileIcon = {
        provider = "FileIcon",
        condition = function() return buffer_not_empty() and not is_term() end,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
    }
}

gls.left[6] = {
    FileName = {
        provider = {"FileName"},
        condition = function() return buffer_not_empty() and not is_term() end,
        highlight = {colors.fg, colors.lightbg},
    }
}

gls.left[7] = {
    TermIcon = {
        provider = function() return "  " end,
        condition = is_term,
        highlight = {colors.fg, colors.lightbg}
    }
}

gls.left[8] = {
    TermName = {
        provider = function() return " term " end,
        condition = is_term,
        highlight = {colors.fg, colors.lightbg},
    }
}


gls.left[9] = {
    leftRightRounded = {
        provider = function()
            return ""
        end,
        highlight = {colors.lightbg, colors.bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 50 then
        return true
    end
    return false
end

gls.left[10] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.green, colors.line_bg}
    }
}

gls.left[11] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.orange, colors.line_bg}
    }
}

gls.left[12] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.red, colors.line_bg}
    }
}

gls.left[13] = {
    LeftEnd = {
        provider = function()
            return " "
        end,
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[14] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[15] = {
    Space = {
        provider = function()
            return " "
        end,
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[16] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.blue, colors.bg}
    }
}

HasFunction = nil;

-- gls.right[1] = {
--   funcIcon = {
--     provider = function ()
--       return " "
--     end,
--     highlight = {colors.yellow, colors.bg},
--     condition = function()
--       print(vim.api.nvim_eval('nvim_treesitter#statusline(90)'))
--       return vim.api.nvim_eval('nvim_treesitter#statusline(90)') ~= nil and checkwidth() and buffer_not_empty() and not is_term()
--     end,
--   }
-- }

gls.right[2] = {
  funcText = {
    provider = function ()
      local statusLine = vim.api.nvim_eval('nvim_treesitter#statusline(120)')
      local funcName = statusLine ~= nil and string.match(statusLine, '%s*(%w+)%(') or nil
      if funcName ~= nil and string.len(funcName) > 0 then
        return " " .. funcName
      else
        return ""
      end
    end,
    highlight = {colors.nord, colors.bg},
    condition = function() return checkwidth() and buffer_not_empty() and not is_term() end,
  }
}

gls.right[3] = {
    projectIcon = {
        provider = function()
            return "  "
        end,
        highlight = {colors.purple, colors.line_bg},
        separator = " ",
        separator_highlight = {colors.fg, colors.bg},
        condition = function() return checkwidth() and buffer_not_empty() and not is_term() end,
    }
}

gls.right[4] = {
  project = {
    provider = function ()
      -- local path = vim.api.nvim_eval('projectroot#guess()')
      return string.match(vim.b.projectroot, '[^/]+$')
    end,
    highlight = {colors.purple, colors.bg},
    condition = function() return checkwidth() and buffer_not_empty() and not is_term() end,
  }
}

gls.right[5] = {
    LSPIcon = {
        provider = function()
            return " 煉"
        end,
        separator = " ",
        separator_highlight = {colors.fg, colors.bg},
        condition = function()
          return require("galaxyline.condition").check_active_lsp() and checkwidth()
        end,
        highlight = {colors.fg, colors.line_bg}
    }
}

gls.right[6] = {
  LSP = {
    provider = "GetLspClient",
    highlight = {colors.fg, colors.bg},
    condition = function()
      return require("galaxyline.condition").check_active_lsp() and checkwidth()
    end,
  }
}

gls.right[7] = {
    GitIcon = {
        provider = function()
            return "  "
        end,
        condition = function()
          return require("galaxyline.condition").check_git_workspace() and checkwidth()
        end,
        highlight = {colors.green, colors.line_bg},
        separator = " ",
        separator_highlight = {colors.fg, colors.bg},
    }
}

gls.right[8] = {
    GitBranch = {
        provider = "GitBranch",
        condition = function()
          return require("galaxyline.condition").check_git_workspace() and checkwidth()
        end,
        highlight = {colors.green, colors.line_bg}
    }
}

gls.right[9] = {
    SizeIcon = {
        provider = function()
            return " "
        end,
        condition = function() return checkwidth() and buffer_not_empty() and not is_term() end,
        highlight = {colors.cyan, colors.line_bg},
        separator = " ",
        separator_highlight = {colors.fg, colors.bg},
    }
}

gls.right[10] = {
    FileSize = {
        provider = "FileSize",
        condition = function() return checkwidth() and buffer_not_empty() and not is_term() end,
        highlight = {colors.cyan, colors.line_bg}
    }
}

gls.right[11] = {
    right_LeftRounded = {
        provider = function()
            return ""
        end,
        separator = " ",
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.lightbg, colors.bg},
    }
}


gls.right[12] = {
    PerCent = {
        provider = "LinePercent",
        highlight = {colors.fg, colors.lightbg},
    }
}

gls.right[13] = {
    Column = {
        provider = "LineColumn",
        highlight = {colors.bg, colors.fg},
        separator = " ",
        separator_highlight = {colors.bg, colors.fg},
    }
}

gls.right[14] = {
    rightRounded = {
        provider = function()
            return ""
        end,
        highlight = {colors.fg, colors.bg},
    }
}

gls.short_line_left[1] = {
    shortleftbound = {
        provider = function()
            return ""
        end,
        highlight = {colors.lightbg, colors.bg}
    }
}

gls.short_line_left[2] = {
    ShortFileIcon = {
        provider = "FileIcon",
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
    }
}

gls.short_line_left[3] = {
    ShortFileName = {
        provider = {"FileName", "FileSize"},
        highlight = {colors.fg, colors.lightbg}
    }
}

gls.short_line_left[4] = {
    shortrightbound = {
        provider = function()
            return ""
        end,
        separator = " ",
        highlight = {colors.lightbg, colors.bg}
    }
}
