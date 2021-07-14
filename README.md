<h1 align="center">
  <a href="https://github.com/spaceship-prompt/spaceship-prompt">
    <img alt="spaceship →~ prompt" src="https://cloud.githubusercontent.com/assets/3459374/21679181/46e24706-d34b-11e6-82ee-5efb3d2ba70f.png" width="400">
  </a>
  <br>🚀⭐ Spaceship ZSH <br>
</h1>

<h4 align="center">
  <a href="http://zsh.org" target="_blank"><code>Zsh</code></a> prompt for Astronauts.
</h4>

<p align="center">
  <a href="https://npmjs.org/package/spaceship-prompt">
    <img src="https://img.shields.io/npm/v/spaceship-prompt.svg?style=flat-square"
      alt="NPM Version" />
  </a>

  <a href="https://githucom/spaceship-prompt/spaceship-prompt/actions">
    <img src="https://img.shields.io/github/workflow/status/spaceship-prompt/spaceship-prompt/ci?style=flat-square"
      alt="GitHub Workflow Status" />
  </a>

  <a href="http://zsh.org/">
    <img src="https://img.shields.io/badge/zsh-%3E%3Dv5.2-777777.svg?style=flat-square"
      alt="Zsh Version" />
  </a>

  <a href="https://twitter.com/SpaceshipPrompt">
    <img src="https://img.shields.io/badge/twitter-%40SpaceshipZSH-00ACEE.svg?style=flat-square"
      alt="Spaceship Twitter" />
  </a>

  <a href="https://discord.gg/NTQWz8Dyt9">
    <img
      src="https://img.shields.io/discord/859409950999707668?label=discord&logoColor=white&style=flat-square"
      alt="Chat on Discord"
    />
  </a>

  <a href="https://patreon.com/denysdovhan">
    <img src="https://img.shields.io/badge/support-patreon-F96854.svg?style=flat-square"
      alt="Donate" />
  </a>
</p>

<div align="center">
  <h4>
    <a href="https://spaceship-prompt.sh">Website</a> |
    <a href="https://spaceship-prompt.sh/getting-started">Installing</a> |
    <a href="#features">Features</a> |
    <a href="https://spaceship-prompt.sh/options">Options</a> |
    <a href="https://spaceship-prompt.sh/api">API</a>
  </h4>
</div>

<div align="center">
  <sub>Built with ❤︎ by
  <a href="https://denysdovhan.com">Denys Dovhan</a> and
  <a href="https://github.com/spaceship-prompt/spaceship-prompt/graphs/contributors">contributors </a>
</div>
<br>

Spaceship is a minimalistic, powerful and extremely customizable [Zsh][zsh-url] prompt. It combines everything you may need for convenient work, without unnecessary complications, like a real spaceship.

<p align="center">
  <img alt="Spaceship with Hyper and One Dark" src="https://user-images.githubusercontent.com/10276208/36086434-5de52ace-0ff2-11e8-8299-c67f9ab4e9bd.gif" width="980px">
</p>

<sub>Visit <a href="./docs/troubleshooting.md#why-doesnt-my-prompt-look-like-the-preview">Troubleshooting</a> for similar setup and find more examples with different color schemes in <a href="https://github.com/spaceship-prompt/spaceship-prompt/wiki/Screenshots">Screenshots </a>wiki-page.</sub>

## Features

- Clever hostname and username displaying.
- Prompt character turns red if the last command exits with non-zero code.
- Current Git branch and rich repo status:
  - `?` — untracked changes;
  - `+` — uncommitted changes in the index;
  - `!` — unstaged changes;
  - `»` — renamed files;
  - `✘` — deleted files;
  - `$` — stashed changes;
  - `=` — unmerged changes;
  - `⇡` — ahead of remote branch;
  - `⇣` — behind of remote branch;
  - `⇕` — diverged changes.
- Current Mercurial bookmark/branch and rich repo status:
  - `?` — untracked changes;
  - `+` — uncommitted changes in the index;
  - `!` — unstaged changes;
  - `✘` — deleted files;
