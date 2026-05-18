# 宿舍管理系统改造任务清单

## 改造目标

将当前以增删改查为主的宿舍管理系统，升级为贴近真实宿舍管理场景的平台：

- 角色清晰：管理员、宿管员、学生看到不同首页、菜单和操作权限。
- 流程完整：入住分配、门禁出入、请假审核、报修处理、卫生检查、违纪登记形成闭环。
- 数据可视：提供请假、门禁、报修、卫生、入住率等统计分析。
- 操作高效：常用字段改为下拉选择、联动回填、组合筛选，减少手动输入。
- 界面现代：春季浅色配色、紧凑布局、字号提升、交互反馈更明确。

## Commit 规范

后续提交统一使用 Conventional Commits：

- `docs(scope): ...` 文档和计划
- `feat(scope): ...` 新功能
- `fix(scope): ...` 缺陷修复
- `style(scope): ...` 样式和视觉调整
- `refactor(scope): ...` 结构调整但不改变行为
- `chore(scope): ...` 构建、配置、维护类改动

每个任务完成后单独提交，提交信息正文写明：

- 做了什么
- 为什么这样做
- 如何验证

## 阶段 1：信息架构和权限边界

### 1.1 菜单命名修正

目标：

- 将“请假信息”改为“请假申请”或“请假”。
- 修复路由里 `qingjia` 错写为“宿舍报修”的问题。
- 将“出入宿舍”改为“门禁出入”。
- 将“考勤信息”改为“晚归/未归统计”或“考勤统计”。

涉及文件：

- `src/main/resources/admin/admin/src/utils/menu.js`
- `src/main/resources/admin/admin/src/router/router-static.js`

验证：

- 登录后菜单名称正确。
- 路由标题和菜单含义一致。

建议提交：

- `fix(navigation): correct dormitory workflow menu labels`

### 1.2 三角色菜单重新划分

目标：

- 管理员：基础数据、宿舍资源、一键分配、统计分析、公告、AI 客服。
- 宿管员：所管事务处理、门禁出入、请假审核、报修工单、卫生检查、违纪登记。
- 学生：我的宿舍、我的请假、我的报修、我的门禁记录、个人人脸档案。

涉及文件：

- `src/main/resources/admin/admin/src/utils/menu.js`
- 各模块按钮权限判断相关页面

验证：

- 三种角色菜单不同。
- 学生端不出现宿管/管理员管理入口。

建议提交：

- `refactor(auth): separate menus by dormitory role responsibility`

## 阶段 2：界面视觉升级

### 2.1 春季浅色主题变量

目标：

- 建立绿色、薄荷色、浅黄、浅蓝的主题色。
- 统一页面背景、菜单、表格、按钮、状态标签。
- 字号整体提升，减少阅读压力。

涉及文件：

- `src/main/resources/admin/admin/src/assets/css/style.scss`
- `src/main/resources/admin/admin/src/components/index/*.vue`
- `src/main/resources/admin/admin/src/views/home.vue`

验证：

- 首页、列表页、表单页视觉一致。
- 无大面积空白。
- 表格文字清晰。

建议提交：

- `style(theme): apply spring palette and readable admin typography`

### 2.2 列表页密度优化

目标：

- 搜索区改为紧凑筛选条。
- 表格上方增加统计卡片。
- 操作按钮增加图标和 hover 反馈。
- 空数据区增加引导。

涉及模块：

- 学生
- 宿舍
- 宿舍分配
- 门禁出入
- 请假
- 报修
- 卫生

验证：

- 主要列表页首屏不再出现大面积空白。
- 查询、重置、增删改查操作正常。

建议提交：

- `style(lists): improve density and interactions for admin tables`

## 阶段 3：数据统计分析

### 3.1 新增“数据分析”菜单和路由骨架

目标：

- 新增 `analysis` 页面。
- 展示入住率、请假、门禁、报修、卫生、违纪统计入口。
- 先使用现有接口和已有数据聚合展示。

涉及文件：

- `src/main/resources/admin/admin/src/router/router-static.js`
- `src/main/resources/admin/admin/src/utils/menu.js`
- `src/main/resources/admin/admin/src/views/analysis.vue`

验证：

- 管理员和宿管员可进入数据分析。
- 学生不显示全局分析入口。

建议提交：

- `feat(analysis): add dormitory operations dashboard route`

### 3.2 请假统计

目标：

- 待审核、已通过、已驳回数量。
- 按班级、宿舍楼栋、日期统计请假。
- 展示请假天数排行。

