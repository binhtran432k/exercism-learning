pub fn binarySearch(comptime T: type, target: T, items: []const T) ?usize {
    var left: usize = 0;
    var right: usize = items.len;
    while (left < right) {
        const mid = @divTrunc(right + left, 2);
        const curr_value = items[mid];
        if (target < curr_value) {
            right = mid;
        } else if (target > curr_value) {
            left = mid + 1;
        } else {
            return mid;
        }
    }
    return null;
}
