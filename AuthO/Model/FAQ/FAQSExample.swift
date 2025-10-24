//
//  FAQSExample.swift
//  AuthO
//
//  Created by Leoni Bernabe on 11/10/25.
//

import Foundation

struct FAQsExample {
    static let all: [FAQModel] = [
        FAQModel(
            id: 1,
            question: "¿Qué es la aplicación ScamWatch?",
            description: "ScamWatch es una herramienta para reportar sitios web fraudulentos (phishing, scam y páginas maliciosas). Los reportes enviados son revisados por un equipo de administradores y analistas de ciberseguridad, quienes validan la amenaza y comparten inteligencia con proveedores y entidades pertinentes para ayudar a proteger a otros usuarios."
        ),
        FAQModel(
            id: 2,
            question: "¿Puedo reportar de forma anónima?",
            description: "Sí. Puedes enviar reportes de forma anónima si así lo prefieres. Si decides identificarte, tu información solo se usará para seguimiento del caso y contacto en caso de requerir más evidencia. La opción anónima limita el contacto posterior pero no impide la revisión del reporte."
        ),
        FAQModel(
            id: 3,
            question: "¿Cómo se revisan y validan los reportes?",
            description: "Cuando recibimos un reporte, nuestros administradores realizan un análisis automático inicial (comprobación de listas negras, reputación y contenido) y luego una revisión manual. Si el sitio es malicioso se marca, se genera un informe técnico y, cuando aplica, se notifica a proveedores de hosting, navegadores y autoridades para su mitigación."
        ),
        FAQModel(
            id: 4,
            question: "¿De qué manera ayuda esto a la ciberseguridad?",
            description: "Cada reporte validado enriquece una base de datos de inteligencia sobre amenazas que usamos para bloquear sitios maliciosos, alertar a la comunidad y colaborar con equipos de respuesta. Esto reduce la exposición de usuarios y facilita acciones preventivas a nivel técnico y legal."
        ),
        FAQModel(
            id: 5,
            question: "¿Qué tipo de evidencia puedo adjuntar en un reporte?",
            description: "Puedes adjuntar capturas de pantalla, URL, encabezados HTTP, correos sospechosos (en texto) y cualquier otro archivo que ayude a la verificación. Procura no compartir información sensible (contraseñas, números de tarjeta). Los administradores usarán la evidencia para acelerar la clasificación y el bloqueo del sitio."
        ),
        FAQModel(
            id: 6,
            question: "¿Mis datos están seguros y cómo se usan?",
            description: "Sí. Los datos que proporciones se almacenan con medidas de seguridad y solo se usan para la gestión del reporte, contacto con el denunciante y mejora de la plataforma. No vendemos tu información. Si quieres ejercer derechos ARCO o solicitar eliminación, consulta la sección de privacidad dentro de la app."
        )
    ]
}
