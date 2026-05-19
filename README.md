# 广厦 BaseOS（CGX BaseOS）

面向实体门店、经销流通、电商、知识付费、企业服务和中小企业团队的 AI 经营数仓搭建 Skill。

它帮你用飞书多维表格或类似低代码数据工具，先搭出一套最小经营系统：客户、线索、订单、项目、收款、费用、交付、看板和 AI Agent 可调用的数据入口。

可在 Codex、Claude Code、Cursor、Trae Solo 等支持 Skill / system prompt 的 Agent 上使用。

**最新版本：v1.0.0**

**作者背景**：笔者既做实体门店和经销业务，也做企业服务。在服务不同行业客户时，我发现很多企业并不是不会用 AI，而是还没有完成最基础的数据化和数字化。关键数据散落在微信、Excel、旧 SaaS、员工个人表格和口头同步里，AI Agent 很难稳定读取、写入和维护业务数据。

**核心判断**：很多企业第一阶段并不需要重型 ERP 或复杂 SaaS。一个设计得足够好的飞书多维表格，就能覆盖大量经营管理场景。再通过飞书 CLI 和 AI Agent 连接，就可以继续做日报、经营分析、客户提醒、销售复盘、交付跟踪、爆款预测和自动化录入。

---

## 如何安装

#### 通用安装方式（适用于 Codex / Claude Code）

```bash
npx -y skills add guangxia321/cgx-baseos -g --all
```

#### Trae Solo / 手动安装

从 [GitHub Releases](https://github.com/guangxia321/cgx-baseos/releases) 下载最新的 `cgx-baseos-版本号.zip`。总包里包含 4 个独立的 skill zip：

1. `cgx-baseos.zip`
2. `cgx-baseos-diagnose.zip`
3. `cgx-baseos-build.zip`
4. `cgx-baseos-repair.zip`

如果工具要求一个 zip 对应一个 skill，就解压总包后逐个上传 `individual/` 里的四个 zip。

如果想本地构建，运行：

```bash
bash tools/build-skills.sh
```

构建产物在 `dist/skills/`。

## 如何更新

通过 `npx skills add` 安装的用户，重新运行一次同样的命令即可：

```bash
npx -y skills add guangxia321/cgx-baseos -g --all
```

手动安装的用户，从 [GitHub Releases](https://github.com/guangxia321/cgx-baseos/releases) 下载最新版，替换旧版本 skill。

---

## 工具箱

| Skill | 做什么 |
|---|---|
| `/cgx-baseos` | 主入口。根据用户问题判断进入诊断、构建还是维修 |
| `/cgx-baseos-diagnose` | 业务数据诊断。识别关键数据、重复动作、AI 可用数据和自动化机会，输出一页业务数据地图 |
| `/cgx-baseos-build` | 经营系统构建。基于业务数据地图，按四阶段搭建或重构飞书 Base |
| `/cgx-baseos-repair` | 维修排障。修复已有 Base、字段、公式、lookup、看板、筛选器和工作流问题 |

## 工具路径图

#### 从 0 开始做企业 AI 化

```text
diagnose（先判断哪些经营数据值得沉淀）
    ↓
business data map（一页业务数据地图）
    ↓
build（搭建最小经营系统）
    ↓
Feishu Base / low-code data system
    ↓
AI Agent（日报、经营分析、提醒、预测、自动化录入）
```

#### 已经有旧表或旧系统

```text
旧 Excel / 旧飞书 Base / 旧 SaaS 导出数据
    ↓
diagnose（判断哪些结构值得保留）
    ↓
build（重构为 AI 能读写的数据底座）
```

#### 已经搭好，但系统出错

```text
字段、公式、lookup、看板、筛选器、工作流异常
    ↓
repair（先定位最小对象）
    ↓
最小修复 + 样例数据验证
```

---

## 适合什么场景

### 一人公司 / 知识付费 / 咨询服务

- 产品、内容、渠道、线索、客户、订单、交付、收款没有系统管理。
- 想让 AI 帮忙做客户查询、交付提醒、月度复盘和渠道转化分析。

### 实体门店 / 经销流通 / 销售型小企业

- 客户、商品、订单、库存、收款、费用、利润靠 Excel 和人工统计。
- 想快速看到销售额、利润、未收款、客户排行、商品表现和经营看板。

### 企业服务团队

- 线索、商机、报价、合同、项目交付、续费和回款分散在不同人员手里。
- 想建立一套销售、交付、财务、客户成功都能共用的数据底座。

### AI 企业服务 / 数字化服务商

- 想帮客户 AI 化，但客户没有开放、稳定、可被 Agent 调用的数据系统。
- 可以先用飞书多维表格搭一个最小经营系统，再把 AI Agent 接上去。

---

## 这个项目的边界

广厦 BaseOS 不是完整 ERP，不替代专业财务软件、报税系统、进销存系统或复杂权限审批系统。

它优先解决第一阶段最关键的问题：

- 企业有哪些关键经营数据。
- 哪些数据应该被结构化沉淀。
- 哪些流程最重复、最适合自动化。
- 哪些指标应该先进入看板。
- 人和 AI Agent 应该共用哪些录入、查询和分析入口。

第一版系统应该尽量小，但要足够稳定。先让数据跑起来，再逐步扩展。

## v1.0.0 包含什么

- 主入口 + 诊断 + 构建 + 维修的公开技能结构。
- 业务数据诊断和一页业务数据地图格式。
- 基础数据层、录入联动层、展示看板层、验收发布层四阶段构建流程。
- 销售系统、一人公司、企业服务、经营财务四类模板骨架。
- 看板、字段、公式、lookup、筛选器和工作流维修规则。
- 路由、诊断产物和四阶段构建的第一版测试用例。
- 构建脚本，可生成四个公开 skill zip 和统一整包。

## 仓库结构

```text
.
├── SKILL.md             # 主入口路由
├── skills/              # 4 个公开 skill
├── references/          # 运行时参考资料
├── templates/           # 阶段化业务模板
├── tools/               # 打包与本地安装脚本
├── tests/               # 技能评测和回归测试材料
└── docs/                # 架构、路线图和开发背景
```

## 许可证

本项目采用 CC BY-NC 4.0 许可证。个人学习、研究和非商业项目可以使用；公开发布衍生作品请注明来源；商业用途需要单独授权。
