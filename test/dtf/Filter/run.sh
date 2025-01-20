#!/bin/bash

lua luafun.lua > expected.txt

lua laskall.lua > actual.txt

if diff "actual.txt" "expected.txt"; then
    echo "✅"
else
    echo "❌"
fi

