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
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info'"  label="宿舍名称" prop="sushemingcheng">
					<el-select :disabled="ro.sushemingcheng" v-model="ruleForm.sushemingcheng" placeholder="请选择宿舍名称" @change="sushemingchengChange">
						<el-option
							v-for="item in sushemingchengOptions"
							:key="item"
							:label="item"
							:value="item">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="宿舍名称" prop="sushemingcheng">
					<el-input v-model="ruleForm.sushemingcheng" placeholder="宿舍名称" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info'"  label="宿舍类型" prop="susheleixing">
					<el-select :disabled="ro.susheleixing" v-model="ruleForm.susheleixing" placeholder="请选择宿舍类型" @change="susheleixingChange">
						<el-option
							v-for="item in susheleixingOptions"
							:key="item"
							:label="item"
							:value="item">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="宿舍类型" prop="susheleixing">
					<el-input v-model="ruleForm.susheleixing" placeholder="宿舍类型" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info'"  label="宿舍楼栋" prop="susheloudong">
					<el-select :disabled="ro.susheloudong" v-model="ruleForm.susheloudong" placeholder="请选择宿舍楼栋" @change="susheloudongChange">
						<el-option
							v-for="item in susheloudongOptions"
							:key="item"
							:label="item"
							:value="item">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="宿舍楼栋" prop="susheloudong">
					<el-input v-model="ruleForm.susheloudong" placeholder="宿舍楼栋" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info'"  label="房间号" prop="fangjianhao">
					<el-select :disabled="ro.fangjianhao" v-model="ruleForm.fangjianhao" placeholder="请选择房间号" @change="fangjianhaoChange">
						<el-option
							v-for="item in fangjianhaoOptions"
							:key="item"
							:label="item"
							:value="item">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="房间号" prop="fangjianhao">
					<el-input v-model="ruleForm.fangjianhao" placeholder="房间号" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info'" label="学生学号" prop="xueshengxuehao">
					<el-select :disabled="ro.xueshengxuehao" @change="xueshengxuehaoChange" v-model="ruleForm.xueshengxuehao" placeholder="请选择学生学号">
						<el-option
							v-for="(item,index) in xueshengxuehaoOptions"
							v-bind:key="index"
							:label="item"
							:value="item">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-else-if="ruleForm.xueshengxuehao" label="学生学号" prop="xueshengxuehao">
					<el-input v-model="ruleForm.xueshengxuehao" placeholder="学生学号" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'"  label="学生姓名" prop="xueshengxingming">
					<el-input v-model="ruleForm.xueshengxingming" placeholder="学生姓名" clearable  :readonly="ro.xueshengxingming"></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="学生姓名" prop="xueshengxingming">
					<el-input v-model="ruleForm.xueshengxingming" placeholder="学生姓名" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info'"  label="床位号" prop="chuangweihao">
					<el-select :disabled="ro.chuangweihao" v-model="ruleForm.chuangweihao" placeholder="请选择床位号">
						<el-option
							v-for="item in chuangweihaoOptions"
							:key="item.value"
							:label="item.label"
							:value="item.value"
							:disabled="item.disabled">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="床位号" prop="chuangweihao">
					<el-input v-model="ruleForm.chuangweihao" placeholder="床位号" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="date" v-if="type!='info'" label="分配日期" prop="fenpeiriqi">
					<el-date-picker
						format="yyyy 年 MM 月 dd 日"
						value-format="yyyy-MM-dd"
						v-model="ruleForm.fenpeiriqi" 
						type="date"
						:readonly="ro.fenpeiriqi"
						placeholder="分配日期"
					></el-date-picker> 
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-else-if="ruleForm.fenpeiriqi" label="分配日期" prop="fenpeiriqi">
					<el-input v-model="ruleForm.fenpeiriqi" placeholder="分配日期" readonly></el-input>
				</el-form-item>
				<div v-if="type!='info'" class="allocation-form-tip">新增只显示未分配学生；如需调整已入住学生，请进入该记录后使用换宿/换床。</div>
			</template>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="textarea" v-if="type!='info'" label="备注" prop="beizhu">
					<el-input
					  style="min-width: 200px; max-width: 600px;"
					  type="textarea"
					  :rows="8"
					  placeholder="备注"
					  v-model="ruleForm.beizhu" >
					</el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else-if="ruleForm.beizhu" label="备注" prop="beizhu">
					<span :style='{"fontSize":"14px","lineHeight":"40px","color":"#333","fontWeight":"500","display":"inline-block"}'>{{ruleForm.beizhu}}</span>
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
		return {
			id: '',
			type: '',
			allStudents: [],
			selectedStudentGender: '',
			
			
			ro:{
				sushemingcheng : false,
				susheleixing : false,
				susheloudong : false,
				fangjianhao : false,
				xueshengxuehao : false,
				xueshengxingming : false,
				chuangweihao : false,
				fenpeiriqi : false,
				beizhu : false,
			},
			
			
			ruleForm: {
				sushemingcheng: '',
				susheleixing: '',
				susheloudong: '',
				fangjianhao: '',
				xueshengxuehao: '',
				xueshengxingming: '',
				chuangweihao: '',
				fenpeiriqi: '',
				beizhu: '',
			},
		
			xueshengxuehaoOptions: [],
			sushemingchengOptions: [],
			susheleixingOptions: [],
			susheloudongOptions: [],
			fangjianhaoOptions: [],
			chuangweihaoOptions: [],
			dormOptions: [],

			
			rules: {
				sushemingcheng: [
					{ required: true, message: '请选择宿舍名称', trigger: 'change' }
				],
				susheleixing: [
					{ required: true, message: '请选择宿舍类型', trigger: 'change' }
				],
				susheloudong: [
					{ required: true, message: '请选择宿舍楼栋', trigger: 'change' }
				],
				fangjianhao: [
					{ required: true, message: '请选择房间号', trigger: 'change' }
				],
				xueshengxuehao: [
					{ required: true, message: '请选择学生学号', trigger: 'change' }
				],
				xueshengxingming: [
				],
				chuangweihao: [
					{ required: true, message: '请选择床位号', trigger: 'change' }
				],
				fenpeiriqi: [
				],
				beizhu: [
				],
			}
		};
	},
	props: ["parent"],
	computed: {



	},
    components: {
    },
	created() {
		this.ruleForm.fenpeiriqi = this.getCurDate()
	},
	methods: {
		
		// 下载
		download(file){
			window.open(`${file}`)
		},
		// 初始化
		init(id,type) {
			if (id) {
				this.id = id;
				this.type = type;
			}
			if(this.type=='info'||this.type=='else'){
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
						if(o=='chuangweihao'){
							this.ruleForm.chuangweihao = obj[o];
							this.ro.chuangweihao = true;
							continue;
						}
						if(o=='fenpeiriqi'){
							this.ruleForm.fenpeiriqi = obj[o];
							this.ro.fenpeiriqi = true;
							continue;
						}
						if(o=='beizhu'){
							this.ruleForm.beizhu = obj[o];
							this.ro.beizhu = true;
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
				} else {
					this.$message.error(data.msg);
				}
			});
			
            this.$http({
				url: `xuesheng/list`,
				method: "get",
				params: {
					page: 1,
					limit: 500
				}
            }).then(({ data }) => {
				if (data && data.code === 0) {
					this.allStudents = data.data.list || [];
					this.refreshStudentOptions();
					this.syncSelectedStudentInfo();
				} else {
					this.$message.error(data.msg);
				}
            });
			this.loadDormOptions();
			
		},
			loadDormOptions() {
				this.$http({
					url: 'sushexinxi/list',
					method: 'get',
					params: {
						page: 1,
						limit: 500,
						sort: 'susheloudong',
						order: 'asc'
					}
				}).then(({ data }) => {
					if (data && data.code === 0) {
						this.dormOptions = data.data.list || [];
						this.refreshDormSelectors();
					} else {
						this.$message.error(data.msg);
					}
				});
			},
			refreshStudentOptions() {
				this.$http({
					url: 'sushefenpei/list',
					method: 'get',
					params: {
						page: 1,
						limit: 500
					}
				}).then(({ data }) => {
					const allocationList = data && data.code === 0 ? (data.data.list || []) : [];
					const assignedStudents = allocationList
						.filter(item => String(item.id || '') !== String(this.ruleForm.id || ''))
						.map(item => item.xueshengxuehao);
					this.xueshengxuehaoOptions = (this.allStudents || [])
						.filter(item => !assignedStudents.includes(item.xueshengxuehao))
						.map(item => item.xueshengxuehao);
					if (this.ruleForm.xueshengxuehao && !this.xueshengxuehaoOptions.includes(this.ruleForm.xueshengxuehao)) {
						this.xueshengxuehaoOptions.unshift(this.ruleForm.xueshengxuehao);
					}
					this.syncSelectedStudentInfo();
				});
			},
			refreshDormSelectors() {
				this.sushemingchengOptions = this.getUniqueValues(this.dormOptions, 'sushemingcheng');
				const typeSource = this.dormOptions.filter(item => !this.ruleForm.sushemingcheng || item.sushemingcheng === this.ruleForm.sushemingcheng);
				this.susheleixingOptions = this.getUniqueValues(typeSource, 'susheleixing');
				const buildingSource = typeSource.filter(item => !this.ruleForm.susheleixing || item.susheleixing === this.ruleForm.susheleixing);
				this.susheloudongOptions = this.getUniqueValues(buildingSource, 'susheloudong');
				const roomSource = buildingSource.filter(item => !this.ruleForm.susheloudong || item.susheloudong === this.ruleForm.susheloudong);
				this.fangjianhaoOptions = this.getUniqueValues(roomSource, 'fangjianhao');
				this.refreshChuangweihaoOptions();
			},
			refreshChuangweihaoOptions() {
				this.chuangweihaoOptions = [];
				const selectedDorm = this.getSelectedDorm();
				if (!selectedDorm) {
					return;
				}
				const capacity = parseInt(selectedDorm.kezhurenshu, 10) || 0;
				if (!capacity) {
					return;
				}
				this.$http({
					url: 'sushefenpei/list',
					method: 'get',
					params: {
						page: 1,
						limit: 200,
						sushemingcheng: selectedDorm.sushemingcheng,
						susheleixing: selectedDorm.susheleixing,
						susheloudong: selectedDorm.susheloudong,
						fangjianhao: selectedDorm.fangjianhao
					}
				}).then(({ data }) => {
					const list = data && data.code === 0 ? (data.data.list || []) : [];
					const occupiedBeds = list
						.filter(item => String(item.id || '') !== String(this.ruleForm.id || ''))
						.map(item => this.normalizeBedNo(item.chuangweihao));
					const options = [];
					for (let i = 1; i <= capacity; i++) {
						const value = `${i}号床`;
						const occupied = occupiedBeds.includes(this.normalizeBedNo(value));
						options.push({
							label: occupied ? `${value}（已占用）` : value,
							value,
							disabled: occupied
						});
					}
					this.chuangweihaoOptions = options;
					if (this.ruleForm.chuangweihao && !options.find(item => item.value === this.ruleForm.chuangweihao)) {
						this.ruleForm.chuangweihao = '';
					}
				});
			},
			getUniqueValues(list, key) {
				return Array.from(new Set((list || []).map(item => item[key]).filter(item => item)));
			},
			normalizeBedNo(value) {
				if (!value) {
					return '';
				}
				const text = String(value).trim();
				const match = text.match(/\d+/);
				if (match) {
					return `${Number(match[0])}号床`;
				}
				const map = {
					'一': 1,
					'二': 2,
					'三': 3,
					'四': 4,
					'五': 5,
					'六': 6,
					'七': 7,
					'八': 8,
					'九': 9,
					'十': 10
				};
				const compact = text.replace(/号床|床|号/g, '');
				if (map[compact]) {
					return `${map[compact]}号床`;
				}
				return text;
			},
			getSelectedDorm() {
				return this.dormOptions.find(item =>
					item.sushemingcheng === this.ruleForm.sushemingcheng &&
					item.susheleixing === this.ruleForm.susheleixing &&
					item.susheloudong === this.ruleForm.susheloudong &&
					item.fangjianhao === this.ruleForm.fangjianhao
				);
			},
			syncSelectedStudentInfo() {
				const selectedStudent = (this.allStudents || []).find(item => item.xueshengxuehao === this.ruleForm.xueshengxuehao);
				this.selectedStudentGender = selectedStudent && selectedStudent.xingbie ? selectedStudent.xingbie : '';
				if (selectedStudent && selectedStudent.xueshengxingming) {
					this.ruleForm.xueshengxingming = selectedStudent.xueshengxingming;
				}
			},
			normalizeStudentGender(gender) {
				if (!gender) {
					return '';
				}
				if (String(gender).includes('男')) {
					return '男';
				}
				if (String(gender).includes('女')) {
					return '女';
				}
				return String(gender).trim();
			},
			normalizeDormGender(dormType) {
				if (!dormType) {
					return '';
				}
				if (String(dormType).includes('男')) {
					return '男';
				}
				if (String(dormType).includes('女')) {
					return '女';
				}
				return String(dormType).trim();
			},
			validateGenderMatch(showMessage = true) {
				const studentGender = this.normalizeStudentGender(this.selectedStudentGender);
				const dormGender = this.normalizeDormGender(this.ruleForm.susheleixing);
				if (!studentGender || !dormGender || studentGender === dormGender) {
					return true;
				}
				if (showMessage) {
					this.$message.warning(`当前学生为${this.selectedStudentGender}，不能分配到${this.ruleForm.susheleixing}宿舍`);
				}
				return false;
			},
			sushemingchengChange() {
				if (!this.ro.susheleixing) {
					this.ruleForm.susheleixing = '';
				}
				if (!this.ro.susheloudong) {
					this.ruleForm.susheloudong = '';
				}
				if (!this.ro.fangjianhao) {
					this.ruleForm.fangjianhao = '';
				}
				if (!this.ro.chuangweihao) {
					this.ruleForm.chuangweihao = '';
				}
				this.refreshDormSelectors();
			},
			susheleixingChange() {
				if (!this.ro.susheloudong) {
					this.ruleForm.susheloudong = '';
				}
				if (!this.ro.fangjianhao) {
					this.ruleForm.fangjianhao = '';
				}
				if (!this.ro.chuangweihao) {
					this.ruleForm.chuangweihao = '';
				}
				this.refreshDormSelectors();
				this.validateGenderMatch();
			},
			susheloudongChange() {
				if (!this.ro.fangjianhao) {
					this.ruleForm.fangjianhao = '';
				}
				if (!this.ro.chuangweihao) {
					this.ruleForm.chuangweihao = '';
				}
				this.refreshDormSelectors();
			},
			fangjianhaoChange() {
				if (!this.ro.chuangweihao) {
					this.ruleForm.chuangweihao = '';
				}
				this.refreshDormSelectors();
			},
			// 下二随
			xueshengxuehaoChange () {
				this.syncSelectedStudentInfo();
				this.validateGenderMatch();
			},
    // 多级联动参数

    info(id) {
      this.$http({
        url: `sushefenpei/info/${id}`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
        this.ruleForm = data.data;
		this.ruleForm.chuangweihao = this.normalizeBedNo(this.ruleForm.chuangweihao);
		this.syncSelectedStudentInfo();
		this.refreshStudentOptions();
		this.refreshDormSelectors();
        //解决前台上传图片后台不显示的问题
        let reg=new RegExp('../../../upload','g')//g代表全部
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
		 this.ruleForm.chuangweihao = this.normalizeBedNo(this.ruleForm.chuangweihao);
		 if (!this.validateGenderMatch()) {
			 return false;
		 }
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
				url: "sushefenpei/page", 
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
					   url: `sushefenpei/${!this.ruleForm.id ? "save" : "update"}`,
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
						 this.parent.sushefenpeiCrossAddOrUpdateFlag = false;
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
			   url: `sushefenpei/${!this.ruleForm.id ? "save" : "update"}`,
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
				 this.parent.sushefenpeiCrossAddOrUpdateFlag = false;
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
      this.parent.sushefenpeiCrossAddOrUpdateFlag = false;
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

	.allocation-form-tip {
		width: 440px;
		margin: -4px 0 20px 140px;
		padding: 10px 14px;
		border-radius: 10px;
		background: #f4f7ee;
		border: 1px solid #c9d4b8;
		color: #5e694d;
		font-size: 13px;
		line-height: 1.7;
	}
</style>
