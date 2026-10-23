# fluttercandies/homebrew-tap

简体中文 | **[English](README.md)**

[FlutterCandies](https://github.com/fluttercandies) 组织级 Homebrew Tap，为组织内对外发布的 CLI 工具与开发者工具提供统一的 Homebrew 分发入口。

**当前状态**：本仓库只包含基础设施（结构、基础检查、接入文档），尚未收录任何 Formula。第一个软件接入后，安装命令才会真正可用。

## 用途与维护范围

- 托管 FlutterCandies 组织内**对外发布**的命令行工具、开发者工具的 Homebrew Formula。
- 本仓库只做**分发入口**：Formula 仅描述如何下载、校验、安装已发布的产物，不承载任何源码构建逻辑。
- 每个软件一个独立的 `Formula/<name>.rb`，软件之间互不依赖（除非存在真实依赖）。
- 不收录：仅供内部使用的工具、闭源/私有软件（Homebrew 面向公网分发）、与组织无关的第三方软件。

## 安装

```bash
# 方式一：直接安装（推荐，Homebrew 会自动信任该单个 Formula）
brew install fluttercandies/tap/<formula-name>

# 方式二：先添加 Tap，再安装
brew tap fluttercandies/tap
brew install <formula-name>
```

> **Homebrew 7+ 的信任机制**：非官方 Tap 中的 Formula 默认不被信任。方式一会自动信任被安装的单个 Formula；方式二在安装前需要显式信任：
>
> ```bash
> brew trust --formula fluttercandies/tap/<formula-name>   # 信任单个 Formula
> # 或
> brew trust --tap fluttercandies/tap                      # 信任整个 Tap
> ```

## 仓库结构

```text
homebrew-tap/
├── Formula/                  # 所有软件的 Formula（当前为空）
├── .github/
│   ├── workflows/
│   │   └── ci.yml            # 基础检查：tap 语法与命名规范
│   └── dependabot.yml        # 保持 CI 使用的 GitHub Actions 更新
└── README.md                 # 本文档：规范与接入流程
```

## Formula 规范

新增或更新 Formula 时必须遵守：

- **位置与命名**：一软件一文件，位于 `Formula/<name>.rb`。名称用小写字母、数字和连字符（`-`），与 CLI 实际命令名一致；Ruby 类名按 Homebrew 规则转换（`foo-bar` → `class FooBar < Formula`）。
- **版本**：`version` 与软件的 GitHub Release tag 对应（惯例为 `v` 前缀 + 语义化版本，Homebrew 通常可从 URL 自动推导）。每次发版只更新 `url`、`version`、`sha256`（以及真实变化的依赖），不做无关改动。
- **下载地址（url）**：必须指向公开、可直接下载、内容不可变的产物地址（首选该软件仓库的 GitHub Release 资产），必须使用 HTTPS。
- **多平台**：macOS 需同时覆盖 Apple Silicon（`aarch64`）与 Intel（`x86_64`），按需增加 Linux。不同平台的资产用 `on_macos`/`on_arm`/`on_intel`/`on_linux` 块分别指定各自的 `url` 与 `sha256`。
- **SHA256**：必填。值为**最终用户所下载平台资产**的 SHA256，不是某个"主资产"的值。缺失或不匹配的 SHA256 一律不予合入。
- **质量门槛**：合入前 `brew audit --strict` 与 `brew style` 必须通过（见下节），CI 的 tap 语法检查必须为绿。
- **禁止事项**：不得提交任何凭证、token；不得引入下载后执行任意远程脚本的安装逻辑；在组织决定启用 bottle 之前，不添加 `bottle` 块（见[待决定事项](#接入时再决定的事项)）。

## 验证

### 维护者本地验证清单（每次新增/更新 Formula）

```bash
# 1. 审计与风格
brew audit --strict --formula fluttercandies/tap/<name>
brew style --formula fluttercandies/tap/<name>

# 2. 从发布产物安装（--build-from-source 可绕过缓存暴露真实安装路径）
brew install --build-from-source fluttercandies/tap/<name>

# 3. 基本功能冒烟（至少能跑 --version / --help，或执行一次核心命令）

# 4. 升级 / 重装 / 卸载（更新版本时验证 upgrade；至少验证一次卸载后可重新安装）
brew upgrade <name>
brew reinstall <name>
brew uninstall <name>
```

若 Formula 定义了 `test do ... end` 块，另跑 `brew test <name>`。

### CI 验证（本仓库自动执行）

每次 push 到 `main` 和所有 Pull Request 都会运行 [`brew test-bot --only-tap-syntax`](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)，校验 Tap 内所有 Ruby 文件的语法、文件与类命名规范。该检查不依赖任何具体软件，空 Tap 也能独立运行。

## 新软件接入流程

一个软件项目接入本 Tap 的标准流程：

1. **准备 Release**：在软件仓库打版本 tag（建议 `v` + 语义化版本），创建 GitHub Release（正式版，非 prerelease，除非刻意灰度发布），将构建产物作为 Release 资产上传。
2. **提供平台资产**：至少覆盖 macOS Apple Silicon 与 Intel，按需覆盖 Linux。资产命名包含软件名、版本、操作系统、CPU 架构（如 `<name>-<version>-<os>-<arch>.<ext>`），一经确定在该软件后续所有 Release 中保持稳定。**具体命名与打包格式（zip / tar.gz 等）在接入该项目时确定**，本 Tap 不预设统一方案。
3. **生成并校验 SHA256**：在构建流水线内对每个资产计算并输出 SHA256（`shasum -a 256 <asset>` 或 `sha256sum <asset>`），随 Release 一同公布（可写入 Release notes），供 Formula 与人工核对。发布后可用 `brew fetch --formula fluttercandies/tap/<name>` 复核。
4. **创建 / 审核 Formula**：新建或更新 `Formula/<name>.rb`。首次接入走 PR 评审（至少一名其他维护者确认名称、依赖、安装逻辑）；后续版本更新在 PR 中注明软件与版本号，只需复核 `url` / `version` / `sha256` 与上游 Release 一致。
5. **验证安装**：按上节"本地验证清单"执行（audit / style / install / 冒烟 / upgrade / reinstall / uninstall）。
6. **更新到本仓库**：向 `fluttercandies/homebrew-tap` 的 `main` 分支提 Pull Request。任何 GitHub 账号都可以对公开仓库发 PR，**手动接入阶段无需任何额外权限或 token**；CI 通过并经 review 后合入，用户即可 `brew install fluttercandies/tap/<name>`。

## 自动发布与跨仓库更新（设计方案，当前未实现）

当前采用**阶段 0（手动 PR）**。随接入软件增多，可按需演进，演进前不需要预先配置任何东西：

- **阶段 1 —— 软件仓库自动开 PR**：软件仓库的 release 工作流在新版本发布后，自动更新本 Tap 中对应 Formula 并开 PR（仍由人审核后合入）。所需凭证见[权限与凭证安全](#权限与凭证安全)。也可以改为 `repository_dispatch` 触发本仓库的工作流来执行更新，但两者所需权限相同，且后者增加本仓库的维护面，不作为首选。
- **阶段 2 —— 本仓库自动跟进（官方模板自带，可随时启用）**：Homebrew 官方 `brew tap-new` 模板自带两个可选工作流，届时直接参照生成即可：
  - `brew bump` 每日自动检查上游新版本并开 PR（只需本仓库默认 `GITHUB_TOKEN`）；
  - bottle（预编译二进制）构建与发布流水线（`--only-formulae` + `brew pr-pull` + GitHub Packages/GHCR），可显著加快用户安装，但引入 bottle root-url、GHCR 凭证等约定，**是否启用属于待决定事项**。

## 权限与凭证安全

- **本仓库 CI**：`GITHUB_TOKEN` 仅需只读（`contents: read`），当前没有配置任何自定义 Secrets，也不应为本仓库配置无关 Secrets。
- **跨仓库更新（未来）**：阶段 1 的自动化需要一个对本仓库有写权限的凭证，二选一：
  - **Fine-grained PAT**（推荐起步）：仅授予 `fluttercandies/homebrew-tap` 单个仓库的 **Contents: Read & write** 权限，不授予其他任何仓库与权限；存储在**软件仓库**的 Actions Secrets 中（如 `HOMEBREW_TAP_TOKEN`），绝不提交进代码、绝不打印到日志。
  - **组织级 GitHub App**（规模化后）：安装到相关软件仓库，并对本仓库授予 Contents: Read & write；以 App 私钥换取短期 installation token 使用，避免长期 PAT。
- **通用要求**：最小权限（只写本仓库、不做 admin）、定期轮换、离职或移交时立即吊销；凭证命名与用途在对应软件仓库 README 中登记。
- **不得**为绕过自动化便利而申请放宽组织安全策略、分支保护或评审规则；确有需要时走组织管理员评审。

## 接入时再决定的事项

以下选型依赖具体软件的语言与构建方式，或依赖实际规模，**接入时再定，本文档不预设**：

- 各软件 Release 资产的命名与打包格式（zip / tar.gz / 单二进制），以及是否覆盖 Linux。
- 是否启用 bottle（涉及 GHCR 发布、root-url 约定、`publish` 工作流与对应 Secrets）。
- 自动更新 Formula 的自动化程度（手动 PR / release 触发开 PR / `brew bump` 每日检查）。
- 跨仓库凭证形态（fine-grained PAT vs GitHub App）。
- Formula 是否需要 `livecheck` 块（对有稳定 release feed 的软件推荐）。
- 本仓库的分支保护与 required checks 设置、License 选择（组织管理员决策）。

## 相关链接

- 组织主页：<https://github.com/fluttercandies>
- Homebrew Tap 维护文档：<https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap>
- Formula 规范：<https://docs.brew.sh/Formula-Cookbook>
