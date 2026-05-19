# 飞书 CLI 准备

## 何时读取

只要任务要真正落到飞书多维表格 / Base，开始建表、建字段、写记录、建视图、建看板或建工作流之前，必须先读这份 reference。

这一步是广厦 BaseOS 落到飞书 Base 的硬前置条件。没有可用的飞书 CLI，就只能输出方案、模板或本地验算结果，不能承诺已经搭建到飞书，也不能把本地 Excel 当成默认交付物。

本地 Excel / 表格只用于复杂口径校验、历史数据清洗预演、导入字段顺序调整和样例数据核对。它发挥不出飞书多维表格的权限、视图、关联、lookup、看板、工作流和 Agent 共用入口能力，不能替代最终的飞书 Base。

## 官方来源

- 官方安装说明：`https://open.feishu.cn/document/no_class/mcp-archive/feishu-cli-installation-guide.md`
- 官方仓库：`https://github.com/larksuite/cli`
- 中文官网：`https://feishu-cli.com/zh/`

飞书 CLI / Lark CLI 是同一个工具，命令行二进制名是 `lark-cli`，npm 包名是 `@larksuite/cli`。

## 安装

先检查 Node.js 和 npm：

```bash
node --version
npm --version
```

全局安装 CLI：

```bash
npm install -g @larksuite/cli
```

安装 AI Agent skills：

```bash
npx skills add larksuite/cli -y -g
```

安装后检查：

```bash
lark-cli --version
lark-cli doctor
```

如果 CLI skills 刚安装或更新，提醒用户重启当前 Agent / Codex 应用后再使用新加载的 skills。

## 初始化配置

首次使用需要配置应用：

```bash
lark-cli config init --new
```

这是交互式流程。作为 Agent 执行时，后台启动命令，读取 CLI 返回的授权链接，原样发给用户打开完成配置。不要改写、拼接或重新编码链接。

如果用户已有飞书开放平台应用，也可以在配置流程里选择已有应用。

## 用户授权

搭建多维表格通常需要用户身份访问用户自己的云文档和 Base。优先按任务需要授权，不要无端申请无关权限。

多维表格搭建常用方式：

```bash
lark-cli auth login --domain base
```

如果还需要搜索云文档、导入文件或上传附件，按需补充：

```bash
lark-cli auth login --domain drive
lark-cli auth login --domain docs
```

也可以使用官方推荐范围：

```bash
lark-cli auth login --recommend
```

授权命令同样可能返回需要用户打开的链接。链接必须原样转发。

## 验证

搭建前必须验证：

```bash
lark-cli doctor
lark-cli auth status
```

通过标准：

- CLI 版本检查通过。
- 配置文件存在。
- app 能解析到飞书环境。
- token 存在且有效。
- `https://open.feishu.cn` 可访问。
- 目标身份符合任务：操作用户个人 Base 时通常用 `--as user`。

## Base 可用性检查

真正改 Base 之前，继续确认：

1. 用户提供的是目标 Base 链接、Wiki 链接，还是只给了名称关键词。
2. 如果只有名称，先用文档搜索定位 `BITABLE` 资源。
3. 读取目标 Base 信息、表列表和字段列表。
4. 确认当前身份对目标 Base 有建表、建字段、写记录、建视图、建看板和建工作流的权限。
5. 迁移或重构时默认不动旧 Base，先复制或新建版本。

涉及具体 Base 操作时，必须切到 `lark-base` skill，并按它的 reference 逐条执行。不要直接猜 API、字段 ID、表 ID 或公式语法。

## 权限不足处理

如果 CLI 返回权限不足：

- 看清当前身份是 user 还是 bot。
- user 身份缺 scope：按错误提示使用 `auth login --scope` 或 `auth login --domain` 增量授权。
- bot 身份缺权限：把 CLI 返回的飞书开发者后台链接原样给用户，让用户开通权限。
- 不要把权限错误当成字段错误或数据模型错误。

## 输出给用户

CLI 准备完成后，简短说明：

1. CLI 是否已安装。
2. 是否已登录并授权。
3. 当前能否访问飞书开放平台。
4. 下一步需要用户提供哪个 Base 链接，或是否新建 Base。
