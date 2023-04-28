# Windows - step by step

## Installing scoop
```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
```bash
irm get.scoop.sh | iex
```
> A bucket in Scoop is a collection of packages, and the extras bucket contains packages that are not in the main buckets, including neovim-qt
```bash
scoop bucket add extras
```
> ripgrep is a line-oriented search tool that recursively searches the current directory for a regex pattern. By default, ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files.
```bash
scoop install ripgrep
```

## Install the Microsoft Visual C++ Runtime (vcredist2022), a requirement for running Neovim
```bash
scoop install vcredist2022
```
(You can remove this installer with `scoop uninstall vcredist2022`)

## Install Neovim
> neovim – Neovim’s latest stable release.
```bash
scoop install neovim
```
> neovim-qt – A GUI for Neovim based on Qt, a cross-platform application framework.
```bash
scoop install neovim_qt
```

## Finally run the next command to open NeoVim
```bahs
nvim
```

> REFERENCES: [https://adamtheautomator.com/nvim/](https://adamtheautomator.com/nvim/)
---------------------------------------------------

## Parcker installation
```bash
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
```

> REFERENCES: [https://github.com/wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)
---------------------------------------------------

## LSP Dependencies

```bash
scoop install stylua
npm install eslint --global
pip install flake8
pip install black
```
