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

## Install ChatGPT (Linux)

Install the [ChatGPT desktop app for Linux](https://learn.chatgpt.com/docs/linux/linux-app)
(preview, x64 and ARM64):

```sh
brew install --cask leoxlin/craftbeer/chatgpt
```

Homebrew may require trusting the tap first: `brew trust leoxlin/craftbeer`.
The upstream download always serves the latest build, so update with:

```sh
brew upgrade --cask --greedy-latest leoxlin/craftbeer/chatgpt
```

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
