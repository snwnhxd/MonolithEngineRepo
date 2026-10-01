local Monolith = {}

Monolith.Time     = require("engine.core.time")
Monolith.Input    = require("engine.core.input")
Monolith.Graphics = require("engine.graphics.renderer")

-- Estados del runtime
local STATE_UNINITIALIZED = "UNINITIALIZED"
local STATE_INITIALIZING  = "INITIALIZING"
local STATE_RUNNING       = "RUNNING"
local STATE_SHUTTING_DOWN = "SHUTTING_DOWN"
local STATE_SHUTDOWN      = "SHUTDOWN"

local state = STATE_UNINITIALIZED

local function buildConfig(userConfig)
    userConfig = userConfig or {}

    local title = userConfig.title
    if title == nil then
        title = "Monolith Engine"
    else
        assert(type(title) == "string" and #title > 0, 
        "Monolith: config.title debe ser un string no vacio"
        )
    end

    local width = userConfig.width
    if width == nil then
        width = 1280
    else
        assert(
            type(width) == "number" and width > 0 and width % 1 == 0,
            "Monolith: config.width debe ser un entero positivo mayor a 0"
        )
    end

    local height = userConfig.height
    if height == nil then
        height = 720
    else
        assert(
            type(height) == "number" and height > 0 and height % 1 == 0,
            "Monolith: config.height debe ser un entero positivo mayor a 0"
        )
    end

    local resizable = userConfig.resizable
    if resizable == nil then
        resizable = true
    else
        assert(type(resizable) == "boolean", "Monolith: config.resizable debe ser un boolean")
    end

    local maximized = userConfig.maximized
    if maximized == nil then
        maximized = false
    else
        assert(type(maximized) == "boolean", "Monolith: config.maximized debe ser un boolean")
    end

    local vsync = userConfig.vsync
    if vsync == nil then
        vsync = true
    else
        assert(type(vsync) == "boolean", "Monolith: config.vsync debe ser un boolean")
    end

    return {
        window = {
            title = title,
            width = width,
            height = height,
            resizable = resizable,
            maximized = maximized
        },
        graphics = {
            vsync = vsync
        }
    }
end

function Monolith.init(userConfig)
    assert(state == STATE_UNINITIALIZED, "Monolith no se puede inicializar en estado: " .. state)
    
    state = STATE_INITIALIZING
    print("[Monolith] Validando UserConfig...")
    
    local runtimeConfig = buildConfig(userConfig)

    print("[Monolith] Inicializando Core v0.1...")

    Monolith.Time.init()
    Monolith.Input.init()
    Monolith.Graphics.init(runtimeConfig.window, runtimeConfig.graphics)

    state = STATE_RUNNING
    print("[Monolith] Estado cambiado a RUNNING.")
end

function Monolith.update(dt)
    assert(state == STATE_RUNNING, "Se intento llamar a Monolith.update() fuera de RUNNING")

    Monolith.Time.update(dt)
    Monolith.Input.update(dt)
end

function Monolith.render()
    assert(state == STATE_RUNNING, "Se intento llamar a Monolith.render() fuera de RUNNING")

    Monolith.Graphics.beginFrame()
    Monolith.Graphics.endFrame()
end

function Monolith.shutdown()
    if state ~= STATE_RUNNING then return end

    state = STATE_SHUTTING_DOWN
    print("[Monolith] Apagando subsistemas...")

    Monolith.Graphics.shutdown()
    Monolith.Input.shutdown()
    Monolith.Time.shutdown()

    state = STATE_SHUTDOWN
    print("[Monolith] Runtime apagado correctamente.")
end

function Monolith.getState()
    return state
end

return Monolith

