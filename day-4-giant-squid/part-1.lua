#!/usr/bin/env lua
header = io.read("*l")
_ = io.read("*l")

local rows = {}

while true do
	local line = io.read("*l")

	if not line or line == "" then
		local start = #rows - #rows[#rows].row + 1
		local width = #rows - start + 1

		local board = {}

		for i=1,width do
			local row = {row = {}, board = {}}
			for ii=0,width-1 do -- zero index for `start` offset
				table.insert(row.row, tonumber(rows[start+ii].row[i]))
				table.insert(board, tonumber(rows[start+ii].row[i]))
			end
			table.insert(rows, row)
		end

		for i=0,width*2-1 do -- zero index for `start` offset
			rows[start+i].board = board
		end

		if not line then
			break
		end
		goto continue
	end

	local row = {row = {}, board = {}}

	for v in string.gmatch(line, "(%d+)") do
		table.insert(row.row, tonumber(v))
	end

	table.insert(rows, row)

	::continue::
end

for draw in string.gmatch(header, "(%d+)") do
	local draw = tonumber(draw)

	for i=#rows,1,-1 do
		for ii=#rows[i].row,1,-1 do
			if rows[i].row[ii] == draw then
				table.remove(rows[i].row, ii)
			end
		end

		for ii=#rows[i].board,1,-1 do
			if rows[i].board[ii] == draw then
				table.remove(rows[i].board, ii)
			end
		end

		if #rows[i].row == 0 then
			local sum = 0
			for _,v in pairs(rows[i].board) do
				sum = sum + v
			end

			print(sum * draw)

			goto done
		end
	end
end
::done::
