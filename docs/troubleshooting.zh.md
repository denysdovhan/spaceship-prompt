---
hide:
  - navigation
---

# 疑难解答

此页面旨在帮助您修复在使用Spaceship提示符遇到的常见问题。

## `git` 分支的奇怪符号是什么?

您需要有一个powerline的补丁字体才能正确显示 `git` 分支符号。

- 安装任何powerline兼容的字体，例如 [Fira Code](https://github.com/tonsky/FiraCode) 或 [其他](https://github.com/powerline/fonts)。
- 配置您的终端仿真器 [使用那个字体](https://powerline.readthedocs.io/en/master/troubleshooting/osx.html)。

## 模块前面奇怪的字符是什么？

这并不是Spaceship提示符的问题。 Spaceship在模块中使用 Unicode 符号来代表 `SPACESHIP_*_SYMBOL`。 要解决此问题：

- 使用此命令验证您的终端模拟器支持 Unicode 字符：
  ```zsh
  curl - L https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt
  # 或
  wget -O - https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt
  ```
- 配置您的终端模拟器使用UTF-8作为字符编码。

如果不支持 Unicode 符号，您可以用 `SPACESHIP_*_SYMBOL` 选项替换它们与您终端兼容。 查看 [选项](./options.zh.md) 页面以获取更多信息。

## 提示符之前的 `[I]` 是什么？

那是 [`vi_mode`](https://spaceship-prompt.sh/options/#vi-mode-vi_mode) 模块表示 `插入` 模式。 您可以在您的配置中用以下行禁用此功能：

```
SPACESHIP_VI_MODE_SHOW=false
```

## 为什么我的提示符很慢？

由于状态检查是相当繁重的操作，空间飞船在大仓库中Spaceship可能较慢。 在这种情况下，试图避免有许多未提交的文件。

使用 `grep` 获取软件包版本没有返回准确信息。 所以我们现在使用 `jq` ，并且用 `python` 和 `node`作为备选。这可能会稍微影响性能。 在这种情况下安装 [jq](https://stedolan.github.io/jq/) (详情请 [#439][], [#441][])。

由于未使用的模块加载，提示符也可能变慢。 Spaceship只装载 `SPACESHIP_PROPT_ORDER` 或 `SPACESHIP_RPROPT_ORDER` 中提到的模块。 如果你认为某些模块对你来说可能毫无用处，试图通过在排序选项中省略它们的名字来禁用它们。

在下面的示例中， `time`, `package`, `xcode`, `julia`, `docker`, ` ember ` 和 `vi_mode` 模块被禁用，根本不会被加载。

```zsh
#  如果你想禁用仅仅需要将模块注释
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

禁用大量未使用的部分可能会实现显著的性能提升。 下面是用上面示例的 `SPACESHIP_PROPT_ORDER` 和所有模块全部开启运行100次的渲染Spaceship的比较：

|             |  所有模块   |  有禁用模块  |
|:----------- |:-------:|:-------:|
| 在Git仓库内\* | `23.5秒` | `21.3秒` |
| 在Git仓库外\* | `8.3秒`  | `7.4秒`  |

\* - `spaceship-prompt ` 项目用于此测试。

## 某些模块图标相互重叠？

![](https://user-images.githubusercontent.com/3459374/34945188-1f6398be-fa0b-11e7-9845-a744bc3e148d.png)

此问题与您的终端模拟器如何渲染Unicode 9字符有关。 要解决此问题：

- 确保终端使用 _Unicode 版本 9 宽度_。
- 让您的终端以双宽度渲染不明确的字符。

在 _iTerm_ 中，遵循这些指令：

- 转至 _iTerm → Preferences… (⌘,) → Profiles → Text_
- 检查 _Unicode 版本 9 宽度_。
- 检查 _宽度模糊字符是否为双宽度_。
- 重新装入终端标签页。

## 为什么我的提示符看起来不像预览？

![预览](https://user-images.githubusercontent.com/10276208/36086434-5de52ace-0ff2-11e8-8299-c67f9ab4e9bd.gif)

预览显示 `Spaceship` 提示符设置为：

- [ Hyper ](https://hyper.is)作为终端仿真器。
- [One Dark](https://www.npmjs.com/package/hyperterm-atom-dark) 来自 [Atom](https://atom.io/) 编辑器的一个颜色主题。
- [Fira Code](https://github.com/tonsky/FiraCode), 与ligatures 作为主字体 (16px size).
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) 让命令颜色化。
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) 类似浏览器的自动补全。

查看 [屏幕截图](https://github.com/spaceship-prompt/spaceship-prompt/wiki/Screenshots) 维基以了解更多的配色方案示例。

## 难道没有帮助吗？

请 [提出 issue](https://github.com/spaceship-prompt/spaceship-prompt/issues/new)，描述你的问题，我们将乐意帮助你。

[#439]: https://github.com/spaceship-prompt/spaceship-prompt/issues/439
[#441]: https://github.com/spaceship-prompt/spaceship-prompt/pull/441
