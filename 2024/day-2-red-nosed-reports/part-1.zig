const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var safeReports: u32 = 0;

    var buf: [64]u8 = undefined;
    outer: while (try stdin.readUntilDelimiterOrEof(&buf, '\n')) |report| {
        var levels = std.mem.split(u8, report, " ");

        var previous: u8 = 0;
        var descending: ?bool = null;

        while (levels.next()) |slevel| {
            const level = try std.fmt.parseInt(u8, slevel, 10);
            defer previous = level;

            if (previous == 0) {
                continue;
            }

            const diff: u8 = if (previous > level) previous - level else level - previous;

            if (diff > 3 or diff == 0) {
                continue :outer;
            }

            if (descending == null) {
                descending = previous > level;
                continue;
            }

            if (descending != (previous > level)) {
                continue :outer;
            }
        }

        safeReports += 1;
    }

    try stdout.print("{d}\n", .{safeReports});
}
