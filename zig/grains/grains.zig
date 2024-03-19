const math = @import("std").math;

pub const ChessboardError = error{IndexOutOfBounds};

pub fn square(index: usize) ChessboardError!u64 {
    if (index < 1 or index > 64) return error.IndexOutOfBounds;
    return math.pow(u64, 2, index - 1);
}

pub fn total() u64 {
    return math.maxInt(u64);
}
