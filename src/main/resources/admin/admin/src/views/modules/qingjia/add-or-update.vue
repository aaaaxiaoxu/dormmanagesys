<template>
	<div class="addEdit-block" :style='{"padding":"30px 0 0 0"}' style="width: 100%;">
		<el-form
			:style='{"padding":"20px 0px 120px"}'
			class="add-update-preview"
			ref="ruleForm"
			:model="ruleForm"
			:rules="rules"
			label-width="140px"
		>
					<template >
					<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info'" label="请假类型">
						<el-select v-model="selectedLeaveType" placeholder="请选择请假类型" filterable clearable @change="onLeaveTypeChange">
							<el-option v-for="item in leaveTypeOptions" :key="item.type" :label="item.type" :value="item.type"></el-option>
						</el-select>
					</el-form-item>
					<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info' && selectedLeaveType" label="常用原因">
						<el-select v-model="selectedLeaveReason" placeholder="请选择常用原因" filterable clearable @change="onLeaveReasonChange">
							<el-option v-for="item in currentLeaveReasons" :key="item" :label="item" :value="item"></el-option>
						</el-select>
					</el-form-item>
					<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'"  label="标题" prop="biaoti">
						<el-input v-model="ruleForm.biaoti" placeholder="标题" clearable  :readonly="ro.biaoti"></el-input>
					</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="标题" prop="biaoti">
					<el-input v-model="ruleForm.biaoti" placeholder="标题" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'"  label="学生学号" prop="xueshengxuehao">
					<el-input v-model="ruleForm.xueshengxuehao" placeholder="学生学号" clearable  :readonly="ro.xueshengxuehao"></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="学生学号" prop="xueshengxuehao">
					<el-input v-model="ruleForm.xueshengxuehao" placeholder="学生学号" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'"  label="学生姓名" prop="xueshengxingming">
					<el-input v-model="ruleForm.xueshengxingming" placeholder="学生姓名" clearable  :readonly="ro.xueshengxingming"></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="学生姓名" prop="xueshengxingming">
					<el-input v-model="ruleForm.xueshengxingming" placeholder="学生姓名" readonly></el-input>
				</el-form-item>
				
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="date" v-if="type!='info'" label="离开日期" prop="qingjia1">
					<el-date-picker
					value-format="yyyy-MM-dd HH:mm:ss"
						v-model="ruleForm.qingjia1" 
						type="datetime"
						:readonly="ro.qingjia1"
						placeholder="离开日期"
					></el-date-picker> 
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-else-if="ruleForm.qingjia1" label="离开日期" prop="qingjia1">
					<el-input v-model="ruleForm.qingjia1" placeholder="离开日期" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="date" v-if="type!='info'" label="返回日期" prop="qingjia2">
					<el-date-picker
					value-format="yyyy-MM-dd HH:mm:ss"
						v-model="ruleForm.qingjia2" 
						type="datetime"
						:readonly="ro.qingjia2"
						placeholder="返回日期"
					></el-date-picker> 
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-else-if="ruleForm.qingjia1" label="返回日期" prop="qingjia2">
					<el-input v-model="ruleForm.qingjia2" placeholder="返回日期" readonly></el-input>
				</el-form-item>
			</template>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-if="type!='info'"  label="请假原因" prop="qingjiayuanyin">
					<editor 
						style="min-width: 200px; max-width: 600px;"
						v-model="ruleForm.qingjiayuanyin" 
						class="editor" 
						action="file/upload">
					</editor>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else-if="ruleForm.qingjiayuanyin" label="请假原因" prop="qingjiayuanyin">
                    <span :style='{"fontSize":"14px","lineHeight":"40px","color":"#333","fontWeight":"500","display":"inline-block"}' v-html="ruleForm.qingjiayuanyin"></span>
                </el-form-item>
			<el-form-item :style='{"padding":"0","margin":"0"}' class="btn">
				<el-button :style='{"border":"0","cursor":"pointer","padding":"0","margin":"0 20px 0 0","outline":"none","color":"rgba(255, 255, 255, 1)","borderRadius":"40px","background":"rgba(78, 106, 226, 1)","width":"128px","lineHeight":"40px","fontSize":"14px","height":"40px"}'  v-if="type!='info'" type="primary" class="btn-success" @click="onSubmit">提交</el-button>
				<el-button :style='{"border":"1px solid rgba(78, 106, 226, 1)","cursor":"pointer","padding":"0","margin":"0","outline":"none","color":"rgba(78, 106, 226, 1)","borderRadius":"40px","background":"rgba(255, 255, 255, 1)","width":"128px","lineHeight":"40px","fontSize":"14px","height":"40px"}' v-if="type!='info'" class="btn-close" @click="back()">取消</el-button>
				<el-button :style='{"border":"1px solid rgba(78, 106, 226, 1)","cursor":"pointer","padding":"0","margin":"0","outline":"none","color":"rgba(78, 106, 226, 1)","borderRadius":"40px","background":"rgba(255, 255, 255, 1)","width":"128px","lineHeight":"40px","fontSize":"14px","height":"40px"}' v-if="type=='info'" class="btn-close" @click="back()">返回</el-button>
			</el-form-item>
		</el-form>
    

  </div>
