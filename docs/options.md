---
hide:
  - navigation
---

## Порядок

You have ability to customize or disable specific elements of Spaceship. All options must be overridden in your `.zshrc` file **after** the theme.

Colors for sections can be [basic colors](https://wiki.archlinux.org/index.php/zsh#Colors) or [color codes](https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg).

!!! note The symbol `·` in this document represents a regular space character ``, it is used to clearly indicate when an option default value starts or ends with a space.

### Порядок

You can specify the order of prompt section using `SPACESHIP_PROMPT_ORDER` option. Use Zsh array syntax to define your own prompt order.

The order also defines which sections that Spaceship loads. If you're struggling with slow prompt, you can just omit the sections that you don't use, and they won't be loaded.

Типовий порядок:

```zsh
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  gradle        # Gradle section
  maven         # Maven section
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  gcloud        # Google Cloud Platform section
  venv          # virtualenv section
  conda         # conda virtualenv section
  python        # Python section
  dotnet        # .NET section
  ember         # Ember.js section
  kubectl       # Kubectl context section
  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
```

You can also add items to the right prompt by specifying them in the `SPACESHIP_RPROMPT_ORDER` option. By default `SPACESHIP_RPROMPT_ORDER` is empty.

### Командний рядок

This group of options defines a behaviour of prompt and standard parameters for sections displaying.

| Змінна                               | За замовчуванням | Пояснення                                                   |
| :----------------------------------- | :--------------: | ----------------------------------------------------------- |
| `SPACESHIP_PROMPT_ADD_NEWLINE`       |      `true`      | Додає символ нового рядка перед кожним командним рядком     |
| `SPACESHIP_PROMPT_SEPARATE_LINE`     |      `true`      | Відображати підказку у два рядки                            |
| `SPACESHIP_PROMPT_FIRST_PREFIX_SHOW` |     `false`      | Показує префікс першого розділу у командному рядку          |
| `SPACESHIP_PROMPT_PREFIXES_SHOW`     |      `true`      | Показувати префікси перед секціями у командному рядку чи ні |
| `SPACESHIP_PROMPT_SUFFIXES_SHOW`     |      `true`      | Показувати суфікси після секцій у командному рядку чи ні    |
| `SPACESHIP_PROMPT_DEFAULT_PREFIX`    |      `via·`      | Типовий префікс для секцій                                  |
| `SPACESHIP_PROMPT_DEFAULT_SUFFIX`    |        ``        | Типовий суфікс для секцій                                   |

### Символ

| Змінна                            |     За замовчуванням     | Пояснення                                                            |
| :-------------------------------- | :----------------------: | -------------------------------------------------------------------- |
| `SPACESHIP_CHAR_PREFIX`           |            ``            | Prefix before prompt character                                       |
| `SPACESHIP_CHAR_SUFFIX`           |            ``            | Suffix after prompt character                                        |
| `SPACESHIP_CHAR_SYMBOL`           |           `➜`            | Prompt character to be shown before any command                      |
| `SPACESHIP_CHAR_SYMBOL_ROOT`      | `$SPACESHIP_CHAR_SYMBOL` | Prompt character to be shown before any command for the root user    |
| `SPACESHIP_CHAR_SYMBOL_SECONDARY` | `$SPACESHIP_CHAR_SYMBOL` | Secondary prompt character to be shown for incomplete commands       |
| `SPACESHIP_CHAR_COLOR_SUCCESS`    |         `green`          | Color of prompt character if last command completes successfully     |
| `SPACESHIP_CHAR_COLOR_FAILURE`    |          `red`           | Color of prompt character if last command returns non-zero exit-code |
| `SPACESHIP_CHAR_COLOR_SECONDARY`  |         `yellow`         | Color of secondary prompt character                                  |

### Час (`time`)

Disabled by default. Set `SPACESHIP_TIME_SHOW` to `true` in your `.zshrc`, if you need to show time stamps.

| Змінна                  |          За замовчуванням          | Пояснення                                                                                                             |
| :---------------------- | :--------------------------------: | --------------------------------------------------------------------------------------------------------------------- |
| `SPACESHIP_TIME_SHOW`   |              `false`               | Show time (set to `true` for enabling)                                                                                |
| `SPACESHIP_TIME_PREFIX` |               `at·`                | Prefix before time section                                                                                            |
| `SPACESHIP_TIME_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after time section                                                                                             |
| `SPACESHIP_TIME_COLOR`  |              `yellow`              | Color of time section                                                                                                 |
| `SPACESHIP_TIME_FORMAT` |              `false`               | Custom date formatting [ZSH date formats](http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Date-and-time) |
| `SPACESHIP_TIME_12HR`   |              `false`               | Format time using 12-hour clock (am/pm)                                                                               |

### Ім’я користувача (`user`)

By default, a username is shown only when it's not the same as `$LOGNAME`, when you're connected via SSH or when you're root. Root user is highlighted in `SPACESHIP_USER_COLOR_ROOT` color (red as default).

| Змінна                      |          За замовчуванням          | Пояснення                                                 |
| :-------------------------- | :--------------------------------: | --------------------------------------------------------- |
| `SPACESHIP_USER_SHOW`       |               `true`               | Show user section (`true`, `false`, `always` or `needed`) |
| `SPACESHIP_USER_PREFIX`     |              `with·`               | Prefix before user section                                |
| `SPACESHIP_USER_SUFFIX`     | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after user section                                 |
| `SPACESHIP_USER_COLOR`      |              `yellow`              | Color of user section                                     |
| `SPACESHIP_USER_COLOR_ROOT` |               `red`                | Color of user section when it's root                      |

`SPACESHIP_USER_SHOW` defines when to show username section. Here are possible values:

| `SPACESHIP_USER_SHOW` | Show on local | Show on remote |
| :-------------------: | :------------ | :------------- |
|        `false`        | Never         | Never          |
|       `always`        | Always        | Always         |
|        `true`         | If needed     | Always         |
|       `needed`        | If needed     | If needed      |

### Ім’я хоста (`host`)

Hostname is shown only when you're connected via SSH unless you change this behavior.

| Змінна                     |          За замовчуванням          | Пояснення                                       |
| :------------------------- | :--------------------------------: | ----------------------------------------------- |
| `SPACESHIP_HOST_SHOW`      |               `true`               | Show host section (`true`, `false` or `always`) |
| `SPACESHIP_HOST_SHOW_FULL` |              `false`               | Show full hostname section (`true`, `false`)    |
| `SPACESHIP_HOST_PREFIX`    |               `at·`                | Prefix before the connected SSH machine name    |
| `SPACESHIP_HOST_SUFFIX`    | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the connected SSH machine name     |
| `SPACESHIP_HOST_COLOR`     |               `blue`               | Color of host section                           |
| `SPACESHIP_HOST_COLOR_SSH` |              `green`               | Color of host in SSH connection                 |

### Директорія (`dir`)

Directory is always shown and truncated to the value of `SPACESHIP_DIR_TRUNC`. While you are in repository, it shows only root directory and folders inside it. If current directory is write-protected or if current user has not enough rights to write in it, a padlock (by default) is displayed as a suffix.

| Змінна                       |                                              За замовчуванням                                               | Пояснення                                                                              |
| :--------------------------- | :---------------------------------------------------------------------------------------------------------: | -------------------------------------------------------------------------------------- |
| `SPACESHIP_DIR_SHOW`         |                                                   `true`                                                    | Show directory section                                                                 |
| `SPACESHIP_DIR_PREFIX`       |                                                    `in·`                                                    | Prefix before current directory                                                        |
| `SPACESHIP_DIR_SUFFIX`       |                                     `$SPACESHIP_PROMPT_DEFAULT_SUFFIX`                                      | Suffix after current directory                                                         |
| `SPACESHIP_DIR_TRUNC`        |                                                     `3`                                                     | Number of folders of cwd to show in prompt, 0 to show all                              |
| `SPACESHIP_DIR_TRUNC_PREFIX` |                                                     ``                                                      | Prefix before cwd when it's truncated. For example `…/` or `.../`, empty to disable    |
| `SPACESHIP_DIR_TRUNC_REPO`   |                                                   `true`                                                    | While in `git` repo, show only root directory and folders inside it                    |
| `SPACESHIP_DIR_COLOR`        |                                                   `cyan`                                                    | Color of directory section                                                             |
| `SPACESHIP_DIR_LOCK_SYMBOL`  | ![·](https://user-images.githubusercontent.com/10276208/46248218-4af95d80-c434-11e8-8e25-595d792503f1.png) | The symbol displayed if directory is write-protected (requires powerline patched font) |
| `SPACESHIP_DIR_LOCK_COLOR`   |                                                    `red`                                                    | Color for the lock symbol                                                              |

### Git (`git`)

Git section consists of `git_branch` and `git_status` subsections. Він відображається лише в Git-репозитаріях.

| Variable               |                                                  Default                                                   | Meaning                                                                                                          |
| :--------------------- | :--------------------------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------------------------------- |
| `SPACESHIP_GIT_SHOW`   |                                                   `true`                                                   | Show Git section                                                                                                 |
| `SPACESHIP_GIT_PREFIX` |                                                   `on·`                                                    | Prefix before Git section                                                                                        |
| `SPACESHIP_GIT_SUFFIX` |                                     `$SPACESHIP_PROMPT_DEFAULT_SUFFIX`                                     | Suffix after Git section                                                                                         |
| `SPACESHIP_GIT_SYMBOL` | ![·](https://user-images.githubusercontent.com/3459374/34947621-4f324a92-fa13-11e7-9b99-cdba2cdda6b9.png) | Character to be shown before Git section (requires [powerline patched font](https://github.com/powerline/fonts)) |

#### Git гілка (`git_branch`)

| Змінна                        |    За замовчуванням     | Пояснення                           |
| :---------------------------- | :---------------------: | ----------------------------------- |
| `SPACESHIP_GIT_BRANCH_SHOW`   |         `true`          | Show Git branch subsection          |
| `SPACESHIP_GIT_BRANCH_PREFIX` | `$SPACESHIP_GIT_SYMBOL` | Prefix before Git branch subsection |
| `SPACESHIP_GIT_BRANCH_SUFFIX` |           ``            | Suffix after Git branch subsection  |
| `SPACESHIP_GIT_BRANCH_COLOR`  |        `magenta`        | Color of Git branch subsection      |

#### Git статус (`git_status`)

Індикатори стану Git показуються лише тоді, коли у вас є зміни в репозиторії.

| Змінна                           | За замовчуванням | Пояснення                                                    |
| :------------------------------- | :--------------: | ------------------------------------------------------------ |
| `SPACESHIP_GIT_STATUS_SHOW`      |      `true`      | Show Git status subsection                                   |
| `SPACESHIP_GIT_STATUS_PREFIX`    |       `·[`       | Prefix before Git status subsection                          |
| `SPACESHIP_GIT_STATUS_SUFFIX`    |       `]`        | Suffix after Git status subsection                           |
| `SPACESHIP_GIT_STATUS_COLOR`     |      `red`       | Color of Git status subsection                               |
| `SPACESHIP_GIT_STATUS_UNTRACKED` |       `?`        | Indicator for untracked changes                              |
| `SPACESHIP_GIT_STATUS_ADDED`     |       `+`        | Indicator for added changes                                  |
| `SPACESHIP_GIT_STATUS_MODIFIED`  |       `!`        | Indicator for unstaged files                                 |
| `SPACESHIP_GIT_STATUS_RENAMED`   |       `»`        | Indicator for renamed files                                  |
| `SPACESHIP_GIT_STATUS_DELETED`   |       `✘`        | Indicator for deleted files                                  |
| `SPACESHIP_GIT_STATUS_STASHED`   |       `$`        | Indicator for stashed changes                                |
| `SPACESHIP_GIT_STATUS_UNMERGED`  |       `=`        | Indicator for unmerged changes                               |
| `SPACESHIP_GIT_STATUS_AHEAD`     |       `⇡`        | Indicator for unpushed changes (ahead of remote branch)      |
| `SPACESHIP_GIT_STATUS_BEHIND`    |       `⇣`        | Indicator for unpulled changes (behind of remote branch)     |
| `SPACESHIP_GIT_STATUS_DIVERGED`  |       `⇕`        | Indicator for diverged changes (diverged with remote branch) |

### Mercurial (`hg`)

Mercurial section is consists with `hg_branch` and `hg_status` subsections. It is shown only in Mercurial repositories.

| Змінна                |          За замовчуванням          | Пояснення                                      |
| :-------------------- | :--------------------------------: | ---------------------------------------------- |
| `SPACESHIP_HG_SHOW`   |               `true`               | Show Mercurial section                         |
| `SPACESHIP_HG_PREFIX` |               `on·`                | Prefix before Mercurial section                |
| `SPACESHIP_HG_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Mercurial section                 |
| `SPACESHIP_HG_SYMBOL` |                `☿·`                | Character to be shown before Mercurial section |

#### Mercurial гілка (`hg_branch`)

Shows Mercurial bookmarks when available, otherwise shows Mercurial branch information.

| Змінна                       |          За замовчуванням          | Пояснення                                 |
| :--------------------------- | :--------------------------------: | ----------------------------------------- |
| `SPACESHIP_HG_BRANCH_SHOW`   |               `true`               | Show Mercurial branch subsection          |
| `SPACESHIP_HG_BRANCH_PREFIX` |       `$SPACESHIP_HG_SYMBOL`       | Prefix before Mercurial branch subsection |
| `SPACESHIP_HG_BRANCH_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Mercurial branch subsection  |
| `SPACESHIP_HG_BRANCH_COLOR`  |             `magenta`              | Color of Mercurial branch subsection      |

#### Mercurial статус (`hg_status`)

Mercurial status indicators is shown only when you have dirty repository.

| Змінна                          | За замовчуванням | Пояснення                                 |
| :------------------------------ | :--------------: | ----------------------------------------- |
| `SPACESHIP_HG_STATUS_SHOW`      |      `true`      | Show Mercurial status subsection          |
| `SPACESHIP_HG_STATUS_PREFIX`    |       `[`        | Prefix before Mercurial status subsection |
| `SPACESHIP_HG_STATUS_SUFFIX`    |       `]`        | Suffix after Mercurial status subsection  |
| `SPACESHIP_HG_STATUS_COLOR`     |      `red`       | Color of Mercurial status subsection      |
| `SPACESHIP_HG_STATUS_UNTRACKED` |       `?`        | Indicator for untracked changes           |
| `SPACESHIP_HG_STATUS_ADDED`     |       `+`        | Indicator for added changes               |
| `SPACESHIP_HG_STATUS_MODIFIED`  |       `!`        | Indicator for unstaged files              |
| `SPACESHIP_HG_STATUS_DELETED`   |       `✘`        | Indicator for deleted files               |

### Версія пакету (`package`)

> Works for [npm](https://www.npmjs.com/) and [cargo](https://crates.io/) at the moment. Please, help us improve this section!

Package version is shown when repository is a package.

- **npm** — `npm` package contains a `package.json` file. We use `jq`, `python` to parse package version for improving performance and `node` as a fallback. Install [jq](https://stedolan.github.io/jq/) for **improved performance** of this section ([Why?](./troubleshooting.md#why-is-my-prompt-slow))
- **lerna** — `lerna` monorepo contains a `lerna.json` file. We use `jq`, `python` to parse package version for improving performance and `node` as a fallback. Install [jq](https://stedolan.github.io/jq/) for **improved performance** of this section (same reason as npm).
- **cargo** — `cargo` package contains a `Cargo.toml` file. Currently, we use `cargo pkgid`, it depends on `Cargo.lock`. So if package version isn't shown, you may need to run some command like `cargo build` which can generate `Cargo.lock` file.

> **Note:** This is the version of the package you are working on, not the version of package manager itself.

| Змінна                     |          За замовчуванням          | Пояснення                                    |
| :------------------------- | :--------------------------------: | -------------------------------------------- |
| `SPACESHIP_PACKAGE_SHOW`   |               `true`               | Show package version                         |
| `SPACESHIP_PACKAGE_PREFIX` |               `is·`                | Prefix before package version section        |
| `SPACESHIP_PACKAGE_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after package version section         |
| `SPACESHIP_PACKAGE_SYMBOL` |               `📦·`                | Character to be shown before package version |
| `SPACESHIP_PACKAGE_COLOR`  |               `red`                | Color of package version section             |

### Node.js (`node`)

Node.js section is shown only in directories that contain `package.json` file, or `node_modules` folder, or any other file with `.js` extension.

If you set `SPACESHIP_NODE_DEFAULT_VERSION` to the default Node.js version and your current version is the same as `SPACESHIP_NODE_DEFAULT_VERSION`, then Node.js section will be hidden.

| Змінна                           |          За замовчуванням          | Пояснення                                    |
| :------------------------------- | :--------------------------------: | -------------------------------------------- |
| `SPACESHIP_NODE_SHOW`            |               `true`               | Current Node.js section                      |
| `SPACESHIP_NODE_PREFIX`          | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before Node.js section                |
| `SPACESHIP_NODE_SUFFIX`          | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Node.js section                 |
| `SPACESHIP_NODE_SYMBOL`          |                `⬢·`                | Character to be shown before Node.js version |
| `SPACESHIP_NODE_DEFAULT_VERSION` |                 ``                 | Node.js version to be treated as default     |
| `SPACESHIP_NODE_COLOR`           |              `green`               | Колір секції Node.js                         |

### Ruby (`ruby`)

Ruby section is shown only in directories that contain `Gemfile`, or `Rakefile`, or any other file with `.rb` extension.

| Змінна                  |          За замовчуванням          | Пояснення                                 |
| :---------------------- | :--------------------------------: | ----------------------------------------- |
| `SPACESHIP_RUBY_SHOW`   |               `true`               | Show Ruby section                         |
| `SPACESHIP_RUBY_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before Ruby section                |
| `SPACESHIP_RUBY_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Ruby section                 |
| `SPACESHIP_RUBY_SYMBOL` |               `💎·`                | Character to be shown before Ruby version |
| `SPACESHIP_RUBY_COLOR`  |               `red`                | Color of Ruby section                     |

### Elm (`elm`)

Elm section is shown only in directories that contain `elm.json` file, `elm-package.json` file, `elm-stuff` directory, or any other file with `.elm` extension.

| Змінна                 |          За замовчуванням          | Пояснення                                |
| :--------------------- | :--------------------------------: | ---------------------------------------- |
| `SPACESHIP_ELM_SHOW`   |               `true`               | Show installed Elm version               |
| `SPACESHIP_ELM_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before Elm section                |
| `SPACESHIP_ELM_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Elm section                 |
| `SPACESHIP_ELM_SYMBOL` |               `🌳·`                | Character to be shown before Elm version |
| `SPACESHIP_ELM_COLOR`  |               `cyan`               | Колір секції Elm                         |

### Elixir (`elixir`)

Elixir section is shown only in directories that contain `mix.exs`, or any other file with `.ex` or `.exs` extension. If the current elixir version is the same as the version set in `SPACESHIP_ELIXIR_DEFAULT_VERSION`, the elixir section will be hidden.

| Змінна                             |          За замовчуванням          | Пояснення                                   |
| :--------------------------------- | :--------------------------------: | ------------------------------------------- |
| `SPACESHIP_ELIXIR_SHOW`            |               `true`               | Show Elixir section                         |
| `SPACESHIP_ELIXIR_PREFIX`          | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before Elixir section                |
| `SPACESHIP_ELIXIR_SUFFIX`          | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Elixir section                 |
| `SPACESHIP_ELIXIR_DEFAULT_VERSION` |                 ``                 | Elixir version to be treated as default     |
| `SPACESHIP_ELIXIR_SYMBOL`          |               `💧·`                | Character to be shown before Elixir version |
| `SPACESHIP_ELIXIR_COLOR`           |             `magenta`              | Color of Elixir section                     |

### Xcode (`xcode`)

Показує поточну версію Xcode. Локальна версія має більший пріоритет, ніж глобальна.

| Змінна                        |          За замовчуванням          | Пояснення                                    |
| :---------------------------- | :--------------------------------: | -------------------------------------------- |
| `SPACESHIP_XCODE_SHOW_LOCAL`  |               `true`               | Current local Xcode version based on [xcenv] |
| `SPACESHIP_XCODE_SHOW_GLOBAL` |              `false`               | Global Xcode version based on [xcenv]        |
| `SPACESHIP_XCODE_PREFIX`      | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before Xcode section                  |
| `SPACESHIP_XCODE_SUFFIX`      | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Xcode section                   |
| `SPACESHIP_XCODE_SYMBOL`      |                `🛠·`                | Character to be shown before Xcode version   |
| `SPACESHIP_XCODE_COLOR`       |               `blue`               | Колір секції Xcode                           |

### Swift (`swift`)

Показує поточну версію Swift. Локальна версія має більший пріоритет, ніж глобальна.

| Змінна                        |          За замовчуванням          | Пояснення                                       |
| :---------------------------- | :--------------------------------: | ----------------------------------------------- |
| `SPACESHIP_SWIFT_SHOW_LOCAL`  |               `true`               | Current local Swift version based on [swiftenv] |
| `SPACESHIP_SWIFT_SHOW_GLOBAL` |              `false`               | Global Swift version based on [swiftenv]        |
| `SPACESHIP_SWIFT_PREFIX`      | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before the Swift section                 |
| `SPACESHIP_SWIFT_SUFFIX`      | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix to be shown before the Swift section     |
| `SPACESHIP_SWIFT_SYMBOL`      |               `🐦·`                | Character to be shown before Swift version      |
| `SPACESHIP_SWIFT_COLOR`       |              `yellow`              | Колір секції Swift                              |

### Go (`golang`)

Go section is shown only in directories that contain `go.mod`, `Godeps`, `glide.yaml`, any other file with `.go` extension, or when current directory is in the Go workspace defined in `$GOPATH`.

If you are using a development version of `Go`, the version uses git commit hash instead.

Наприклад:

- `devel:5efe9a8f11` for development version
- `v1.11.4` for release version

| Змінна                    |          За замовчуванням          | Пояснення                               |
| :------------------------ | :--------------------------------: | --------------------------------------- |
| `SPACESHIP_GOLANG_SHOW`   |               `true`               | Shown current Go version or not         |
| `SPACESHIP_GOLANG_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before the Go section            |
| `SPACESHIP_GOLANG_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the Go section             |
| `SPACESHIP_GOLANG_SYMBOL` |               `🐹·`                | Character to be shown before Go version |
| `SPACESHIP_GOLANG_COLOR`  |               `cyan`               | Колір секції Go                         |

### PHP (`php`)

PHP section is shown only in directories that contain `composer.json` file, or any other file with `.php` extension.

| Змінна                 |          За замовчуванням          | Пояснення                                |
| :--------------------- | :--------------------------------: | ---------------------------------------- |
| `SPACESHIP_PHP_SHOW`   |                true                | Показувати секцію PHP                    |
| `SPACESHIP_PHP_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Префікс перед секцією PHP                |
| `SPACESHIP_PHP_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Суфікс після секції PHP                  |
| `SPACESHIP_PHP_SYMBOL` |               `🐘·`                | Character to be shown before PHP version |
| `SPACESHIP_PHP_COLOR`  |               `blue`               | Колір секції PHP                         |

### Rust (`rust`)

Rust section is shown only in directories that contain `Cargo.toml` or any other file with `.rs` extension.

| Змінна                           |          За замовчуванням          | Пояснення                                               |
| :------------------------------- | :--------------------------------: | ------------------------------------------------------- |
| `SPACESHIP_RUST_SHOW`            |               `true`               | Shown current Rust version or not                       |
| `SPACESHIP_RUST_PREFIX`          | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before the Rust section                          |
| `SPACESHIP_RUST_SUFFIX`          | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the Rust section                           |
| `SPACESHIP_RUST_SYMBOL`          |               `🦀·`                | Character to be shown before Rust version               |
| `SPACESHIP_RUST_COLOR`           |               `red`                | Color of Rust section                                   |
| `SPACESHIP_RUST_VERBOSE_VERSION` |              `false`               | Show what branch is being used, if any. (Beta, Nightly) |

### Haskell (`haskell`)

Секція Haskell відображається лише у каталогах, які містять файл `stack.yaml`.

| Змінна                     |          За замовчуванням          | Пояснення                                               |
| :------------------------- | :--------------------------------: | ------------------------------------------------------- |
| `SPACESHIP_HASKELL_SHOW`   |               `true`               | Shown current Haskell Tool Stack version or not         |
| `SPACESHIP_HASKELL_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before the Haskell section                       |
| `SPACESHIP_HASKELL_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the Haskell section                        |
| `SPACESHIP_HASKELL_SYMBOL` |                `λ·`                | Character to be shown before Haskell Tool Stack version |
| `SPACESHIP_HASKELL_COLOR`  |               `red`                | Колір секції Haskell                                    |

### Julia (`julia`)

Секція Julia відображається лише у каталогах, що містять файл з розширенням `.jl`.

| Змінна                   |          За замовчуванням          | Пояснення                                  |
| :----------------------- | :--------------------------------: | ------------------------------------------ |
| `SPACESHIP_JULIA_SHOW`   |               `true`               | Shown current Julia version or not         |
| `SPACESHIP_JULIA_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before the Julia section            |
| `SPACESHIP_JULIA_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the Julia section             |
| `SPACESHIP_JULIA_SYMBOL` |                `ஃ·`                | Character to be shown before Julia version |
| `SPACESHIP_JULIA_COLOR`  |              `green`               | Колір секції Julia                         |

### Docker (`docker`)

Docker section is shown only in directories that contain `Dockerfile` or it's possible to run `docker-compose`.

`docker-compose` will run only if there is docker-compose.yml, or other file(s) specified with `COMPOSE_FILE` are accessible.

The environment variable `COMPOSE_PATH_SEPARATOR` is supported too. For more information see [Compose CLI environment variables](https://docs.docker.com/compose/reference/envvars/).

| Змінна                     |          За замовчуванням          | Пояснення                                   |
| :------------------------- | :--------------------------------: | ------------------------------------------- |
| `SPACESHIP_DOCKER_SHOW`    |               `true`               | Show current Docker version or not          |
| `SPACESHIP_DOCKER_PREFIX`  |                `on`                | Prefix before the Docker section            |
| `SPACESHIP_DOCKER_SUFFIX`  | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the Docker section             |
| `SPACESHIP_DOCKER_SYMBOL`  |               `🐳·`                | Character to be shown before Docker version |
| `SPACESHIP_DOCKER_COLOR`   |               `cyan`               | Color of Docker section                     |
| `SPACESHIP_DOCKER_VERBOSE` |              `false`               | Show complete Docker version                |

### Контекст Docker (`docker_context`)

| Змінна                            | За замовчуванням | Пояснення                                |
| :-------------------------------- | :--------------: | ---------------------------------------- |
| `SPACESHIP_DOCKER_CONTEXT_SHOW`   |      `true`      | Show current Docker context or not       |
| `SPACESHIP_DOCKER_CONTEXT_PREFIX` |       `·(`       | Prefix before the Docker context section |
| `SPACESHIP_DOCKER_CONTEXT_SUFFIX` |       `)`        | Suffix after the Docker context section  |

### Amazon Web Services (AWS) (`aws`)

Shows selected Amazon Web Services profile configured using [`AWS_PROFILE`](http://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html) variable.

| Змінна                 |          За замовчуванням          | Пояснення                                    |
| :--------------------- | :--------------------------------: | -------------------------------------------- |
| `SPACESHIP_AWS_SHOW`   |               `true`               | Show current selected AWS-cli profile or not |
| `SPACESHIP_AWS_PREFIX` |              `using·`              | Prefix before the AWS section                |
| `SPACESHIP_AWS_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the AWS section                 |
| `SPACESHIP_AWS_SYMBOL` |               `☁️·`                | Character to be shown before AWS profile     |
| `SPACESHIP_AWS_COLOR`  |               `208`                | Color of AWS section                         |

### Google Cloud Platform (`gcloud`)

Shows active Google Cloud Platform configuration using gcloud active configuration file.

| Змінна                    |          За замовчуванням          | Пояснення                                                |
| :------------------------ | :--------------------------------: | -------------------------------------------------------- |
| `SPACESHIP_GCLOUD_SHOW`   |               `true`               | Show current active gcloud configuration or not          |
| `SPACESHIP_GCLOUD_PREFIX` |              `using·`              | Prefix before the GCLOUD section                         |
| `SPACESHIP_GCLOUD_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the GCLOUD section                          |
| `SPACESHIP_GCLOUD_SYMBOL` |               `☁️·`                | Character to be shown before GCLOUD active configuration |
| `SPACESHIP_GCLOUD_COLOR`  |                `26`                | Color of GCLOUD section                                  |

### Virtualenv (`venv`)

| Змінна                         |          За замовчуванням          | Пояснення                                                                                      |
| :----------------------------- | :--------------------------------: | ---------------------------------------------------------------------------------------------- |
| `SPACESHIP_VENV_SHOW`          |               `true`               | Show current Python virtualenv or not                                                          |
| `SPACESHIP_VENV_PREFIX`        | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before the virtualenv section                                                           |
| `SPACESHIP_VENV_SUFFIX`        | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the virtualenv section                                                            |
| `SPACESHIP_VENV_SYMBOL`        |                `·`                 | Character to be shown before virtualenv                                                        |
| `SPACESHIP_VENV_GENERIC_NAMES` |     `(virtualenv venv .venv)`      | If the virtualenv folder is in this _array_, than use its parent directory as its name instead |
| `SPACESHIP_VENV_COLOR`         |               `blue`               | Color of virtualenv environment section                                                        |

### Conda virtualenv (`conda`)

Show activated conda virtual environment. Disable native conda prompt by `conda config --set changeps1 False`.

| Змінна                    |          За замовчуванням          | Пояснення                                                |
| :------------------------ | :--------------------------------: | -------------------------------------------------------- |
| `SPACESHIP_CONDA_SHOW`    |               `true`               | Show current Python conda virtualenv or not              |
| `SPACESHIP_CONDA_PREFIX`  | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before the conda virtualenv section               |
| `SPACESHIP_CONDA_SUFFIX`  | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the conda virtualenv section                |
| `SPACESHIP_CONDA_SYMBOL`  |                `🅒·`                | Character to be shown before conda virtualenv section    |
| `SPACESHIP_CONDA_COLOR`   |               `blue`               | Color of conda virtualenv environment section            |
| `SPACESHIP_CONDA_VERBOSE` |               `true`               | Toggle to truncate environment names under custom prefix |

### Python (`python`)

Python version is shown only inside directories that contain relevant files like `requirements.txt`, `Pipfile`, `pyproject.toml` or any other file with `.py` extension with virtual environment activated or if section is configured to be displayed `always` with relevant files.

| Variable                  |              Default               | Meaning                                                          |
| :------------------------ | :--------------------------------: | ---------------------------------------------------------------- |
| `SPACESHIP_PYTHON_SHOW`   |               `true`               | Show current Python version or not (`true`, `false` or `always`) |
| `SPACESHIP_PYTHON_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before the python section                                 |
| `SPACESHIP_PYTHON_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the python section                                  |
| `SPACESHIP_PYTHON_SYMBOL` |               `🐍·`                | Character to be shown before python version                      |
| `SPACESHIP_PYTHON_COLOR`  |              `yellow`              | Color of python section                                          |

### .NET (`dotnet`)

.NET section is shown only in directories that contains a `project.json` or `global.json` file, or a file with one of these extensions: `.csproj`, `.xproj` or `.sln`.

| Змінна                    |          За замовчуванням          | Пояснення                                 |
| :------------------------ | :--------------------------------: | ----------------------------------------- |
| `SPACESHIP_DOTNET_SHOW`   |               `true`               | Current .NET section                      |
| `SPACESHIP_DOTNET_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before .NET section                |
| `SPACESHIP_DOTNET_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after .NET section                 |
| `SPACESHIP_DOTNET_SYMBOL` |              `.NET·`               | Character to be shown before .NET version |
| `SPACESHIP_DOTNET_COLOR`  |               `128`                | Color of .NET section                     |

### Ember.js (`ember`)

Ember.js section is shown only in directories that contain a `ember-cli-build.js` file.

| Variable                 |          За замовчуванням          | Пояснення                                     |
| :----------------------- | :--------------------------------: | --------------------------------------------- |
| `SPACESHIP_EMBER_SHOW`   |               `true`               | Current Ember.js section                      |
| `SPACESHIP_EMBER_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before Ember.js section                |
| `SPACESHIP_EMBER_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Ember.js section                 |
| `SPACESHIP_EMBER_SYMBOL` |               `🐹·`                | Character to be shown before Ember.js version |
| `SPACESHIP_EMBER_COLOR`  |               `210`                | Color of Ember.js section                     |

### Kubernetes (`kubectl`)

Kubernetes section consists of `kubectl_version` and `kubectl_context` subsections. It is shown only when kubectl can connect to Kubernetes cluster.

| Змінна                     |          За замовчуванням          | Пояснення                                          |
| :------------------------- | :--------------------------------: | -------------------------------------------------- |
| `SPACESHIP_KUBECTL_SHOW`   |              `false`               | Show Kubernetes section                            |
| `SPACESHIP_KUBECTL_PREFIX` |               `at·`                | Prefix before Kubernetes section                   |
| `SPACESHIP_KUBECTL_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Kubernetes section                    |
| `SPACESHIP_KUBECTL_COLOR`  |              `white`               | Color of Kubernetes section                        |
| `SPACESHIP_KUBECTL_SYMBOL` |               `☸️··`               | Character to be shown before Kubernetes subsection |

#### Версія Kubernetes (`kubectl_version`)

| Змінна                             |          За замовчуванням          | Пояснення                                   |
| :--------------------------------- | :--------------------------------: | ------------------------------------------- |
| `SPACESHIP_KUBECTL_VERSION_SHOW`   |               `true`               | Show Kubernetes version subsection          |
| `SPACESHIP_KUBECTL_VERSION_PREFIX` |                 ``                 | Prefix before Kubernetes version subsection |
| `SPACESHIP_KUBECTL_VERSION_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Kubernetes version subsection  |
| `SPACESHIP_KUBECTL_VERSION_COLOR`  |               `cyan`               | Color of Kubernetes version subsection      |

### Контекст Kubernetes (`kubectl_context`)

Shows the active kubectl context, which consists of a cluster name and, when working in a non-default namespace, also a namespace name.

**💡 Tip:** If your cluster name (and thus context name) is too long, you can give it a shorter name using `kubectl config rename-context very_long_context_name name`.

| Змінна                                 |          За замовчуванням          | Пояснення                                                       |
| :------------------------------------- | :--------------------------------: | --------------------------------------------------------------- |
| `SPACESHIP_KUBECONTEXT_SHOW`           |               `true`               | Current Kubectl context section                                 |
| `SPACESHIP_KUBECONTEXT_PREFIX`         |               `at·`                | Prefix before Kubectl context section                           |
| `SPACESHIP_KUBECONTEXT_SUFFIX`         | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Kubectl context section                            |
| `SPACESHIP_KUBECONTEXT_COLOR`          |               `cyan`               | Color of Kubectl context section                                |
| `SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW` |               `true`               | Should namespace be also displayed                              |
| `SPACESHIP_KUBECONTEXT_COLOR_GROUPS`   |                 ``                 | _Array_ of pairs of colors and match patterns, empty by default |

**Color Groups:** To set the section to a different color based on context or namespace, you can define an array of pair values in which the first value of a pair is a color name to use and the second value is a regular expression pattern to match against the section text (context name and/or namespace). The first matched pattern will determine the color, so list order can be used to prioritize patterns.

For example, add the following to your `.zshrc` file:

```zsh
SPACESHIP_KUBECONTEXT_COLOR_GROUPS=(
  # red if namespace is "kube-system"
  red    '\(kube-system)$'
  # else, green if "dev-01" is anywhere in the context or namespace
  green  dev-01
  # else, red if context name ends with ".k8s.local" _and_ namespace is "system"
  red    '\.k8s\.local \(system)$'
  # else, yellow if the entire content is "test-" followed by digits, and no namespace is displayed
  yellow '^test-[0-9]+$'
)
```

### Gradle (`gradle`)

Показує поточні версії maven та jvm.

| Змінна                                 |          За замовчуванням          | Пояснення                                       |
| :------------------------------------- | :--------------------------------: | ----------------------------------------------- |
| `SPACESHIP_GRADLE_SHOW`                |               `true`               | Current Gradle section                          |
| `SPACESHIP_GRADLE_PREFIX`              | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before Gradle section                    |
| `SPACESHIP_GRADLE_SUFFIX`              | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Gradle section                     |
| `SPACESHIP_GRADLE_SYMBOL`              |                `⬡·`                | Character to be shown before Gradle section     |
| `SPACESHIP_GRADLE_DEFAULT_VERSION`     |                 ``                 | Gradle version to be treated as default         |
| `SPACESHIP_GRADLE_COLOR`               |              `green`               | Color of Gradle section                         |
| `SPACESHIP_GRADLE_JVM_SHOW`            |               `true`               | Show JVM version used by Gradle                 |
| `SPACESHIP_GRADLE_JVM_PREFIX`          | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before Gradle JVM section                |
| `SPACESHIP_GRADLE_JVM_SUFFIX`          | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Gradle JVM section                 |
| `SPACESHIP_GRADLE_JVM_SYMBOL`          |               `☕️·`               | Character to be shown before Gradle JVM section |
| `SPACESHIP_GRADLE_JVM_DEFAULT_VERSION` |                 ``                 | Gradle JVM version to be treated as default     |
| `SPACESHIP_GRADLE_JVM_COLOR`           |             `magenta`              | Color of Gradle JVM section                     |

### Maven (`maven`)

Показує поточну версію maven та jvm.

| Змінна                                |          За замовчуванням          | Пояснення                                      |
| :------------------------------------ | :--------------------------------: | ---------------------------------------------- |
| `SPACESHIP_MAVEN_SHOW`                |               `true`               | Current Maven section                          |
| `SPACESHIP_MAVEN_PREFIX`              | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before Maven section                    |
| `SPACESHIP_MAVEN_SUFFIX`              | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Maven section                     |
| `SPACESHIP_MAVEN_SYMBOL`              |                `𝑚·`                | Character to be shown before Maven section     |
| `SPACESHIP_MAVEN_DEFAULT_VERSION`     |                 ``                 | Maven version to be treated as default         |
| `SPACESHIP_MAVEN_COLOR`               |              `yellow`              | Color of Maven section                         |
| `SPACESHIP_MAVEN_JVM_SHOW`            |               `true`               | Show JVM version used by Maven                 |
| `SPACESHIP_MAVEN_JVM_PREFIX`          | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before Maven JVM section                |
| `SPACESHIP_MAVEN_JVM_SUFFIX`          | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Maven JVM section                 |
| `SPACESHIP_MAVEN_JVM_SYMBOL`          |               `☕️·`               | Character to be shown before Maven JVM section |
| `SPACESHIP_MAVEN_JVM_DEFAULT_VERSION` |                 ``                 | Maven JVM version to be treated as default     |
| `SPACESHIP_MAVEN_JVM_COLOR`           |             `magenta`              | Color of Maven JVM section                     |

### Робоча область Terraform (`terraform`)

Shows the active Terraform wokspace in directories that contain `.terraform/environment` file.

| Змінна                       |          За замовчуванням          | Пояснення                                        |
| :--------------------------- | :--------------------------------: | ------------------------------------------------ |
| `SPACESHIP_TERRAFORM_SHOW`   |               `true`               | Current Terraform workspace section              |
| `SPACESHIP_TERRAFORM_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before Terraform workspace section        |
| `SPACESHIP_TERRAFORM_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Terraform workspace section         |
| `SPACESHIP_TERRAFORM_SYMBOL` |               `🛠️·`                | Character to be shown before Terraform workspace |
| `SPACESHIP_TERRAFORM_COLOR`  |               `105`                | Color of Terraform workspace section             |

### Час виконання (`exec_time`)

Час виконання останньої команди. Відображуватиметься якщо він перевищить встановлений поріг часу.

| Змінна                        |          За замовчуванням          | Пояснення                                                        |
| :---------------------------- | :--------------------------------: | ---------------------------------------------------------------- |
| `SPACESHIP_EXEC_TIME_SHOW`    |               `true`               | Show execution time                                              |
| `SPACESHIP_EXEC_TIME_PREFIX`  |              `took·`               | Prefix before execution time section                             |
| `SPACESHIP_EXEC_TIME_SUFFIX`  | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after execution time section                              |
| `SPACESHIP_EXEC_TIME_COLOR`   |              `yellow`              | Color of execution time section                                  |
| `SPACESHIP_EXEC_TIME_ELAPSED` |                `2`                 | The minimum number of seconds for showing execution time section |

### Батарея (`battery`)

By default, Battery section is shown only if battery level is below `SPACESHIP_BATTERY_THRESHOLD` (default: 10%).

| Змінна                                 |          За замовчуванням          | Пояснення                                                            |
| :------------------------------------- | :--------------------------------: | -------------------------------------------------------------------- |
| `SPACESHIP_BATTERY_SHOW`               |               `true`               | Show battery section or not (`true`, `false`, `always` or `charged`) |
| `SPACESHIP_BATTERY_PREFIX`             |                 ``                 | Prefix before battery section                                        |
| `SPACESHIP_BATTERY_SUFFIX`             | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after battery section                                         |
| `SPACESHIP_BATTERY_SYMBOL_CHARGING`    |                `⇡`                 | Character to be shown if battery is charging                         |
| `SPACESHIP_BATTERY_SYMBOL_DISCHARGING` |                `⇣`                 | Character to be shown if battery is discharging                      |
| `SPACESHIP_BATTERY_SYMBOL_FULL`        |                `•`                 | Character to be shown if battery is full                             |
| `SPACESHIP_BATTERY_THRESHOLD`          |                 10                 | Battery level below which battery section will be shown              |

`SPACESHIP_BATTERY_SHOW` defines when to show battery section. Ось можливі значення:

| `SPACESHIP_BATTERY_SHOW` | Нижче порогу | Вище порогу | Повністю заряджена |
| :----------------------: | :----------- | :---------- | :----------------- |
|         `false`          | Приховано    | Приховано   | Приховано          |
|         `always`         | Показано     | Показано    | Показано           |
|          `true`          | Показано     | Приховано   | Приховано          |
|        `charged`         | Показано     | Приховано   | Показано           |

### Vi-mode (`vi_mode`)

This section shows mode indicator only when Vi-mode is enabled.

| Змінна                     |          За замовчуванням          | Пояснення                            |
| :------------------------- | :--------------------------------: | ------------------------------------ |
| `SPACESHIP_VI_MODE_SHOW`   |               `true`               | Shown current Vi-mode or not         |
| `SPACESHIP_VI_MODE_PREFIX` |                 ``                 | Prefix before Vi-mode section        |
| `SPACESHIP_VI_MODE_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after Vi-mode section         |
| `SPACESHIP_VI_MODE_INSERT` |               `[I]`                | Text to be shown when in insert mode |
| `SPACESHIP_VI_MODE_NORMAL` |               `[N]`                | Text to be shown when in normal mode |
| `SPACESHIP_VI_MODE_COLOR`  |              `white`               | Color of Vi-mode section             |

You can temporarily enable or disable vi-mode with handy functions (just execute them in terminal as any other regular command):

| Функція                     | Пояснення                                    |
| :-------------------------- | -------------------------------------------- |
| `spaceship_vi_mode_enable`  | Enable vi-mode for current terminal session  |
| `spaceship_vi_mode_disable` | Disable vi-mode for current terminal session |

**Note:** If the prompt does not refresh when changing modes add `eval spaceship_vi_mode_enable` to your `.zshrc`. Beware that `spaceship_vi_mode_enable` will override the`zle-keymap-select` widget, so if you have a custom one just make sure it contains the line `zle reset-prompt ; zle -R`.

**Note:** For oh-my-zsh users with vi-mode plugin enabled: Add `export RPS1="%{$reset_color%}"` before `source $ZSH/oh-my-zsh.sh` in `.zshrc` to disable default `<<<` NORMAL mode indicator in right prompt.

### Завдання (`jobs`)

Цей розділ показується лише тоді, коли є активні завдання у фоновому режимі.

| Змінна                            | За замовчуванням | Пояснення                                                                 |
| :-------------------------------- | :--------------: | ------------------------------------------------------------------------- |
| `SPACESHIP_JOBS_SHOW`             |      `true`      | Show background jobs indicator                                            |
| `SPACESHIP_JOBS_PREFIX`           |        ``        | Prefix before the jobs indicator                                          |
| `SPACESHIP_JOBS_SUFFIX`           |        ``        | Suffix after the jobs indicator                                           |
| `SPACESHIP_JOBS_SYMBOL`           |       `✦`        | Character to be shown when jobs are hiding                                |
| `SPACESHIP_JOBS_COLOR`            |      `blue`      | Color of background jobs section                                          |
| `SPACESHIP_JOBS_AMOUNT_PREFIX`    |        ``        | Prefix before the number of jobs (between jobs indicator and jobs amount) |
| `SPACESHIP_JOBS_AMOUNT_SUFFIX`    |        ``        | Suffix after the number of jobs                                           |
| `SPACESHIP_JOBS_AMOUNT_THRESHOLD` |       `1`        | Number of jobs after which job count will be shown                        |

### Код виходу (`exit_code`)

За замовчуванням вимкнено. Set `SPACESHIP_EXIT_CODE_SHOW` to `true` in your `.zshrc`, if you need to show exit code of last command.

| Змінна                       | За замовчуванням | Пояснення                              |
| :--------------------------- | :--------------: | -------------------------------------- |
| `SPACESHIP_EXIT_CODE_SHOW`   |     `false`      | Show exit code of last command         |
| `SPACESHIP_EXIT_CODE_PREFIX` |        ``        | Prefix before exit code section        |
| `SPACESHIP_EXIT_CODE_SUFFIX` |        ``        | Suffix after exit code section         |
| `SPACESHIP_EXIT_CODE_SYMBOL` |       `✘`        | Character to be shown before exit code |
| `SPACESHIP_EXIT_CODE_COLOR`  |      `red`       | Колір секції коду виходу               |

## Командний рядок

Якщо цих опцій недостатньо для того, щоб зробити те, що ви хочете, ознайомтеся з API на [сторінці API](./api.md) цієї документації.
