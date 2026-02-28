#!/bin/bash

# Help function
show_help() {
    echo "Usage: $(basename $0) [option]"
    echo "Options:"
    echo "  -c, --chat     Clear only chats"
    echo "  -a, --all      Clear everything (chats and caches)"
    echo "  -h, --help     Show this help message"
    echo ""
    echo "Example:"
    echo "  $(basename $0) --chat    # Clears only chats"
    echo "  $(basename $0) --all     # Clears everything"
}

# Check if Cursor is running
check() {
    if pgrep -x "Cursor" > /dev/null; then
        echo "⚠️  Please close Cursor"
        exit 1
    fi
}

CURSOR_SUPPORT="$HOME/Library/Application Support/Cursor"

clean() {
    for dir in "$@"; do
        if [ -d "$dir" ]; then
            rm -rf "$dir"/*
            echo "✅ Cleared $dir"
        fi
    done
}

chat() {
    check
    echo "📝 Clearing chats"
    if [ -f "$CURSOR_SUPPORT/User/globalStorage/state.vscdb" ]; then
        sqlite3 "$CURSOR_SUPPORT/User/globalStorage/state.vscdb" "DELETE FROM cursorDiskKV WHERE key LIKE 'bubbleId%' OR key LIKE 'composerData%';"
        echo "✅ Chats cleared"
    else
        echo "❌ Chats not found"
    fi
    clean "$HOME/.cursor/ai-tracking" "$HOME/.cursor/projects"
}

cache() {
    echo "🗑️  Clearing caches"
    clean \
        "$CURSOR_SUPPORT/Cache" \
        "$CURSOR_SUPPORT/CachedData" \
        "$CURSOR_SUPPORT/CachedExtensionVSIXs" \
        "$CURSOR_SUPPORT/CachedProfilesData" \
        "$CURSOR_SUPPORT/Code Cache" \
        "$CURSOR_SUPPORT/Crashpad" \
        "$CURSOR_SUPPORT/GPUCache" \
        "$CURSOR_SUPPORT/User/History" \
        "$CURSOR_SUPPORT/User/workspaceStorage"
}

# Main script
case "$1" in
    -c|--chat)
        chat
        ;;
    -a|--all)
        chat
        cache
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

echo "✨ All done!"
