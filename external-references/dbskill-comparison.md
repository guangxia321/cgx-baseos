# DBS Skill 对比笔记

## 为什么保留这个参考

DBS skill 的参考价值在于它是一个多 skill 工具箱：一个主入口负责识别用户意图，然后路由到不同的专业 skill。

广厦 BaseOS 未来也可能演进成类似的形态：一个主入口判断用户是在新建系统、重构系统、维修系统、搭一人公司经营底座，还是搭企业服务经营底座；等某些场景成熟后，再拆成独立子技能。

## 当前已本地安装的内容

参考仓库位置：

```text
external-references/dbskill/
```

核心结构：

```text
external-references/dbskill/
├── README.md
├── VERSION
├── LICENSE
├── skills/
├── tools/
├── scripts/
├── .claude-plugin/
└── 知识库/
```

技能源码位置：

```text
external-references/dbskill/skills/
```

打包产物位置：

```text
external-references/dbskill/dist/skills/
```

当前已经执行过：

```bash
git clone https://github.com/dontbesilent2025/dbskill external-references/dbskill
bash external-references/dbskill/tools/build-skills.sh
```

## 可借鉴的结构

### 1. 主入口路由

DBS 的主入口只做一件事：判断用户意图，然后路由到对应 skill。

广厦 BaseOS 可以借鉴这个原则，但路由对象应换成自己的经营数字化场景：

| 广厦 BaseOS 场景 | 未来可能的处理方向 |
| --- | --- |
| 从 0 搭系统 | build |
| 旧系统重构 | rebuild |
| 看板 / 字段 / 公式出错 | repair |
| 一人公司经营底座 | solo-business |
| 企业服务经营底座 | service-business |
| 只要模板 | templates |
| AI 接入前数据盘点 | ai-readiness |

### 2. 多 skill 目录

DBS 把每个能力做成独立目录，每个目录都有自己的 `SKILL.md`。

广厦 BaseOS 早期不必马上拆这么细，但可以先在 `templates/`、`references/`、`tests/` 里按模块沉淀，等流程稳定后再拆。

### 3. 构建与分发

DBS 有构建脚本，把多个 skill 打包成 zip，并按使用场景分组。

广厦 BaseOS 后续如果拆成多 skill，也需要类似能力：

- 单技能安装包。
- 多技能整包。
- 模板文件包。
- 示例案例包。
- 版本号和发布说明。

## 不应照搬的部分

DBS 是商业诊断工具箱，广厦 BaseOS 是经营系统搭建和 AI 基座项目。

两者底层任务不同，所以不要照搬：

- 诊断话术。
- 商业问题分类。
- 内容创作工具链。
- 状态管理三件套。
- 知识库内容组织。

广厦 BaseOS 的核心应围绕：

- 业务形态识别。
- 高频动作采集。
- 主数据 / 事实数据盘点。
- 录入入口设计。
- 系统判型。
- 飞书 Base 实施。
- 维修和重构。
