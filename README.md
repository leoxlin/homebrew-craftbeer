# Craftbeer Homebrew Tap

Homebrew formulae and casks maintained by [leoxlin](https://github.com/leoxlin).

## Install lfg

Install [lfg](https://github.com/leoxlin/lfg), which jumps into a Git worktree
and starts a coding agent:

```sh
brew install leoxlin/craftbeer/lfg
```

Activate it in your shell:

```sh
# Bash: add to ~/.bashrc
source "$(brew --prefix leoxlin/craftbeer/lfg)/share/lfg/lfg.bash"

# Zsh: add to ~/.zshrc
source "$(brew --prefix leoxlin/craftbeer/lfg)/share/lfg/lfg.zsh"
```

Fish functions and completions are installed automatically. Start a new shell,
then run `lfg`.

## Upgrade lfg

Either Homebrew or lfg can perform the upgrade:

```sh
brew upgrade leoxlin/craftbeer/lfg
lfg --update
```

Both commands let Homebrew manage the installed files.

## Other packages

Formulae and casks added to this tap are available without extra setup:

```sh
brew install leoxlin/craftbeer/<formula>
brew install --cask leoxlin/craftbeer/<cask>
```

To tap the repository first and use short package names:

```sh
brew tap leoxlin/craftbeer
brew install <formula>
brew install --cask <cask>
```
