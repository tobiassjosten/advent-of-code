const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var safeReports: u32 = 0;

    var buf: [64]u8 = undefined;
    while (try stdin.readUntilDelimiterOrEof(&buf, '\n')) |report| {
        const levels = try split(report);

        if (isSafe(levels)) {
            safeReports += 1;
        }
    }

    try stdout.print("{d}\n", .{safeReports});
}

fn split(s: []u8) ![]u8 {
    const allocator = std.heap.page_allocator;
    var levels = std.ArrayList(u8).init(allocator);
    defer levels.deinit();

    var parts = std.mem.split(u8, s, " ");
    while (parts.next()) |part| {
        const level = try std.fmt.parseInt(u8, part, 10);
        try levels.append(level);
    }

    return levels.toOwnedSlice();
}

fn splice(slice : []u8, index: usize) []u8 {
    var allocator = std.heap.page_allocator;
    var result = allocator.alloc(u8, slice.len - 1) catch unreachable;

    if (index > 0) {
        @memcpy(result[0..index], slice[0..index]);
    }

    if (index < slice.len - 1) {
        @memcpy(result[index..], slice[index + 1..]);
    }

    return result;
}

fn isSafe(levels: []u8) bool {
    if (_isSafe(levels)) {
        return true;
    }

    for (0..levels.len) |i| {
        if (_isSafe(splice(levels, i))) {
            return true;
        }
    }

    return false;
}

fn _isSafe(levels : []u8) bool {
    var descending: ?bool = null;
    var previous: u8 = levels[0];

    for (levels[1..]) |level| {
        defer previous = level;

        const diff: u8 = if (previous > level) previous - level else level - previous;

        if (descending == null) {
            descending = previous > level;
        }

        if (diff > 3 or diff == 0 or descending != (previous > level)) {
            return false;
        }
    }

    return true;
}
