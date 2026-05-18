<template>
  <div :style='{ "padding": "30px 0 0 0" }'>
    <el-form :style='{ "padding": "20px 0px 120px" }' class="add-update-preview" ref="ruleForm" :model="ruleForm"
      label-width="140px">
      <el-row>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'xuesheng'"
          label="学生学号" prop="xueshengxuehao">
          <el-input v-model="ruleForm.xueshengxuehao" readonly placeholder="学生学号" clearable></el-input>
        </el-form-item>

        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'xuesheng'"
          label="学生姓名" prop="xueshengxingming">
          <el-input v-model="ruleForm.xueshengxingming" placeholder="学生姓名" clearable></el-input>
        </el-form-item>

        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'xuesheng'"
          label="性别" prop="xingbie">
          <el-select v-model="ruleForm.xingbie" placeholder="请选择性别">
            <el-option v-for="(item, index) in xingbieOptions" v-bind:key="index" :label="item" :value="item">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'xuesheng'"
          label="头像" prop="touxiang">
          <file-upload tip="点击上传头像" action="file/upload" :limit="3" :multiple="true"
            :fileUrls="ruleForm.touxiang ? ruleForm.touxiang : ''" @change="touxiangUploadChange"></file-upload>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'xuesheng'"
          label="学生电话" prop="xueshengdianhua">
          <el-input v-model="ruleForm.xueshengdianhua" placeholder="学生电话" clearable></el-input>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'xuesheng'"
          label="班级" prop="banji">
          <el-input v-model="ruleForm.banji" placeholder="班级" clearable></el-input>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'xuesheng'"
          label="专业" prop="zhuanye">
          <el-input v-model="ruleForm.zhuanye" placeholder="专业" clearable></el-input>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'xuesheng'"
          label="宿舍楼栋">
          <el-input v-model="studentDorm.susheloudong" readonly placeholder="暂未分配宿舍"></el-input>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'xuesheng'"
          label="宿舍号">
          <el-input v-model="studentDorm.fangjianhao" readonly placeholder="暂未分配宿舍"></el-input>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'users'"
          label="用户名" prop="username">
          <el-input v-model="ruleForm.username" placeholder="用户名"></el-input>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'suguan'"
          label="宿管员账号" prop="suguan">
          <el-input v-model="ruleForm.zhanghao" readonly placeholder="账号" clearable></el-input>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'suguan'"
          label="宿管员姓名" prop="suguanxingming">
          <el-input v-model="ruleForm.suguanxingming" placeholder="宿管员姓名" clearable></el-input>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'suguan'"
          label="性别" prop="xingbie">
          <el-select v-model="ruleForm.xingbie" placeholder="请选择性别">
            <el-option v-for="(item, index) in xingbieOptions" v-bind:key="index" :label="item" :value="item">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'suguan'"
          label="头像" prop="touxiang">
          <file-upload tip="点击上传头像" action="file/upload" :limit="3" :multiple="true"
            :fileUrls="ruleForm.touxiang ? ruleForm.touxiang : ''" @change="touxiangUploadChange"></file-upload>
        </el-form-item>
        <el-form-item :style='{ "width": "100%", "margin": "0 0 20px 0", "display": "inline-block" }' v-if="flag == 'suguan'"
          label="电话" prop="dianhua">
          <el-input v-model="ruleForm.dianhua" placeholder="电话" clearable></el-input>
        </el-form-item>

        <el-form-item :style='{ "padding": "0", "margin": "0" }'>
          <el-button
            :style='{ "border": "0", "cursor": "pointer", "padding": "0", "margin": "0 20px 0 0", "outline": "none", "color": "rgba(255, 255, 255, 1)", "borderRadius": "40px", "background": "rgba(78, 106, 226, 1)", "width": "128px", "lineHeight": "40px", "fontSize": "14px", "height": "40px" }'
            type="primary" @click="onUpdateHandler">修 改</el-button>
          <el-button
            v-if="flag == 'xuesheng'"
            :style='{ "border": "0", "cursor": "pointer", "padding": "0", "margin": "0", "outline": "none", "color": "rgba(255, 255, 255, 1)", "borderRadius": "40px", "background": "rgba(121, 139, 121, 1)", "width": "128px", "lineHeight": "40px", "fontSize": "14px", "height": "40px" }'
            type="primary" @click="registerFaceHandler">录入人脸</el-button>
        </el-form-item>
      </el-row>
    </el-form>
    <imgAdd ref="faceImgAdd" @imgChange="onFaceRegisterChange"></imgAdd>
  </div>
