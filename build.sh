#!/usr/bin/env bash
set -e
./convert_image.py
bass panda.asm
chksum64 panda.z64
