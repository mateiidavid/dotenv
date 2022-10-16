local M = {}

-- map_keys(t: <table>) is a helper function that maps a table with given keymap
-- config globally.
-- t: {mode, lhs, rhs, opts = {}}
function M.map_keys(t)
	for _, v in pairs(t) do
		vim.api.nvim_set_keymap(v.mode, v.lhs, v.rhs, v.opts)
	end
end

return M
