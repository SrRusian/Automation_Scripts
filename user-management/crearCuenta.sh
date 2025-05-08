#!/bin/bash

# Información Personal
# Usuario: [Tu Nombre o Apodo]
# Fecha: [Fecha de creación]
# Descripción: Este script lee un archivo con nombres y cuentas, y crea cuentas de usuario con directorios personales.

if [ $# -ne 1 ]; then
  echo "Uso: $0 <archivo_de_usuarios>"
  exit 1
fi

archivo=$1

# Verificar que el archivo existe y es legible
if [ ! -f "$archivo" ] || [ ! -r "$archivo" ]; then
  echo "El archivo $archivo no existe o no se puede leer."
  exit 1
fi

while IFS=' ' read -r nombre cuenta; do
  # Validación de columnas del archivo
  if [ -z "$nombre" ] || [ -z "$cuenta" ]; then
    echo "Línea inválida: '$nombre $cuenta'."
    continue
  fi

  # Verificar si la cuenta ya existe
  if id "$cuenta" &>/dev/null; then
    echo "La cuenta '$cuenta' ya existe. Omitiendo..."
    continue
  fi

  # Crear la cuenta y el directorio personal
  sudo useradd -m -c "$nombre" "$cuenta"
  if [ $? -eq 0 ]; then
    echo "Cuenta '$cuenta' creada para '$nombre'."
  else
    echo "Error al crear la cuenta '$cuenta'."
  fi
done < "$archivo"
