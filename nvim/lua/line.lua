local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local gls = gl.section
-- can also use mid
local normal = {"NORMAL", colors.orange}
local insert = {"INSERT", colors.green}
local visual = {"VISUAL", colors.magenta}

local mode_map = {
		   n = normal,
		   no = normal,
		   v = visual, 
		   V = visual, 
		   cv = {"VISUAL BLOCK", colors.violet},
		   i = insert
}

local mode_name = function() return mode_map[vim.fn.mode()] and mode_map[vim.fn.mode()][1] or 'N/A' end
local mode_highlight = function() return mode_map[vim.fn.mode()] and mode_map[vim.fn.mode()][2] or colors.blue end

gls.left[2] = {
  ViMode = {
   provider = function()
           vim.api.nvim_command('hi GalaxyViMode guifg='..mode_highlight()..' guibg='..colors.bg..' gui=bold')
           return string.format(' %s', mode_name())
   end,
  },
}

local ayu_mirage = {
bg = '#202328',
fg = '#bbc2cf',
yellow = '#ECBE7B',
cyan = '#008080',
darkblue = '#081633',
green = '#98be65',
orange = '#FF8800',
violet = '#a9a1e1',
magenta = '#c678dd',
blue = "#242b38",
red = '#ec5f67';

}
