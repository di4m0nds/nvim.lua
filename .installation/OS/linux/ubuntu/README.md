# Neovim Installation Instructions for Ubuntu

This guide will walk you through the installation process on Ubuntu, allowing you to harness the power of Neovim in your development workflow.

> **Prerequisites** - Ubuntu 20.04 or later

## Installation Steps

Follow these steps to install Neovim on Ubuntu:

1. Open a terminal by pressing `Ctrl+Alt+T` or searching for "Terminal" in the Ubuntu applications.

2. Update the package lists by running the following command:
```shell
sudo apt update
```

3. Install Neovim by executing the following command:
```shell
sudo apt install neovim
```
**Note**: Ensure that you are installing **version 0.9 or higher**. If the available version in the package manager is lower than 0.9, you will need to follow the steps below:
- Go to the [Neovim releases page on GitHub](https://github.com/neovim/neovim/releases). Download the compressed tar version (.tar.gz) of the desired Neovim release that is 0.9 or higher.
- Extract the downloaded tar file in `~/.local/bin`
    ```shell
    tar xzvf nvim-linux64.tar.gz
    ```
- Run `./nvim-linux64/bin/nvim`
- Add alias in `~/.bashrc` at the bottom
    ```bash
    alias nvim='~/.local/bin/nvim-linux64/bin/nvim'
    ```

4. Verify the installation by checking the version of Neovim:
```shell
nvim --version
```

5. Install required dependencies:
```shell
sudo apt install gcc ripgrep
```

6.  Steps to navigate to the .config directory and clone the repository with the name "nvim":

    - 6.1 Change to the .config directory:
    ```shell
    cd ~/.config
    ```
    - 6.2 Clone the repository with the name "nvim":
    ```shell
    git clone https://github.com/di4m0nds/nvim.lua.git nvim
    ```

7.  Installing Packer (Plugin Manager) Clone the packer.nvim repository:
```shell
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

8.  Navigate to the `~/.config/nvim/lua/di4m0nds` directory in your terminal:
- Run the following command to edit the packer.lua file:
    ```shell
    nvim packer.lua
    ```
- Inside Neovim, run the following command to source the packer.lua file:
    ```bash
    :source
    ```
- Finally, run the following command inside Neovim to install the configured plugins:
    ```ruby
    :PackerInstall
    ```

## LSP Dependencies

1. `lua-language-server`
    - Go to the [LuaLS/lua-language-server releases page on GitHub](https://github.com/LuaLS/lua-language-server/releases). Download the compressed tar version (.tar.gz).
    - Create a folder `lua-language-server-linux64` and extract the downloaded tar file in `~/.local/bin`
        ```shell
        tar xzvf lua-language-server-<version...>-linux-x64.tar.gz -C ./lua-language-server-linux64
        ```
    - Link bin file in `~/.local/bin`
        ```shell
        ln -s lua-language-server-linux64/bin/lua-language-server ./lua-language-server
        ```
