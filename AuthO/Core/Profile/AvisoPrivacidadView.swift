//
//  AvisoPrivacidadView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 09/10/25.
//

import SwiftUI

struct AvisoPrivacidadView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Divider()
                    
                    Image(systemName: "hand.raised.app.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.blue)
                        .padding(.top)
                        .frame(maxWidth: .infinity)
                    
                    Group {
                        Text("""
                        **¿Para qué fines utilizaremos sus datos personales?**

                        Los datos personales que recabamos de usted, los utilizaremos para las siguientes finalidades que son necesarias para el servicio que solicita:

                        • Envío de información acerca de los programas de la organización  
                        • Prospección comercial

                        De manera adicional, utilizaremos su información personal para las siguientes finalidades secundarias que no son necesarias para el servicio solicitado, pero que nos permiten y facilitan brindarle una mejor atención:

                        • Mercadotecnia o publicitaria  
                        • Registros estadísticos de uso de materiales de la organización

                        En caso de que no desee que sus datos personales se utilicen para estos fines secundarios, indíquelo a continuación:  
                        No consiento que mis datos personales se utilicen para los siguientes fines:  
                        [ ] Mercadotecnia o publicitaria  
                        [ ] Registros estadísticos de uso de materiales de la organización

                        La negativa para el uso de sus datos personales para estas finalidades no podrá ser un motivo para que le neguemos los servicios y productos que solicita o contrata con nosotros.
                        """)
                        
                        Text("""
                        **¿Qué datos personales utilizaremos para estos fines?**

                        Para llevar a cabo las finalidades descritas en el presente aviso de privacidad, utilizaremos los siguientes datos personales:

                        • Datos de identificación  
                        • Datos de contacto  
                        • Datos laborales  
                        • Datos académicos  
                        • Datos patrimoniales y/o financieros

                        Además, para las finalidades informadas utilizaremos los siguientes datos personales considerados como **sensibles**, que requieren de especial protección:

                        • Datos sobre vida sexual  
                        • Datos de origen étnico o racial
                        """)
                    }

                    Group {
                        Text("""
                        **¿Cómo puede acceder, rectificar o cancelar sus datos personales, u oponerse a su uso?**

                        Usted tiene derecho a conocer qué datos personales tenemos de usted, para qué los utilizamos y las condiciones del uso que les damos (**Acceso**). Asimismo, es su derecho solicitar la **Rectificación**, **Cancelación** u **Oposición** (derechos ARCO).

                        Para el ejercicio de cualquiera de los derechos ARCO, deberá presentar la solicitud respectiva a través del siguiente medio:  
                        **ayuda@t6i.872.myftpupload.com**

                        Los datos de contacto de la persona o departamento de datos personales son los siguientes:

                        • **Nombre:** Oscar Ortega  
                        • **Domicilio:** Retorno Ruiseñor 12, Col. Mayorazgos del Bosque, Atizapán de Zaragoza, México, C.P. 52957  
                        • **Correo electrónico:** ayuda@t6i.872.myftpupload.com
                        """)
                        
                        Text("""
                        **Revocación del consentimiento**

                        Usted puede revocar el consentimiento que nos haya otorgado para el tratamiento de sus datos personales. Sin embargo, tenga en cuenta que no en todos los casos podremos atender su solicitud o concluir el uso de forma inmediata.

                        Para revocar su consentimiento deberá presentar su solicitud a través del siguiente medio:  
                        **ayuda@t6i.872.myftpupload.com**
                        """)
                        
                        Text("""
                        **¿Cómo puede limitar el uso o divulgación de su información personal?**

                        Con objeto de que usted pueda limitar el uso y divulgación de su información personal, le ofrecemos los siguientes medios:  
                        **ayuda@t6i.872.myftpupload.com**

                        Asimismo, puede inscribirse en el **Registro Público para Evitar Publicidad (PROFECO)**.
                        """)
                        
                        Text("""
                        **El uso de tecnologías de rastreo en nuestro portal de internet**

                        En nuestra página utilizamos cookies, web beacons u otras tecnologías, a través de las cuales es posible monitorear su comportamiento como usuario de internet.

                        Los datos personales que recabamos a través de estas tecnologías, los utilizaremos para fines **estadísticos** y **publicitarios**.

                        Los datos que obtenemos incluyen:

                        • Identificadores, nombre de usuario y contraseñas de una sesión  
                        • Idioma preferido  
                        • Región en la que se encuentra el usuario  
                        • Tipo de navegador y sistema operativo  
                        • Fecha y hora del inicio y final de sesión  
                        • Páginas visitadas y búsquedas realizadas  
                        • Publicidad revisada  
                        • Listas y hábitos de consumo
                        """)
                        
                        Text("""
                        **¿Cómo puede conocer los cambios en este aviso de privacidad?**

                        El presente aviso de privacidad puede sufrir modificaciones o actualizaciones derivadas de nuevos requerimientos legales o de cambios en nuestro modelo de negocio.

                        Nos comprometemos a mantenerlo informado sobre los cambios a través de nuestro sitio web.

                        **Última actualización: 30/11/2023**
                        """)
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Aviso de Privacidad")
        }
    }
}

#Preview {
    AvisoPrivacidadView()
}
