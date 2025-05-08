#!/bin/bash

# Información Personal
# Usuario: Emmanuel Camacho Moctezuma
# Fecha: 20/11/2024
# Descripción: Este script verifica si un usuario existe en el sistema operativo.

if [ $# -ne 1 ]; then
  echo "Uso: $0 <nombre_de_usuario>"
  exit 1
fi

usuario=$1

if id "$usuario" &>/dev/null; then
  echo "El usuario '$usuario' está registrado en el sistema."
else
  echo "El usuario '$usuario' NO está registrado en el sistema."
fi
