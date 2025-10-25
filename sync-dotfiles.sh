#!/usr/bin/env bash
# hyprdots 同期スクリプト
# ~/.config, ~/bin へのstowリンクを安全に再作成します

set -e

# 削除する既存ディレクトリ
CONFIGS=("~/.config/hypr" "~/.config/waybar" "~/.config/rofi")

# 既存設定の削除確認
echo "[hyprdots] 既存のHyprland/Waybar/Rofi設定を削除しますか？ (y/N)"
read -r yn
if [[ "$yn" =~ ^[Yy]$ ]]; then
  for d in "${CONFIGS[@]}"; do
    eval d_expanded=$d
    if [ -e "$d_expanded" ]; then
      echo "削除: $d_expanded"
      rm -rf "$d_expanded"
    fi
  done
else
  echo "既存設定の削除をスキップします。"
fi

# .config配下のアンストウ→再stow
echo "[hyprdots] .config配下のstowリンクを再作成します。"
stow -D -t ~/.config .config || true
stow -v -t ~/.config .config

# bin配下のアンストウ→再stow
echo "[hyprdots] bin配下のstowリンクを再作成します。"
stow -D -t ~/bin bin || true
stow -v -t ~/bin bin

echo "[hyprdots] 同期完了！"