</template>
<script>
// 数字，邮件，手机，url，身份证校验
import { isNumber,isIntNumer,isEmail,isPhone, isMobile,isURL,checkIdCard } from "@/utils/validate";
export default {
	data() {
		let self = this
		var validateIdCard = (rule, value, callback) => {
			if(!value){
				callback();
			} else if (!checkIdCard(value)) {
				callback(new Error("请输入正确的身份证号码"));
			} else {
				callback();
			}
		};
		var validateUrl = (rule, value, callback) => {
			if(!value){
				callback();
			} else if (!isURL(value)) {
				callback(new Error("请输入正确的URL地址"));
			} else {
				callback();
			}
		};
		var validateMobile = (rule, value, callback) => {
			if(!value){
				callback();
			} else if (!isMobile(value)) {
				callback(new Error("请输入正确的手机号码"));
			} else {
				callback();
			}
		};
		var validatePhone = (rule, value, callback) => {
			if(!value){
				callback();
			} else if (!isPhone(value)) {
				callback(new Error("请输入正确的电话号码"));
			} else {
				callback();
			}
		};
		var validateEmail = (rule, value, callback) => {
			if(!value){
				callback();
			} else if (!isEmail(value)) {
				callback(new Error("请输入正确的邮箱地址"));
			} else {
				callback();
			}
		};
		var validateNumber = (rule, value, callback) => {
			if(!value){
				callback();
			} else if (!isNumber(value)) {
				callback(new Error("请输入数字"));
			} else {
				callback();
			}
		};
			var validateIntNumber = (rule, value, callback) => {
				if(!value){
					callback();
				} else if (!isIntNumer(value)) {
					callback(new Error("请输入整数"));
				} else {
					callback();
				}
			};
			var validateLeaveContent = (rule, value, callback) => {
				const text = String(value || "").replace(/<[^>]+>/g, "").replace(/&nbsp;/g, "").trim();
				if(!text){
					callback(new Error("请填写请假原因"));
				} else {
					callback();
				}
			};
			return {
				id: '',
				type: '',
				selectedLeaveType: '',
				selectedLeaveReason: '',
				leaveTypeOptions: [
					{ type: "病假", reasons: ["门诊就医", "复诊检查", "身体不适需休养", "住院或陪护"] },
					{ type: "事假", reasons: ["家庭事务", "证件办理", "校外面试", "个人紧急事务"] },
					{ type: "公假", reasons: ["学院活动", "竞赛训练", "实习实践", "志愿服务"] },
					{ type: "周末外出", reasons: ["回家", "探亲", "短途出行", "采购生活用品"] }
				],
				ro:{
				biaoti : false,
				xueshengxuehao : false,
				xueshengxingming : false,
				qingjia1 : false,
				qingjia2 : false,
				qingjiayuanyin : false,
				sfsh : false,
				shhf : false,
			},
			
			
			ruleForm: {
				biaoti: '',
				xueshengxuehao: '',
				xueshengxingming: '',
				qingjia1: '',
				qingjia2: '',
				qingjiayuanyin: '',
				shhf: '',
			},
		

			
				rules: {
					biaoti: [
						{ required: true, message: '请输入标题', trigger: 'blur' }
					],
					xueshengxuehao: [
						{ required: true, message: '学生学号不能为空', trigger: 'blur' }
					],
					xueshengxingming: [
						{ required: true, message: '学生姓名不能为空', trigger: 'blur' }
					],
					qingjia1: [
						{ required: true, message: '请选择离开日期', trigger: 'change' }
					],
					qingjia2: [
						{ required: true, message: '请选择返回日期', trigger: 'change' }
					],
					qingjiayuanyin: [
						{ validator: validateLeaveContent, trigger: 'blur' },
						{ validator: validateLeaveContent, trigger: 'change' }
					],
				sfsh: [
				],
				shhf: [
				],
			}
		};
	},
	props: ["parent"],
		computed: {
			currentLeaveReasons() {
				const option = this.leaveTypeOptions.find(item => item.type === this.selectedLeaveType);
				return option ? option.reasons : [];
			}
		},
    components: {
    },
		created() {
			this.ruleForm.qingjia1 = this.getCurDateTime();
			this.ruleForm.qingjia2 = this.getCurDateTime();
		},
		methods: {
			onLeaveTypeChange() {
				this.selectedLeaveReason = "";
				if (this.selectedLeaveType && !this.ruleForm.biaoti) {
					this.ruleForm.biaoti = `${this.selectedLeaveType}申请`;
				}
			},
			onLeaveReasonChange(reason) {
				if (!reason) {
					return;
				}
				this.ruleForm.biaoti = `${this.selectedLeaveType}-${reason}`;
				this.ruleForm.qingjiayuanyin = [
					`<p>请假类型：${this.selectedLeaveType}</p>`,
					`<p>请假原因：${reason}</p>`,
					`<p>离校时间：${this.ruleForm.qingjia1 || "待选择"}</p>`,
					`<p>返校时间：${this.ruleForm.qingjia2 || "待选择"}</p>`,
					`<p>补充说明：请填写外出去向、联系方式和安全承诺。</p>`
				].join("");
			},
				// 下载
		download(file){
			window.open(`${file}`)
		},
		// 初始化
		init(id,type) {
			this.id = id || '';
			this.type = type || '';
			if(this.id && (this.type=='info'||this.type=='else')){
				this.info(id);
			}else if(this.type=='logistics'){
				this.logistics=false;
				this.info(id);
			}else if(this.type=='cross'){
				var obj = this.$storage.getObj('crossObj');
				for (var o in obj){
						if(o=='biaoti'){
							this.ruleForm.biaoti = obj[o];
							this.ro.biaoti = true;
							continue;
						}
						if(o=='xueshengxuehao'){
							this.ruleForm.xueshengxuehao = obj[o];
							this.ro.xueshengxuehao = true;
							continue;
						}
						if(o=='xueshengxingming'){
							this.ruleForm.xueshengxingming = obj[o];
							this.ro.xueshengxingming = true;
							continue;
						}
						if(o=='qingjia1'){
							this.ruleForm.qingjia1 = obj[o];
							this.ro.qingjia1 = true;
							continue;
						}
						if(o=='qingjia2'){
							this.ruleForm.qingjia2 = obj[o];
							this.ro.qingjia2 = true;
							continue;
						}
						if(o=='qingjiayuanyin'){
							this.ruleForm.qingjiayuanyin = obj[o];
							this.ro.qingjiayuanyin = true;
							continue;
						}
				}
				











			}
			
			
			// 获取用户信息
			this.$http({
				url: `${this.$storage.get('sessionTable')}/session`,
				method: "get"
			}).then(({ data }) => {
				if (data && data.code === 0) {
					
					var json = data.data;
					if(((json.xueshengxuehao!=''&&json.xueshengxuehao) || json.xueshengxuehao==0) && this.$storage.get("role")!="管理员"){
						this.ruleForm.xueshengxuehao = json.xueshengxuehao
						this.ro.xueshengxuehao = true;
					}
					if(((json.xueshengxingming!=''&&json.xueshengxingming) || json.xueshengxingming==0) && this.$storage.get("role")!="管理员"){
						this.ruleForm.xueshengxingming = json.xueshengxingming
						this.ro.xueshengxingming = true;
					}
				} else {
					this.$message.error(data.msg);
				}
			});
			
			
		},
    // 多级联动参数

    info(id) {
      this.$http({
        url: `qingjia/info/${id}`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
        this.ruleForm = data.data;
        //解决前台上传图片后台不显示的问题
        let reg=new RegExp('../../../upload','g')//g代表全部
        this.ruleForm.qingjiayuanyin = this.ruleForm.qingjiayuanyin.replace(reg,'../../../dormmanagesys/upload');
        } else {
          this.$message.error(data.msg);
        }
      });
    },


    // 提交
    onSubmit() {























var objcross = this.$storage.getObj('crossObj');

      //更新跨表属性
       var crossuserid;
       var crossrefid;
       var crossoptnum;
       if(this.type=='cross'){
                var statusColumnName = this.$storage.get('statusColumnName');
                var statusColumnValue = this.$storage.get('statusColumnValue');
                if(statusColumnName!='') {
                        var obj = this.$storage.getObj('crossObj');
                       if(statusColumnName && !statusColumnName.startsWith("[")) {
                               for (var o in obj){
                                 if(o==statusColumnName){
                                   obj[o] = statusColumnValue;
                                 }
                               }
                               var table = this.$storage.get('crossTable');
                             this.$http({
                                 url: `${table}/update`,
                                 method: "post",
                                 data: obj
                               }).then(({ data }) => {});
                       } else {
                               crossuserid=this.$storage.get('userid');
                               crossrefid=obj['id'];
                               crossoptnum=this.$storage.get('statusColumnName');
                               crossoptnum=crossoptnum.replace(/\[/,"").replace(/\]/,"");
                        }
                }
        }
       this.$refs["ruleForm"].validate(valid => {
         if (valid) {
		 if(crossrefid && crossuserid) {
			 this.ruleForm.crossuserid = crossuserid;
			 this.ruleForm.crossrefid = crossrefid;
			let params = { 
				page: 1, 
				limit: 10, 
				crossuserid:this.ruleForm.crossuserid,
				crossrefid:this.ruleForm.crossrefid,
			} 
			this.$http({ 
				url: "qingjia/page", 
				method: "get", 
				params: params 
			}).then(({ 
				data 
			}) => { 
				if (data && data.code === 0) { 
				       if(data.data.total>=crossoptnum) {
					     this.$message.error(this.$storage.get('tips'));
					       return false;
				       } else {
					 this.$http({
					   url: `qingjia/${!this.ruleForm.id ? "save" : "update"}`,
					   method: "post",
					   data: this.ruleForm
					 }).then(({ data }) => {
					   if (data && data.code === 0) {
					     this.$message({
					       message: "操作成功",
					       type: "success",
					       duration: 1500,
					       onClose: () => {
						 this.parent.showFlag = true;
						 this.parent.addOrUpdateFlag = false;
						 this.parent.qingjiaCrossAddOrUpdateFlag = false;
						 this.parent.search();
						 this.parent.contentStyleChange();
					       }
					     });
					   } else {
					     this.$message.error(data.msg);
					   }
					 });

				       }
				} else { 
				} 
			});
		 } else {
			 this.$http({
			   url: `qingjia/${!this.ruleForm.id ? "save" : "update"}`,
			   method: "post",
			   data: this.ruleForm
			 }).then(({ data }) => {
			   if (data && data.code === 0) {
			     this.$message({
			       message: "操作成功",
			       type: "success",
			       duration: 1500,
			       onClose: () => {
				 this.parent.showFlag = true;
				 this.parent.addOrUpdateFlag = false;
				 this.parent.qingjiaCrossAddOrUpdateFlag = false;
				 this.parent.search();
				 this.parent.contentStyleChange();
			       }
			     });
			   } else {
			     this.$message.error(data.msg);
			   }
			 });
		 }
         }
       });
    },
    // 获取uuid
    getUUID () {
      return new Date().getTime();
    },
    // 返回
    back() {
      this.parent.showFlag = true;
      this.parent.addOrUpdateFlag = false;
      this.parent.qingjiaCrossAddOrUpdateFlag = false;
      this.parent.contentStyleChange();
    },
  }
};
</script>
<style lang="scss" scoped>
	.amap-wrapper {
		width: 100%;
		height: 500px;
	}
	
	.search-box {
		position: absolute;
	}
	
	.el-date-editor.el-input {
		width: auto;
	}
	
	.add-update-preview .el-form-item  ::v-deep .el-form-item__label {
	  	  padding: 0 10px 0 0;
	  	  color: #333;
	  	  width: 140px;
	  	  font-size: 14px;
	  	  line-height: 40px;
	  	  text-align: right;
	  	}
	
	.add-update-preview .el-form-item  ::v-deep .el-form-item__content {
	  margin-left: 140px;
	}
	
	.add-update-preview .el-input  ::v-deep .el-input__inner {
	  	  border: 2px solid #797979;
	  	  border-radius: 4px;
	  	  padding: 0 12px;
	  	  outline: none;
	  	  color: #333;
	  	  width: 300px;
	  	  font-size: 14px;
	  	  height: 40px;
	  	}
	
	.add-update-preview .el-select  ::v-deep .el-input__inner {
	  	  border: 2px solid #797979;
	  	  border-radius: 4px;
	  	  padding: 0 10px;
	  	  outline: none;
	  	  color: #333;
	  	  width: 200px;
	  	  font-size: 14px;
	  	  height: 40px;
	  	}
	
	.add-update-preview .el-date-editor  ::v-deep .el-input__inner {
	  	  border: 2px solid #797979;
	  	  border-radius: 4px;
	  	  padding: 0 10px 0 30px;
	  	  outline: none;
	  	  color: #333;
	  	  width: 200px;
	  	  font-size: 14px;
	  	  height: 40px;
	  	}
	
	.add-update-preview  ::v-deep .el-upload--picture-card {
		background: transparent;
		border: 0;
		border-radius: 0;
		width: auto;
		height: auto;
		line-height: initial;
		vertical-align: middle;
	}
	
	.add-update-preview  ::v-deep .upload .upload-img {
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
	
	.add-update-preview  ::v-deep .el-upload-list .el-upload-list__item {
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
	
	.add-update-preview  ::v-deep .el-upload .el-icon-plus {
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
	
	.add-update-preview .el-textarea  ::v-deep .el-textarea__inner {
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
