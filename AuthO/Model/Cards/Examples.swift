//
//  Examples.swift
//  AuthO
//
//  Created by Leoni Bernabe on 25/09/25.
//

import Foundation

struct ExampleCategories {
    static let compras = CategoryModel(
            id: 1,
            name: "Compras",
            icon: "cart.badge.questionmark",
            description: "Reportes de fraudes relacionados con compras en línea o físicas. Incluye casos donde se realizaron cargos no autorizados, productos que nunca llegaron, o tiendas que resultaron ser falsas o engañosas."
        )
        
        static let phishing = CategoryModel(
            id: 2,
            name: "Phishing",
            icon: "envelope.badge.shield.half.filled",
            description: "Intentos de engaño mediante correos electrónicos, mensajes de texto o llamadas telefónicas que suplantan la identidad de entidades confiables para obtener información personal, contraseñas o datos bancarios."
        )
        
        static let apps = CategoryModel(
            id: 3,
            name: "Apps",
            icon: "app.badge.checkmark",
            description: "Aplicaciones móviles o de escritorio que simulan ser legítimas pero que contienen malware, solicitan permisos innecesarios o realizan cobros no autorizados. También incluye apps falsas que imitan servicios conocidos."
        )
        
        static let bancos = CategoryModel(
            id: 4,
            name: "Bancos",
            icon: "banknote.fill",
            description: "Estafas vinculadas a instituciones bancarias o financieras. Puede tratarse de llamadas fraudulentas, páginas web falsas de bancos o mensajes que buscan robar credenciales o acceder a cuentas bancarias."
        )
        
        static let redes = CategoryModel(
            id: 5,
            name: "Redes",
            icon: "person.2.slash.fill",
            description: "Casos de fraude cometidos a través de redes sociales o plataformas de mensajería. Incluye suplantación de perfiles, mensajes engañosos de conocidos, y fraudes en grupos o comunidades digitales."
        )
        
        static let inversion = CategoryModel(
            id: 6,
            name: "Inversión",
            icon: "chart.line.downtrend.xyaxis",
            description: "Esquemas fraudulentos que prometen grandes ganancias con inversiones mínimas. Incluye estafas con criptomonedas, pirámides financieras, o plataformas de inversión que desaparecen tras recibir dinero."
        )
        
        static let viajes = CategoryModel(
            id: 7,
            name: "Viajes",
            icon: "airplane.path.dotted",
            description: "Estafas relacionadas con paquetes turísticos falsos, reservas inexistentes o agencias de viaje fraudulentas. También abarca casos de promociones engañosas para vuelos, hoteles o alquiler de autos."
        )
        
        static let identidad = CategoryModel(
            id: 8,
            name: "Identidad",
            icon: "person.crop.circle.badge.exclamationmark",
            description: "Situaciones donde una persona ha sido víctima de robo de identidad. Puede incluir el uso indebido de datos personales para abrir cuentas, realizar compras, solicitar créditos u otros actos fraudulentos."
        )
        
        static let otra = CategoryModel(
            id: 999,
            name: "Otra",
            icon: "questionmark.circle",
            description: "Reportes de fraudes o estafas que no encajan en ninguna de las categorías anteriores. Puede tratarse de nuevos métodos de engaño o situaciones poco comunes que requieren análisis adicional."
        )

        static let all: [CategoryModel] = [
            compras, phishing, apps, bancos,
            redes, inversion, viajes, identidad, otra
        ]
}

struct ExampleUsers {
    static let ana = UserModel(
        id: "u1",
        name: "Ana López",
        email: "ana.lopez@example.com",
        creationDate: Date(timeIntervalSinceNow: -86400 * 14), // ~200 days ago
        profileImageUrl: "https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/media/image/2020/12/star-wars-general-leia-organa-2180815.jpg?tf=3840x",
        updateDate: Date()
    )

    static let carlos = UserModel(
        id: "u2",
        name: "Carlos Ramírez",
        email: "carlos.ramirez@example.com",
        creationDate: Date(timeIntervalSinceNow: -86400 * 150),
        profileImageUrl: "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
        updateDate: Date()
    )

    static let maria = UserModel(
        id: "u3",
        name: "María Fernández",
        email: "maria.fernandez@example.com",
        creationDate: Date(timeIntervalSinceNow: -86400 * 90),
        profileImageUrl: "https://i.redd.it/zw0i302m0luc1.jpeg",
        updateDate: Date()
    )

