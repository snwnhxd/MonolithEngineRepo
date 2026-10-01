local Time = {}

Time.dt = 0
Time.elapsed = 0

function Time.init()
    Time.dt = 0
    Time.elapsed = 0
end

function Time.update(dt)
    Time.dt = dt
    Time.elapsed = Time.elapsed + dt
end

function Time.shutdown()
    Time.dt = 0
    Time.elapsed = 0
end

return Time

