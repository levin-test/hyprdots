# hyprdots

## 概要

このリポジトリは Hyprland 環境専用の設定ファイルおよび補助コマンド群を管理します。
GNU stow を用いて `~/.config` などに連携する運用を前提としています。

## クイックスタート

```sh
# 1. このリポジトリをクローン
git clone https://github.com/levin-test/hyprdots.git
cd hyprdots

# 2. パッケージをインストール（CachyOS環境想定）
./install-packages.sh

# 3. 設定をホームディレクトリにリンク（stow使用）
stow .config
```

## ディレクトリ構成

```
hyprdots/
├── .config/
│   ├── hypr/        # Hyprland本体の設定
│   │   ├── hyprland.conf   # メイン設定ファイル
│   │   ├── keybinds.conf   # キーバインド設定
│   │   ├── monitors.conf   # モニター配置設定
│   │   └── rofi/           # ランチャー設定（別途配置）
│   └── waybar/      # Waybar設定
│       ├── config          # Waybarモジュール設定
│       └── style.css       # Waybarスタイル設定
├── bin/             # Hyprland専用の実行可能コマンド群
├── go/              # Go製コマンドのソース（オプション）
└── install-packages.sh # パッケージインストールスクリプト
```

## 設定ファイル概要

### Hyprland設定

- **hyprland.conf**: メイン設定（基本設定、デコレーション、アニメーション、自動起動）
- **keybinds.conf**: キーバインド定義
  - ウィンドウ移動・フォーカス切り替え（Super+H/J/K/L）
  - ウィンドウ操作（閉じる、フルスクリーン、フローティング、リサイズ）
  - ワークスペース切り替え（Super+0-9）
  - ランチャー起動（Alt+Space）
- **monitors.conf**: モニター配置設定（手動設定が必要）

### Waybar設定

- **config**: モジュール設定（ワークスペース、時計、CPU/メモリ、バッテリー、ネットワーク）
- **style.css**: 外観設定

### rofi設定

- **config.rasi**: ランチャー設定（drun モード）

## 設定ファイル分割例

`.config/hypr/hyprland.conf` で以下のように分割設定ファイルを読み込みます：

```conf
source = keybinds.conf
source = monitors.conf
```

## 運用方針

- Hyprland環境専用の設定・コマンドのみを管理します。
- DE/WM非依存の設定（nvim, kitty, fish等）は別リポジトリ（dotfiles）で管理してください。
- 他環境でも使う汎用コマンドは、他のリポジトリで管理してください。

## 初期セットアップ

### ステップ1: パッケージのインストール

```sh
cd hyprdots
chmod +x install-packages.sh
./install-packages.sh
```

CachyOS環境で実行してください。`paru` を使用してインストールします。

**注意:** 一部パッケージ（firefox, fish, git等）はCachyOSで標準インストール済みのため、スクリプトから除外しています。必要に応じて個別にインストールしてください。

### ステップ2: 設定をホームディレクトリにリンク

```sh
# .config/hypr を ~/.config/hypr にリンク
stow -D .config/hypr 2>/dev/null || true  # 既存のリンクを削除（エラー無視）
stow .config/hypr

# .config/waybar を ~/.config/waybar にリンク
stow -D .config/waybar 2>/dev/null || true
stow .config/waybar

# .config/rofi を ~/.config/rofi にリンク
stow -D .config/rofi 2>/dev/null || true
stow .config/rofi
```

### ステップ3: モニター設定を確認・調整

`~/.config/hypr/monitors.conf` を開いて、ご自身のモニター構成に合わせて設定してください。

`hyprctl monitors` コマンドで接続されているモニターを確認できます。

### ステップ4: Hyprlandを起動

ディスプレイマネージャーから Hyprland を選択して起動してください。

## キーバインド一覧

### ウィンドウ操作

- `Super + H/J/K/L`: フォーカス移動
- `Super + Ctrl + H/J/K/L`: ウィンドウ移動
- `Super + Q`: ウィンドウを閉じる
- `Super + F`: フルスクリーン切り替え
- `Super + Shift + Space`: フローティング切り替え
- `Super + R`: リサイズモード（H/J/K/Lで調整、Escapeで終了）

### ワークスペース

- `Super + 0-9`: ワークスペース切り替え
- `Super + Shift + 0-9`: ウィンドウをワークスペースに移動
- `Super + Ctrl + Shift + H/L`: 前後のワークスペースに移動

### アプリケーション

- `Super + Return`: ターミナル起動（kitty）
- `Alt + Space`: ランチャー起動（rofi）

## stowで安全に更新する方法

ファイルの追加・削除が頻繁に発生する場合、以下の手順がもっとも安全です。

```sh
# 例: .config/hypr を stow で ~/.config に連携する場合
stow -D .config/hypr   # まずアンストウ（既存のリンクを安全に解除）
stow .config/hypr      # その後、再度stowでリンクを作成
```

- `-D` オプションは「アンストウ（unlink）」を意味します。
- 追加・削除・変更があった場合は、**必ずアンストウ→再stow**の順で実行してください。
- 他のディレクトリ（waybar, rofi, bin等）も同様に運用できます。

## 今後の設定予定

以下は実PCでの運用を通じて、必要に応じて追加予定の機能です：

- **ロック画面**: hyprlock の設定
- **音量・明るさ調整**: キーバインド追加（例：wpctl, brightnessctl）
- **スクリーンショット**: 撮影コマンドのキーバインド追加
- **通知デーモン**: mako や dunst の設定
- **補助コマンド**: bin/ ディレクトリにカスタムコマンドを追加

## CachyOS標準でインストール済みのため除外したパッケージ

以下のパッケージはCachyOSで標準インストールされている、または高確率で含まれているため、セットアップスクリプトから除外しています。

- firefox
- fish
- flatpak
- go
- git
- xdg-user-dirs
- xdg-utils
- htop

必要に応じて個別にインストールしてください。
