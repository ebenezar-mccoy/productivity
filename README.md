#### tmux requirments

clipboard:
```
brew install reattach-to-user-namespace 
```

#### zsh requirments

highlighting and fuzzy search:
```
brew install zsh-syntax-highlighting fzf
```

pure prompt:
``` 
npm install --global pure-prompt
```

#### vim requirments

neovim:

```
brew install nvim
pip3 install neovim pyvim
```

plugins (vim-plug):

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

plugin installation:

```
nvim +PlugInstall
```
