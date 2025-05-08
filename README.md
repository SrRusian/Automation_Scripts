# 🛠️ Automation Scripts

Este repositorio contiene una colección de scripts en Bash diseñados para automatizar tareas simples en entornos Linux. Actualmente está enfocado en la **gestión de usuarios simulada**, **operaciones basicas** e **instalacion/configuracion personalizada de entorno**, utilizando archivos planos como base de datos. Son útiles como material de práctica, introducción a la automatización y referencia en entornos controlados.

## 📁 Carpeta: `user-management/`

Scripts dedicados a la creación, verificación y eliminación de usuarios en un sistema simulado.

### Contenido:

| Script | Descripción |
|--------|-------------|
| `crearCuenta.sh` | Crea un nuevo usuario y lo registra en `usuarios.txt`. |
| `eliminarCuenta.sh` | Elimina a un usuario existente del archivo de usuarios. |
| `verificarUsuario.sh` | Verifica si un usuario está registrado. |
| `usuarios.txt` | Archivo donde se almacenan los registros simulados de usuarios. |

## 📁 Carpeta: `tests/`

Scripts dedicados a pruebas o practicas.

### Contenido:

| Script | Descripción |
|--------|-------------|
| `consecutivos.sh` | Genera o gestiona consecutivos únicos para nuevas cuentas. |
| `operaciones.sh` | Script central para ejecutar las operaciones básicas del sistema. |

## 📁 Carpeta: `customKaliConfigurations/`

Scripts dedicados a la personalizacion del sistema Kali de forma automatizada.

### Contenido:

| Script | Descripción |
|--------|-------------|
| `customSetup.sh` | Ejecucion de configuraciones propias automatizadas para facilitar la reinstalacion del sistema. |

> ⚠️ **Nota:** Estos scripts no alteran usuarios reales del sistema, son puramente educativos y operan sobre archivos `.txt`.

---

## 🚀 Uso

1. Clona el repositorio:

```bash
git clone https://github.com/SrRusian/Automation_Scripts.git
