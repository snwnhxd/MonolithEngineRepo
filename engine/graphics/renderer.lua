local Renderer = {}

local loveBackend = require("engine.graphics.backends.love_backend")
local Mesh = require("engine.graphics.mesh")

local function validateMeshContract(vertices, layout)
    assert(type(layout) == "table" and #layout > 0, "Monolith: 'layout' debe ser una tabla no vacia")
    assert(type(vertices) == "table" and #vertices > 0, "Monolith: 'vertices' debe ser una tabla no vacia")

    local expectedComponents = 0

    for i, attr in ipairs(layout) do
        assert(type(attr.name) == "string" and #attr.name > 0, 
            "Monolith: layout[" .. i .. "].name debe ser un string valido")
        assert(attr.type == "float", 
            "Monolith: layout[" .. i .. "].type actualmente solo soporta 'float'")
        assert(type(attr.components) == "number" and attr.components >= 1 and attr.components <= 4 and attr.components % 1 == 0,
            "Monolith: layout[" .. i .. "].components debe ser un entero entre 1 y 4")

        expectedComponents = expectedComponents + attr.components
    end

    for i, vertex in ipairs(vertices) do
        assert(type(vertex) == "table", 
            "Monolith: vertices[" .. i .. "] debe ser una tabla de componentes")
        assert(#vertex == expectedComponents, 
            "Monolith: Vertice " .. i .. " invalido. El layout requiere " .. expectedComponents .. 
            " componentes, pero se recibieron " .. #vertex)
            
        for j, val in ipairs(vertex) do
            assert(type(val) == "number", 
                "Monolith: Componente " .. j .. " del vertice " .. i .. " debe ser un numero")
        end
    end
end

function Renderer.init(windowConfig, graphicsConfig)
    
    local backendConfig = {
        title = windowConfig.title,
        width = windowConfig.width,
        height = windowConfig.height,
        resizable = windowConfig.resizable,
        maximized = windowConfig.maximized,
        vsync = graphicsConfig.vsync
    }

    loveBackend.init(backendConfig)
end

function Renderer.createMesh(vertices, layout)
    validateMeshContract(vertices, layout)

    local handle = loveBackend.createMesh(vertices, layout)

    return Mesh.new(handle, #vertices, layout)
end

function Renderer.drawMesh(mesh)
    assert(mesh and mesh._getBackendHandle, "Renderer.drawMesh: Se esperaba un objeto Mesh de Monolith valido")

    local handle = mesh:_getBackendHandle()
    loveBackend.drawMesh(handle)
end

function Renderer.beginFrame()
    loveBackend.clear(0.05, 0.05, 0.08, 1.0)
end

function Renderer.endFrame()
    loveBackend.present()
end

function Renderer.shutdown()
    loveBackend.shutdown()
end

return Renderer

