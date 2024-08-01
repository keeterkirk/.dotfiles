# dotfiles

## setup

Before running the below commands:

* Make sure you can clone from GitHub by adding your SSH key to your profile.
* Install homebrew

```bash
git clone git@github.com:keeterkirk/.dotfiles.git
cd .dotfiles
brew install stow
./stow_all
brew bundle
```

## rspec

To run `rspec` with more or less cores, set `RSPEC_CORES` in `~/.zshenv`
