local Mesh = {}
Mesh.__index = Mesh

function Mesh.new(handle, vertexCount, layout)
    local self = setmetatable({}, Mesh)
    
    self._handle = handle
    self._vertexCount = vertexCount
    self._layout = layout
    
    return self
end

function Mesh:getVertexCount()
    return self._vertexCount
end

function Mesh:getLayout()
    return self._layout
end

function Mesh:_getBackendHandle()
    return self._handle
end

return Mesh

