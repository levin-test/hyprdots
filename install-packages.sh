#!/bin/sh

# Script to install required packages for Hyprland environment
# Run with sudo privileges if necessary
# Target: Arch Linux (paru)

# Official repository packages
PKGS_OFFICIAL=(
  # === Desktop Environment ===
  hyprland           # Window manager
  waybar             # Status bar
  rofi               # Launcher
  networkmanager     # Network management
  pcmanfm-qt         # File manager
  
  # === Terminal & Shell ===
  kitty              # Terminal emulator
  starship           # Prompt
  zoxide             # Fast directory jumper
  
  # === Editors & Development ===
  neovim             # Terminal editor
  zed                # GUI editor
  go                 # Go language
  
  # === CLI Tools ===
  eza                # Alternative to ls
  fd                 # Fast file search
  fzf                # Command-line fuzzy finder
  ripgrep            # Fast grep
  delta              # git diff viewer
  lazygit            # Terminal git client
  go-yq              # YAML processor
  
  # === Version Control & APIs ===
  git                # Version control
  gh                 # GitHub CLI
  
  # === System & File Management ===
  xdg-user-dirs      # User directory management
  xdg-utils          # XDG utilities
  docker             # Container management
  snapper            # btrfs snapshot management
  clamav             # Virus scanner
  rclone             # Cloud storage integration
  
  # === System Monitoring ===
  fastfetch          # System info display
  htop               # Process viewer
  nvtop              # GPU process viewer
  
  # === Multimedia & Applications ===
  kdenlive           # Video editing
  obs-studio         # Streaming/recording
  scrcpy             # Android screen mirroring
  steam              # Game platform
  vivaldi            # Vivaldi browser
  
  # === Localization & Fonts ===
  fcitx5-mozc        # Japanese input (Mozc)
  ttf-jetbrains-mono-nerd # JetBrains Mono Nerd Font
)

# AUR packages
PKGS_AUR=(
  hyprpaper          # Wallpaper management (AUR)
  swww               # Image switching / wallpaper (AUR)
  nwg-look           # GTK theme settings (AUR)
)


echo "Official packages to be installed:"
for pkg in "${PKGS_OFFICIAL[@]}"; do
  echo "  $pkg"
done
echo "--------------------------------"

echo "AUR packages to be installed:"
for pkg in "${PKGS_AUR[@]}"; do
  echo "  $pkg"
done
echo "--------------------------------"

# Install both official and AUR packages using paru
paru -Syu --needed "${PKGS_OFFICIAL[@]}" "${PKGS_AUR[@]}"

echo "--------------------------------"
echo "Excluded packages (likely preinstalled with CachyOS):"
echo "  firefox      # Default browser"
echo "  fish         # Default shell"
echo "  flatpak      # Default package manager"
echo "  go           # Default language"
echo "  git          # Default VCS"
echo "  xdg-user-dirs # Default"
echo "  xdg-utils    # Default"
echo "  htop         # Default"
echo "(Add manually if needed)"
