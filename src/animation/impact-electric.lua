assert(assets.particles.impact)
assert(anim8)

return {
    id = "IMPACT-ELECTRIC",
    image = assets.particles.impact,
    grid = anim8.newGrid(32, 32, assets.particles.impact:getWidth(), assets.particles.impact:getHeight()),
    animation_names = {
        "DEFAULT"
    },
    layers = {
        {
            DEFAULT = {
                frame_duration = 0.12,
                x = '1-3',
                y = 4,
                offset_x = 0,
                offset_y = 0,
                scale_x = 0.025,
                scale_y = 0.025,
                rotation = 0
            }
        }
    }
}