</template>
<script>
import imgAdd from "@/components/common/img";
// 数字，邮件，手机，url，身份证校验
import { isNumber, isIntNumer, isEmail, isMobile, isPhone, isURL, checkIdCard } from "@/utils/validate";

export default {
  components: {
    imgAdd,
  },
  data() {
    return {
      ruleForm: {},
      studentDorm: {
        susheloudong: '',
        fangjianhao: '',
      },
      flag: '',
      usersFlag: false,
      xingbieOptions: [],
    };
  },
  mounted() {
    var table = this.$storage.get("sessionTable");
    this.flag = table;
    this.$http({
      url: `${this.$storage.get("sessionTable")}/session`,
      method: "get"
    }).then(({ data }) => {
      if (data && data.code === 0) {
        this.ruleForm = data.data;
        if (this.flag === 'xuesheng' && this.ruleForm.xueshengxuehao) {
          this.loadStudentDorm();
        }
      } else {
        this.$message.error(data.msg);
      }
    });
    this.xingbieOptions = "男,女".split(',')
  },
  methods: {
    normalizeUploadPath(path) {
      if (!path) {
        return '';
      }
      return String(path)
        .replace(new RegExp(this.$base.url, "g"), "")
        .replace(/^\/+/, '')
        .replace(/^upload\//, '');
    },
    touxiangUploadChange(fileUrls) {
      this.ruleForm.touxiang = fileUrls;
    },
    registerFaceHandler() {
      if (this.flag !== 'xuesheng') {
        return;
      }
      this.$refs.faceImgAdd.onTake();
    },
    onFaceRegisterChange(fileName) {
      const face = this.normalizeUploadPath(fileName);
      if (!face) {
        this.$message.error("未获取到人脸照片，请重新拍照");
        return;
      }
      this.$http({
        url: `registerFace`,
        method: "post",
        params: {
          face,
        }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.$message({
            message: "人脸录入成功",
            type: "success",
            duration: 1500
          });
        } else {
          this.$message.error((data && data.msg) || "人脸录入失败");
        }
      });
    },
    loadStudentDorm() {
      this.$http({
        url: `sushefenpei/list`,
        method: "get",
        params: {
          page: 1,
          limit: 1,
          xueshengxuehao: this.ruleForm.xueshengxuehao
        }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          const dormInfo = (data.data.list && data.data.list.length) ? data.data.list[0] : {};
          this.studentDorm.susheloudong = dormInfo.susheloudong || '';
          this.studentDorm.fangjianhao = dormInfo.fangjianhao || '';
        }
      });
    },
    onUpdateHandler() {
      if ((!this.ruleForm.xueshengxuehao) && 'xuesheng' == this.flag) {
        this.$message.error('学生学号不能为空');
        return
      }
      if ((!this.ruleForm.mima) && 'xuesheng' == this.flag) {
        this.$message.error('密码不能为空');
        return
      }
      if ((!this.ruleForm.xueshengxingming) && 'xuesheng' == this.flag) {
        this.$message.error('学生姓名不能为空');
        return
      }
      if (this.ruleForm.touxiang != null) {
        this.ruleForm.touxiang = this.ruleForm.touxiang.replace(new RegExp(this.$base.url, "g"), "");
      }
      if ('xuesheng' == this.flag && this.ruleForm.xueshengdianhua && (!isMobile(this.ruleForm.xueshengdianhua))) {
        this.$message.error(`学生电话应输入手机格式`);
        return
      }
            if ((!this.ruleForm.xueshengxuehao) && 'xuesheng' == this.flag) {
        this.$message.error('学生学号不能为空');
        return
      }
      if ((!this.ruleForm.mima) && 'xuesheng' == this.flag) {
        this.$message.error('密码不能为空');
        return
      }
      if ((!this.ruleForm.xueshengxingming) && 'xuesheng' == this.flag) {
        this.$message.error('学生姓名不能为空');
        return
      }
      if (this.ruleForm.touxiang != null) {
        this.ruleForm.touxiang = this.ruleForm.touxiang.replace(new RegExp(this.$base.url, "g"), "");
      }
      if ('xuesheng' == this.flag && this.ruleForm.xueshengdianhua && (!isMobile(this.ruleForm.xueshengdianhua))) {
        this.$message.error(`学生电话应输入手机格式`);
        return
      }

      if ((!this.ruleForm.zhanghao) && 'suguan' == this.flag) {
        this.$message.error('宿管员账号不能为空');
        return
      }
      if ((!this.ruleForm.mima) && 'suguan' == this.flag) {
        this.$message.error('密码不能为空');
        return
      }
      if ((!this.ruleForm.suguanxingming) && 'suguan' == this.flag) {
        this.$message.error('宿管员姓名不能为空');
        return
      }
      if (this.ruleForm.touxiang != null) {
        this.ruleForm.touxiang = this.ruleForm.touxiang.replace(new RegExp(this.$base.url, "g"), "");
      }
      if ('suguan' == this.flag && this.ruleForm.dianhua && (!isMobile(this.ruleForm.dianhua))) {
        this.$message.error(`宿管员电话应输入手机格式`);
        return
      }

      if ('users' == this.flag && this.ruleForm.username.trim().length < 1) {
        this.$message.error(`用户名不能为空`);
        return
      }
      this.$http({
        url: `${this.$storage.get("sessionTable")}/update`,
        method: "post",
        data: this.ruleForm
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.$message({
            message: "修改信息成功",
            type: "success",
            duration: 1500,
            onClose: () => {
            }
          });
        } else {
          this.$message.error(data.msg);
        }
      });
    }
  }
};
</script>
<style lang="scss" scoped>
.el-date-editor.el-input {
  width: auto;
}

