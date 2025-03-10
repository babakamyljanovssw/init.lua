function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    	'rose-pine/neovim',

	name = "rose-pine",

	config = function()
		require("rose-pine").setup({
			disable_backgrund = true,
			styles = {
				italic = false,
			},
		})

		ColorMyPencils();
	end
}
