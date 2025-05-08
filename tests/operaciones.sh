#!/bin/bash

# Información Personal
# Usuario: Emmanuel Camacho Moctezuma
# Fecha: 20/11/2024
# Descripción: Este script realiza operaciones matemáticas básicas según la opción elegida por el usuario.

echo "Seleccione una opción:"
echo "1) Suma"
echo "2) Resta"
echo "3) Multiplicación"
read -p "Ingrese la opción (1-3): " opcion

if [[ $opcion -lt 1 || $opcion -gt 3 ]]; then
  echo "Opción inválida. Ejecute el script nuevamente."
  exit 1
fi

read -p "Ingrese el primer número: " num1
read -p "Ingrese el segundo número: " num2

case $opcion in
  1)
    resultado=$((num1 + num2))
    echo "La suma de $num1 y $num2 es $resultado."
    ;;
  2)
    resultado=$((num1 - num2))
    echo "La resta de $num1 y $num2 es $resultado."
    ;;
  3)
    resultado=$((num1 * num2))
    echo "La multiplicación de $num1 y $num2 es $resultado."
    ;;
esac
