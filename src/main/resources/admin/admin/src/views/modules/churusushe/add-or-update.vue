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
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info' && !ruleForm.id && $storage.get('role')!='学生'" label="选择学生" prop="selectedAllocationNo">
					<el-select v-model="ruleForm.selectedAllocationNo" placeholder="请选择学生" filterable @change="onAllocationChange">
						<el-option
							v-for="item in allocationOptions"
							:key="item.value"
							:label="item.label"
							:value="item.value">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'"  label="宿舍名称" prop="sushemingcheng">
					<el-input v-model="ruleForm.sushemingcheng" placeholder="宿舍名称" clearable  :readonly="ro.sushemingcheng"></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="宿舍名称" prop="sushemingcheng">
					<el-input v-model="ruleForm.sushemingcheng" placeholder="宿舍名称" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'"  label="宿舍类型" prop="susheleixing">
					<el-input v-model="ruleForm.susheleixing" placeholder="宿舍类型" clearable  :readonly="ro.susheleixing"></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="宿舍类型" prop="susheleixing">
					<el-input v-model="ruleForm.susheleixing" placeholder="宿舍类型" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'"  label="宿舍楼栋" prop="susheloudong">
					<el-input v-model="ruleForm.susheloudong" placeholder="宿舍楼栋" clearable  :readonly="ro.susheloudong"></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="宿舍楼栋" prop="susheloudong">
					<el-input v-model="ruleForm.susheloudong" placeholder="宿舍楼栋" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'"  label="房间号" prop="fangjianhao">
					<el-input v-model="ruleForm.fangjianhao" placeholder="房间号" clearable  :readonly="ro.fangjianhao"></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="房间号" prop="fangjianhao">
					<el-input v-model="ruleForm.fangjianhao" placeholder="房间号" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info'" label="通行类型" prop="churuleixing">
					<el-select :disabled="ro.churuleixing" v-model="ruleForm.churuleixing" placeholder="请先选择出宿或入宿">
						<el-option v-for="item in churuleixingOptions" :key="item" :label="item" :value="item"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="通行类型" prop="churuleixing">
					<el-input v-model="ruleForm.churuleixing" placeholder="通行类型" readonly></el-input>
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
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="date" v-if="type!='info'" label="出入时间" prop="churushijian">
					<el-date-picker
						value-format="yyyy-MM-dd HH:mm:ss"
						v-model="ruleForm.churushijian" 
						type="datetime"
						:readonly="ro.churushijian"
						placeholder="出入时间"
					></el-date-picker>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-else-if="ruleForm.churushijian" label="出入时间" prop="churushijian">
					<el-input v-model="ruleForm.churushijian" placeholder="出入时间" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="upload" v-if="type!='info' && !ro.xiangpian" label="相片" prop="xiangpian">
                    <el-image v-if="ruleForm.xiangpian" :src="ruleForm.xiangpian?$base.url + ruleForm.xiangpian:''" style="width:150px;height:150px;"></el-image>
                    <el-button @click="imgAddClick">人脸识别</el-button>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="upload" v-else-if="ruleForm.xiangpian" label="相片" prop="xiangpian">
					<img v-if="ruleForm.xiangpian.substring(0,4)=='http'" class="upload-img" style="margin-right:20px;" v-bind:key="index" :src="ruleForm.xiangpian.split(',')[0]" width="100" height="100">
					<img v-else class="upload-img" style="margin-right:20px;" v-bind:key="index" v-for="(item,index) in ruleForm.xiangpian.split(',')" :src="$base.url+item" width="100" height="100">
				</el-form-item>
			</template>
			<el-form-item :style='{"padding":"0","margin":"0"}' class="btn">
				<el-button :style='{"border":"0","cursor":"pointer","padding":"0","margin":"0 20px 0 0","outline":"none","color":"rgba(255, 255, 255, 1)","borderRadius":"40px","background":"rgba(78, 106, 226, 1)","width":"128px","lineHeight":"40px","fontSize":"14px","height":"40px"}' v-show="!faceMatchFlag" v-if="type!='info'" type="primary" class="btn-success" @click="faceMatchHandle">人脸校验</el-button>
				<el-button :style='{"border":"0","cursor":"pointer","padding":"0","margin":"0 20px 0 0","outline":"none","color":"rgba(255, 255, 255, 1)","borderRadius":"40px","background":"rgba(78, 106, 226, 1)","width":"128px","lineHeight":"40px","fontSize":"14px","height":"40px"}' v-show="faceMatchFlag" v-if="type!='info'" type="primary" class="btn-success" @click="onSubmit">提交</el-button>
				<el-button :style='{"border":"1px solid rgba(78, 106, 226, 1)","cursor":"pointer","padding":"0","margin":"0","outline":"none","color":"rgba(78, 106, 226, 1)","borderRadius":"40px","background":"rgba(255, 255, 255, 1)","width":"128px","lineHeight":"40px","fontSize":"14px","height":"40px"}' v-if="type!='info'" class="btn-close" @click="back()">取消</el-button>
				<el-button :style='{"border":"1px solid rgba(78, 106, 226, 1)","cursor":"pointer","padding":"0","margin":"0","outline":"none","color":"rgba(78, 106, 226, 1)","borderRadius":"40px","background":"rgba(255, 255, 255, 1)","width":"128px","lineHeight":"40px","fontSize":"14px","height":"40px"}' v-if="type=='info'" class="btn-close" @click="back()">返回</el-button>
			</el-form-item>
		</el-form>
    

    <imgAdd ref="imgAdd" @imgChange="imgChange"></imgAdd>
  </div>
