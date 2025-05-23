# 🛠️ Automation Scripts

This repository contains a collection of Bash scripts designed to automate simple tasks in Linux environments. It is currently focused on **simulated user management**, **basic operations**, and **custom environment setup/configuration**, using plain text files as a database. These scripts are useful for practice, introductory automation learning, and as references in controlled environments.

## 📁 Folder: `user-management/`

Scripts dedicated to the creation, verification, and deletion of users in a simulated system.

### Contents:

| Script                | Description                                            |
| --------------------- | ------------------------------------------------------ |
| `crearCuenta.sh`      | Creates a new user and registers it in `usuarios.txt`. |
| `eliminarCuenta.sh`   | Removes an existing user from the user file.           |
| `verificarUsuario.sh` | Checks if a user is registered.                        |
| `usuarios.txt`        | File used to store simulated user records.             |

## 📁 Folder: `tests/`

Scripts dedicated to testing and practice.

### Contents:

| Script            | Description                                               |
| ----------------- | --------------------------------------------------------- |
| `consecutivos.sh` | Generates or manages unique identifiers for new accounts. |
| `operaciones.sh`  | Central script to execute the system's basic operations.  |

## 📁 Folder: `customKaliConfigurations/`

Scripts for automating the customization of the Kali system.

### Contents:

| Script           | Description                                                                 |
| ---------------- | --------------------------------------------------------------------------- |
| `customSetup.sh` | Executes automated custom configurations to simplify system reinstallation. |

> ⚠️ **Note:** These scripts do not modify real system users — they are purely educational and operate on `.txt` files only.

---

## 🚀 Usage

1. Clone the repository:

```bash
git clone https://github.com/SrRusian/Automation_Scripts.git
```
