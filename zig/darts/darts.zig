pub const Coordinate = struct {
    x: f32,
    y: f32,

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return .{ .x = x_coord, .y = y_coord };
    }

    pub fn score(self: Coordinate) usize {
        const r = self.x * self.x + self.y * self.y;
        return if (r <= 1) 10 else if (r <= 25) 5 else if (r <= 100) 1 else 0;
    }
};
