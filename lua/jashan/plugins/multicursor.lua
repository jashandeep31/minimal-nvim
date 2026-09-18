return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local set = vim.keymap.set

		-- Add or skip cursors above/below the main cursor.
		set({ "n", "x" }, "<Up>", function()
			mc.lineAddCursor(-1)
		end, { desc = "Add multicursor above" })
		set({ "n", "x" }, "<Down>", function()
			mc.lineAddCursor(1)
		end, { desc = "Add multicursor below" })
		set({ "n", "x" }, "<leader><Up>", function()
			mc.lineSkipCursor(-1)
		end, { desc = "Skip line above" })
		set({ "n", "x" }, "<leader><Down>", function()
			mc.lineSkipCursor(1)
		end, { desc = "Skip line below" })

		-- Add or skip cursors matching the word or visual selection.
		set({ "n", "x" }, "<leader>n", function()
			mc.matchAddCursor(1)
		end, { desc = "Add next matching cursor" })
		set({ "n", "x" }, "<leader>N", function()
			mc.matchAddCursor(-1)
		end, { desc = "Add previous matching cursor" })
		set({ "n", "x" }, "<leader>s", function()
			mc.matchSkipCursor(1)
		end, { desc = "Skip next matching cursor" })
		set({ "n", "x" }, "<leader>S", function()
			mc.matchSkipCursor(-1)
		end, { desc = "Skip previous matching cursor" })

		-- Mouse and cursor enable/disable support.
		set("n", "<C-LeftMouse>", mc.handleMouse, { desc = "Add multicursor with mouse" })
		set("n", "<C-LeftDrag>", mc.handleMouseDrag)
		set("n", "<C-LeftRelease>", mc.handleMouseRelease)
		set({ "n", "x" }, "<C-q>", mc.toggleCursor, { desc = "Toggle multicursors" })

		-- These mappings are active only while multiple cursors exist.
		mc.addKeymapLayer(function(layer_set)
			layer_set({ "n", "x" }, "<Left>", mc.prevCursor, { desc = "Previous multicursor" })
			layer_set({ "n", "x" }, "<Right>", mc.nextCursor, { desc = "Next multicursor" })
			layer_set({ "n", "x" }, "<leader>x", mc.deleteCursor, { desc = "Delete multicursor" })
			layer_set("n", "<Esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end, { desc = "Clear multicursors" })
		end)
	end,
}
