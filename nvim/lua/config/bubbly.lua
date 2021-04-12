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
    fg = "#494b53",
    fg_green = "#50a14f",
    yellow = "#A3BE8C",
    cyan = "#0184bc",
    darkblue = "#61afef",
    green = "#50a14f",
    orange = "#FF8800",
    purple = "#a626a4",
    magenta = "#c678dd",
    blue = "#61afef",
    red = "#DF8890",
    lightbg = "#d3d3d3",
    nord = "#81A1C1",
    greenYel = "#EBCB8B"
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end
local mode_color = {n = colors.fg, i = colors.blue,v=colors.purple,
  [''] = colors.purple,V=colors.purple,
  c = colors.magenta,no = colors.red,s = colors.orange,
  S=colors.orange,[''] = colors.orange,
  ic = colors.yellow,R = colors.nord,Rv = colors.nord,
  cv = colors.red,ce=colors.red, r = colors.cyan,
  rm = colors.cyan, ['r?'] = colors.cyan,
  ['!']  = colors.red,t = colors.red}


-- gl.section.short_line_left = {{
--     FileIcon = {
--         provider = "FileIcon",
--         condition = buffer_not_empty,
--         highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
--     }
-- }}

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
                n = "NORMAL ",
                i = "INSERT ",
                c = "COMMAND ",
                V = "VISUAL ",
                [""] = "VISUAL ",
                v = "VISUAL ",
                R = "REPLACE "
            }
            vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color[vim.fn.mode()])
            vim.api.nvim_command('hi GalaxystatusIcon guibg='..mode_color[vim.fn.mode()])
            vim.api.nvim_command('hi GalaxyleftRounded guifg='..mode_color[vim.fn.mode()])
            vim.api.nvim_command('hi GalaxyleftRounded guifg='..mode_color[vim.fn.mode()])
            return alias[vim.fn.mode()]
        end,
        separator = " ",
        separator_highlight = {colors.fg, colors.lightbg},
        highlight = {colors.bg, colors.fg}
    }
}

gls.left[4] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
    }
}

gls.left[5] = {
    FileName = {
        provider = {"FileName"},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.lightbg},
        -- separator = "│ ",
        -- separator_highlight = {colors.fg, colors.lightbg},
    }
}

-- gls.left[6] = {
--     FileSize = {
--         provider = {"FileSize"},
--         condition = buffer_not_empty,
--         highlight = {colors.fg, colors.lightbg},
--     }
-- }

gls.left[6] = {
    teech = {
        provider = function()
            return ""
        end,
        separator = " ",
        highlight = {colors.lightbg, colors.bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

gls.left[7] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.green, colors.line_bg}
    }
}

gls.left[8] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.orange, colors.line_bg}
    }
}

gls.left[9] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.red, colors.line_bg}
    }
}

gls.left[10] = {
    LeftEnd = {
        provider = function()
            return " "
        end,
        separator = " ",
        separator_highlight = {colors.line_bg, colors.line_bg},
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[11] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[12] = {
    Space = {
        provider = function()
            return " "
        end,
        highlight = {colors.line_bg, colors.line_bg}
    }
}

gls.left[13] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.blue, colors.bg}
    }
}

gls.right[1] = {
    LSPIcon = {
        provider = function()
            return " 煉 "
        end,
        condition = require("galaxyline.condition").check_active_lsp and checkwidth,
        highlight = {colors.fg, colors.line_bg}
    }
}

gls.right[2] = {
  LSP = {
    provider = "GetLspClient",
    highlight = {colors.fg, colors.bg},
    condition = require("galaxyline.condition").check_active_lsp and checkwidth,
  }
}

gls.right[3] = {
    GitIcon = {
        provider = function()
            return "   "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace and checkwidth,
        highlight = {colors.green, colors.line_bg},
        separator = " ",
        separator_highlight = {colors.fg, colors.bg},
    }
}

gls.right[4] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace and checkwidth,
        highlight = {colors.green, colors.line_bg}
    }
}

gls.right[5] = {
    right_LeftRounded = {
        provider = function()
            return ""
        end,
        separator = " ",
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.lightbg, colors.bg}
    }
}


gls.right[6] = {
    PerCent = {
        provider = "LinePercent",
        highlight = {colors.fg, colors.lightbg},
    }
}

gls.right[7] = {
    Column = {
        provider = "LineColumn",
        highlight = {colors.bg, colors.fg},
        separator = " ",
        separator_highlight = {colors.bg, colors.fg},
    }
}

gls.right[8] = {
    rightRounded = {
        provider = function()
            return ""
        end,
        highlight = {colors.fg, colors.bg}
    }
}

gls.short_line_left[1] = {
    shortLeftRounded = {
        provider = function()
            return ""
        end,
        highlight = {colors.lightbg, colors.bg}
    }
}

gls.short_line_left[2] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        -- highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
        highlight = {colors.red, colors.red}
    }
}

gls.short_line_left[3] = {
    FileName = {
        provider = {"FileName", "FileSize"},
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.lightbg}
    }
}

gls.short_line_left[4] = {
    teech = {
        provider = function()
            return ""
        end,
        separator = " ",
        highlight = {colors.lightbg, colors.bg}
    }
}
