#!/bin/sh

USER_NAME="John Braun"
USER_EMAIL="john@brn.email"

echo "Setting up your Mac."

# Install xcode tools.
echo "Running xcode-select --install"
xcode-select --install

# Check for Homebrew and install it if we don't have it.
if test ! $(which brew); then
  echo "Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing Homebrew formulae..." # See the 'Brewfile'.
brew tap homebrew/bundle
brew update
brew bundle --verbose

echo "Installing oh-my-zsh..."
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Copying .zshrc into $HOME..."
rm -f $HOME/.zshrc
cp $HOME/.dotfiles/.zshrc $HOME/.zshrc

echo "Changing the default shell to 'zsh'..."
chsh -s $(which zsh)

echo "Creating $HOME/projects..."
mkdir $HOME/projects

echo "Installing required PHP extensions..."
pecl install memcached imagick

echo "Installing Composer & pulling in global dependencies..."
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

/usr/local/bin/composer global require laravel/installer

echo "Installing latest version of NodeJS and npm..."
n latest

echo "Setting npm's global directory to something read- & writeable..."
mkdir "$HOME/.npm-global"
npm config set prefix "$HOME/.npm-global"

echo "Setting git configuration..."
rm -f $HOME/.gitignore
cp $HOME/.dotfiles/.gitignore $HOME/.gitignore

rm -f $HOME/.gitconfig
cp $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

git config --global user.name "$USER_NAME"
git config --global user.email "$USER_EMAIL"
git config --global core.excludesFile "$HOME/.gitignore"

echo "Copying the .vimrc file into $HOME..."
rm -f $HOME/.vimrc
cp $HOME/.dotfiles/.vimrc $HOME/.vimrc

if [[ ! -d "$HOME/.ssh" ]]; then
  echo "Copying the .ssh/ folder into $HOME..."
  cp $HOME/.dotfiles/.ssh $HOME/.ssh
fi

if [[ ! -f $HOME/.ssh/id_ed25519 ]]; then
  echo "Generating a new ed25519 SSH key pair..."
  ssh-keygen -t ed25519 -b 4096 -C "$USER_EMAIL" -f $HOME/.ssh/id_ed25519
fi

# Set macOS preferences.
# We will run this last because this will reload the shell.
source .macos