验证：

- 统计数据与 `qingjia` 表一致。

建议提交：

- `feat(analysis): add leave request statistics`

### 3.3 门禁出入统计

目标：

- 每日出入人次。
- 进出高峰时段。
- 深夜出入异常。
- 楼栋出入对比。

验证：

- 统计数据与 `churusushe` 表一致。

建议提交：

- `feat(analysis): add access control attendance statistics`

## 阶段 4：业务流程升级

### 4.1 门禁出入改造为人脸模拟门禁

目标：

- 学生维护人脸档案。
- 上传现场照片进行核验。
- 识别成功后自动生成门禁记录。
- 门禁记录不需要审核。

涉及文件：

- `src/main/java/com/controller/CommonController.java`
- `src/main/java/com/controller/ChurususheController.java`
- `src/main/resources/admin/admin/src/views/modules/churusushe/*`
- `src/main/resources/admin/admin/src/views/center.vue`

验证：

- 上传照片后生成记录。
- 记录自动带出学生、宿舍、时间、照片。

建议提交：

- `feat(access): generate dormitory entry records from face verification`

### 4.2 请假流程区分

目标：

- 学生提交请假。
- 宿管员/管理员审核。
- 审核通过后参与未归异常判断。
- 详情页展示流程状态。

验证：

- 学生不能审核。
- 宿管员可审核。
- 请假和门禁职责区分清楚。

建议提交：

- `refactor(leave): clarify leave workflow and approval states`

### 4.3 报修工单流程完整化

目标：

- 状态：待处理、维修中、已完成。
- 增加报修类型、处理备注、完成照片、完成时间。
- 支持按状态、楼栋、时间筛选。

验证：

- 学生提交后默认待处理。
- 宿管员可更新状态。
- 管理员可统计完成率。

建议提交：

- `feat(repair): add maintenance work order lifecycle`

### 4.4 卫生检查升级

目标：

- 支持评分、评语、现场照片。
- 支持楼栋、宿舍、日期筛选。
- 生成卫生评分排行榜。

验证：

- 分数可统计。
- 学生只能查看本宿舍卫生记录。

建议提交：

- `feat(hygiene): add scoring inspection workflow`

### 4.5 晚归/未归/违纪登记

目标：

- 新增违纪登记模块。
- 类型包含晚归、夜不归宿、违规用电、卫生违规、喧哗扰民、其他。
- 支持按学生、宿舍、楼栋、时间筛选。

验证：

- 宿管员可登记。
- 学生可查看自己的记录。

建议提交：

- `feat(discipline): add late return and violation records`

## 阶段 5：宿舍分配能力

### 5.1 一键分配后端接口

目标：

- 支持按班级、专业、性别筛选未分配学生。
- 自动分配空余床位。
- 遵守性别匹配、不超床位、不混住、不重复床位。
- 返回成功和失败明细。

涉及文件：

- `src/main/java/com/controller/SushefenpeiController.java`
- `src/main/java/com/service/SushefenpeiService.java`

验证：

- 批量分配后宿舍入住人数同步更新。
- 已分配学生不会重复分配。

建议提交：

- `feat(allocation): add automatic dormitory assignment endpoint`

### 5.2 一键分配前端界面

目标：

- 增加“一键分配”按钮。
- 提供筛选条件、预览结果、确认分配。
- 支持清空分配、重置床位。

涉及文件：

- `src/main/resources/admin/admin/src/views/modules/sushefenpei/list.vue`

验证：

- 可预览、确认、失败原因可见。

建议提交：

- `feat(allocation): add automatic assignment dialog`

## 阶段 6：智能输入和导入导出

### 6.1 表单下拉和智能回填

目标：

- 学生选择支持学号/姓名搜索。
- 选择学生自动回填姓名、班级、宿舍。
- 选择宿舍自动回填楼栋、房间、空床位。
- 状态、类型、性别、班级、专业全部使用下拉。

验证：

- 主要表单无需大量手动输入。

建议提交：

- `feat(forms): add searchable selects and smart defaults`

### 6.2 Excel 导入导出

目标：

- 学生、宿舍、分配、请假、门禁、卫生、报修、违纪支持导出。
- 学生和宿舍支持模板导入。
- 导入返回成功数、失败数、失败原因。

验证：

- 导出的 Excel 可打开。
- 导入错误数据不会破坏原数据。

建议提交：

- `feat(import-export): add spreadsheet templates and exports`

