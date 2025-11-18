#!/bin/bash

# Script para publicar el proyecto en GitHub
# Uso: ./publish-to-github.sh <nombre-del-repositorio>
# Ejemplo: ./publish-to-github.sh mi-primer-contrato

if [ -z "$1" ]; then
    echo "❌ Error: Debes proporcionar el nombre del repositorio"
    echo "Uso: ./publish-to-github.sh <nombre-del-repositorio>"
    echo "Ejemplo: ./publish-to-github.sh mi-primer-contrato"
    exit 1
fi

REPO_NAME=$1
GITHUB_USER=$(git config user.name 2>/dev/null || echo "TU_USUARIO")

echo "🚀 Publicando proyecto en GitHub..."
echo ""

# Verificar si ya existe un remoto
if git remote get-url origin &>/dev/null; then
    echo "⚠️  Ya existe un remoto 'origin' configurado"
    read -p "¿Deseas actualizarlo? (s/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo "❌ Operación cancelada"
        exit 1
    fi
    git remote remove origin
fi

# Agregar el remoto
echo "📦 Configurando remoto..."
git remote add origin "https://github.com/${GITHUB_USER}/${REPO_NAME}.git"

# Verificar conexión
echo "🔍 Verificando conexión..."
if ! git ls-remote --heads origin &>/dev/null; then
    echo ""
    echo "❌ Error: No se pudo conectar al repositorio"
    echo ""
    echo "Por favor, asegúrate de:"
    echo "1. Haber creado el repositorio en GitHub: https://github.com/new"
    echo "2. Que el nombre del repositorio sea: ${REPO_NAME}"
    echo "3. Que tu usuario de GitHub sea: ${GITHUB_USER}"
    echo "4. Que tengas permisos para hacer push"
    echo ""
    echo "Si el nombre de usuario es diferente, edita este script o ejecuta:"
    echo "  git remote set-url origin https://github.com/TU_USUARIO/${REPO_NAME}.git"
    git remote remove origin
    exit 1
fi

# Hacer push
echo "📤 Subiendo cambios a GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ ¡Proyecto publicado exitosamente!"
    echo "🌐 URL: https://github.com/${GITHUB_USER}/${REPO_NAME}"
else
    echo ""
    echo "❌ Error al hacer push. Verifica tus credenciales de GitHub."
    echo "Puedes configurar tus credenciales con:"
    echo "  git config --global user.name 'Tu Nombre'"
    echo "  git config --global user.email 'tu@email.com'"
fi

