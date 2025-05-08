#!/bin/bash

# Información Personal
# Usuario: Emmanuel Camacho Moctezuma
# Fecha:  20/11/2024
# Descripción: Este script imprime los números consecutivos entre dos números dados.

if [ $# -ne 2 ]; then
  echo "Uso: $0 <número_inicial> <número_final>"
  exit 1
fi

inicio=$1
fin=$2

if [ $inicio -gt $fin ]; then
  echo "El primer número debe ser menor o igual al segundo."
  exit 1
fi

echo "Números consecutivos de $inicio a $fin:"
for (( i=inicio; i<=fin; i++ ))
do
  echo $i
done
