
<template>
  <div class="login-page">
    <div class="login-shell">
      <section class="login-brand">
        <div class="brand-badge">
          <i class="el-icon-office-building"></i>
          校园住宿服务平台
        </div>
        <h1>宿舍管理系统</h1>
        <p>
          统一处理宿舍分配、公告通知、论坛交流、维修报修、考勤和 AI 客服，
          让学生、宿管和管理员协同更顺畅。
        </p>
        <div class="brand-points">
          <div class="point-card">
            <i class="el-icon-s-home"></i>
            <span>宿舍事务统一管理</span>
          </div>
          <div class="point-card">
            <i class="el-icon-chat-dot-round"></i>
            <span>问题反馈快速流转</span>
          </div>
          <div class="point-card">
            <i class="el-icon-data-analysis"></i>
            <span>数据看板直观展示</span>
          </div>
        </div>
      </section>

      <section class="login-panel">
        <div class="panel-head">
          <div class="panel-title">欢迎登录</div>
          <div class="panel-subtitle">请输入账号信息进入系统后台</div>
        </div>

        <el-form class="login-form-card" @submit.native.prevent>
          <div v-if="loginType == 1" class="field-block">
            <label class="field-label">用户名</label>
            <div class="input-wrap">
              <i class="el-icon-user"></i>
              <input
                class="login-input"
                placeholder="请输入用户名"
                name="username"
                type="text"
                v-model="rulesForm.username"
              >
            </div>
          </div>

          <div v-if="loginType == 1" class="field-block">
            <label class="field-label">密码</label>
            <div class="input-wrap">
              <i class="el-icon-lock"></i>
              <input
                class="login-input"
                placeholder="请输入密码"
                name="password"
                type="password"
                v-model="rulesForm.password"
              >
            </div>
          </div>

          <div v-if="roles.length > 1" class="role-panel" prop="loginInRole">
            <div class="role-title">请选择登录角色</div>
            <el-radio-group v-model="rulesForm.role" class="role-group">
              <el-radio
                v-for="item in roles"
                :key="item.roleName"
                :label="item.roleName"
              >
                {{ item.roleName }}
              </el-radio>
            </el-radio-group>
          </div>

          <el-button
            v-if="loginType == 1"
            type="primary"
            @click="login()"
            class="loginInBt submit-btn"
          >
            登录系统
          </el-button>
        </el-form>
      </section>
    </div>
  </div>
</template>
<script>
import menu from "@/utils/menu";
export default {
  data() {
    return {
      baseUrl: this.$base.url,
      loginType: 1,
      rulesForm: {
        username: "",
        password: "",
        role: "",
        code: "",
      },
      menus: [],
      roles: [],
      tableName: "",
      codes: [{
        num: 1,
        color: '#000',
        rotate: '10deg',
        size: '16px'
      }, {
        num: 2,
        color: '#000',
        rotate: '10deg',
        size: '16px'
      }, {
        num: 3,
        color: '#000',
        rotate: '10deg',
        size: '16px'
      }, {
        num: 4,
        color: '#000',
        rotate: '10deg',
        size: '16px'
      }],
    };
  },
  mounted() {
    let menus = menu.list();
    this.menus = menus;

    for (let i = 0; i < this.menus.length; i++) {
      if (this.menus[i].hasBackLogin == '是') {
        this.roles.push(this.menus[i]);
      }
    }
  },
  created() {
  },
  destroyed() {
  },
  components: {
  },
  methods: {
    register(tableName) {
      this.$storage.set("loginTable", tableName);
      this.$storage.set("pageFlag", "register");
      this.$router.push({ path: '/register' });
    },
    login() {
      let code = '';
      for (let i in this.codes) {
        code += this.codes[i].num;
      }

      if (!this.rulesForm.username) {
        this.$message.error("请输入用户名");
        return;
      }
      if (!this.rulesForm.password) {
        this.$message.error("请输入密码");
        return;
      }
      if (this.roles.length > 1) {
        if (!this.rulesForm.role) {
          this.$message.error("请选择角色");
          return;
        }

        let menus = this.menus;
        for (let i = 0; i < menus.length; i++) {
          if (menus[i].roleName == this.rulesForm.role) {
            this.tableName = menus[i].tableName;
          }
        }
      } else {
        this.tableName = this.roles[0].tableName;
        this.rulesForm.role = this.roles[0].roleName;
      }

      this.$http({
        url: `${this.tableName}/login?username=${this.rulesForm.username}&password=${this.rulesForm.password}`,
        method: "post"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.$storage.set("Token", data.token);
          this.$storage.set("role", this.rulesForm.role);
          this.$storage.set("sessionTable", this.tableName);
          this.$storage.set("adminName", this.rulesForm.username);
          this.$router.replace({ path: "/index/" });
        } else {
          this.$message.error(data.msg);
        }
      });
    },
  }
};
</script>

