---
hide:
  - navigation
---

# Troubleshooting

This page aimed to help you fix the common problems encountered while using Spaceship prompt.

## What's the weird symbol for `git` branch?

You need to have a powerline patched font in order to properly display `git` branch symbol.

- Install any powerline compatible font like [Fira Code](https://github.com/tonsky/FiraCode) or [others](https://github.com/powerline/fonts).
- Configure your terminal emulator to [use that font](https://powerline.readthedocs.io/en/master/troubleshooting/osx.html).

## What's the weird character in front of a section?

This is not an issue with Spaceship prompt. Spaceship uses Unicode symbols to represent `SPACESHIP_*_SYMBOL` in sections. To solve this problem:

- Verify your terminal emulator support Unicode characters with this command:
  ```zsh
  curl -L https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt
  # or
  wget -O - https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt
  ```
- Configure your terminal emulator to use UTF-8 as character encoding.

In case Unicode symbols aren't supported, you can replace them to those that are compatible with your terminal with `SPACESHIP_*_SYMBOL` options. Check out [Options](./options.md) page for more information.

## What is the `[I]` before prompt character ?

That's [`vi_mode`](https://spaceship-prompt.sh/options/#vi-mode-vi_mode) section indicating `insert` mode. You can disable that with following line in your configuration,

```
SPACESHIP_VI_MODE_SHOW=false
```

## Why is my prompt slow?

Spaceship may work slower in big repositories since status checkings are quite a heavy operation. In this case, try to avoid having many uncommitted files.

Using `grep` to fetch package version wasn't returning accurate information. So now we use `jq` with fallbacks to `python` and `node`, Which might slightly affect performance. In that case install [jq](https://stedolan.github.io/jq/) (see [#439], [#441] for more information).

[#439]: https://github.com/spaceship-prompt/spaceship-prompt/issues/439
[#441]: https://github.com/spaceship-prompt/spaceship-prompt/pull/441

Prompt also may slow down because of loading of unused sections. Spaceship loads only sections mentioned in `SPACESHIP_PROMPT_ORDER` or `SPACESHIP_RPROMPT_ORDER`. If you think some sections might be useless for you, try to disable them by omitting their names in order options.

In the example below, `time`, `package`, `xcode`, `julia`, `docker`, `ember` and `vi_mode` sections are disabled so that they won't be loaded at all.

```zsh
# Just comment a section if you want to disable it
SPACESHIP_PROMPT_ORDER=(
  # time        # Time stamps section (Disabled)
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  # package     # Package version (Disabled)
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  # xcode       # Xcode section (Disabled)
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  # julia       # Julia section (Disabled)
  # docker      # Docker section (Disabled)
  aws           # Amazon Web Services section
  gcloud        # Google Cloud Platform section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  # ember       # Ember.js section (Disabled)
  kubectl       # Kubectl context section
  terraform     # Terraform workspace section
  ibmcloud      # IBM Cloud section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  # vi_mode     # Vi-mode indicator (Disabled)
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
```

Disabling a lot of unused section may achieve a significant performance boost. Here's a comparison of rendering Spaceship prompt 100 times with all sections enabled and with `SPACESHIP_PROMPT_ORDER` from example above:

|                    | All section | With disabled sections |
| :----------------- | :---------: | :--------------------: |
| Inside Git repo\*  |   `23.5s`   |        `21.3s`         |
| Outside Git repo\* |   `8.3s`    |         `7.4s`         |

\* — `spaceship-prompt` repo is used in this test.

## Some section icons overlap each other?

![](https://user-images.githubusercontent.com/3459374/34945188-1f6398be-fa0b-11e7-9845-a744bc3e148d.png)

This issue is related to how your terminal emulator renders Unicode 9 characters. To fix this issue:

- Make sure terminal uses _Unicode Version 9 Widths_.
- Let your terminal render ambiguous-width characters as double-width.

In _iTerm_ follow these instructions:

- Go _iTerm → Preferences… (⌘,) → Profiles → Text_
- Check _Unicode Version 9 Widths_.
- Check _Threat ambiguous-width characters as double-width_.
- Reload terminal's tab.

## Why doesn't my prompt look like the preview?

![preview](https://user-images.githubusercontent.com/10276208/36086434-5de52ace-0ff2-11e8-8299-c67f9ab4e9bd.gif)

Preview shows `spaceship` prompt setup with:

- [Hyper](https://hyper.is) as terminal emulator.
- [One Dark](https://www.npmjs.com/package/hyperterm-atom-dark) color theme from [Atom](https://atom.io/) editor.
- [Fira Code](https://github.com/tonsky/FiraCode) with with ligatures as primary font (16px size).
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) to have commands colorized.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) to have browser-like autocompletions.

See [screenshots](https://github.com/spaceship-prompt/spaceship-prompt/wiki/Screenshots) wiki for more color schemes examples.

## Does not help?

If any of above does not help, please, [file an issue](https://github.com/spaceship-prompt/spaceship-prompt/issues/new), describe your problem and we will gladly help you.
