Toast Zsh
=========

My Personal Config
------------------

### About ###
I like experimenting.
I also like having a usable shell.

There was an obvious base from which I wanted to build, but other solutions were all rather too expansive or too limited. Meanwhile I also wanted unique-to-each-machine configs that would be easy to setup.

And thus, Toasty Zsh was born.

### Basic Usage ###
- Clone the repository somewhere where it won't get deleted. Literally anywhere. Though ~/.zsh is not recommended (if you put it there, I recommend editing the config file).
- Enter that directory.
- Symlink zshrc to ~/.zshrc.
- Copy `$zshd/examples/zshrc.local` to `$zd/zshrc.local`

To update: run `autoload toasty-zsh; toasty-zsh -u`.

### Advanced Usage ###
$zshd/config Defines:
- $zshd: the directory where Toasty Zsh lives , to be used in other scripts. (PS: $0 is actually broken inside of init scripts, and resolves to /bin/zsh)
- $zrc: the current zshrc in use, for easy access if you unlink it or something.

### Expanding ###
- Files in $zd/source will get sourced directly.
- Files in $zd/prompt will be added to the fpath (separated from functions purely for convenience), and thus be usable by prompt/promptinit.
- Files in $zd/functions will be added to the fpath, and can be autoloaded in zshrc.local.
- zshrc.local will be the last thing zshrc will source (right before compinit, please don't compinit, it'll be done, I swear).

### Examples ###
Examples of various use cases can be found in `$zshd/examples`. A quickstart zshrc.local can be found there as well.
