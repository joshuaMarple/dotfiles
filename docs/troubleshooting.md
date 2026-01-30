# Troubleshooting

## DevPod Docker Image Caching Issue

### Problem

You update your dotfiles (e.g., neovim config, zsh settings), push to GitHub, and run `devpod up --recreate`, but **the container still has the old code**.

**Symptoms:**
- Changes to files in `nvim/`, `zsh/`, `tmux/` don't appear in the container
- Errors reference line numbers that don't exist in your current code
- `--recreate` flag doesn't fix the issue
- Deleting `~/.devpod` on both client and server doesn't fix it

### Root Cause

DevPod caches Docker images based on a hash of the Dockerfile and devcontainer.json. When these files don't change, DevPod **reuses the cached image** even if the files that get `COPY`'d into the image have changed.

**The debug output shows this happening:**
```
info Found existing local image vsc-content-a4df4:devpod-48486955b30201f00fcacf3a89333186
```

DevPod sees the same hash, finds the cached image, and skips the rebuild entirely.

### What the Flags Actually Do

| Flag | Behavior |
|------|----------|
| `--recreate` | Recreates container but **reuses cached Docker image** |
| `--reset` | Re-downloads source, may or may not rebuild image |
| `devpod delete` | Deletes workspace but **leaves cached images** |

**None of these flags force a Docker image rebuild!**

### Solution

You must manually delete the cached Docker images on the remote server:

```bash
# Quick fix - nuke and rebuild (replace 'your-server' with your SSH host)
just nuke-and-rebuild your-server

# Or manually:
# 1. Delete cached images on the remote server
ssh your-server "docker images --format '{{.Repository}}:{{.Tag}}' | grep -E 'vsc-content|devpod' | xargs -r docker rmi -f"

# 2. Delete the workspace
devpod delete dev --force

# 3. Recreate fresh
devpod up github.com/joshuaMarple/dotfiles --ide none --id dev
```

### Prevention

When making changes to dotfiles that need to be reflected in the container:

1. **Always use `just nuke-and-rebuild <server>`** instead of `--recreate`
2. Or add a cache-busting ARG to your Dockerfile and bump it:
   ```dockerfile
   ARG DOTFILES_VERSION=2  # Bump this to force rebuild
   ```

### Debugging

To see what DevPod is actually doing, run with `--debug`:

```bash
devpod up github.com/joshuaMarple/dotfiles --debug --ide none --id dev 2>&1 | tee /tmp/devpod-debug.log
```

Look for these lines:
- `Found existing local image` = Using cache (bad if you want fresh)
- `Building image` = Actually rebuilding (good)

### Related Issues

- [DevPod #884: Recreate option does not run dotfiles again](https://github.com/loft-sh/devpod/issues/884)
- [DevPod #693: Can't recreate workspace with updated resources](https://github.com/loft-sh/devpod/issues/693)

---

## Neovim Plugin Loading Errors

### Problem

Neovim shows errors like:
```
E5108: Error executing lua: loop or previous error loading module 'some-plugin'
```

### Common Causes

1. **Stale container** - See "DevPod Docker Image Caching Issue" above
2. **Headless plugin installation** - Installing plugins via `nvim --headless` in Dockerfile can cause issues
3. **Plugin load order** - Dependencies not loaded before dependent plugins

### Solution

1. **Don't pre-install neovim plugins in Dockerfile** - Let them install on first interactive use:
   ```dockerfile
   # NOTE: Don't pre-install neovim plugins - headless install causes
   # "loop or previous error" issues. Plugins install on first interactive use.
   ```

2. **Clear plugin state** inside the container:
   ```bash
   rm -rf ~/.local/share/nvim
   rm -rf ~/.local/state/nvim
   rm -rf ~/.cache/nvim
   ```

3. **Rebuild fresh** if plugin config changed - use `just nuke-and-rebuild <server>`

---

## TERM/Colors Not Working

### Problem

Terminal colors look wrong, or you get errors about missing terminfo.

### Solution

Ensure TERM is set correctly in multiple places:

1. **Dockerfile:**
   ```dockerfile
   ENV TERM=xterm-256color
   ```

2. **devcontainer.json:**
   ```json
   "containerEnv": {
     "TERM": "xterm-256color"
   }
   ```

3. **Shell profile** (~/.zshrc or ~/.zshenv):
   ```bash
   export TERM=xterm-256color
   ```

Also ensure `ncurses-term` package is installed for terminfo database.
