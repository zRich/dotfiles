# Clone This Repo

```bash
cd $HOME
git init
git branch -M main
git remote add origin git@github.com:zRich/dotfiles.git
git pull origin main --allow-unrelated-histories
```


# Install Neovim

1. Copy `nvim` into `$HOME/.config/nvim`
2. Sync plugins(`:PackerSync`), restart system maybe required
3. Install go tools(`:GoInstallBinaries`) for go.nvim plugin [Reference](https://github.com/ray-x/go.nvim)

## Install TypeScript Server

```shell:n
npm install -g typescript typescript-language-server
```

## Install null-ls

```shell:n
npm install --save-dev --save-exact prettier
npm install eslint --save-dev
```

`:Prettier` for JSX files

# Install oh-my-zsh

```bash
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh

```

## powerlevel10k 
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
## zsh-syntax-highlighting plugin
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```
## zsh-autosuggestions
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

# Install fzf
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf\n~/.fzf/install
```
