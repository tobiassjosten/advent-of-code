#!/usr/bin/env lua
header = io.read("*l")
_ = io.read("*l")

local rows = {}
local boardid = 0

while true do
	local line = io.read("*l")

	if not line or line == "" then
		boardid = boardid + 1

		local start = #rows - #rows[#rows].row + 1
		local width = #rows - start + 1

		local board = {}

		for i=1,width do
			table.insert(rows, {row = {}})
			for ii=0,width-1 do -- zero index for `start` offset
				table.insert(rows[#rows].row, tonumber(rows[start+ii].row[i]))
				table.insert(board, tonumber(rows[start+ii].row[i]))
			end
		end

		for i=0,width*2-1 do -- zero index for `start` offset
			rows[start+i].board = board
			rows[start+i].boardid = boardid
		end

		if not line then
			break
		end
		goto continue
	end

	local row = {}

	table.insert(rows, {row = {}})
	for v in string.gmatch(line, "(%d+)") do
		table.insert(rows[#rows].row, tonumber(v))
	end

	::continue::
end

local winner = nil

for draw in string.gmatch(header, "(%d+)") do
	local draw = tonumber(draw)

	local boardremoval = {}

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
			winner = rows[i]
			winner.draw = draw
			table.insert(boardremoval, rows[i].boardid)
		end
	end

	for _, boardid in ipairs(boardremoval) do
		for i=#rows,1,-1 do
			if boardid == rows[i].boardid then
				table.remove(rows, i)
			end
		end
	end
end
::done::

local sum = 0
for _,v in pairs(winner.board) do
	sum = sum + v
end

print(sum * winner.draw)
