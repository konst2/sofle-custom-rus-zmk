#!/bin/bash
cd ..
BASE_DIR=$(pwd)

# Пути к директориям
VENV_DIR="$BASE_DIR/keyboard_engines/venv_zmk/bin"
ZMK_DIR="$BASE_DIR/keyboard_engines/zmk"
CONFIG_DIR="$BASE_DIR/sofle-custom-rus-zmk"
BUILD_DIR="$CONFIG_DIR/_builds"
LANG_SWITCH_MODULE="$BASE_DIR/zmk-lang-switch"

# Создаем папку для сборок если не существует
mkdir -p "$BUILD_DIR"

cd $VENV_DIR
. ./activate

# Переходим в директорию zmk
cd $ZMK_DIR

# Очистка предыдущих сборок
rm -rf build

# Сборка левой половины
echo "Building left side..."
west build -s app -b nice_nano_v2 -- -DSHIELD=sofle_left -DZMK_CONFIG="$CONFIG_DIR/config" -DZMK_EXTRA_MODULES="/Volumes/MiniExtra/Projects/zmk-lang-switch"
mv $ZMK_DIR/build/zephyr/zmk.uf2 $BUILD_DIR/sofle_left.uf2

# Очистка перед сборкой правой половины
rm -rf build

# Сборка правой половины (исправлен путь конфига)
echo "Building right side..."
west build -s app -b nice_nano_v2 -- -DSHIELD=sofle_right -DZMK_CONFIG="$CONFIG_DIR/config" -DZMK_EXTRA_MODULES="/Volumes/MiniExtra/Projects/zmk-lang-switch"
mv $ZMK_DIR/build/zephyr/zmk.uf2 $BUILD_DIR/sofle_right.uf2

echo "Build complete!"
