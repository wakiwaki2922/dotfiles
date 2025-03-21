#!/bin/bash

# �u?ng d?n d?n thu m?c dotfiles
DOTFILES_DIR="$HOME/dotfiles"

# �?m b?o thu m?c dotfiles t?n t?i
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Dotfiles directory ($DOTFILES_DIR) does not exist!"
    exit 1
fi

# Di chuy?n v�o thu m?c dotfiles
cd "$DOTFILES_DIR" || exit 1

# T?o c?u tr�c thu m?c n?u chua c�
mkdir -p .config/{i3,kitty,picom,fish,omf} .local/share/fonts Pictures/wallpapers

# Sao ch�p c�c t?p c?u h�nh
echo "Backing up configs..."
cp -r ~/.config/i3 .config/
cp -r ~/.config/kitty .config/
cp -r ~/.config/picom .config/
cp -r ~/.config/fish .config/
cp -r ~/.config/omf .config/
cp -r ~/.local/share/fonts/*CaskaydiaMono* .local/share/fonts/
cp -r ~/Pictures/wallpapers/* Pictures/wallpapers/

# Ki?m tra xem c� thay d?i n�o kh�ng
if git status --porcelain | grep -q .; then
    echo "Changes detected, proceeding with backup..."

    # Th�m t?t c? c�c thay d?i
    git add .

    # Commit v?i timestamp
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    git commit -m "Auto backup: $TIMESTAMP"

    # �?y l�n GitHub
    git push origin main
    echo "Backup completed and pushed to GitHub!"
else
    echo "No changes detected, skipping backup."
fi