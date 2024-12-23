# home

My custom configuration files.

## Install

The configuration doesn't require anything to be installed on the machine, but will add additional features if it finds certain apps are installed.

```shell
cd $HOME
git init
git remote add origin git@github.com:Sorgrum/home.git
git reset --hard origin/main
```

### Optional Apps

* `nvim` - Popular text editor
* `eza` - A replacement for `exa`, which is a replacement of `ls`
* `bat` - Nicer output for `cat`
* `et` - EternalTerminal, for `ssh` that can survive network disconnections

> [!TIP]
> macOS: `brew install eza bat nvim`

### Customize

The installation can be customized by adding anything of your choosing into `~/.zshrc_local`.

For example, you can add directories to your `$PATH`:

```shell
path=(
    $HOME/Library/Python/3.9/bin
    $path
)

```

Or add your own aliases:

```shell
alias foo="echo bar"
```
