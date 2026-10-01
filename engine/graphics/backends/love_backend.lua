local loveBackend = {}

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
end

function loveBackend.clear(r, g, b, a)
    love.graphics.clear(r, g, b, a)
end

function loveBackend.present()
    -- ...
end

function loveBackend.shutdown()´
    -- ...
end

return loveBackend

