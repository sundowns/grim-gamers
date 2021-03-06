assert(assets.structures.saw)
assert(anim8)

return {
    id = "SAW",
    image = assets.structures.saw,
    grid = anim8.newGrid(32, 32, assets.structures.saw:getWidth(), assets.structures.saw:getHeight()),
    animation_names = {
        "DEFAULT"
    },
    layers = {
        {
            DEFAULT = {
                frame_duration = 0.07,
                x = '1-3',
                y = 1,
                offset_x = 0,
                offset_y = 0,
                rotate_to_target = false,
                rotation = 0
            }
        }
    }
}
