#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Dotfiles directory ($DOTFILES_DIR) does not exist!"
    exit 1
fi

cd "$DOTFILES_DIR" || exit 1

mkdir -p .config/{i3,kitty,picom,fish,omf} .local/share/fonts

echo "Backing up configs..."
cp -r ~/.config/i3 .config/
cp -r ~/.config/kitty .config/
cp -r ~/.config/picom .config/
cp -r ~/.config/fish .config/
cp -r ~/.config/omf .config/
cp -r ~/.local/share/fonts/*CaskaydiaMono* .local/share/fonts/

if git status --porcelain | grep -q .; then
    echo "Changes detected, proceeding with backup..."
    git add .
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    git commit -m "Auto backup: $TIMESTAMP"
    git push origin main
    echo "Backup completed and pushed to GitHub!"
else
    echo "No changes detected, skipping backup."
fi
