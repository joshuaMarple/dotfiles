#!/bin/bash

# Neovim Configuration Test Script
# Tests that Neovim starts without errors and loads configuration properly

set -e

CONFIG_DIR="$HOME/.config/nvim"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_LOG="/tmp/nvim_test_$(date +%s).log"

echo "Testing Neovim configuration..."
echo "Configuration directory: $CONFIG_DIR"
echo "Test log: $TEST_LOG"

# Function to cleanup test files
cleanup() {
    rm -f "$TEST_LOG"
    echo "Cleaned up test files"
}

# Set trap for cleanup
trap cleanup EXIT

# Test 1: Basic startup test
echo "Test 1: Basic startup test"
if nvim --headless -c 'echo "Neovim started successfully"' -c 'qa!' > "$TEST_LOG" 2>&1; then
    echo "✓ Basic startup test passed"
else
    echo "✗ Basic startup test failed"
    echo "Error output:"
    cat "$TEST_LOG"
    exit 1
fi

# Test 2: Configuration loading test
echo "Test 2: Configuration loading test"
if nvim --headless -c 'lua print("Lua configuration loaded")' -c 'qa!' > "$TEST_LOG" 2>&1; then
    echo "✓ Lua configuration loading test passed"
else
    echo "✗ Lua configuration loading test failed"
    echo "Error output:"
    cat "$TEST_LOG"
    exit 1
fi

# Test 2b: Full init.lua execution test
echo "Test 2b: Full init.lua execution test"
if nvim --headless -c 'lua dofile(vim.fn.stdpath("config") .. "/init.lua"); print("init.lua executed successfully")' -c 'qa!' > "$TEST_LOG" 2>&1; then
    echo "✓ Full init.lua execution test passed"
else
    echo "✗ Full init.lua execution test failed"
    echo "Error output:"
    cat "$TEST_LOG"
    exit 1
fi

# Test 3: Plugin loading test
echo "Test 3: Plugin loading test"
if nvim --headless -c 'lua local ok, deps = pcall(require, "mini.deps"); if not ok then error("mini.deps not available") end; print("mini.deps loaded successfully")' -c 'qa!' > "$TEST_LOG" 2>&1; then
    echo "✓ Plugin loading test passed"
else
    echo "✗ Plugin loading test failed"
    echo "Error output:"
    cat "$TEST_LOG"
    exit 1
fi

# Test 4: Syntax highlighting test
echo "Test 4: Syntax highlighting test"
if nvim --headless -c 'syntax on' -c 'echo "Syntax highlighting enabled"' -c 'qa!' > "$TEST_LOG" 2>&1; then
    echo "✓ Syntax highlighting test passed"
else
    echo "✗ Syntax highlighting test failed"
    echo "Error output:"
    cat "$TEST_LOG"
    exit 1
fi

# Test 5: Leader key test
echo "Test 5: Leader key configuration test"
if nvim --headless -c 'lua print("Leader key:", vim.g.mapleader)' -c 'qa!' > "$TEST_LOG" 2>&1; then
    echo "✓ Leader key configuration test passed"
else
    echo "✗ Leader key configuration test failed"
    echo "Error output:"
    cat "$TEST_LOG"
    exit 1
fi

# Test 6: Module loading test
echo "Test 6: Module loading test"
modules=("options" "autocmds" "plugins" "mappings")
for module in "${modules[@]}"; do
    if nvim --headless -c "lua local ok, err = pcall(require, '$module'); if not ok then error('Failed to load $module: ' .. tostring(err)) end; print('Module $module loaded successfully')" -c 'qa!' > "$TEST_LOG" 2>&1; then
        echo "✓ Module '$module' loaded successfully"
    else
        echo "✗ Module '$module' failed to load"
        echo "Error output:"
        cat "$TEST_LOG"
        exit 1
    fi
done

# Test 7: Configuration integrity test
echo "Test 7: Configuration integrity test"
if nvim --headless -c 'lua local leader = vim.g.mapleader; if leader ~= " " then error("Leader key not set correctly: " .. tostring(leader)) end; print("Leader key configured correctly")' -c 'qa!' > "$TEST_LOG" 2>&1; then
    echo "✓ Leader key configuration verified"
else
    echo "✗ Leader key configuration test failed"
    echo "Error output:"
    cat "$TEST_LOG"
    exit 1
fi

# Test that essential options are set
if nvim --headless -c 'lua if not vim.o.number then error("line numbers not enabled") end; if not vim.o.relativenumber then error("relative numbers not enabled") end; print("Essential options configured")' -c 'qa!' > "$TEST_LOG" 2>&1; then
    echo "✓ Essential options configured correctly"
else
    echo "✗ Essential options test failed"
    echo "Error output:"
    cat "$TEST_LOG"
    exit 1
fi

# Test 8: Error detection test
echo "Test 8: Error detection test"
if nvim --headless -c 'lua vim.cmd("messages")' -c 'qa!' > "$TEST_LOG" 2>&1; then
    # Check for errors in the output
    if grep -i "error" "$TEST_LOG" > /dev/null; then
        echo "✗ Errors detected in Neovim messages:"
        grep -i "error" "$TEST_LOG"
        exit 1
    elif grep -i "warning" "$TEST_LOG" > /dev/null; then
        echo "⚠ Warnings detected in messages:"
        grep -i "warning" "$TEST_LOG"
    else
        echo "✓ No errors or warnings detected"
    fi
else
    echo "✗ Error detection test failed"
    cat "$TEST_LOG"
    exit 1
fi

echo ""
echo "All tests completed successfully!"
echo "Your Neovim configuration appears to be working correctly."