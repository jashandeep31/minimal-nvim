return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")

		mc.setup()

		-- Match occurrences
		vim.keymap.set({ "n", "v" }, "<leader>mn", function()
			mc.matchAddCursor(1)
		end, { desc = "MultiCursor Next Match" })

		vim.keymap.set({ "n", "v" }, "<leader>ma", mc.matchAllAddCursors, { desc = "MultiCursor All Matches" })

		-- Vertical cursors
		vim.keymap.set({ "n", "v" }, "<leader>mj", function()
			mc.lineAddCursor(1)
		end, { desc = "MultiCursor Below" })

		vim.keymap.set({ "n", "v" }, "<leader>mk", function()
			mc.lineAddCursor(-1)
		end, { desc = "MultiCursor Above" })

		-- Remove cursor
		vim.keymap.set({ "n", "v" }, "<leader>mx", mc.deleteCursor, { desc = "MultiCursor Delete" })

		-- Clear all cursors
		vim.keymap.set({ "n", "v" }, "<Esc>", function()
			if mc.hasCursors() then
				mc.clearCursors()
			else
				vim.cmd("stopinsert")
			end
		end)
	end,
}