<style lang="scss" scoped>
.login-page {
  min-height: 100vh;
  padding: 28px;
  display: flex;
  align-items: center;
  justify-content: center;
  background:
    radial-gradient(circle at top left, rgba(143, 158, 119, 0.18), transparent 24%),
    radial-gradient(circle at bottom right, rgba(198, 184, 156, 0.18), transparent 26%),
    linear-gradient(135deg, #eef1ea 0%, #e5e9e1 48%, #edf1e8 100%);
}

.login-shell {
  width: min(1180px, 100%);
  min-height: 680px;
  display: grid;
  grid-template-columns: 1.1fr 0.9fr;
  border-radius: 30px;
  overflow: hidden;
  border: 1px solid rgba(197, 205, 188, 0.9);
  box-shadow: 0 24px 60px rgba(61, 70, 52, 0.12);
  background: rgba(250, 249, 245, 0.88);
  backdrop-filter: blur(12px);
}

.login-brand {
  padding: 56px 52px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  background:
    radial-gradient(circle at top left, rgba(132, 150, 110, 0.2), transparent 24%),
    linear-gradient(160deg, #20291d 0%, #2f392c 52%, #3c4736 100%);
  color: #f7f8f4;
}

.brand-badge {
  width: fit-content;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 10px 16px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.12);
  color: #e6eddc;
  font-size: 13px;
  letter-spacing: 0.04em;
}

.login-brand h1 {
  margin: 22px 0 16px;
  font-size: 42px;
  line-height: 1.2;
  letter-spacing: 0.02em;
}

.login-brand p {
  margin: 0;
  max-width: 520px;
  color: rgba(233, 238, 227, 0.8);
  line-height: 1.9;
  font-size: 15px;
}

.brand-points {
  margin-top: 36px;
  display: grid;
  grid-template-columns: 1fr;
  gap: 14px;
}

.point-card {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 16px 18px;
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.06);
  color: #f4f7ef;
}

.point-card i {
  width: 38px;
  height: 38px;
  border-radius: 12px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: rgba(233, 239, 224, 0.14);
}

.login-panel {
  padding: 56px 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  background: linear-gradient(180deg, rgba(250, 249, 245, 0.96), rgba(243, 245, 238, 0.98));
}

.panel-head {
  margin-bottom: 30px;
}

.panel-title {
  color: #273123;
  font-size: 34px;
  font-weight: 700;
  line-height: 1.2;
}

.panel-subtitle {
  margin-top: 10px;
  color: #6c7766;
  font-size: 14px;
}

.login-form-card {
  padding: 28px;
  border-radius: 24px;
  background: rgba(255, 255, 255, 0.72);
  border: 1px solid rgba(208, 214, 198, 0.92);
  box-shadow: 0 14px 34px rgba(61, 70, 52, 0.07);
}

.field-block + .field-block,
.role-panel {
  margin-top: 18px;
}

.field-label,
.role-title {
  display: block;
  margin-bottom: 10px;
  color: #4f5d46;
  font-size: 14px;
  font-weight: 600;
}

.input-wrap {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 0 16px;
  height: 52px;
  border-radius: 16px;
  border: 1px solid #c8cfbe;
  background: #fffdf8;
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.input-wrap:focus-within {
  border-color: #87966f;
  box-shadow: 0 0 0 3px rgba(135, 150, 111, 0.12);
}

.input-wrap i {
  color: #879174;
  font-size: 18px;
}

.login-input {
  width: 100%;
  height: 100%;
  border: 0;
  outline: none;
  background: transparent;
  color: #334033;
  font-size: 15px;
}

.login-input::placeholder {
  color: #9aa294;
}

.role-panel {
  padding: 16px 18px;
  border-radius: 18px;
  background: #f6f7f2;
  border: 1px solid #dde2d4;
}

.role-group {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
}

.role-panel ::v-deep .el-radio {
  margin-right: 0;
}

.role-panel ::v-deep .el-radio__input .el-radio__inner {
  background: transparent;
  border-color: #8c977f;
}

.role-panel ::v-deep .el-radio__input.is-checked .el-radio__inner {
  background: #6f7f5f;
  border-color: #6f7f5f;
}

.role-panel ::v-deep .el-radio__label {
  color: #5f6b57;
}

.role-panel ::v-deep .el-radio__input.is-checked + .el-radio__label {
  color: #516146;
}

.submit-btn {
  width: 100%;
  height: 52px;
  margin-top: 24px;
  border: 0;
  border-radius: 16px;
  font-size: 17px;
  font-weight: 700;
  letter-spacing: 0.04em;
  background: linear-gradient(135deg, #839370, #6b7a5b);
}

.submit-btn:hover,
.submit-btn:focus {
  background: linear-gradient(135deg, #7a8968, #627052);
}

@media (max-width: 980px) {
  .login-page {
    padding: 14px;
  }

  .login-shell {
    grid-template-columns: 1fr;
  }

  .login-brand,
  .login-panel {
    padding: 30px 22px;
  }

  .login-brand h1 {
    font-size: 30px;
  }

  .panel-title {
    font-size: 28px;
  }

  .login-form-card {
    padding: 20px;
  }
}
</style>
