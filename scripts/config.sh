#!/bin/bash

set +x

# Git config
git config --global user.email "davecromberge@gmail.com"
git config --global user.name "David Cromberge"

# Global git ignore
touch $HOME/.gitignore_global
git config --global core.excludesfile '$HOME/.gitignore_global'
echo '*.bloop' >> $HOME/.gitignore_global
echo '*.metals' >> $HOME/.gitignore_global

# Git aliases
git config --global alias.amend 'commit --amend -m'
git config --global alias.br branch
git config --global alias.ca 'commit -am'
git config --global alias.cm 'commit -m'
git config --global alias.co checkout
git config --global alias.dc 'diff --cached'
git config --global alias.ls 'log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'
git config --global alias.ll 'log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
git config --global alias.st status

# Nix export
echo '. /Users/dave/.nix-profile/etc/profile.d/nix.sh' >> $HOME/.zshrc

# NeoVim config
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p $HOME/.local/share/nvim/plugged
mkdir -p $HOME/.config/nvim
cp nvim/* $HOME/.config/nvim/.

# Fixing locales
echo 'export LC_ALL="en_US.UTF-8"' >> $HOME/.zshrc
echo 'export LOCALE_ARCHIVE="/usr/bin/locale"' >> $HOME/.zshrc

# Git parser
cat scripts/git-parser >> $HOME/.zshrc

# Overriding common tools like vi, cat and ls
echo 'alias vi=nvim' >> $HOME/.zshrc
echo 'alias vim=nvim' >> $HOME/.zshrc
echo 'alias cat=bat' >> $HOME/.zshrc
echo 'alias ls=exa' >> $HOME/.zshrc

# Install Metals (Scala LSP client)
mkdir -p $HOME/metals
cp metals/update-metals.sh $HOME/metals/.
chmod +x $HOME/metals/update-metals.sh
$HOME/metals/update-metals.sh

# SBT / Sonatype credentials
mkdir -p $HOME/.sbt/1.0
cp sbt/sonatype_credentials $HOME~/.sbt/.
cp sbt/sonatype.sbt $HOME/.sbt/1.0/.
echo ">>> Remember to set up username and password for Sonatype"

# SSH key
ssh-keygen -t rsa -b 4096 -C "davecromberge@gmail.com"
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_rsa

# Tmux configuration
cp tmux/tmux.conf $HOME/.tmux.conf
cp tmux/sessions.sh $HOME/tmux-sessions.sh
chmod +x $HOME/tmux-sessions.sh
echo 'alias tm="$HOME/tmux-sessions.sh"' >> $HOME/.zshrc
echo 'alias ta="tmux a"' >> $HOME/.zshrc
echo 'if [ -z "$TMUX" ] then tmux attach -t TMUX || tmux new -s TMUX fi' >> $HOME/.zshrc

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Bloop bash autocompletion (not installed with Nix)
cp bash/bloop.bash $HOME/.bloop.bash
echo '[ -f ~/.bloop.bash ] && source ~/.bloop.bash' >> $HOME/.zshrc

echo ">>> Installation & Configuration DONE"
