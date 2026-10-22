#!/usr/bin/env bash
# debian.sh - OS layer for a fresh Debian (trixie) box. Run as root.
# Idempotent; safe to re-run.
#
#   debian.sh <user>
#
# Creates <user> if missing (sudo, bash), installs apt packages and mise.
# Layers, each owned by one tool:
#   apt  (this script) - OS packages and what the shell needs at startup
#   mise (config.toml) - dev toolchains and versioned CLI tools
#   dots (manifests)   - wiring configs into place
set -euo pipefail

user=${1:?usage: debian.sh <user>}
[ "$(id -u)" -eq 0 ] || { echo "run as root" >&2; exit 1; }

# Only what must exist before mise/dots run, or that the shell needs to start.
# Other cli tools: add when missed - via mise for the same version as the mac.
packages=(
	# base: sudo, git over ssh for dots, build tools for mise source builds (lua)
	sudo git curl unzip ca-certificates openssh-client build-essential
	# locale: ssh/mosh forward the client's LANG; C is not good enough
	locales
	# shell startup (bashrc/env.base)
	fzf fd-find zoxide direnv starship
	# forge: btrfs snapshots/subvolumes
	btrfs-progs
)

apt-get update
apt-get install -y --no-install-recommends "${packages[@]}"

# debian names it fdfind; env.base sets FZF_DEFAULT_COMMAND='fd --type f'
ln -sf /usr/bin/fdfind /usr/local/bin/fd

# locale: generate en_US.UTF-8 so forwarded LANG resolves
grep -q '^en_US.UTF-8 UTF-8' /etc/locale.gen || echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
update-locale LANG=en_US.UTF-8

id "$user" >/dev/null 2>&1 || useradd -m -s /bin/bash "$user"
usermod -aG sudo -s /bin/bash "$user"

# mise (installs to ~/.local/bin/mise)
home=$(getent passwd "$user" | cut -d: -f6)
[ -x "$home/.local/bin/mise" ] || su - "$user" -c 'curl -fsSL https://mise.run | sh'

echo "done. next, as $user: see setup/README.md"