    static let pedro = UserModel(
        id: "u4",
        name: "Pedro Sánchez",
        email: "pedro.sanchez@example.com",
        creationDate: Date(timeIntervalSinceNow: -86400 * 50),
        profileImageUrl: "https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg?semt=ais_hybrid&w=740&q=80",
        updateDate: Date()
    )

    static let all: [UserModel] = [ana, carlos, maria, pedro]
}

struct ExampleComments {
    static let comment1 = ComentaryModel(
        id: 1,
        user: ExampleUsers.ana,
        content: "Me pasó algo similar, perdí dinero en una tienda en línea falsa.",
        createdAt: Date(timeIntervalSinceNow: -86400 * 5),
        likes: 23,
        comments: []
    )

    static let comment2 = ComentaryModel(
        id: 2,
        user: ExampleUsers.maria,
        content: "Gracias por compartir, voy a tener más cuidado con este tipo de correos.",
        createdAt: Date(timeIntervalSinceNow: -86400 * 2),
        likes: 15,
        comments: []
    )

    static let replyToComment3 = ComentaryModel(
        id: 3,
        user: ExampleUsers.ana,
        content: "Sí, es mejor siempre verificar la dirección del remitente.",
        createdAt: Date(timeIntervalSinceNow: -86400),
        likes: 7,
        comments: []
    )

    static let comment3 = ComentaryModel(
        id: 4,
        user: ExampleUsers.maria,
        content: "Yo también caí en una app fraudulenta, muy parecido a este caso.",
        createdAt: Date(timeIntervalSinceNow: -86400 * 3),
        likes: 9,
        comments: [replyToComment3]
    )

    static let all: [ComentaryModel] = [comment1, comment2, comment3]
}

