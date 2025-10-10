# Diagrama ER - Librería en Línea

## Explicación del Diagrama ER

El diagrama muestra cómo funciona la base de datos de una librería en línea, donde los clientes pueden comprar libros y cada pedido queda registrado con sus detalles.

### Entidades principales
- **Cliente**: guarda los datos de las personas que hacen compras, como su nombre, correo y dirección de envío.  
- **Pedido**: representa cada compra que realiza un cliente, incluyendo la fecha y el total a pagar.  
- **Libro**: contiene la información de los libros disponibles, como el título, autor, precio y su código ISBN.  
- **Categoría**: sirve para clasificar los libros por tipo, por ejemplo: ficción, tecnología, historia, etc.

### Tablas intermedias
- **Pedido_Libro**: conecta los pedidos con los libros y guarda cuántas unidades de cada libro se compraron.  
- **Libro_Categoría**: relaciona los libros con las categorías a las que pertenecen.

### Relaciones
- Un cliente puede tener varios pedidos.  
- Un pedido puede incluir varios libros, y un libro puede estar en distintos pedidos.  
- Un libro puede pertenecer a una o más categorías, y una categoría puede tener varios libros.  

En general, el diagrama ayuda a entender cómo se conectan los clientes, los libros y los pedidos dentro del sistema de la librería.



##  Diagrama ER 

![Diagrama ER – Librería](diagrama.png)





##  Código Mermaid 

```mermaid
```mermaid
erDiagram
    CLIENTE {
        int cliente_id PK
        string nombre
        string email
        string direccion_envio
    }

    PEDIDO {
        int pedido_id PK
        date fecha_pedido
        decimal total
        int cliente_id FK
    }

    LIBRO {
        int libro_id PK
        string titulo
        string autor
        decimal precio
        string isbn
    }

    CATEGORIA {
        int categoria_id PK
        string nombre
        string descripcion
    }

    PEDIDO_LIBRO {
        int pedido_id FK
        int libro_id FK
        int cantidad
    }

    LIBRO_CATEGORIA {
        int libro_id FK
        int categoria_id FK
    }

    CLIENTE ||--o{ PEDIDO : realiza
    PEDIDO  ||--o{ PEDIDO_LIBRO : contiene
    LIBRO   ||--o{ PEDIDO_LIBRO : aparece_en
    LIBRO   ||--o{ LIBRO_CATEGORIA : clasificado_como
    CATEGORIA ||--o{ LIBRO_CATEGORIA : agrupa
