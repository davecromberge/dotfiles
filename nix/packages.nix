let
  pkgs = import <nixpkgs> {};
  fixed = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/19.09.tar.gz") {};
in
(
  with fixed; [
    cachix # nix caching
    nodejs # required by coc.nvim (autocompletion plugin)
    openjdk8 # Java development kit
    python3 # for vim plugins
    sbt # Scala build tool
  ]
) ++ (
  with pkgs; [
    bat # a better `cat`
    bloop # Scala build server
    exa # a better `ls`
    fd # "find" for files
    fzf # fuzzy find tool
    glow # markdown viewer
    htop # interactive processes viewer
    neovim # best text editor ever
    ngrok # secure tunnels to localhost
    niv # nix package manager
    nix # nix commands
    ripgrep # fast grep
    tmux # terminal multiplexer and sessions
    tree # display files in a tree view
  ]
) ++ (
  with pkgs.gitAndTools; [
    diff-so-fancy # git diff with colors
    tig # diff and commit view
  ]
) ++ (
  with pkgs.python3Packages; [
    pynvim # for vim plugins that require python
  ]
) ++ (
  with pkgs.nodePackages; [
    node2nix # to convert node packages
  ]
)