.add-update-preview .el-form-item ::v-deep .el-form-item__label {
  padding: 0 10px 0 0;
  color: #333;
  width: 140px;
  font-size: 14px;
  line-height: 40px;
  text-align: right;
}

.add-update-preview .el-form-item ::v-deep .el-form-item__content {
  margin-left: 140px;
}

.add-update-preview .el-input ::v-deep .el-input__inner {
  border: 2px solid #797979;
  border-radius: 4px;
  padding: 0 12px;
  outline: none;
  color: #333;
  width: 300px;
  font-size: 14px;
  height: 40px;
}

.add-update-preview .el-select ::v-deep .el-input__inner {
  border: 2px solid #797979;
  border-radius: 4px;
  padding: 0 10px;
  outline: none;
  color: #333;
  width: 200px;
  font-size: 14px;
  height: 40px;
}

.add-update-preview .el-date-editor ::v-deep .el-input__inner {
  border: 2px solid #797979;
  border-radius: 4px;
  padding: 0 10px 0 30px;
  outline: none;
  color: #333;
  width: 200px;
  font-size: 14px;
  height: 40px;
}

.add-update-preview ::v-deep .el-upload--picture-card {
  background: transparent;
  border: 0;
  border-radius: 0;
  width: auto;
  height: auto;
  line-height: initial;
  vertical-align: middle;
}

.add-update-preview ::v-deep .el-upload-list .el-upload-list__item {
  border: 2px dashed #797979;
  cursor: pointer;
  border-radius: 6px;
  color: #797979;
  width: 150px;
  font-size: 32px;
  line-height: 150px;
  text-align: center;
  height: 150px;
}

.add-update-preview ::v-deep .el-upload .el-icon-plus {
  border: 2px dashed #797979;
  cursor: pointer;
  border-radius: 6px;
  color: #797979;
  width: 150px;
  font-size: 32px;
  line-height: 150px;
  text-align: center;
  height: 150px;
}

.add-update-preview .el-textarea ::v-deep .el-textarea__inner {
  border: 2px solid #797979;
  border-radius: 4px;
  padding: 12px;
  outline: none;
  color: #333;
  width: 400px;
  font-size: 14px;
  height: 120px;
}
</style>
