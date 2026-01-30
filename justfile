# Dotfiles Development Commands
# Run `just` to see all available commands

# Default recipe - show available commands
default:
    @just --list

# DevPod workspace name
workspace := "dev"
repo := "github.com/joshuaMarple/dotfiles"

# =============================================================================
# DevPod Commands
# =============================================================================

# Create or start the devpod workspace
up:
    devpod up {{repo}} --ide none --id {{workspace}}

# SSH into the devpod workspace
ssh:
    ssh {{workspace}}.devpod

# Stop the devpod workspace
stop:
    devpod stop {{workspace}}

# Delete the devpod workspace (keeps cached images)
delete:
    devpod delete {{workspace}} --force

# Recreate workspace (WARNING: still uses cached Docker image!)
recreate:
    devpod up {{repo}} --recreate --ide none --id {{workspace}}

# Reset workspace - re-downloads source and rebuilds
reset:
    devpod up {{repo}} --reset --ide none --id {{workspace}}

# =============================================================================
# Nuclear Options - Use when caching causes stale builds
# =============================================================================

# Show cached devpod images on remote server
show-cached-images server:
    ssh {{server}} "docker images | grep -E 'vsc-content|devpod'"

# Nuke cached devpod images on remote server
nuke-images server:
    ssh {{server}} "docker images --format '{{"{{"}}.Repository{{"}}"}}:{{"{{"}}.Tag{{"}}"}}' | grep -E 'vsc-content|devpod' | xargs -r docker rmi -f"

# Full nuke: delete workspace + clear image cache + recreate fresh
nuke-and-rebuild server:
    @echo "Deleting workspace..."
    -devpod delete {{workspace}} --force
    @echo "Nuking cached images on {{server}}..."
    ssh {{server}} "docker images --format '{{"{{"}}.Repository{{"}}"}}:{{"{{"}}.Tag{{"}}"}}' | grep -E 'vsc-content|devpod' | xargs -r docker rmi -f"
    @echo "Rebuilding fresh..."
    devpod up {{repo}} --ide none --id {{workspace}}
    @echo "Done! Run 'just ssh' to connect."

# =============================================================================
# Local Development
# =============================================================================

# Test Dockerfile build locally (without devpod)
build-local:
    docker build -t dotfiles-test -f .devcontainer/Dockerfile .

# Run local test container
run-local:
    docker run -it --rm dotfiles-test
