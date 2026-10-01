local loveBackend = {}

local defaultShader = nil
local shaderCode = [[
    varying vec4 vColor;

    #ifdef VERTEX
    vec4 position(mat4 transform_projection, vec4 vertex_position) {
        vColor = VertexColor;
        return transform_projection * vertex_position;
    }
    #endif

    #ifdef PIXEL
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
        return vColor;
    }
    #endif
]]

local function translateLayout(monolithLayout)
    local loveFormat = {}
    
    for _, attr in ipairs(monolithLayout) do
        table.insert(loveFormat, { attr.name, "float", attr.components })
    end
    
    return loveFormat
end

function loveBackend.createMesh(vertices, layout)
    local loveFormat = translateLayout(layout)
    return love.graphics.newMesh(loveFormat, vertices, "triangles", "static")
end

function loveBackend.drawMesh(loveMesh)
    love.graphics.setShader(defaultShader)
    
    local cx = love.graphics.getWidth() / 2
    local cy = love.graphics.getHeight() / 2
    love.graphics.draw(loveMesh, cx, cy, 0, 300, 300)
    
    love.graphics.setShader()
end

function loveBackend.init(backendConfig)
    love.window.setTitle(backendConfig.title)
    love.window.setMode(backendConfig.width, backendConfig.height, {
        resizable = backendConfig.resizable,
        vsync = backendConfig.vsync,
        minwidth = 320,
        minheight = 240
    })

    if backendConfig.maximized then
        love.window.maximize()
    end

    defaultShader = love.graphics.newShader(shaderCode)
end

function loveBackend.clear(r, g, b, a)
    love.graphics.clear(r, g, b, a)
end

function loveBackend.present()
    -- ...
end

function loveBackend.shutdown()
    defaultShader = nil
end

return loveBackend

