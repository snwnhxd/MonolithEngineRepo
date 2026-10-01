local Renderer = {}
local loveBackend = require("engine/graphics/backends/love_backend")

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

