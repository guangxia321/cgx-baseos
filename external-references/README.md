# External References

这个目录用于存放广厦 BaseOS 开发过程中的外部参考项目。

外部参考只用于学习项目结构、安装方式、打包方式、路由设计和开源组织方式，不进入广厦 BaseOS 的运行时技能上下文。

## 当前参考项目

| 项目 | 本地位置 | 用途 |
| --- | --- | --- |
| DBS skill | `external-references/dbskill/` | 参考主入口路由、多 skill 组织、安装说明、构建脚本和开源发布结构 |

`external-references/dbskill/` 是完整克隆的第三方仓库，已经写入根目录 `.gitignore`，后续不会被提交到广厦 BaseOS 自己的 Git 仓库。

## 更新方式

进入参考仓库后拉取最新版本：

```bash
cd external-references/dbskill
git pull
```

重新生成它的技能打包产物：

```bash
bash tools/build-skills.sh
```

构建结果会在：

```text
external-references/dbskill/dist/skills/
```

## 对比边界

可以参考：

- 主入口如何路由到不同专业技能。
- 多 skill 项目如何组织目录。
- README 如何解释安装、更新和使用路径。
- 构建脚本如何把多个 skill 打包成可分发产物。
- 开源发布前需要哪些说明文件和版本信息。

不要复制：

- 外部项目的方法论文本。
- 外部项目的品牌表达。
- 外部项目的 skill 名称、路由词和具体业务诊断内容。
- 不适合广厦 BaseOS 的状态管理、内容工具或诊断工具结构。
