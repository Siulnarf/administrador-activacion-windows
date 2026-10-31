# Administrador de activación de Windows

Utilidad de consola con menú en español para consultar y administrar la activación de Windows mediante las herramientas incluidas en el sistema.

Se distribuye como un archivo `.bat`, no requiere compilación ni instalar programas adicionales.

Desarrollada por **Franluis Maldonado**, con asistencia de **Codex**.

## Funciones

| Opción | Acción |
| --- | --- |
| 1 | Consultar los detalles de la licencia y activación (`slmgr /dlv`). |
| 2 | Consultar el vencimiento de la activación (`slmgr /xpr`). |
| 3 | Instalar una clave de producto (`slmgr /ipk`). |
| 4 | Configurar un servidor KMS autorizado (`slmgr /skms`). |
| 5 | Intentar activar Windows con la configuración actual (`slmgr /ato`). |
| 6 | Quitar el servidor KMS manual y restaurar su detección automática (`slmgr /ckms`). |
| 0 | Salir. |

Cada operación que modifica la configuración solicita confirmación. El programa muestra la respuesta original de Windows para revisar el resultado o el código de error.

## Requisitos

- Windows con CMD, Windows PowerShell, Windows Script Host y `slmgr.vbs` disponibles.
- Permisos de administrador para las operaciones de modificación.
- Una licencia válida para la edición instalada o autorización para utilizar el KMS de tu organización.
- Conectividad con el servicio de activación correspondiente.

## Descarga

Desde este repositorio puedes descargar:

- **Activacion-Windows.bat:** programa listo para utilizar.
- **Activacion-Windows.zip:** paquete con el programa y las instrucciones.

Para descargar todo el repositorio, selecciona **Code → Download ZIP** y extrae su contenido.

## Uso

1. Descarga el BAT o extrae el paquete ZIP.
2. Abre `Activacion-Windows.bat` para consultar detalles y vencimiento.
3. Para modificar la configuración, haz clic derecho en el BAT y selecciona **Ejecutar como administrador**.
4. Selecciona una opción del menú.
5. Introduce los datos solicitados.
6. Confirma la operación y revisa el resultado mostrado por Windows.

En los campos de clave y servidor puedes pulsar **Enter** sin escribir nada para cancelar.

En las confirmaciones, únicamente la respuesta `S`, sin distinguir entre mayúscula y minúscula, autoriza la operación.

## Claves de producto

El programa no incluye claves de producto ni concede licencias de Windows.

- La clave debe corresponder a la edición instalada.
- Windows Pro y Windows Pro for Workstations son ediciones diferentes.
- El programa comprueba el formato de la clave; Windows determina si es válida y aplicable.
- Instalar una clave reemplaza la existente. Conserva previamente tus datos de licencia.
- Las claves genéricas no conceden una licencia.

## Servidores KMS

Utiliza únicamente un servidor autorizado por tu organización.

El campo admite un nombre DNS o IPv4 y un puerto opcional:

    kms.empresa.local:1688

Este nombre es ilustrativo y no corresponde a un servidor incluido en el programa.

- No se incluyen servidores KMS públicos.
- No se admiten direcciones IPv6 literales en el campo.
- Windows Home no admite activación KMS. El programa bloquea su configuración cuando el identificador de edición comienza con `Core`.
- Configurar un servidor manual desactiva la detección automática de KMS.
- Quitar ese servidor restaura la detección automática; no recupera la clave anterior ni garantiza la reactivación.
- Puede ser necesario conectarse a la red o VPN de tu organización.
- KMS normalmente utiliza TCP 1688, salvo que el administrador indique otro puerto.

## Seguridad y privacidad

El código del programa:

- No descarga ni instala componentes adicionales.
- No modifica el firewall, Defender, SmartScreen ni la política de ejecución de PowerShell.
- No realiza cambios de activación al abrirse.
- Solicita confirmación antes de modificar la configuración.
- No guarda las claves ingresadas en archivos de registro propios.

La clave se introduce de forma visible en la consola y se pasa como argumento a la herramienta de Windows. Las herramientas de auditoría o supervisión del equipo podrían registrar información del proceso.

No publiques claves de producto ni datos sensibles en capturas, incidencias o contribuciones.

## Limitaciones

- Una activación exitosa no sustituye la necesidad de contar con una licencia válida.
- La compatibilidad depende de la edición, configuración y políticas del equipo.
- El programa muestra la salida original de Windows; no interpreta automáticamente todos sus códigos de error.
- Las políticas de una organización pueden restringir BAT, PowerShell, Windows Script Host o las conexiones necesarias.
- Los archivos BAT o ZIP pueden recibir advertencias al descargarse o compartirse.
- Convertir el BAT a EXE no garantiza que desaparezcan esas advertencias.

Ante un bloqueo, consulta al administrador del equipo y utiliza un canal de distribución permitido.

## Pruebas y validación

El autor informa haber utilizado el programa varias veces para activar Windows con resultados satisfactorios.

Durante su creación se reportó la comprobación de la sintaxis de los bloques de PowerShell y las referencias a etiquetas del menú. La revisión posterior del código fue estática y no ejecutó cambios de licencia ni de configuración KMS.

No se dispone todavía de una matriz documentada de versiones, ediciones y escenarios probados. Los resultados obtenidos no garantizan compatibilidad con todos los equipos o políticas de Windows.

## Archivos del repositorio

| Archivo | Contenido |
| --- | --- |
| `Activacion-Windows.bat` | Código del programa. |
| `Activacion-Windows.zip` | Paquete de distribución original. |
| `LEEME.txt` | Instrucciones originales en texto plano. |
| `README.md` | Documentación del repositorio. |

## Reportar un problema

Abre una incidencia en la sección **Issues** e incluye:

- Versión y edición de Windows.
- Opción del menú utilizada.
- Mensaje o código de error mostrado.
- Si ejecutaste el programa como administrador.

Oculta cualquier clave de producto o información privada antes de adjuntar capturas.

## Documentación oficial

- [Opciones de slmgr.vbs — Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/get-started/activation-slmgr-vbs-options)
- [Claves de cliente KMS — Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/get-started/kms-client-activation-keys)

## Autor

**Franluis Maldonado**  
GitHub: [@Siulnarf](https://github.com/Siulnarf)

Proyecto desarrollado con asistencia de Codex.
