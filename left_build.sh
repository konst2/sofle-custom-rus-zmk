#!/bin/bash
cd ..
BASE_DIR=$(pwd)

# Пути к директориям
VENV_DIR="$BASE_DIR/keyboard_engines/venv_zmk/bin"
ZMK_DIR="$BASE_DIR/keyboard_engines/zmk"
CONFIG_DIR="$BASE_DIR/sofle-custom-rus-zmk"
BUILD_DIR="$CONFIG_DIR/_builds"
LANG_SWITCH_MODULE="$BASE_DIR/zmk-lang-agnostic-behaviors"

# Создаем папку для сборок если не существует
mkdir -p "$BUILD_DIR"

cd $VENV_DIR
. ./activate

# Переходим в директорию zmk
cd $ZMK_DIR

# Очистка предыдущих сборок
#rm -rf build_left

# Сборка левой половины
echo "Building left side..."
west build -s app -d build_left -b nice_nano_v2 -- -DSHIELD=sofle_left -DZMK_CONFIG="$CONFIG_DIR/config" -DZMK_EXTRA_MODULES="$LANG_SWITCH_MODULE"
mv $ZMK_DIR/build_left/zephyr/zmk.uf2 $BUILD_DIR/sofle_left.uf2


echo "Build complete!"
