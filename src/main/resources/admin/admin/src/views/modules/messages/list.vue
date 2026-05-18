<template>
  <div class="ai-chat-page">
    <section class="chat-shell">
      <div class="chat-hero">
        <div class="hero-copy">
          <div class="hero-badge">
            <i class="el-icon-service"></i>
            <span>{{ roleBadge }}</span>
          </div>
          <h2>{{ heroTitle }}</h2>
          <p>{{ heroDesc }}</p>
        </div>
        <div class="hero-side">
          <div class="side-card">
            <div class="side-label">累计问答</div>
            <div class="side-value">{{ chatList.length }}</div>
          </div>
          <div class="side-card">
            <div class="side-label">当前状态</div>
            <div class="side-value online">在线</div>
          </div>
        </div>
      </div>

      <div class="suggest-panel">
        <div class="panel-title">常用问题</div>
        <div class="suggest-list">
          <button
            v-for="item in presets"
            :key="item"
            class="suggest-chip"
            @click="usePreset(item)"
          >
            {{ item }}
          </button>
        </div>
      </div>

      <div class="chat-card">
        <div class="chat-stream" ref="chatStream" v-loading="loading">
          <div v-if="chatList.length" class="message-group">
            <template v-for="item in chatList">
              <div class="bubble-row user-row" :key="'ask-' + item.id">
                <div class="avatar user-avatar">
                  <i class="el-icon-user"></i>
                </div>
                <div class="bubble user-bubble">
                  <div class="bubble-name">{{ item.username || '我' }}</div>
                  <div class="bubble-content">{{ item.content }}</div>
                  <div class="bubble-time">{{ formatTime(item.addtime) }}</div>
                </div>
              </div>
              <div class="bubble-row ai-row" :key="'reply-' + item.id">
                <div class="avatar ai-avatar">
                  <i class="el-icon-cpu"></i>
                </div>
                <div class="bubble ai-bubble">
                  <div class="bubble-name">AI客服</div>
                  <div class="bubble-content">{{ item.reply || '正在生成回复...' }}</div>
                </div>
              </div>
            </template>
          </div>
          <div v-else class="empty-state">
            <i class="el-icon-chat-dot-round"></i>
            <div class="empty-title">还没有开始对话</div>
            <div class="empty-text">在下方输入问题，AI 客服会立即回复你。</div>
          </div>
        </div>

        <div class="composer">
          <el-input
            type="textarea"
            :rows="4"
            resize="none"
            v-model="question"
            placeholder="例如：宿舍晚上很吵怎么办？报修空调要走什么流程？"
            @keyup.ctrl.enter.native="sendMessage"
          ></el-input>
          <div class="composer-bar">
            <div class="composer-tip">支持 `Ctrl + Enter` 快速发送</div>
            <el-button type="primary" class="send-btn" :loading="sending" @click="sendMessage">
              发送咨询
            </el-button>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
      sending: false,
      question: "",
      chatList: [],
      roleName: "",
      presets: []
    };
  },
  created() {
    this.initRoleView();
    this.loadChatList();
  },
  computed: {
    roleBadge() {
      return this.roleName ? `${this.roleName}专属 AI 助手` : "24小时 AI 客服";
    },
    heroTitle() {
      if (this.roleName === "管理员") {
        return "管理员问题，随时问";
      }
      if (this.roleName === "宿管员") {
        return "宿管工作，随时问";
      }
      if (this.roleName === "学生") {
        return "宿舍生活问题，随时问";
      }
      return "宿舍问题，随时问";
    },
    heroDesc() {
      if (this.roleName === "管理员") {
        return "可咨询宿舍资源统筹、数据管理、角色权限、系统使用等问题，回答会按管理员视角给出。";
      }
      if (this.roleName === "宿管员") {
        return "可咨询宿舍分配、入住管理、卫生巡查、报修跟进、学生管理等问题，回答会按宿管员视角给出。";
      }
      if (this.roleName === "学生") {
        return "可咨询宿舍报修、噪音矛盾、水电费、请假、考勤、系统使用等问题，回答会按学生视角给出。";
      }
      return "可咨询宿舍报修、噪音矛盾、水电费、请假、考勤、系统使用等问题，聊天记录会自动保留。";
    }
  },
  methods: {
    initRoleView() {
      this.roleName = this.$storage.get("role") || "";
      if (this.roleName === "管理员") {
        this.presets = [
          "宿舍资源紧张时应该如何统筹分配",
          "管理员如何排查系统数据异常",
          "宿舍报修数据怎么统一跟进",
          "如何给不同角色分配合适权限",
          "系统菜单或功能异常如何处理"
        ];
        return;
      }
      if (this.roleName === "宿管员") {
        this.presets = [
          "学生宿舍分配时要重点核对什么",
          "宿舍晚上太吵了怎么处理更合适",
          "学生报修后宿管员怎么跟进",
          "卫生巡查发现问题后怎么处理",
          "遇到学生请假或晚归应该怎么登记"
        ];
        return;
      }
      if (this.roleName === "学生") {
        this.presets = [
          "宿舍晚上太吵了怎么处理",
          "宿舍设备坏了应该怎么报修",
          "水电费怎么查询和缴费",
          "请假申请要怎么提交",
          "系统功能出问题了怎么办"
        ];
        return;
      }
      this.presets = [
        "宿舍晚上太吵了怎么处理",
        "宿舍设备坏了应该怎么报修",
        "水电费怎么查询和缴费",
        "请假申请要怎么提交",
        "系统功能出问题了怎么办"
      ];
    },
    loadChatList() {
      this.loading = true;
      this.$http({
        url: "messages/chatList",
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.chatList = data.data || [];
          this.scrollToBottom();
        } else {
          this.chatList = [];
          this.$message.error(data.msg);
        }
        this.loading = false;
      }).catch(() => {
        this.loading = false;
      });
    },
    usePreset(text) {
      this.question = text;
    },
    sendMessage() {
      if (!this.question || !this.question.trim()) {
        this.$message.warning("请输入咨询内容");
        return;
      }
      this.sending = true;
      this.$http({
        url: "messages/ask",
        method: "post",
        data: {
          content: this.question.trim()
        }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.chatList.push(data.data);
          this.question = "";
          this.scrollToBottom();
          this.$message.success("AI客服已回复");
        } else {
          this.$message.error(data.msg);
        }
        this.sending = false;
      }).catch(() => {
        this.sending = false;
      });
    },
    scrollToBottom() {
      this.$nextTick(() => {
        const el = this.$refs.chatStream;
        if (el) {
          el.scrollTop = el.scrollHeight;
        }
      });
    },
    formatTime(value) {
      if (!value) {
        return "";
      }
      return String(value).replace("T", " ");
    }
  }
};
</script>

