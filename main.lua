local Monolith = require("engine/core/monolith")

function love.load()
    Monolith.init({
        title = "Monolith Engine v0.1",
        width = 1280,
        height =  720,
        maximized = true,
        resizable = true,
        vsync = false
    })
end

function love.update(dt)
    Monolith.update(dt)
end

function love.draw()
    Monolith.render()
end

function love.quit()
    Monolith.shutdown()
end

