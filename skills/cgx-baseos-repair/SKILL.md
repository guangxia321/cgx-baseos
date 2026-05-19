---
name: cgx-baseos-repair
description: |
  广厦 BaseOS 维修排障技能。用于修复已有飞书 Base、多维表格、字段、公式、lookup、视图、看板、筛选器、工作流和数据导入问题。适用于图表不显示、配置数据发生变更、筛选不动、公式算错、字段写不进去、工作流没触发等场景。
---

# 广厦 BaseOS Repair

用于维修已有系统。维修路径独立于搭建路径：先局部定位，不默认重建整套系统。

## 必读顺序

1. `references/repair-playbook.md`：最小排障路径。
2. 如果是看板、筛选、排序、组件空白或配置变更：读 `references/dashboard-troubleshooting.md`。
3. 如果是月份筛选、跨表筛选或筛选器不联动：读 `references/dashboard-filter-slicer-case.md`。
4. 如果根因指向状态字段、金额判断、lookup/公式筛选：读 `references/field-modeling-antipatterns.md`。
5. 如果需要回到模型层修正：读 `references/system-design-rules.md`。

## 执行规则

- 先确认出问题的最小对象：表、字段、视图、看板组件、工作流或记录。
- 先只读读取现状，再复现问题，不要凭记忆修改线上结构。
- 一次只改一个变量，修复后用样例记录和页面重载验证。
- 字段同名不代表同源；能聚合不代表能筛选。
- 优先保留公式指标，用显式状态字段或稳定单选字段做筛选。
- 只有局部排障解释不了问题时，才扩大到整套系统。
- 维修不是诊断，也不是重构；只有根因指向底层数据模型错误时，才建议回到 `$cgx-baseos-diagnose` 或 `$cgx-baseos-build`。

## 输出

维修完成后输出：根因、改动对象、验证样例、残余模型风险、是否清理临时字段/组件/视图。如果只定位未修改，也要说明证据指向和下一步需要什么。
