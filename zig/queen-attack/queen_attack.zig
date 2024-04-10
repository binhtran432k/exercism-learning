const math = @import("std").math;

pub const QueenError = error{
    InitializationFailure,
};

pub const Queen = struct {
    row: i8,
    col: i8,

    pub fn init(row: i8, col: i8) QueenError!Queen {
        if (row < 0 or row > 7 or col < 0 or col > 7)
            return error.InitializationFailure;

        return .{ .row = row, .col = col };
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        return isSameRowOrCol(self, other) or isDiagonal(self, other);
    }

    fn isSameRowOrCol(self: Queen, other: Queen) bool {
        return self.col == other.col or self.row == other.row;
    }

    fn isDiagonal(self: Queen, other: Queen) bool {
        return math.absCast(self.col - other.col) == math.absCast(self.row - other.row);
    }
};
