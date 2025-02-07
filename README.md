# Manage App

## Proyecto de prueba técnica
- En el proyecto se utilizó y se realizaron las tareas solicitadas en el documento.
- Para acceder a la app puede ser con cualquiera de los siguientes usuarios.
  - Usuario: asignador
  - Contraseña: 123456
  - Usuario: repartidor1 
  - Contraseña: 123456
  - Usuario: cliente1
  - Contraseña: 123456

- Se hizo uso de MockAPI para obtener las ordenes a través de una API simulada.
    - Puede probarla a través de la siguiente URL: https://67a54225c0ac39787a1ddd1c.mockapi.io/api/v1/order
- Se utilizó Riverpod como manejador de estado, se hizo uso de Isar como base de datos local, y de Shared Preferences como manejador de datos persistentes, Clean Architecture para la arquitectura, se logró una app con bajo acoplamiento y alta cohesion y uso de otros patrones como Singleton y DRY.
- Se le hicieron otras mejoras y se le agregó el CI.yml para su correctra ejecución en el servidor de github.