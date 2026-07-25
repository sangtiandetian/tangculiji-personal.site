# 个人网站项目交接记录

更新时间：2026-07-26  
当前状态：5.0 版本开发中，首页轮播和后台内容管理已接入

## 1. 项目目标

这是“糖醋里脊勇闯互联网”的个人网站，用于展示精选互联网发现、个人介绍和联系方式，并通过后台维护首页精选内容与独立轮播内容。

## 2. 技术和托管方式

- 网站类型：静态 HTML、CSS 和原生 JavaScript
- 内容管理：Decap CMS
- 后台入口：`admin/index.html`
- 内容提交：Netlify Git Gateway
- 身份验证：Netlify Identity
- 联系表单：Netlify Forms
- 代码仓库：`https://github.com/sangtiandetian/tangculiji-personal.site.git`
- 主分支：`main`

## 3. 当前已完成功能

- 首页品牌区、导航和个人介绍
- 精选发现卡片及分类筛选
- 精选内容详情页
- 联系表单和提交成功页面
- Decap CMS 管理后台
- 后台编辑精选发现内容
- 首页独立轮播展示区
- 后台编辑轮播标题、说明、主题色、图片和跳转链接
- 轮播上一项、下一项、圆点切换和自动播放
- 本地预览脚本

## 4. 重要文件

- `index.html`：网站首页、精选内容渲染、轮播和联系表单
- `detail.html`：精选内容详情页
- `success.html`：联系表单提交成功页
- `admin/index.html`：Decap CMS 后台入口
- `admin/config.yml`：后台内容模型、Git Gateway 和媒体配置
- `admin/admin.css`：后台样式
- `content/items.json`：精选发现内容
- `content/spotlight.json`：首页独立轮播内容
- `assets/uploads/`：后台上传的图片
- `preview.bat`：Windows 本地预览快捷入口
- `preview.ps1`：本地静态文件服务器

## 5. 内容结构

### 精选发现

数据保存在 `content/items.json`，主要字段包括：

- `id`
- `category`
- `tag`
- `title`
- `summary`
- `image`
- `cover`
- `date`
- `link`
- `body`

### 首页轮播

数据保存在 `content/spotlight.json`，主要字段包括：

- `id`
- `tone`：支持 `mint`、`peach`、`blue`
- `label`
- `title`
- `summary`
- `image`
- `link`

## 6. 本地预览

在项目根目录运行：

```powershell
.\preview.bat
```

然后访问：

`http://localhost:8787/index.html`

关闭预览命令窗口即可停止本地服务器。

不要仅通过双击 `index.html` 验证内容，因为浏览器在 `file://` 模式下可能限制 JSON 加载。

## 7. 部署和后台注意事项

- Netlify 应连接 GitHub 仓库的 `main` 分支。
- Netlify Identity 和 Git Gateway 必须启用，后台才能登录和提交内容。
- `admin/config.yml` 中的媒体目录是 `assets/uploads`。
- 网站中的公开图片路径使用 `/assets/uploads`。
- 联系表单部署到 Netlify 后才会进入线上表单后台。
- 本地预览时，联系表单只显示本地提示，不会真正提交。

## 8. 当前 Git 状态

检查时，网站主要修改已经进入 Git 历史。以下文件仍是未跟踪文件：

- `preview.bat`
- `preview.ps1`

继续工作前应再次运行 `git status`，以实际结果为准。不要覆盖或删除未确认的本地修改。

## 9. 下一步验证

1. 检查首页轮播在桌面和手机宽度下的布局。
2. 检查轮播上一项、下一项、圆点和自动播放。
3. 检查后台能否读取并保存 `content/spotlight.json`。
4. 检查后台上传图片后，线上图片路径是否正确。
5. 检查没有图片或链接的轮播项是否正常显示。
6. 检查精选内容筛选和详情页跳转。
7. 在线验证 Netlify Identity、Git Gateway 和联系表单。
8. 决定是否将本地预览脚本提交到 Git。

## 10. 安全事项

- 不要在项目文件中写入 GitHub、Netlify 或中转站密钥。
- 不要提交 `.env`、访问令牌或身份验证文件。
- 更换电脑后，应重新登录 GitHub 和 Netlify。
- 修改 `admin/config.yml` 前，先确认不会破坏现有后台内容结构。

## 11. 新任务接手提示

开始继续开发前，请执行以下要求：

> 请先阅读 HANDOFF.md，检查 Git 状态和最近提交，再查看 index.html、admin/config.yml、content/items.json 与 content/spotlight.json。不要覆盖未确认的本地修改。完成工作后，运行本地预览并更新 HANDOFF.md 中的当前状态和下一步事项。

