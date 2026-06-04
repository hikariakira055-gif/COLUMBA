#!/bin/bash

echo "🔍 Détection de la distribution..."

if command -v pacman &> /dev/null; then
    echo "Distro basée sur Arch détectée."
    sudo pacman -Sy --needed netcat-openbsd --noconfirm

elif command -v apt-get &> /dev/null; then
    echo "Distro basée sur Debian/Ubuntu/Kali détectée."
    sudo apt-get update && sudo apt-get install -y netcat-openbsd

elif command -v dnf &> /dev/null; then
    echo "Distro basée sur RHEL/Fedora détectée."
    sudo dnf install -y nc

elif command -v zypper &> /dev/null; then
    echo "Distro basée sur openSUSE détectée."
    sudo zypper install -y netcat-openbsd

else
    echo "Gestionnaire de paquets introuvable."
    exit 1
fi

echo "✅ Installation terminée avec succès !"