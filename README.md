# Config

Dotfile management originally based on [an Atlassian guide](https://www.atlassian.com/git/tutorials/dotfiles) and further inspired by [a Gitlab article](https://about.gitlab.com/blog/2020/04/17/dotfiles-document-and-automate-your-macbook-setup/).

## Setup

* Install iTerm2
* [Pull the bootstrap shell file from gist](https://gist.github.com/jjdonov/62ca29862980857023bed6399c6bdd5b)
* Execute the script
* `cd ~/setup`
* `sh setup-brew.sh`
* `brew bundle`
* Add fnm to .zprofile
* `fnm install --lts1
* `sh setup-vim-plug.sh`
* `nvim` and then `:PlugInstall`
* `sh setup-powerline-fonts.sh`
* `sh setup-prezto.sh`
* `sh setup-iterm.sh`