struct ExampleCards {
    static let cards: [CardModel] = [
        CardModel(
            id: 1001,
            titulo: "Tienda electrónica falsa",
            descripcion: "Ofrecía laptops a precios muy bajos. Los clientes nunca recibieron los productos.",
            url: "https://www.alertafraude.mx/reportes/1001",
            imageUrl: "https://images-wixmp-530a50041672c69d335ba4cf.wixmp.com/templates/image/34041b678f8322dd95446ca0e0ee3d4caebb59008a7aa3f8922a8461c268fe6d1617888011678.jpg",
            user: ExampleUsers.ana,
            categoria: ExampleCategories.compras,
            creationDate: Date(timeIntervalSinceNow: -86400 * 12),
            status: "active",
            likes: 124,
            comments: [ExampleComments.comment1, ExampleComments.comment2, ExampleComments.comment3, ExampleComments.replyToComment3]
        ),
        CardModel(
            id: 1002,
            titulo: "Correo de phishing bancario",
            descripcion: "Usuarios recibieron correos que simulaban ser de un banco, solicitando datos de acceso.",
            url: "https://www.alertafraude.mx/reportes/1002",
            imageUrl: "https://mbluxury1.s3.amazonaws.com/2020/07/14065242/BankWAW-website-design.jpg",
            user: ExampleUsers.carlos,
            categoria: ExampleCategories.phishing,
            creationDate: Date(timeIntervalSinceNow: -86400 * 11),
            status: "active",
            likes: 312,
            comments: [ExampleComments.comment2]
        ),
        CardModel(
            id: 1003,
            titulo: "App de descuentos fraudulentos",
            descripcion: "Una aplicación prometía grandes descuentos, pero robaba datos bancarios.",
            url: "https://www.alertafraude.mx/reportes/1003",
            imageUrl: "https://www.templateshub.net/uploads/1570009401%20CouponDay%20Clean%20Premium%20Coupon%20Template.jpg",
            user: ExampleUsers.maria,
            categoria: ExampleCategories.apps,
            creationDate: Date(timeIntervalSinceNow: -86400 * 10),
            status: "active",
            likes: 198,
            comments: [ExampleComments.comment3]
        ),
        CardModel(
            id: 1004,
            titulo: "Falsos créditos inmediatos",
            descripcion: "Un sitio pedía depósitos por 'gastos de gestión' y nunca otorgaba el crédito.",
            url: "https://www.alertafraude.mx/reportes/1004",
            imageUrl: "https://themewagon.com/wp-content/uploads/2020/11/credit-1.jpg",
            user: ExampleUsers.pedro,
            categoria: ExampleCategories.bancos,
            creationDate: Date(timeIntervalSinceNow: -86400 * 9),
            status: "active",
            likes: 265,
            comments: []
        ),
        CardModel(
            id: 1005,
            titulo: "Perfil falso en redes sociales",
            descripcion: "Cuentas se hacían pasar por celebridades para pedir dinero a seguidores.",
            url: "https://www.alertafraude.mx/reportes/1005",
            imageUrl: "https://miro.medium.com/v2/resize:fit:1400/0*sVJDL0GdqXDxzynj.jpg",
            user: ExampleUsers.ana,
            categoria: ExampleCategories.redes,
            creationDate: Date(timeIntervalSinceNow: -86400 * 8),
            status: "active",
            likes: 432,
            comments: []
        ),
        CardModel(
            id: 1006,
            titulo: "Inversión en criptomonedas inexistentes",
            descripcion: "Un sitio ofrecía inversiones en criptomonedas que no existían.",
            url: "https://www.alertafraude.mx/reportes/1006",
            imageUrl: "https://themewagon.com/wp-content/uploads/2020/11/crypto-1.jpg",
            user: ExampleUsers.carlos,
            categoria: ExampleCategories.inversion,
            creationDate: Date(timeIntervalSinceNow: -86400 * 7),
            status: "active",
            likes: 289,
            comments: []
        ),
        CardModel(
            id: 1007,
            titulo: "Publicidad de viajes falsos",
            descripcion: "Promocionaban viajes todo incluido a mitad de precio. Nunca se confirmaron boletos.",
            url: "https://www.alertafraude.mx/reportes/1007",
            imageUrl: "https://mbluxury1.s3.amazonaws.com/2024/06/25074513/Travel-Website-Design-Tour-Radar.jpg",
            user: ExampleUsers.maria,
            categoria: ExampleCategories.viajes,
            creationDate: Date(timeIntervalSinceNow: -86400 * 6),
            status: "active",
            likes: 150,
            comments: []
        ),
        CardModel(
            id: 1008,
            titulo: "Venta de consolas inexistentes",
            descripcion: "Prometían entregas inmediatas de consolas en preventa, pero nunca se enviaron.",
            url: "https://www.alertafraude.mx/reportes/1008",
            imageUrl: "https://static.vecteezy.com/system/resources/previews/009/521/560/non_2x/online-gaming-concept-website-landing-page-with-game-console-free-illustration-background-free-vector.jpg",
            user: ExampleUsers.pedro,
            categoria: ExampleCategories.compras,
            creationDate: Date(timeIntervalSinceNow: -86400 * 5),
            status: "active",
            likes: 375,
            comments: []
        ),
        CardModel(
            id: 1009,
            titulo: "Correo con archivo sospechoso",
            descripcion: "Un correo con un supuesto recibo contenía un archivo malicioso.",
            url: "https://www.alertafraude.mx/reportes/1009",
            imageUrl: "https://www.lifewire.com/thmb/GYpSjFecUJX2Ktls5ZCKPIDvc_g=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/gmail-select-insert-link-2681bddad62a4b34afe7c732995bd003.jpg",
            user: ExampleUsers.ana,
            categoria: ExampleCategories.phishing,
            creationDate: Date(timeIntervalSinceNow: -86400 * 4),
            status: "active",
            likes: 210,
            comments: []
        ),
        CardModel(
            id: 1010,
            titulo: "Suplantación de identidad en trámites",
            descripcion: "Un portal imitaba páginas de gobierno para robar datos personales.",
            url: "https://www.alertafraude.mx/reportes/1010",
            imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4y9X3Kv9wa0Biax50gBdST0EwkhQPZQG6ow&s",
            user: ExampleUsers.carlos,
            categoria: ExampleCategories.identidad,
            creationDate: Date(timeIntervalSinceNow: -86400 * 3),
            status: "active",
            likes: 498,
            comments: []
        )
    ]
}

//struct ExampleSeachCards {
//    static let searchCards: [SearchCardModel] = [
//        SearchCardModel(card: ExampleCards.cards[0], relatedFields: ["Descripcion", "Titulo"])
//    ]
//}
