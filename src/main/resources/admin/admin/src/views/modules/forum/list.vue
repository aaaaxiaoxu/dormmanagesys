<template>
  <div class="forum-page">
    <template v-if="showFlag">
      <section class="hero-panel">
        <div class="hero-copy">
          <div class="eyebrow">
            <i class="el-icon-chat-line-round"></i>
            宿舍论坛交流区
          </div>
          <h1>这里不只是提问题，也能聊天、求助、提问和分享近况</h1>
          <p>
            论坛支持自由发帖、评论和楼中楼回复。你可以讨论宿舍生活、发起求助、请教问题，
            也可以围绕具体帖子继续交流。
          </p>
          <div class="hero-actions">
            <el-button v-if="isAuth('forum','新增')" type="primary" class="hero-btn primary-btn" @click="addOrUpdateHandler()">
              <i class="el-icon-circle-plus-outline"></i>
              发布新帖子
            </el-button>
            <el-button class="hero-btn ghost-btn" @click="search()">
              <i class="el-icon-refresh"></i>
              刷新列表
            </el-button>
          </div>
        </div>
        <div class="hero-metrics">
          <div class="metric-card warm-card">
            <div class="metric-icon">
              <i class="el-icon-chat-dot-round"></i>
            </div>
            <div class="metric-value">{{ openCount }}</div>
            <div class="metric-label">开放帖子</div>
          </div>
          <div class="metric-card cool-card">
            <div class="metric-icon">
              <i class="el-icon-close-notification"></i>
            </div>
            <div class="metric-value">{{ closedCount }}</div>
            <div class="metric-label">关闭帖子</div>
          </div>
          <div class="metric-card green-card">
            <div class="metric-icon">
              <i class="el-icon-chat-line-round"></i>
            </div>
            <div class="metric-value">{{ totalPage }}</div>
            <div class="metric-label">当前帖子数</div>
          </div>
        </div>
      </section>

      <section class="toolbar-panel">
        <div class="toolbar-title">
          <div class="toolbar-badge">
            <i class="el-icon-s-grid"></i>
          </div>
          <div>
            <div class="toolbar-name">帖子筛选</div>
            <div class="toolbar-desc">按标题和状态快速定位开放或关闭的讨论</div>
          </div>
        </div>

        <el-form class="filter-form" :inline="true" :model="searchForm">
          <el-form-item>
            <el-input v-model="searchForm.title" placeholder="搜索帖子标题" clearable>
              <i slot="prefix" class="el-input__icon el-icon-search"></i>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-select v-model="searchForm.isdone" clearable placeholder="状态">
              <el-option v-for="item in statusOptions" :key="item" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button class="action-btn rich-btn" @click="search()">
              <i class="el-icon-search"></i>
              查询
            </el-button>
          </el-form-item>
          <el-form-item v-if="canBatchDelete">
            <el-button class="action-btn danger-btn" :disabled="dataListSelections.length <= 0" @click="deleteHandler()">
              <i class="el-icon-delete"></i>
              批量删除
            </el-button>
          </el-form-item>
        </el-form>
      </section>

      <section class="list-panel" v-if="isAuth('forum','查看')">
        <div class="panel-head">
          <div>
            <div class="panel-title">论坛帖子列表</div>
            <div class="panel-subtitle">点击“进入交流”查看完整对话和继续回复</div>
          </div>
          <div class="panel-chip">
            <i class="el-icon-tickets"></i>
            共 {{ totalPage }} 条
          </div>
        </div>

        <el-table
          class="forum-table"
          :data="dataList"
          v-loading="dataListLoading"
          :stripe="false"
          @selection-change="selectionChangeHandler"
        >
          <el-table-column type="selection" align="center" width="55"></el-table-column>
          <el-table-column label="帖子信息" min-width="360">
            <template slot-scope="scope">
              <div class="topic-cell">
                <div class="topic-icon">
                  <i class="el-icon-chat-dot-round"></i>
                </div>
                <div class="topic-main">
                  <div class="topic-title">{{ scope.row.title || '未命名帖子' }}</div>
                  <div class="topic-preview">{{ formatText(scope.row.content) }}</div>
                </div>
              </div>
            </template>
          </el-table-column>
          <el-table-column label="发帖人" min-width="140">
            <template slot-scope="scope">
              <div class="user-chip">
                <i class="el-icon-user-solid"></i>
                <span>{{ forumUserDisplay(scope.row) }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column label="状态" min-width="120">
            <template slot-scope="scope">
              <div class="status-pill" :class="statusClass(scope.row.isdone)">
                <i :class="statusIcon(scope.row.isdone)"></i>
                <span>{{ scope.row.isdone || '开放' }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="addtime" label="发布时间" min-width="180"></el-table-column>
          <el-table-column width="340" label="操作">
            <template slot-scope="scope">
              <div class="table-actions">
                <el-button class="table-btn detail-btn" size="mini" @click="addOrUpdateHandler(scope.row.id,'info')">
                  <i class="el-icon-document"></i>
                  详情
                </el-button>
                <el-button class="table-btn enter-btn" size="mini" @click="addOrUpdateHandler(scope.row.id,'thread')">
                  <i class="el-icon-position"></i>
                  进入帖子
                </el-button>
                <el-button v-if="canEdit(scope.row)" class="table-btn edit-btn" size="mini" @click="addOrUpdateHandler(scope.row.id,'edit')">
                  <i class="el-icon-edit"></i>
                  修改
                </el-button>
                <el-button v-if="canDelete(scope.row)" class="table-btn remove-btn" size="mini" @click="deleteHandler(scope.row.id)">
                  <i class="el-icon-delete"></i>
                  删除
                </el-button>
              </div>
            </template>
          </el-table-column>
        </el-table>

        <el-pagination
          class="forum-pagination"
          @size-change="sizeChangeHandle"
          @current-change="currentChangeHandle"
          :current-page="pageIndex"
          background
          :page-sizes="[10, 20, 30, 50]"
          :page-size="pageSize"
          :layout="layouts.join()"
          :total="totalPage"
          prev-text="<"
          next-text=">"
          :hide-on-single-page="false"
        ></el-pagination>
      </section>
    </template>

    <add-or-update v-if="addOrUpdateFlag" :parent="this" ref="addOrUpdate"></add-or-update>
  </div>
</template>

<script>
import AddOrUpdate from "./add-or-update";

export default {
  data() {
    return {
      searchForm: {
        title: "",
        isdone: ""
      },
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      showFlag: true,
      addOrUpdateFlag: false,
      layouts: ["total", "prev", "pager", "next", "sizes", "jumper"],
      statusOptions: ["开放", "关闭"]
    };
  },
  created() {
    this.getDataList();
  },
  components: {
    AddOrUpdate
  },
  computed: {
    sessionTable() {
      return this.$storage.get("sessionTable");
    },
    currentUserId() {
      return Number(this.$storage.get("userId") || this.$storage.get("userid") || 0);
    },
    privileged() {
      return this.sessionTable === "users" || this.sessionTable === "suguan";
    },
    canBatchDelete() {
      return this.isAuth("forum", "删除");
    },
    openCount() {
      return this.dataList.filter(item => (item.isdone || "开放") === "开放").length;
    },
    closedCount() {
      return this.dataList.filter(item => item.isdone === "关闭").length;
    }
  },
  methods: {
    forumRoleLabel(row) {
      const role = (row && row.avatarurl) || "";
      if (role === "宿管" || role === "学生" || role === "管理员") {
        return role;
      }
      return "用户";
    },
    forumUserDisplay(row) {
      const username = (row && row.username) || "匿名用户";
      return `${this.forumRoleLabel(row)}：${username}`;
    },
    search() {
      this.pageIndex = 1;
      this.getDataList();
    },
    getDataList() {
      this.dataListLoading = true;
      const params = {
        page: this.pageIndex,
        limit: this.pageSize,
        parentid: 0,
        sort: "addtime",
        order: "desc"
      };
      if (this.searchForm.title) {
        params.title = "%" + this.searchForm.title + "%";
      }
      if (this.searchForm.isdone) {
        params.isdone = this.searchForm.isdone;
      }
      this.$http({
        url: "forum/page",
        method: "get",
        params
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.dataList = data.data.list || [];
          this.totalPage = data.data.total || 0;
        } else {
          this.dataList = [];
          this.totalPage = 0;
        }
        this.dataListLoading = false;
      });
    },
    sizeChangeHandle(val) {
      this.pageSize = val;
      this.pageIndex = 1;
      this.getDataList();
    },
    currentChangeHandle(val) {
      this.pageIndex = val;
      this.getDataList();
    },
    selectionChangeHandler(val) {
      this.dataListSelections = val;
    },
    addOrUpdateHandler(id, type) {
      this.showFlag = false;
      this.addOrUpdateFlag = true;
      this.$nextTick(() => {
        this.$refs.addOrUpdate.init(id, type || "create");
      });
    },
    formatText(content) {
      const text = (content || "").replace(/<[^>]+>/g, "").replace(/\s+/g, " ").trim();
      if (!text) {
        return "暂无内容";
      }
      return text.length > 52 ? text.slice(0, 52) + "..." : text;
    },
    statusClass(status) {
      const map = {
        "开放": "solved-pill",
        "关闭": "closed-pill"
      };
      return map[status] || "solved-pill";
    },
    statusIcon(status) {
      const map = {
        "开放": "el-icon-circle-check",
        "关闭": "el-icon-close-notification"
      };
      return map[status] || "el-icon-circle-check";
    },
    canEdit(row) {
      return Number(row.userid) === this.currentUserId;
    },
    canDelete(row) {
      return this.privileged || Number(row.userid) === this.currentUserId;
    },
    deleteHandler(id) {
      const ids = id
        ? [Number(id)]
        : this.dataListSelections.filter(item => this.canDelete(item)).map(item => Number(item.id));
      if (!ids.length) {
        this.$message.error("当前没有可删除的帖子");
        return;
      }
      this.$confirm(`确定进行[${id ? "删除" : "批量删除"}]操作?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "forum/delete",
          method: "post",
          data: ids
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({
              message: "操作成功",
              type: "success",
              duration: 1500,
              onClose: () => {
                this.search();
              }
            });
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    }
  }
};
</script>

<style lang="scss" scoped>
.forum-page {
  min-height: 100%;
  padding: 20px;
  background:
    radial-gradient(circle at top left, rgba(146, 161, 123, 0.12), transparent 24%),
    radial-gradient(circle at top right, rgba(196, 182, 153, 0.12), transparent 22%),
    linear-gradient(180deg, #eef1ea 0%, #e8ece4 100%);
}

.hero-panel,
.toolbar-panel,
.list-panel {
  border-radius: 24px;
  overflow: hidden;
  border: 1px solid rgba(194, 202, 184, 0.9);
  box-shadow: 0 16px 36px rgba(61, 70, 52, 0.08);
}

.hero-panel {
  padding: 34px;
  margin-bottom: 24px;
  display: grid;
  grid-template-columns: 1.5fr 1fr;
  gap: 24px;
  background:
    linear-gradient(135deg, rgba(205, 192, 168, 0.2), rgba(146, 161, 123, 0.18)),
    linear-gradient(180deg, rgba(250, 249, 245, 0.98), rgba(243, 245, 238, 0.96));
}

.eyebrow {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 14px;
  border-radius: 999px;
  background: rgba(229, 235, 221, 0.9);
  color: #5f6f52;
  font-size: 13px;
  letter-spacing: 1px;
  margin-bottom: 16px;
}

.hero-copy h1 {
  margin: 0 0 14px;
  color: #283125;
  font-size: 34px;
  line-height: 1.25;
}

.hero-copy p {
  margin: 0;
  color: #586554;
  line-height: 1.9;
  font-size: 15px;
  max-width: 720px;
}

.hero-actions {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
  margin-top: 26px;
}

.hero-btn {
  border-radius: 999px;
  padding: 12px 22px;
  font-size: 14px;
  border: none;
}

.primary-btn {
  background: linear-gradient(135deg, #839370, #6b7a5b);
  color: #fffef9;
}

.ghost-btn {
  background: rgba(235, 238, 229, 0.96);
  color: #55664b;
}

.hero-metrics {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 14px;
}

.metric-card {
  border-radius: 18px;
  padding: 20px 16px;
  min-height: 160px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  color: #fff;
  border: 1px solid rgba(193, 200, 183, 0.55);
}

.warm-card {
  background: linear-gradient(160deg, #96866c, #ab9a7f);
}

.cool-card {
  background: linear-gradient(160deg, #7b8869, #8f9d7b);
}

.green-card {
  background: linear-gradient(160deg, #6b8161, #7d9472);
}

.metric-icon {
  width: 44px;
  height: 44px;
  border-radius: 14px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.18);
  font-size: 20px;
}

.metric-value {
  font-size: 34px;
  font-weight: 700;
}

.metric-label {
  font-size: 13px;
  opacity: 0.92;
}

.toolbar-panel {
  margin-bottom: 24px;
  padding: 22px 26px;
  background: linear-gradient(180deg, rgba(244, 246, 240, 0.98), rgba(237, 240, 233, 0.96));
}

.toolbar-title {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 18px;
}

.toolbar-badge {
  width: 54px;
  height: 54px;
  border-radius: 18px;
  background: linear-gradient(135deg, #d8ccb6, #b4c09d);
  color: #4c5844;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  box-shadow: 0 10px 22px rgba(125, 137, 102, 0.16);
}

.toolbar-name {
  color: #2d3729;
  font-size: 20px;
  font-weight: 600;
}

.toolbar-desc {
  color: #6a7564;
  margin-top: 4px;
  font-size: 13px;
}

.filter-form {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.filter-form ::v-deep .el-form-item {
  margin: 0;
}

.filter-form ::v-deep .el-input__inner,
.filter-form ::v-deep .el-select .el-input__inner {
  width: 230px;
  height: 44px;
  border-radius: 14px;
  border: 1px solid #c9d0c0;
  background: #fffdf8;
  color: #334033;
}

.filter-form ::v-deep .el-input__prefix,
.filter-form ::v-deep .el-input__icon,
.filter-form ::v-deep .el-select__caret {
  color: #879174;
}

.action-btn {
  height: 44px;
  padding: 0 20px;
  border: none;
  border-radius: 14px;
  font-size: 14px;
}

.rich-btn {
  color: #fffef9;
  background: linear-gradient(135deg, #839370, #6b7a5b);
}

.danger-btn {
  color: #fff;
  background: linear-gradient(135deg, #b46857, #925449);
}

.list-panel {
  padding: 24px;
  background: linear-gradient(180deg, rgba(250, 249, 245, 0.98), rgba(243, 245, 238, 0.96));
}

.panel-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 16px;
  margin-bottom: 20px;
}

.panel-title {
  color: #283125;
  font-size: 24px;
  font-weight: 700;
}

.panel-subtitle {
  margin-top: 6px;
  color: #6a7564;
  font-size: 13px;
}

.panel-chip {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 10px 16px;
  border-radius: 999px;
  color: #667553;
  background: rgba(231, 235, 224, 0.92);
}

.forum-table {
  border-radius: 22px;
  overflow: hidden;
}

.forum-table ::v-deep .el-table,
.forum-table ::v-deep .el-table__expanded-cell {
  color: #334033;
  background: rgba(255, 253, 248, 0.98);
}

.forum-table ::v-deep th {
  border: none;
  background: linear-gradient(180deg, #8a9975, #6f7f5f) !important;
  color: #fffef9;
  font-weight: 700;
}

.forum-table ::v-deep tr,
.forum-table ::v-deep td {
  background: rgba(255, 253, 248, 0.98);
  border-bottom: 1px solid #eceee6;
}

.forum-table ::v-deep .el-table__row:hover > td {
  background: #f4f6ef !important;
}

.topic-cell {
  display: flex;
  align-items: flex-start;
  gap: 14px;
}

.topic-icon {
  flex: 0 0 42px;
  width: 42px;
  height: 42px;
  border-radius: 14px;
  background: linear-gradient(135deg, #8e9d79, #758465);
  color: #fff;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  box-shadow: 0 10px 22px rgba(117, 132, 101, 0.18);
}

.topic-main {
  min-width: 0;
}

.topic-title {
  color: #2f392b;
  font-size: 15px;
  font-weight: 700;
  margin-bottom: 6px;
}

.topic-preview {
  color: #6a7564;
  line-height: 1.7;
}

.user-chip {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(236, 239, 231, 0.96);
  color: #4f5d46;
}


.status-pill {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 14px;
  border-radius: 999px;
  font-weight: 600;
}

.pending-pill {
  background: rgba(189, 164, 120, 0.18);
  color: #866d47;
}

.processing-pill {
  background: rgba(143, 158, 119, 0.18);
  color: #667553;
}

.solved-pill {
  background: rgba(120, 148, 103, 0.18);
  color: #577049;
}

.closed-pill {
  background: rgba(148, 163, 184, 0.18);
  color: #68727d;
}

.table-actions {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.table-btn {
  border: 1px solid transparent;
  border-radius: 12px;
  padding: 8px 14px;
  color: #fffef9;
}

.detail-btn {
  background: linear-gradient(135deg, #8a9384, #717a6c);
}

.enter-btn {
  background: linear-gradient(135deg, #839370, #6b7a5b);
}

.edit-btn {
  background: linear-gradient(135deg, #ad9870, #907d59);
}

.remove-btn {
  background: linear-gradient(135deg, #b46857, #925449);
}

.forum-pagination {
  margin-top: 20px;
  text-align: center;
}

.forum-pagination ::v-deep .btn-prev,
.forum-pagination ::v-deep .btn-next,
.forum-pagination ::v-deep .el-pager li,
.forum-pagination ::v-deep .el-input__inner {
  background: #f7f8f2;
  border: 1px solid #d6dccd;
  color: #55624a;
}

.forum-pagination ::v-deep .el-pager li.active {
  background: linear-gradient(135deg, #8a9975, #6f7f5f);
  color: #fffef9;
}

.forum-pagination ::v-deep .el-pagination__total,
.forum-pagination ::v-deep .el-pagination__jump {
  color: #6a7564;
}

@media (max-width: 1200px) {
  .hero-panel {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .forum-page {
    padding: 12px;
  }

  .hero-panel,
  .toolbar-panel,
  .list-panel {
    padding-left: 16px;
    padding-right: 16px;
  }

  .hero-copy h1 {
    font-size: 26px;
  }

  .hero-metrics {
    grid-template-columns: 1fr;
  }

  .filter-form ::v-deep .el-input__inner,
  .filter-form ::v-deep .el-select .el-input__inner {
    width: 100%;
  }

  .table-actions {
    flex-direction: column;
    align-items: stretch;
  }
}
</style>
