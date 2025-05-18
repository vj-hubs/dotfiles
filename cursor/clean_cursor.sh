#!/bin/bash

# Help function
show_help() {
    echo "Usage: $(basename $0) [option]"
    echo "Options:"
    echo "  -c, --chat     Clear only chat history"
    echo "  -a, --all      Clear everything (chat history and cache)"
    echo "  -h, --help     Show this help message"
    echo ""
    echo "Example:"
    echo "  $(basename $0) --chat    # Clears only chat history"
    echo "  $(basename $0) --all     # Clears everything"
}

# Check if Cursor is running
check_cursor() {
    if pgrep -x "Cursor" > /dev/null; then
        echo "⚠️  Please close Cursor before running this script"
        exit 1
    fi
}

# Clear chat history from SQLite database
clear_chat() {
    echo "📝 Clearing chat history..."
    CURSOR_SUPPORT="$HOME/Library/Application Support/Cursor"
    if [ -f "$CURSOR_SUPPORT/User/globalStorage/state.vscdb" ]; then
        sqlite3 "$CURSOR_SUPPORT/User/globalStorage/state.vscdb" "DELETE FROM cursorDiskKV WHERE key LIKE 'bubbleId%' OR key LIKE 'composerData%';"
        echo "✅ Chat history cleared"
    else
        echo "❌ Chat database not found"
    fi
}

# Clear all cache directories
clear_cache() {
    echo "🗑️  Clearing cache directories..."
    CURSOR_SUPPORT="$HOME/Library/Application Support/Cursor"
    CURSOR_CACHE="$HOME/Library/Caches/Cursor"
    
    directories=(
        "$CURSOR_SUPPORT/Cache"
        "$CURSOR_SUPPORT/CachedData"
        "$CURSOR_SUPPORT/CachedExtensionVSIXs"
        "$CURSOR_SUPPORT/CachedProfilesData"
        "$CURSOR_SUPPORT/Code Cache"
        "$CURSOR_SUPPORT/Crashpad"
        "$CURSOR_SUPPORT/GPUCache"
        "$CURSOR_SUPPORT/User/History"
        "$CURSOR_SUPPORT/User/workspaceStorage"
        "$CURSOR_CACHE"
    )

    for dir in "${directories[@]}"; do
        if [ -d "$dir" ]; then
            rm -rf "$dir"/*
            echo "✅ Cleared $dir"
        fi
    done
}

# Main script
case "$1" in
    -c|--chat)
        check_cursor
        clear_chat
        ;;
    -a|--all)
        check_cursor
        clear_chat
        clear_cache
        ;;
    -h|--help)
        show_help
        ;;
    *)
        echo "⚠️  Invalid option"
        show_help
        exit 1
        ;;
esac

echo "✨ All done! You can now restart Cursor."
