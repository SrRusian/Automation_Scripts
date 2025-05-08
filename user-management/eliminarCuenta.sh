#!/bin/bash

# Información Personal
# Usuario: [Tu Nombre o Apodo]
# Fecha: [Fecha de creación]
# Descripción: Este script lee un archivo con nombres y cuentas, y elimina completamente las cuentas y sus directorios personales.

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

  # Verificar si la cuenta existe
  if id "$cuenta" &>/dev/null; then
    # Eliminar la cuenta y su directorio personal
    sudo userdel -r "$cuenta"
    if [ $? -eq 0 ]; then
      echo "Cuenta '$cuenta' y su directorio personal eliminados."
    else
      echo "Error al eliminar la cuenta '$cuenta'."
    fi
  else
    echo "La cuenta '$cuenta' no existe. Omitiendo..."
  fi
done < "$archivo"