- Indicator for jobs in the background (`✦`).
- Current Node.js version, through nvm/nodenv/n (`⬢`).
- Current Ruby version, through rvm/rbenv/chruby/asdf (`💎`).
- Current Python version (`🐍`).
- Current Elm version (`🌳`)
- Current Elixir version, through kiex/exenv/elixir (`💧`).
- Current Swift version, through swiftenv (`🐦`).
- Current Xcode version, through xenv (`🛠`).
- Current Go version (`🐹`).
- Current PHP version (`🐘`).
- Current Rust version (`🦀`).
- Current version of Haskell GHC Compiler, defined in stack.yaml file (`λ`).
- Current Julia version (`ஃ`).
- Current Docker version and connected machine (`🐳`).
- Current Amazon Web Services (AWS) profile (`☁️`) ([Using named profiles](http://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html)).
- Current Google Cloud Platform gcloud active configuration (`☁️`).
- Current Python virtualenv.
- Current Conda virtualenv (`🅒`).
- Current .NET SDK version, through dotnet-cli (`.NET`).
- Current Ember.js version, through ember-cli (`🐹`).
- Current Kubectl context (`☸️`).
- Current Terraform workspace (`🛠`).
- Package version, if there's is a package in current directory (`📦`).
- Current battery level and status:
  - `⇡` - charging;
  - `⇣` - discharging;
  - `•` - fully charged.
- Current Vi-mode mode ([with handy aliases for temporarily enabling](./docs/options.md#vi-mode-vi_mode)).
- Optional exit-code of last command ([how to enable](./docs/options.md#exit-code-exit_code)).
- Optional time stamps 12/24hr in format ([how to enable](./docs/options.md#time-time)).
- Execution time of the last command if it exceeds the set threshold.

Want more features? Please, [open an issue](https://github.com/spaceship-prompt/spaceship-prompt/issues/new/choose) or send pull request.

**💡 Tip:** Follow [our Twitter](https://twitter.com/SpaceshipPrompt) to keep yourself updated about new features, improvements, and bugfixes.

## Requirements

To work correctly, you will first need:

- [`zsh`](http://www.zsh.org/) (v5.2 or recent) must be installed.
- [Powerline Font](https://github.com/powerline/fonts) must be installed and used in your terminal (for example, switch font to [Fira Code](https://github.com/tonsky/FiraCode)).

## Installing

Now that the requirements are satisfied, you can install Spaceship ZSH via any of the following tools.

**💡 Tip:** If you like this project ~~and want to get some stickers and postcards~~, consider becoming a patron:

<a href="https://patreon.com/denysdovhan">
  <img alt="Become a patron" src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="150px">
</a>

### [Homebrew]

```
brew install spaceship
```

You can also add the following to your [`Brewfile`](https://github.com/Homebrew/homebrew-bundle#usage):

```ruby
brew "spaceship"
```

### [npm]

```
npm install -g spaceship-prompt
```

Done. This command should link `spaceship.zsh` as `prompt_spaceship_setup` to your `$fpath` and set `prompt spaceship` in `.zshrc`. Just reload your terminal.
Ensure that you have enabled post-scripts in npm by `npm config set ignore-scripts false` before starting installation.

**💡 Tip:** Update Spaceship to new versions as you would any other package.

### [oh-my-zsh]

Clone this repo:

```zsh
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
```

Symlink `spaceship.zsh-theme` to your oh-my-zsh custom themes directory:

```zsh
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

Set `ZSH_THEME="spaceship"` in your `.zshrc`.

### [prezto]

- Follow [prezto-contrib#usage](https://github.com/belak/prezto-contrib#usage) to clone `prezto-contrib` to the proper location.
- Enable the `contrib-prompt` module (before the `prompt` module).
- Set `zstyle ':prezto:module:prompt' theme 'spaceship'` in your `.zpreztorc`.

### [zim]

Add `zmodule spaceship-prompt/spaceship-prompt --name spaceship` to your `.zimrc` and run `zimfw install`.

### [antigen]

Add the following snippet in your `.zshrc`:

```
antigen theme spaceship-prompt/spaceship-prompt
```

### [antibody]

Update your `.zshrc` file with the following line:

```
antibody bundle spaceship-prompt/spaceship-prompt
```

### [zinit]

Add the following line to your `.zshrc` where you're adding your other Zsh plugins:

```
zinit light spaceship-prompt/spaceship-prompt
```

### [zgen]

Add the following line to your `.zshrc` where you're adding your other Zsh plugins:

```
zgen load spaceship-prompt/spaceship-prompt spaceship
```

### [zplug]

Use this command in your `.zshrc` to load Spaceship as prompt theme:

```
zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
```

### Linux package manager

#### Arch Linux

Install the latest master from the AUR package [`spaceship-prompt-git`](https://aur.archlinux.org/packages/spaceship-prompt-git/):

```
git clone https://aur.archlinux.org/spaceship-prompt-git.git --depth=1
cd spaceship-prompt-git
makepkg -si
```

### Manual

If you have problems with approaches above, follow these instructions:

- Clone this repo `git clone https://github.com/spaceship-prompt/spaceship-prompt.git --depth=1`
- Symlink `spaceship.zsh` to somewhere in [`$fpath`](http://www.refining-linux.org/archives/46/ZSH-Gem-12-Autoloading-functions/) as `prompt_spaceship_setup`.
- Initialize prompt system and choose `spaceship`.

#### Example

Run `echo $fpath` to see possible location and link `spaceship.zsh` there, like:

```zsh
$ ln -sf "$PWD/spaceship.zsh" "/usr/local/share/zsh/site-functions/prompt_spaceship_setup"
```

For a user-specific installation, simply add a directory to `$fpath` for that user in `.zshrc`:

```zsh
fpath=( "${ZDOTDIR:-$HOME}/.zfunctions" $fpath )
```

Then install the theme like this:

```zsh
$ ln -sf "$PWD/spaceship.zsh" "${ZDOTDIR:-$HOME}/.zfunctions/prompt_spaceship_setup"
```

For initializing prompt system add this to your `.zshrc`:

```zsh
# .zshrc
autoload -U promptinit; promptinit
prompt spaceship
```

## Customization

Spaceship works well out of the box, but you can customize almost everything if you want.

- [**Options**](./docs/options.md) — Tweak section's behavior with tons of options.
- [**API**](./docs/api.md) — Define a custom section that will do exactly what you want.

You have the ability to customize or disable specific elements of Spaceship. Set options and define new sections in your `.zshrc` file, **after** the theme. To include a custom section you have defined in your prompt, add it to the `SPACESHIP_PROMPT_ORDER`.

For example:

```shell
# .zshrc

# add Spaceship (differs by setup, see Installating above)

section_mysection() {
  # ...
}

SPACESHIP_PROMPT_ORDER=(<any preceding sections> mysection <any following sections>)
```

To append custom sections to the default Spaceship prompt, follow the form:

```shell
SPACESHIP_PROMPT_ORDER=($SPACESHIP_PROMPT_ORDER mysection)
```

To prepend custom sections to the default Spaceship prompt, follow the form:

```shell
SPACESHIP_PROMPT_ORDER=(mysection $SPACESHIP_PROMPT_ORDER)
```

**💡 Tip:** Take a look at popular option presets or share your own configuration on [Presets](https://github.com/spaceship-prompt/spaceship-prompt/wiki/Presets) wiki page.

## Troubleshooting

Having trouble? Take a look at out [Troubleshooting](./docs/troubleshooting.md) page.

Still struggling? Please, [file an issue](https://github.com/spaceship-prompt/spaceship-prompt/issues/new/choose), describe your problem and we will gladly help you.

## Related Projects

Here's a list of related projects that have been inspired by Spaceship ZSH.

- [**matchai/spacefish**](https://github.com/matchai/spacefish) - A port of Spaceship ZSH for fish shell intending to achieve complete feature parity.
- [**starship/starship**](https://github.com/starship/starship) - A blazing-fast, cross-shell prompt written in Rust, heavily inspired by Spaceship ZSH.

## Team

| [![Denys Dovhan](https://github.com/denysdovhan.png?size=100)](http://denysdovhan.com) | [![Salmanul Farzy](https://github.com/salmanulfarzy.png?size=100)](https://github.com/salmanulfarzy) | [![Maxim Baz](https://github.com/maximbaz.png?size=100)](https://github.com/maximbaz) | [![Runrioter Wung](https://github.com/Runrioter.png?size=100)](https://github.com/Runrioter) |
| :------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------: |
|                     [Denys Dovhan](https://github.com/denysdovhan)                     |                          [Salmanul Farzy](https://github.com/salmanulfarzy)                          |                       [Maxim Baz](https://github.com/maximbaz)                        |                        [Runrioter Wung](https://github.com/Runrioter)                        |

## Donate

Hi! I work on this project in my spare time, in addition to my primary job. I hope you enjoy using Spaceship ZSH. If you do, please, [become my patron 🤝][patreon-url].

|                                                                    Patreon                                                                     |                                                            Bitcoin                                                             |                                                            Ethereum                                                            |
| :--------------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------: |
|                                                         [Become a patron][patreon-url]                                                         |                                              `1FrPrQb6ACTkbSBAz9PduJWrDFfq41Ggb4`                                              |                                          `0x6aF39C917359897ae6969Ad682C14110afe1a0a1`                                          |
| <a href="https://www.patreon.com/denysdovhan"><img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="150px"></a> | <img src="https://user-images.githubusercontent.com/3459374/33760933-1c9b81b4-dc10-11e7-8e4b-22d81f98c138.png" width="100px"/> | <img src="https://user-images.githubusercontent.com/3459374/33760932-1c7b3fb2-dc10-11e7-9774-411264d533da.png" width="100px"/> |

This is your way make a clear statement: **My work is valued.**

I would appreciate your support! _Thank you!_

## License

MIT © [Denys Dovhan](http://denysdovhan.com)

<!-- Badges -->

[npm-url]: https://npmjs.org/package/spaceship-prompt
[npm-image]: https://img.shields.io/npm/v/spaceship-prompt.svg?style=flat-square
[zsh-url]: http://zsh.org/
[zsh-image]: https://img.shields.io/badge/zsh-%3E%3Dv5.2-777777.svg?style=flat-square
[patreon-url]: https://www.patreon.com/denysdovhan
[patreon-image]: https://img.shields.io/badge/zsh-%3E%3Dv5.2-777777.svg?style=flat-square

<!-- References -->

[oh-my-zsh]: http://ohmyz.sh/
[prezto]: https://github.com/sorin-ionescu/prezto
[zim]: https://github.com/zimfw/zimfw
[antigen]: http://antigen.sharats.me/
[zgen]: https://github.com/tarjoilija/zgen
[npm]: https://www.npmjs.com/
[antibody]: https://github.com/getantibody/antibody
[zplug]: https://github.com/zplug/zplug
[homebrew]: https://brew.sh
[n]: https://github.com/tj/n
[xcenv]: http://xcenv.org/
[swiftenv]: https://github.com/kylef/swiftenv
[powerline]: https://github.com/powerline/fonts
[zinit]: https://github.com/zdharma/zinit
