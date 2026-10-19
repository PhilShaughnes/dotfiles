#!/usr/bin/env sh
# g4 dev lxc (bb8) only - sourced first by .env.base.
# tools + caches live on /forge (btrfs, survives LXC rebuilds), not the LXC root.
# sandboxes later: own writable MISE_DATA_DIR + MISE_SHARED_INSTALL_DIRS=/forge/tools/mise/installs

# tools
export MISE_DATA_DIR=/forge/tools/mise
export PLAYWRIGHT_BROWSERS_PATH=/forge/tools/playwright

# caches
export MISE_CACHE_DIR=/forge/cache/mise
export XDG_CACHE_HOME=/forge/cache/xdg
export GOMODCACHE=/forge/cache/go/mod
export GOCACHE=/forge/cache/go/build
export GOFLAGS=-modcacherw             # go's module cache is read-only by default, painful to clean
export CARGO_HOME=/forge/cache/cargo
export UV_CACHE_DIR=/forge/cache/uv
export UV_LINK_MODE=clone              # reflink from the cache
export npm_config_cache=/forge/cache/npm
export npm_config_store_dir=/forge/cache/pnpm
