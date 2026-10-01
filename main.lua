local Monolith = require("engine/core/monolith")

local mesh = nil

function love.load()
    Monolith.init({
        title = "Monolith Engine v0.1",
        width = 1280,
        height =  720,
        maximized = true,
        resizable = true,
        vsync = false
    })

    local layout = {
        { name = "VertexPosition", type = "float", components = 3},
        { name = "VertexColor", type = "float", components = 3}
    }

    local vertices = {
        -- x,   y,   z,     r,   g,   b
        {  0.0,  0.5, 0.0,   1.0, 0.0, 0.0 },
        { -0.5, -0.5, 0.0,   0.0, 1.0, 0.0 },
        {  0.5, -0.5, 0.0,   0.0, 0.0, 1.0 }
    }

    mesh = Monolith.Graphics.createMesh(vertices, layout)
end

function love.update(dt)
    Monolith.update(dt)
end

function love.draw()
    Monolith.render()

    if mesh then
        Monolith.Graphics.drawMesh(mesh)
    end
end

function love.quit()
    Monolith.shutdown()
end