<style lang="scss" scoped>
.ai-chat-page {
  min-height: 100%;
  padding: 24px;
  background:
    radial-gradient(circle at top left, rgba(111, 127, 95, 0.08), transparent 24%),
    linear-gradient(180deg, rgba(241, 245, 249, 0.72) 0%, rgba(238, 243, 248, 0.42) 100%);
}

.chat-shell {
  max-width: 1280px;
  margin: 0 auto;
}

.chat-hero,
.suggest-panel,
.chat-card {
  border: 1px solid rgba(148, 163, 184, 0.16);
  border-radius: 22px;
  background: rgba(248, 250, 252, 0.92);
  box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06);
}

.chat-hero {
  display: flex;
  justify-content: space-between;
  gap: 24px;
  padding: 28px;
  color: #334155;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 14px;
  border-radius: 999px;
  background: rgba(227, 235, 218, 0.92);
  color: #55664b;
  font-size: 13px;
  margin-bottom: 16px;
}

.hero-copy h2 {
  margin: 0 0 10px;
  font-size: 34px;
  color: #0f172a;
}

.hero-copy p {
  margin: 0;
  max-width: 700px;
  color: #64748b;
  line-height: 1.8;
}

.hero-side {
  display: flex;
  gap: 14px;
}

.side-card {
  min-width: 140px;
  padding: 18px;
  border-radius: 18px;
  background: linear-gradient(180deg, #f2f4ec, #e6eadc);
  border: 1px solid rgba(148, 163, 184, 0.16);
}

.side-label {
  color: #64748b;
  font-size: 13px;
}

.side-value {
  margin-top: 10px;
  color: #0f172a;
  font-size: 28px;
  font-weight: 700;
}

.side-value.online {
  color: #55724c;
}

.suggest-panel {
  margin-top: 18px;
  padding: 20px 24px;
}

.panel-title {
  color: #3b4634;
  font-size: 15px;
  font-weight: 600;
  margin-bottom: 14px;
}

.suggest-list {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.suggest-chip {
  border: 0;
  border-radius: 999px;
  padding: 10px 16px;
  cursor: pointer;
  color: #334155;
  background: rgba(235, 238, 229, 0.96);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.suggest-chip:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 18px rgba(148, 163, 184, 0.18);
}

.chat-card {
  margin-top: 18px;
  padding: 22px;
}

.chat-stream {
  height: 520px;
  overflow-y: auto;
  padding-right: 8px;
}

.message-group {
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.bubble-row {
  display: flex;
  gap: 14px;
  align-items: flex-start;
}

.user-row {
  justify-content: flex-end;
}

.user-row .avatar {
  order: 2;
}

.user-row .bubble {
  order: 1;
}

.avatar {
  width: 44px;
  height: 44px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  flex-shrink: 0;
}

.user-avatar {
  color: #fff;
  background: linear-gradient(135deg, #7d8b6b, #6b7a5b);
}

.ai-avatar {
  color: #0f172a;
  background: linear-gradient(135deg, #eef2e5, #dfe7d1);
}

.bubble {
  max-width: calc(100% - 90px);
  padding: 16px 18px;
  border-radius: 18px;
  line-height: 1.8;
}

.user-bubble {
  border-top-right-radius: 8px;
  color: #f7fbff;
  background: linear-gradient(135deg, #1d4ed8, #0284c7);
}

.ai-bubble {
  border-top-left-radius: 8px;
  color: #334155;
  background: linear-gradient(180deg, rgba(248, 250, 252, 0.98), rgba(241, 245, 249, 0.96));
  border: 1px solid rgba(148, 163, 184, 0.16);
}

.bubble-name {
  font-size: 13px;
  font-weight: 600;
  margin-bottom: 8px;
  opacity: 0.92;
}

.bubble-content {
  white-space: pre-wrap;
  word-break: break-word;
}

.bubble-time {
  margin-top: 10px;
  font-size: 12px;
  opacity: 0.7;
}

.empty-state {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  color: #64748b;
}

.empty-state i {
  font-size: 48px;
  margin-bottom: 14px;
  color: #87966f;
}

.empty-title {
  font-size: 18px;
  font-weight: 600;
  color: #0f172a;
}

.empty-text {
  margin-top: 8px;
  font-size: 14px;
}

.composer {
  margin-top: 22px;
  padding: 18px;
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.72);
  border: 1px solid rgba(148, 163, 184, 0.16);
}

.composer ::v-deep .el-textarea__inner {
  border: 1px solid rgba(148, 163, 184, 0.24);
  border-radius: 16px;
  background: rgba(248, 250, 252, 0.96);
  color: #0f172a;
  padding: 16px 18px;
}

.composer-bar {
  margin-top: 14px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 16px;
}

.composer-tip {
  color: #64748b;
  font-size: 13px;
}

.send-btn {
  border: 0;
  border-radius: 999px;
  padding: 12px 28px;
  background: linear-gradient(135deg, #839370, #6b7a5b);
}

@media (max-width: 900px) {
  .ai-chat-page {
    padding: 14px;
  }

  .chat-hero {
    flex-direction: column;
  }

  .hero-side {
    width: 100%;
  }

  .side-card {
    flex: 1;
  }

  .chat-stream {
    height: 460px;
  }

  .composer-bar {
    flex-direction: column;
    align-items: stretch;
  }
}
</style>
