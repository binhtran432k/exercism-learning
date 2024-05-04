(module
  ;;
  ;; Score a dart throw based on its coordinates.
  ;;
  ;; @param {f32} x - The x coordinate of the dart.
  ;; @param {f32} y - The y coordinate of the dart.
  ;;
  ;; @returns {i32} - The score of the dart throw (10, 5, 1, or 0).
  ;;
  (func (export "score") (param $x f32) (param $y f32) (result i32)
    (local $distance f32)

    local.get $x
    local.get $x
    f32.mul

    local.get $y
    local.get $y
    f32.mul

    f32.add
    local.set $distance

    local.get $distance
    f32.const 100
    f32.gt
    (if (then (return (i32.const 0))))

    local.get $distance
    f32.const 25
    f32.gt
    (if (then (return (i32.const 1))))

    local.get $distance
    f32.const 1
    f32.gt
    (if (then (return (i32.const 5))))

    (return (i32.const 10))
  )
)
