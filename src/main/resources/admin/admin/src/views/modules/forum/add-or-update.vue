<template>
  <div class="forum-detail-page">
    <template v-if="pageMode === 'thread' || pageMode === 'info'">
      <section class="thread-hero">
        <div class="thread-hero-main">
          <div class="detail-badge">
            <i class="el-icon-chat-line-round"></i>
            论坛帖子详情
          </div>
          <h2>{{ thread.title || "未命名帖子" }}</h2>
          <p>这里可以自由交流、评论和继续回复评论，让讨论更完整、更自然。</p>
        </div>
        <div class="thread-status-board">
          <div class="status-ring" :class="statusClass(thread.isdone)">
            <i :class="statusIcon(thread.isdone)"></i>
          </div>
          <div class="status-text">{{ thread.isdone || "开放" }}</div>
          <div class="status-subtext">当前帖子状态</div>
          <el-button v-if="canManageStatus" class="status-action" @click="toggleStatusDialog = true">
            <i class="el-icon-edit-outline"></i>
            修改状态
          </el-button>
        </div>
      </section>

      <section class="thread-grid">
        <div class="thread-main-card">
          <div class="card-head">
            <div class="head-title">
              <div class="icon-box orange-box">
                <i class="el-icon-document-copy"></i>
              </div>
              <div>
                <div class="title-text">帖子内容</div>
                <div class="desc-text">发帖人可以自行管理帖子状态，其他用户可以评论交流</div>
              </div>
            </div>
          </div>

          <div class="meta-row">
            <div class="meta-pill">
              <i class="el-icon-user-solid"></i>
              {{ forumUserDisplay(thread) }}
            </div>
            <div class="meta-pill">
              <i class="el-icon-time"></i>
              {{ thread.addtime || "" }}
            </div>
            <div class="meta-pill strong-pill" :class="statusClass(thread.isdone)">
              <i :class="statusIcon(thread.isdone)"></i>
              {{ thread.isdone || "开放" }}
            </div>
          </div>

          <div class="content-panel" v-html="thread.content || '暂无内容'"></div>
        </div>

        <div class="thread-side-card">
          <div class="side-stat vivid-blue">
            <div class="side-icon"><i class="el-icon-chat-dot-round"></i></div>
            <div class="side-value">{{ commentCount }}</div>
            <div class="side-label">累计评论数</div>
          </div>
          <div class="side-stat vivid-orange">
            <div class="side-icon"><i class="el-icon-s-comment"></i></div>
            <div class="side-value">{{ thread.isdone || "开放" }}</div>
            <div class="side-label">讨论状态</div>
          </div>
        </div>
      </section>

      <section class="reply-board">
        <div class="card-head">
          <div class="head-title">
            <div class="icon-box blue-box">
              <i class="el-icon-chat-line-round"></i>
            </div>
            <div>
              <div class="title-text">评论区</div>
              <div class="desc-text">支持直接评论帖子，也支持在评论下面继续回复评论</div>
            </div>
          </div>
        </div>

        <div v-if="flatComments.length" class="comment-tree">
          <div
            v-for="item in flatComments"
            :key="item.id"
            class="comment-node"
            :style="{ marginLeft: (item.level > 0 ? Math.min(item.level, 4) * 24 : 0) + 'px' }"
          >
            <div class="reply-card">
              <div class="reply-avatar">
                <i class="el-icon-user"></i>
              </div>
              <div class="reply-body">
                <div class="reply-top">
                  <span class="reply-name">{{ forumUserDisplay(item) }}</span>
                  <span class="reply-time">{{ item.addtime || "" }}</span>
                </div>
                <div class="reply-content" v-html="item.content || '暂无评论内容'"></div>
                <div class="reply-actions">
                  <el-button
                    v-if="pageMode === 'thread' && (thread.isdone || '开放') === '开放'"
                    type="text"
                    class="inline-btn"
                    @click="openReplyToComment(item)"
                  >
                    {{ activeReplyTarget && activeReplyTarget.id === item.id ? "正在回复" : "回复评论" }}
                  </el-button>
                  <el-button
                    v-if="canDeleteComment(item)"
                    type="text"
                    class="inline-btn delete-inline"
                    @click="deleteComment(item)"
                  >
                    删除
                  </el-button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div v-else class="empty-box">
          <i class="el-icon-chat-dot-square"></i>
          <span>还没有评论，欢迎来发第一条评论</span>
        </div>
      </section>

      <section v-if="pageMode === 'thread'" class="reply-editor-panel">
        <div class="card-head">
          <div class="head-title">
            <div class="icon-box green-box">
              <i class="el-icon-edit"></i>
            </div>
            <div>
              <div class="title-text">{{ activeReplyTarget ? "回复评论" : "发表评论" }}</div>
              <div class="desc-text">
                {{ activeReplyTarget ? `当前正在回复：${forumUserDisplay(activeReplyTarget)}` : "可以直接在帖子下发表评论" }}
              </div>
            </div>
          </div>
        </div>

        <div v-if="!canCommentThread" class="closed-tip">
          <i class="el-icon-lock"></i>
          当前帖子已关闭，暂时不能继续评论。
        </div>
        <div v-if="!canCommentThread" class="closed-actions">
          <el-button class="back-btn" @click="back()">
            <i class="el-icon-arrow-left"></i>
            返回列表
          </el-button>
        </div>

        <el-form v-else ref="replyForm" :model="replyForm" :rules="replyRules" label-width="100px" class="reply-form">
          <el-form-item v-if="activeReplyTarget" label="回复对象">
            <div class="reply-target">
              {{ forumUserDisplay(activeReplyTarget) }}
              <el-button type="text" @click="clearReplyTarget">取消回复</el-button>
            </div>
          </el-form-item>
          <el-form-item :label="activeReplyTarget ? '回复内容' : '评论内容'" prop="content">
            <el-input
              type="textarea"
              :rows="7"
              :placeholder="activeReplyTarget ? '请输入要回复的内容' : '请输入你的评论内容'"
              v-model="replyForm.content"
            ></el-input>
          </el-form-item>
          <el-form-item class="btn-row">
            <el-button type="primary" class="send-btn" @click="submitReply">
              <i class="el-icon-position"></i>
              {{ activeReplyTarget ? "发送回复" : "发表评论" }}
            </el-button>
            <el-button class="back-btn" @click="back()">
              <i class="el-icon-arrow-left"></i>
              返回列表
            </el-button>
          </el-form-item>
        </el-form>
      </section>

      <section v-else class="single-action-panel">
        <el-button class="back-btn" @click="back()">
          <i class="el-icon-arrow-left"></i>
          返回列表
        </el-button>
      </section>

      <el-dialog title="修改帖子状态" :visible.sync="toggleStatusDialog" width="420px">
        <el-form label-width="80px">
          <el-form-item label="状态">
            <el-select v-model="thread.isdone" placeholder="请选择状态" style="width: 100%;">
              <el-option v-for="item in statusOptions" :key="item" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <span slot="footer">
          <el-button @click="toggleStatusDialog = false">取消</el-button>
          <el-button type="primary" @click="updateStatus">保存</el-button>
        </span>
      </el-dialog>
    </template>

    <section v-else class="publish-page">
      <div class="publish-hero">
        <div>
          <div class="detail-badge">
            <i class="el-icon-edit-outline"></i>
            {{ ruleForm.id ? "编辑帖子" : "发布帖子" }}
          </div>
          <h2>{{ ruleForm.id ? "编辑帖子内容和状态" : "发一条新帖子，开始新的讨论" }}</h2>
          <p>这里既可以发起求助、讨论生活，也可以分享经验、提问和闲聊。</p>
        </div>
      </div>

      <div class="publish-form-card">
        <el-form
          class="add-update-preview"
          ref="ruleForm"
          :model="ruleForm"
          :rules="rules"
          label-width="120px"
        >
          <el-form-item class="input" label="帖子标题" prop="title">
            <el-input v-model="ruleForm.title" placeholder="请输入帖子标题"></el-input>
          </el-form-item>

          <el-form-item class="select" label="状态" prop="isdone">
            <el-select v-model="ruleForm.isdone" placeholder="请选择状态">
              <el-option v-for="item in statusOptions" :key="item" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>

          <el-form-item label="帖子内容" prop="content">
            <editor
              style="min-width: 200px; max-width: 760px;"
              v-model="ruleForm.content"
              class="editor"
              action="file/upload"
            ></editor>
          </el-form-item>

          <el-form-item class="btn-row">
            <el-button type="primary" class="send-btn" @click="onSubmit">
              <i class="el-icon-upload2"></i>
              提交帖子
            </el-button>
            <el-button class="back-btn" @click="back()">
              <i class="el-icon-close"></i>
              取消
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  props: ["parent"],
  data() {
    return {
      id: "",
      pageMode: "create",
      toggleStatusDialog: false,
      statusOptions: ["开放", "关闭"],
      ruleForm: {
        id: "",
        title: "",
        content: "",
        isdone: "开放"
      },
      replyForm: {
        content: ""
      },
      activeReplyTarget: null,
      thread: {},
      commentTree: [],
      rules: {
        title: [{ required: true, message: "帖子标题不能为空", trigger: "blur" }],
        content: [{ required: true, message: "帖子内容不能为空", trigger: "blur" }]
      },
      replyRules: {
        content: [{ required: true, message: "评论内容不能为空", trigger: "blur" }]
      }
    };
  },
  computed: {
    currentUserId() {
      return Number(this.$storage.get("userId") || this.$storage.get("userid") || 0);
    },
    sessionTable() {
      return this.$storage.get("sessionTable");
    },
    privileged() {
      return this.sessionTable === "users" || this.sessionTable === "suguan";
    },
    canManageStatus() {
      return this.pageMode === "thread" && Number(this.thread.userid) === this.currentUserId;
    },
    canCommentThread() {
      return (this.thread.isdone || "开放") === "开放";
    },
    commentCount() {
      return this.countComments(this.commentTree);
    },
    flatComments() {
      return this.flattenComments(this.commentTree);
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
    init(id, type) {
      this.id = id || "";
      this.pageMode = type || "create";
      this.toggleStatusDialog = false;
      this.activeReplyTarget = null;
      this.ruleForm = {
        id: "",
        title: "",
        content: "",
        isdone: "开放"
      };
      this.replyForm = {
        content: ""
      };
      this.thread = {};
      this.commentTree = [];

      if (this.pageMode === "edit" && id) {
        this.info(id);
      }
      if ((this.pageMode === "thread" || this.pageMode === "info") && id) {
        this.loadThread(id);
      }
    },
    info(id) {
      this.$http({
        url: `forum/info/${id}`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.ruleForm = Object.assign({}, data.data);
          this.ruleForm.content = this.normalizeContent(this.ruleForm.content);
          this.ruleForm.isdone = this.ruleForm.isdone || "开放";
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    loadThread(id) {
      this.$http({
        url: `forum/list/${id}`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.thread = this.normalizeThreadNode(data.data || {});
          this.commentTree = this.thread.childs || [];
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    normalizeThreadNode(item) {
      if (!item) {
        return {};
      }
      const node = Object.assign({}, item);
      node.content = this.normalizeContent(node.content);
      node.childs = (node.childs || []).map(child => this.normalizeThreadNode(child));
      return node;
    },
    normalizeContent(content) {
      return (content || "").replace(new RegExp("../../../upload", "g"), "../../../dormmanagesys/upload");
    },
    prepareContentForSubmit(content) {
      return (content || "").replace(new RegExp("../../../dormmanagesys/upload", "g"), "../../../upload");
    },
    countComments(list) {
      return (list || []).reduce((sum, item) => {
        return sum + 1 + this.countComments(item.childs || []);
      }, 0);
    },
    flattenComments(list, level = 0, result = []) {
      (list || []).forEach(item => {
        result.push(Object.assign({}, item, { level }));
        if (item.childs && item.childs.length) {
          this.flattenComments(item.childs, level + 1, result);
        }
      });
      return result;
    },
    statusClass(status) {
      const map = {
        "开放": "open-style",
        "关闭": "closed-style"
      };
      return map[status] || "open-style";
    },
    canDeleteComment(item) {
      return this.privileged || Number(item.userid) === this.currentUserId;
    },
    statusIcon(status) {
      const map = {
        "开放": "el-icon-circle-check",
        "关闭": "el-icon-close-notification"
      };
      return map[status] || "el-icon-circle-check";
    },
    onSubmit() {
      this.$refs["ruleForm"].validate(valid => {
        if (!valid) {
          return;
        }
        const url = `forum/${this.ruleForm.id ? "update" : "save"}`;
        const payload = Object.assign({}, this.ruleForm, {
          content: this.prepareContentForSubmit(this.ruleForm.content),
          isdone: this.ruleForm.isdone || "开放"
        });
        this.$http({
          url,
          method: "post",
          data: payload
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({
              message: "操作成功",
              type: "success",
              duration: 1500,
              onClose: () => {
                this.parent.showFlag = true;
                this.parent.addOrUpdateFlag = false;
                this.parent.search();
              }
            });
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
    openReplyToComment(item) {
      this.activeReplyTarget = item;
      this.$nextTick(() => {
        const textarea = this.$el.querySelector(".reply-editor-panel textarea");
        if (textarea) {
          textarea.focus();
        }
      });
    },
    clearReplyTarget() {
      this.activeReplyTarget = null;
    },
    submitReply() {
      this.$refs["replyForm"].validate(valid => {
        if (!valid) {
          return;
        }
        this.$http({
          url: "forum/save",
          method: "post",
          data: {
            title: this.thread.title,
            content: this.prepareContentForSubmit(this.replyForm.content),
            parentid: this.activeReplyTarget ? this.activeReplyTarget.id : this.thread.id
          }
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message.success(this.activeReplyTarget ? "回复成功" : "评论成功");
            this.replyForm.content = "";
            this.activeReplyTarget = null;
            this.loadThread(this.thread.id);
            if (this.parent && this.parent.getDataList) {
              this.parent.getDataList();
            }
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
    updateStatus() {
      this.$http({
        url: "forum/update",
        method: "post",
        data: {
          id: this.thread.id,
          title: this.thread.title,
          content: this.prepareContentForSubmit(this.thread.content),
          isdone: this.thread.isdone
        }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.$message.success("状态已更新");
          this.toggleStatusDialog = false;
          this.loadThread(this.thread.id);
          if (this.parent && this.parent.getDataList) {
            this.parent.getDataList();
          }
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    deleteComment(item) {
      this.$confirm("确定删除这条内容吗？删除后其下级回复也会一起删除。", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "forum/delete",
          method: "post",
          data: [Number(item.id)]
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message.success("删除成功");
            this.loadThread(this.thread.id);
            if (this.parent && this.parent.getDataList) {
              this.parent.getDataList();
            }
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
    back() {
      this.parent.showFlag = true;
      this.parent.addOrUpdateFlag = false;
    }
  }
};
</script>

<style lang="scss" scoped>
.forum-detail-page {
  min-height: 100%;
  padding: 20px;
  background:
    radial-gradient(circle at top left, rgba(146, 161, 123, 0.12), transparent 24%),
    radial-gradient(circle at top right, rgba(196, 182, 153, 0.12), transparent 22%),
    linear-gradient(180deg, #eef1ea 0%, #e8ece4 100%);
}

.thread-hero,
.thread-main-card,
.thread-side-card,
.reply-board,
.reply-editor-panel,
.publish-hero,
.publish-form-card,
.single-action-panel {
  border-radius: 24px;
  border: 1px solid rgba(194, 202, 184, 0.9);
  box-shadow: 0 16px 36px rgba(61, 70, 52, 0.08);
  overflow: hidden;
}

.thread-hero {
  margin-bottom: 24px;
  padding: 28px;
  display: grid;
  grid-template-columns: 1.4fr 320px;
  gap: 20px;
  background:
    linear-gradient(135deg, rgba(205, 192, 168, 0.2), rgba(146, 161, 123, 0.18)),
    linear-gradient(180deg, rgba(250, 249, 245, 0.98), rgba(243, 245, 238, 0.96));
}

.detail-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 14px;
  border-radius: 999px;
  background: rgba(229, 235, 221, 0.9);
  color: #5f6f52;
  margin-bottom: 14px;
}

.thread-hero-main h2,
.publish-hero h2 {
  margin: 0 0 12px;
  color: #283125;
  font-size: 32px;
  line-height: 1.3;
}

.thread-hero-main p,
.publish-hero p {
  margin: 0;
  color: #586554;
  line-height: 1.8;
}

.thread-status-board {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  border-radius: 20px;
  padding: 24px 18px;
  background: rgba(234, 238, 228, 0.88);
}

.status-ring {
  width: 88px;
  height: 88px;
  border-radius: 50%;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 36px;
  margin-bottom: 16px;
}

.open-style {
  background: rgba(120, 148, 103, 0.18);
  color: #577049;
}

.closed-style {
  background: rgba(148, 163, 184, 0.18);
  color: #68727d;
}

.status-text {
  color: #283125;
  font-size: 22px;
  font-weight: 700;
}

.status-subtext {
  margin-top: 6px;
  color: #6a7564;
}

.status-action {
  margin-top: 20px;
  border: none;
  border-radius: 14px;
  color: #fffef9;
  background: linear-gradient(135deg, #839370, #6b7a5b);
}

.thread-grid {
  display: grid;
  grid-template-columns: 1.4fr 320px;
  gap: 20px;
  margin-bottom: 24px;
}

.thread-main-card,
.thread-side-card,
.reply-board,
.reply-editor-panel,
.publish-form-card,
.single-action-panel {
  padding: 24px;
  background: linear-gradient(180deg, rgba(250, 249, 245, 0.98), rgba(243, 245, 238, 0.96));
}

.card-head {
  margin-bottom: 18px;
}

.head-title {
  display: flex;
  align-items: center;
  gap: 14px;
}

.icon-box {
  width: 52px;
  height: 52px;
  border-radius: 18px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: #fffef9;
  font-size: 22px;
}

.orange-box {
  background: linear-gradient(135deg, #ad9870, #907d59);
}

.blue-box {
  background: linear-gradient(135deg, #8e9d79, #758465);
}

.green-box {
  background: linear-gradient(135deg, #6b8161, #7d9472);
}

.title-text {
  color: #283125;
  font-size: 20px;
  font-weight: 700;
}

.desc-text {
  margin-top: 4px;
  color: #6a7564;
  font-size: 13px;
}

.meta-row {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-bottom: 18px;
}

.meta-pill {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 10px 14px;
  border-radius: 999px;
  color: #4f5d46;
  background: rgba(236, 239, 231, 0.96);
}

.strong-pill {
  font-weight: 700;
}

.content-panel {
  border-radius: 20px;
  padding: 22px;
  min-height: 220px;
  color: #334033;
  line-height: 1.9;
  background: rgba(255, 253, 248, 0.92);
  border: 1px solid #e5e9dd;
  word-break: break-all;
}

.thread-side-card {
  display: grid;
  gap: 16px;
}

.side-stat {
  min-height: 180px;
  border-radius: 18px;
  padding: 22px;
  color: #fff;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border: 1px solid rgba(193, 200, 183, 0.55);
}

.vivid-blue {
  background: linear-gradient(160deg, #7b8869, #8f9d7b);
}

.vivid-orange {
  background: linear-gradient(160deg, #96866c, #ab9a7f);
}

.side-icon {
  width: 46px;
  height: 46px;
  border-radius: 15px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.18);
  font-size: 20px;
}

.side-value {
  font-size: 30px;
  font-weight: 700;
}

.side-label {
  opacity: 0.9;
}

.reply-board {
  margin-bottom: 24px;
}

.comment-tree {
  display: grid;
  gap: 14px;
}

::v-deep .comment-node {
  display: grid;
  gap: 12px;
}

::v-deep .comment-children {
  display: grid;
  gap: 12px;
}

::v-deep .reply-card {
  display: flex;
  gap: 14px;
  padding: 18px;
  border-radius: 20px;
  background: rgba(255, 253, 248, 0.92);
  border: 1px solid #e5e9dd;
}

::v-deep .reply-avatar {
  width: 48px;
  height: 48px;
  border-radius: 16px;
  flex: 0 0 48px;
  color: #fffef9;
  background: linear-gradient(135deg, #8e9d79, #758465);
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
}

::v-deep .reply-body {
  min-width: 0;
  flex: 1;
}

::v-deep .reply-top {
  display: flex;
  flex-wrap: wrap;
  gap: 14px;
  align-items: center;
}

::v-deep .reply-name {
  color: #2f392b;
  font-weight: 700;
}

::v-deep .reply-time {
  color: #899286;
  font-size: 13px;
}

::v-deep .reply-content {
  margin-top: 10px;
  color: #445042;
  line-height: 1.8;
  word-break: break-word;
}

::v-deep .reply-actions {
  margin-top: 12px;
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
}

::v-deep .inline-btn {
  padding: 0;
  color: #6b7a5b;
}

::v-deep .delete-inline {
  color: #b46857;
}

.empty-box {
  min-height: 180px;
  border-radius: 22px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 12px;
  color: #6a7564;
  background: rgba(255, 253, 248, 0.88);
  border: 1px dashed #d7ddcc;
  font-size: 16px;
}

.empty-box i {
  font-size: 34px;
}

.closed-tip,
.reply-target {
  border-radius: 16px;
  padding: 14px 16px;
  color: #55624a;
  background: rgba(236, 239, 231, 0.96);
}

.closed-tip i {
  margin-right: 8px;
}

.closed-actions {
  margin-top: 18px;
}

.reply-form ::v-deep .el-form-item__label,
.add-update-preview ::v-deep .el-form-item__label {
  color: #55624a;
}

.reply-form ::v-deep .el-textarea__inner,
.add-update-preview ::v-deep .el-input__inner,
.add-update-preview ::v-deep .el-select .el-input__inner,
.add-update-preview ::v-deep .el-textarea__inner {
  border: 1px solid #c9d0c0;
  border-radius: 16px;
  background: #fffdf8;
  color: #334033;
}

.btn-row {
  margin-bottom: 0;
}

.send-btn,
.back-btn {
  border: none;
  border-radius: 14px;
  padding: 12px 20px;
}

.send-btn {
  color: #fffef9;
  background: linear-gradient(135deg, #839370, #6b7a5b);
}

.back-btn {
  color: #55664b;
  background: rgba(235, 238, 229, 0.96);
}

.single-action-panel {
  text-align: center;
}

.publish-page {
  display: grid;
  gap: 24px;
}

.publish-hero {
  padding: 30px;
  background:
    linear-gradient(135deg, rgba(205, 192, 168, 0.2), rgba(146, 161, 123, 0.18)),
    linear-gradient(180deg, rgba(250, 249, 245, 0.98), rgba(243, 245, 238, 0.96));
}

.publish-form-card {
  padding: 26px;
}

.add-update-preview ::v-deep .el-form-item__content {
  max-width: 820px;
}

@media (max-width: 1200px) {
  .thread-hero,
  .thread-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .forum-detail-page {
    padding: 12px;
  }

  .thread-hero,
  .thread-main-card,
  .thread-side-card,
  .reply-board,
  .reply-editor-panel,
  .publish-hero,
  .publish-form-card,
  .single-action-panel {
    padding: 16px;
  }

  .thread-hero-main h2,
  .publish-hero h2 {
    font-size: 24px;
  }

  .meta-row,
  ::v-deep .reply-top {
    flex-direction: column;
    align-items: flex-start;
  }
}
</style>
