# LoveCook - Aplicación de Recetas con SwiftUI

LoveCook es una aplicación moderna y elegante de recetas que te permite explorar y descubrir una amplia variedad de deliciosas opciones culinarias. Con una interfaz intuitiva y funciones avanzadas, LoveCook hace que cocinar sea una experiencia aún más placentera. La aplicación se conecta a la API de Recetas de [TheMealDB](https://www.themealdb.com/api.php) para ofrecer una amplia gama de recetas organizadas por categorías.

## Características Destacadas

- Todo el proyecto está desarrollado en **SwiftUI**.
- La aplicación utiliza autenticación con **Firebase** para la gestión de usuarios, lo que facilita la creación de cuentas y el inicio de sesión seguro.
- LoveCook ofrece tres modos de inicio de sesión:
  - Inicio de sesión con **email y contraseña**.
  - Inicio de sesión social con **cuenta Apple**.
  - Inicio de sesión social con **cuenta Google** `(recomendado por la integración de datos de usuario y avatar)`.
- **Persistencia local**: Utiliza **Core Data** para el almacenamiento local de recetas favoritas.
- **Persistencia remota**: Utiliza **Cloud Firestore** para cargar imágenes de recetas personales del usuario en el servidor de Firebase.
- Se utiliza **GridLayout** para mostrar los diferentes listados de imágenes y categorías.
- **Funcionalidad de gestos:** Los usuarios pueden eliminar las recetas favoritas mediante gestos de deslizamiento lateral (swipe actions).
- Se pueden subir imágenes desde la **Galería de Fotos** del dispositivo a la base de datos.

## Arquitectura
La aplicación LoveCook sigue el patrón Clean Architecture y está organizada en varias capas:

- **Data:** Contiene la lógica para acceder y manipular los datos, el acceso a Cloud Firestore y CoreData.
- **NetworkClient:** Gestiona todas las operaciones de red, incluida la interacción con la API de Recetas.
- **Mappers:** Transforma los datos entre las capas de la aplicación.
- **Entities:** Define las entidades fundamentales de la aplicación.
- **UseCases:** Contiene casos de uso específicos de la aplicación.
- **Features:** Contiene todas las vistas de la aplicación con sus correspondientes view models.
- **Widgets:** Incluye componentes reutilizables, como vistas o modificadores, que mejoran la modularidad de la aplicación.
- **Utils:** Incluye componentes de utilidad, como la gestión de permisos para el acceso a la galería de fotos del dispositivo.

## Librerías externas
- Librería Firebase: [Firebase](https://github.com/firebase/firebase-ios-sdk.git)
- Librería para cargar imágenes desde web: [Kingfisher](https://github.com/onevcat/Kingfisher.git)
- Librería para mostrar toast: [Toast-Swift](https://github.com/BastiaanJansen/toast-swift)
- Librería Lottie para animaciones: [Lottie](https://github.com/airbnb/lottie-spm.git)
- Librería para reproductor de vídeos: [Youtube Player Kit](https://github.com/SvenTiigi/YouTubePlayerKit.git)

> [!NOTE]
>### Configuración del Proyecto
>1. Clona este repositorio: `git clone https://github.com/laurazp/Lovecook_app.git`
>2. Abre el proyecto en Xcode: `open LoveCook.xcodeproj`
>3. Asegúrate de instalar las dependencias utilizando Swift Package Manager.

> [!IMPORTANT]
>### Requisitos
>- Xcode 15.0 o posterior
>- Swift 5.9
>- Conexión a Internet para acceder a la API de Recetas y a las funciones de inicio de sesión.
>- Otorgar permisos de archivos multimedia para poder acceder a las fotos de la Galería del dispositivo.

¡Disfruta cocinando con LoveCook! Si tienes alguna pregunta o sugerencia, no dudes en [contactarnos](mailto:luridevlabs@gmail.com). ¡Buen provecho!
