# Monolith prototype.

Un proyecto personal con fines de entretenimiento y aprendizaje.

## Notas:

- configuración RunTime/Usuario, experimental.
- "Renderer" consume unicamente sus secciones.
- "BackendConfig" plano y especifico.
- "imGay" Implícito.

- declaración de Layout y Stride.
- validación de geometría 'Renderer.createMesh'.
- Mesh wrapper abstracto.
- el backend recibe la tabla agnóstica del motor y la traduce al formato nativo que necesita.
- inyección de "shader 3D" copilando un Vertex y PixelShader básico en el backend.
- todavia no es un render 3D, necesito una representación matemática que lo transforme.

