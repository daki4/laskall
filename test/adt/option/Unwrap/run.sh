#!/bin/bash

rustc main.rs
chmod +x main
./main > expected.txt

lua main.lua > actual.txt

if diff "actual.txt" "expected.txt" >/dev/null 2>&1; then
    echo "✅"
else
    echo "❌"
fi

rm main

