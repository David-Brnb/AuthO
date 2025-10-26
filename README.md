# oFraud - Mobile(iOS)

![License](https://img.shields.io/badge/license-MIT-green)
![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Coverage](https://img.shields.io/badge/coverage-85%25-yellowgreen)
---

## Descripción

Este repositorio contiene todo lo relacionado con la **aplicación móvil** del proyecto **oFraud**, una plataforma web y móvil enfocada en la **seguridad de los usuarios**, permitiendo realizar **reportes de fraude** en sitios y páginas web.

<div align="center">
  <img src="https://raw.githubusercontent.com/David-Brnb/AuthO/main/AuthO/readme_images/login.png" alt="Login page" width="300"/>
</div>

<div align="center">
  <img src="https://raw.githubusercontent.com/David-Brnb/AuthO/main/AuthO/readme_images/profile.png" alt="Profile page" width="300"/>
</div>

<div align="center">
  <img src="https://raw.githubusercontent.com/David-Brnb/AuthO/main/AuthO/readme_images/reports.png" alt="Reports page" width="300"/>
</div>

<div align="center">
  <img src="https://raw.githubusercontent.com/David-Brnb/AuthO/main/AuthO/readme_images/charts.png" alt="Charts page" width="300"/>
</div>


En este repositorio nos enfocamos en la cosntrucción de una aplicación móvil para los usuarios

El repositorio incluye:
* **Frontend**: representación gráfica de los datos del usuario y de la aplicación, teniendo interacciones entre la aplicación web y el backend para realizar el registro de datos ingresados mediante la aplicación web. 

---

## Tecnologías y versiones recomendadas
- **Swift**: 6.2
- **Xcode**: 26.0
- **KingFisher**: 8.0

---

## Instalación

Sigue estos pasos para poner en marcha la aplicación localmente:

```bash
# Clonar el repositorio
https://github.com/David-Brnb/AuthO.git
cd AuthO

# Configurar variables de entorno
cp .env.example .env
# Edita .env con tus credenciales y configuraciones

```
---

## Ejecución
```bash
# Abrir Xcode
para abrir y correr la aplicación lo que se tiene que hacer es abrir el archivo descargado en github con Xcode. 
```
----

## Uso

Pasa su uso se debe tener el [`backend`](https://github.com/etxsA/backend-ofraud)  de esta aplicación funcionando, y corriendo de forma local en la computadora en la cual se intentará correr este proyecto. 

Al correr el proyecto la primera pantalla será el inicio de sesión de aquí podremos ya sea iniciar sesión o navegar hacia la pantalla de registro, en la cual se pediran los datos de inicio de sesión así como una foto de perfil al usuario. 

Posterior a haber iniciado sesión dentro de la aplicación se podrá acceder a los siguientes apartados: 
- Perfil: 
    - Contiene información personal del usuario como el nombre de usuario y la foto de perfil. 
    - Contiene información relacionada a los reportes del usuario así como una vista general de estos. 
    - Permite ver información general como FAQs, descripción de las categorías, y el aviso de privacidad. 
    - Tiene la opción para salir del perfil. 


- Reportes: 
    - Contiene los reportes más relevantes de la aplicación.
    - Permite filtrar los reportes por categoría. 
    - Permite crear un nuevo reporte. 


- Gráficas
    - Contiene 4 diferentes graficas con descripciones del desempeño del usuario y de los usuarios dentro de la aplicación. 

- Buscar
    - Contiene una vista general de todos los reportes dentro de la aplicación, y a su vez una barra de busqueda, los filtros se pueden hacer por distintos componentes del reporte. 

---

## Estructura del Proyecto

```bash
AuthO/
├── AuthO
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   ├── AppIcon.appiconset
│   │   ├── Contents.json
│   │   ├── CustomBlue.colorset
│   │   ├── add_photo.imageset
│   │   └── logo.imageset
│   ├── AuthOApp.swift
│   ├── ContentView.swift
│   ├── Controllers
│   │   ├── Auth
│   │   ├── Category
│   │   ├── Charts
│   │   ├── Feed
│   │   └── Profile
│   ├── Core
│   │   ├── Auth
│   │   ├── Charts
│   │   ├── Components
│   │   ├── Feed
│   │   ├── MainTab
│   │   ├── Profile
│   │   ├── Report
│   │   └── Search
│   ├── Extensions
│   │   ├── Color
│   │   └── String
│   ├── Launch Screen.storyboard
│   ├── Model
│   │   ├── Auth
│   │   ├── Cards
│   │   ├── Charts
│   │   ├── FAQ
│   │   ├── File
│   │   └── User
│   ├── Services
│   │   ├── Auth
│   │   ├── Category
│   │   ├── Charts
│   │   ├── Feed
│   │   ├── General
│   │   └── Profile
│   └── readme_images
│       ├── charts.png
│       ├── login.png
│       ├── profile.png
│       └── reports.png
├── AuthO.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcshareddata
│   │   └── xcuserdata
│   └── xcuserdata
│       └── leonibernabe.xcuserdatad
└── AuthOTest
    ├── ChartsTests.swift
    ├── ChartsTestsFail.swift
    ├── RecentReportsTests.swift
    ├── RecentReportsTestsFail.swift
    ├── ReportCreationTests.swift
    ├── ReportCreationTestsFail.swift
    ├── UserProfileTests.swift
    └── UserProfileTestsFail.swift

```

## Contribución

Instrucciones para contribuir al proyecto:

1. Haz un fork del repositorio
2. Crea tu rama (`git checkout -b feature/nueva-funcionalidad`)
3. Commit (`git commit -m 'Descripción del cambio'`)
4. Push (`git push origin feature/nueva-funcionalidad`)
5. Crea un Pull Request

---
## Fuentes de información
- Visit the [SwiftUI Documentation](https://developer.apple.com/swiftui/) to learn more about the language.
- Visit the [Swift Documentation](https://developer.apple.com/swift/) to learn more about the framlanguageework.
- Visit the [KingFisher Documentation](https://github.com/onevcat/Kingfisher) to learn more about the package.

---
## Colaboradores
- https://github.com/etxsA
- https://github.com/David-Brnb
- https://github.com/EmmanuelLopz

