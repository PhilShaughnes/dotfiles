# setup

One-time machine bootstrap. Everything after this is `dots` + `mise`.

The repo is public, so scripts can be fetched with curl before git or ssh keys
exist:

    https://raw.githubusercontent.com/PhilShaughnes/dotfiles/main/setup/<file>

## debian (trixie)

As root on the fresh box (a bare image may need `apt-get install -y curl` first):

    curl -fsSL https://raw.githubusercontent.com/PhilShaughnes/dotfiles/main/setup/debian.sh | bash -s -- <user>

Then as `<user>`:

    # ssh key: forward an agent (ssh -A) or create one and add it to github
    git clone git@github.com:PhilShaughnes/dotfiles.git ~/.config/dotfiles
    cd ~/.config/dotfiles
    PATH=~/.local/bin:$PATH
    GOBIN=~/.local/bin mise exec go@latest -- go install github.com/philshaughnes/dots@latest
    dots apply -f base.toml -f agents.toml
    exec zsh        # picks up env.base (mise shims, PATH)
    mise install

## mac

TODO: stale - still assumes asdf, chezmoi and Intel brew (/usr/local).

    xcode-select --install
    # homebrew: https://brew.sh
    brew bundle --file setup/Brewfile
    sh setup/mac-settings.sh   # optional: macOS defaults

Then clone, `dots apply -f base.toml -f mac.toml -f agents.toml`, `mise install`.