</template>
<script>
import imgAdd from "@/components/common/img";
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
		var validateAllocationRequired = (rule, value, callback) => {
			if (self.ruleForm.id || self.$storage.get('role') === '学生') {
				callback();
				return;
			}
			if (!value) {
				callback(new Error("请选择学生"));
				return;
			}
			callback();
		};
		return {
			id: '',
			type: '',
			allocationOptions: [],
			allocationOptionsRaw: [],
			
			userface : '',
			faceMatchFlag: false,
			
			ro:{
				sushemingcheng : true,
				susheleixing : true,
				susheloudong : true,
				fangjianhao : true,
				churuleixing : false,
				xueshengxuehao : true,
				xueshengxingming : true,
				churushijian : false,
				xiangpian : false,
			},
			
			
			ruleForm: {
				sushemingcheng: '',
				susheleixing: '',
				susheloudong: '',
				fangjianhao: '',
				churuleixing: '',
				xueshengxuehao: '',
				xueshengxingming: '',
				churushijian: '',
				xiangpian: '',
				selectedAllocationNo: '',
			},
			churuleixingOptions: ['出宿', '入宿'],
		

			
			rules: {
				selectedAllocationNo: [
					{ validator: validateAllocationRequired, trigger: 'change' }
				],
				sushemingcheng: [
				],
				susheleixing: [
				],
				susheloudong: [
				],
				fangjianhao: [
				],
				churuleixing: [
					{ required: true, message: '请选择出宿或入宿', trigger: 'change' }
				],
				xueshengxuehao: [
				],
				xueshengxingming: [
				],
				churushijian: [
					{ required: true, message: '请选择出入时间', trigger: 'change' }
				],
				xiangpian: [
					{ required: true, message: '请上传相片', trigger: 'change' }
				],
			}
		};
	},
	props: ["parent"],
	computed: {



	},
    components: {
        imgAdd
    },
	created() {
		this.ruleForm.churushijian = this.getCurDateTime()
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
        imgAddClick(){
            this.$refs.imgAdd.onTake()
        },
        imgChange(e){
            this.ruleForm.xiangpian = 'upload/' + e
        },
		onAllocationChange(value) {
			const allocation = this.allocationOptionsRaw.find(item => item.xueshengxuehao === value);
			if (!allocation) {
				return;
			}
			this.ruleForm.sushemingcheng = allocation.sushemingcheng || '';
			this.ruleForm.susheleixing = allocation.susheleixing || '';
			this.ruleForm.susheloudong = allocation.susheloudong || '';
			this.ruleForm.fangjianhao = allocation.fangjianhao || '';
			this.ruleForm.xueshengxuehao = allocation.xueshengxuehao || '';
			this.ruleForm.xueshengxingming = allocation.xueshengxingming || '';
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
						if(o=='sushemingcheng'){
							this.ruleForm.sushemingcheng = obj[o];
							this.ro.sushemingcheng = true;
							continue;
						}
						if(o=='susheleixing'){
							this.ruleForm.susheleixing = obj[o];
							this.ro.susheleixing = true;
							continue;
						}
						if(o=='susheloudong'){
							this.ruleForm.susheloudong = obj[o];
							this.ro.susheloudong = true;
							continue;
						}
						if(o=='fangjianhao'){
							this.ruleForm.fangjianhao = obj[o];
							this.ro.fangjianhao = true;
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
						if(o=='churushijian'){
							this.ruleForm.churushijian = obj[o];
							this.ro.churushijian = true;
							continue;
						}
						if(o=='xiangpian'){
							this.ruleForm.xiangpian = obj[o];
							this.ro.xiangpian = true;
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
                    if(this.$storage.get("role")=="管理员") {
                        this.faceMatchFlag= true;
                    }
                    this.userface = data.data.touxiang;
					
					var json = data.data;
					if(((json.xueshengxuehao!=''&&json.xueshengxuehao) || json.xueshengxuehao==0) && this.$storage.get("role")!="管理员"){
						this.ruleForm.xueshengxuehao = json.xueshengxuehao;
						this.ro.xueshengxuehao = true;
						this.loadStudentDormInfo(json.xueshengxuehao);
					}
					if(((json.xueshengxingming!=''&&json.xueshengxingming) || json.xueshengxingming==0) && this.$storage.get("role")!="管理员"){
						this.ruleForm.xueshengxingming = json.xueshengxingming;
						this.ro.xueshengxingming = true;
					}
					if (!this.id && this.$storage.get("role") !== "学生") {
						this.$http({
							url: "sushefenpei/list",
							method: "get",
							params: {
								page: 1,
								limit: 1000,
								sort: "susheloudong",
								order: "asc"
							}
						}).then(({ data }) => {
							if (data && data.code === 0) {
								this.allocationOptionsRaw = data.data.list || [];
								this.allocationOptions = this.allocationOptionsRaw.map(item => ({
									value: item.xueshengxuehao,
									label: `${item.xueshengxingming || '-'} (${item.xueshengxuehao || '-'}) / ${item.sushemingcheng || '-'} / ${item.susheloudong || '-'} / ${item.fangjianhao || '-'}`
								}));
							} else {
								this.$message.error(data.msg);
							}
						});
					}
				} else {
					this.$message.error(data.msg);
				}
			});
			
			
		},
    loadStudentDormInfo(studentNo) {
      if (!studentNo || this.$storage.get("role") === "管理员") {
        return;
      }
      this.$http({
        url: "sushefenpei/list",
        method: "get",
        params: {
          page: 1,
          limit: 1,
          sort: "fenpeiriqi",
          order: "desc",
          xueshengxuehao: studentNo
        }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          const dormInfo = (data.data.list || [])[0];
          if (dormInfo) {
            this.ruleForm.sushemingcheng = dormInfo.sushemingcheng || '';
            this.ruleForm.susheleixing = dormInfo.susheleixing || '';
            this.ruleForm.susheloudong = dormInfo.susheloudong || '';
            this.ruleForm.fangjianhao = dormInfo.fangjianhao || '';
            this.ro.sushemingcheng = true;
            this.ro.susheleixing = true;
            this.ro.susheloudong = true;
            this.ro.fangjianhao = true;
          } else if (!this.id) {
            this.$message.warning("暂未查询到你的宿舍分配信息，请先完成宿舍分配后再登记出入宿舍");
          }
        } else {
          this.$message.error(data.msg);
        }
      });
    },
    // 多级联动参数

    info(id) {
      this.$http({
        url: `churusushe/info/${id}`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
        this.ruleForm = data.data;
        //解决前台上传图片后台不显示的问题
        let reg=new RegExp('../../../upload','g')//g代表全部
        } else {
          this.$message.error(data.msg);
        }
      });
    },

    faceMatchHandle() {
        const currentFace = this.normalizeUploadPath(this.ruleForm.xiangpian);
        if (this.$storage.get("role") === "学生") {
            if (!currentFace) {
                this.faceMatchFlag = false;
                this.$message.error("请先上传现场照片后再进行人脸校验");
                return false;
            }
            this.$http({
                url: `matchRegisteredFace`,
                method: "get",
                params: {
                    face2: currentFace,
                }
            }).then(({ data }) => {
                if (data && data.code === 0 && data.matched) {
                    this.faceMatchFlag = true;
                    this.$message({
                      message: "匹配成功",
                      type: "success",
                      duration: 1500,
                    });
					this.onSubmit();
                } else {
                    this.faceMatchFlag = false;
                    this.$message.error((data && data.msg) || "匹配失败，请确认已先录入人脸并重新拍摄清晰正脸照片");
                    return false;
                }
            });
            return;
        }
        const userFace = this.normalizeUploadPath(this.userface);
        if (!userFace) {
            this.faceMatchFlag = false;
            this.$message.error("未找到你已录入的人脸，请先到个人信息页上传头像并点击“录入人脸”");
            return false;
        }
        if (!currentFace) {
            this.faceMatchFlag = false;
            this.$message.error("请先上传现场照片后再进行人脸校验");
            return false;
        }
        let params = {
            face1: userFace,
            face2: currentFace,
        }
        this.$http({
            url: `matchFace`,
            method: "get",
            params: params
          }).then(({ data }) => {
            if (data && data.code === 0) {
                if(data.score>60) {
                    this.faceMatchFlag = true;
                    this.$message({
                      message: "匹配成功",
                      type: "success",
                      duration: 1500,
                    });
					this.onSubmit();
                } else {
                    this.faceMatchFlag = false;
                    this.$message.error("匹配失败");
                    return false;
                }
            } else {
              this.faceMatchFlag = false;
              this.$message.error("匹配失败");
			  return false;
            }
          });
    },

    // 提交
    onSubmit() {
















	if(this.ruleForm.xiangpian!=null) {
		this.ruleForm.xiangpian = this.ruleForm.xiangpian.replace(new RegExp(this.$base.url,"g"),"");
	}

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
				url: "churusushe/page", 
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
					   url: `churusushe/${!this.ruleForm.id ? "save" : "update"}`,
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
						 this.parent.churususheCrossAddOrUpdateFlag = false;
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
			   url: `churusushe/${!this.ruleForm.id ? "save" : "update"}`,
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
				 this.parent.churususheCrossAddOrUpdateFlag = false;
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
      this.parent.churususheCrossAddOrUpdateFlag = false;
      this.parent.contentStyleChange();
    },
    xiangpianUploadChange(fileUrls) {
	    this.ruleForm.xiangpian = fileUrls;
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
