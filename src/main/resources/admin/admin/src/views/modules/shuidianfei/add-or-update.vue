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
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info' && !ruleForm.id" label="宿舍范围" prop="chargeDormScope">
					<el-select v-model="ruleForm.chargeDormScope" placeholder="请选择宿舍范围" @change="onChargeDormScopeChange">
						<el-option label="单个宿舍" value="single"></el-option>
						<el-option label="全部宿舍" value="all"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info' && !ruleForm.id && ruleForm.chargeDormScope==='single'" label="选择宿舍" prop="targetDormKey">
					<el-select v-model="ruleForm.targetDormKey" placeholder="请选择宿舍" filterable @change="onTargetDormChange">
						<el-option
							v-for="item in dormOptions"
							:key="item.value"
							:label="item.label"
							:value="item.value">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="select" v-if="type!='info' && !ruleForm.id" label="学生范围" prop="targetStudentNo">
					<el-select v-model="ruleForm.targetStudentNo" placeholder="请选择学生范围" filterable @change="onTargetStudentChange">
						<el-option
							v-for="item in studentOptions"
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
				 <el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'"  label="月份" prop="yuefen">
					<el-input v-model="ruleForm.yuefen" placeholder="月份" clearable  :readonly="ro.yuefen"></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="月份" prop="yuefen">
					<el-input v-model="ruleForm.yuefen" placeholder="月份" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'"  label="水费" prop="shuifei">
					<el-input v-model="ruleForm.shuifei" placeholder="水费" clearable  :readonly="ro.shuifei"></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="水费" prop="shuifei">
					<el-input v-model="ruleForm.shuifei" placeholder="水费" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'"  label="电费" prop="dianfei">
					<el-input v-model="ruleForm.dianfei" placeholder="电费" clearable  :readonly="ro.dianfei"></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else class="input" label="电费" prop="dianfei">
					<el-input v-model="ruleForm.dianfei" placeholder="电费" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-if="type!='info'" label="总金额" prop="zongjine">
					<el-input v-model="zongjine" placeholder="总金额" readonly></el-input>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-else-if="ruleForm.zongjine" label="总金额" prop="zongjine">
					<el-input v-model="ruleForm.zongjine" placeholder="总金额" readonly></el-input>
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
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="date" v-if="type!='info'" label="登记时间" prop="dengjishijian">
					<el-date-picker
						format="yyyy 年 MM 月 dd 日"
						value-format="yyyy-MM-dd"
						v-model="ruleForm.dengjishijian" 
						type="date"
						:readonly="ro.dengjishijian"
						placeholder="登记时间"
					></el-date-picker> 
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' class="input" v-else-if="ruleForm.dengjishijian" label="登记时间" prop="dengjishijian">
					<el-input v-model="ruleForm.dengjishijian" placeholder="登记时间" readonly></el-input>
				</el-form-item>
			</template>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-if="type!='info'"  label="详情" prop="xiangqing">
					<editor 
						style="min-width: 200px; max-width: 600px;"
						v-model="ruleForm.xiangqing" 
						class="editor" 
						action="file/upload">
					</editor>
				</el-form-item>
				<el-form-item :style='{"width":"100%","margin":"0 0 20px 0","display":"inline-block"}' v-else-if="ruleForm.xiangqing" label="详情" prop="xiangqing">
                    <span :style='{"fontSize":"14px","lineHeight":"40px","color":"#333","fontWeight":"500","display":"inline-block"}' v-html="ruleForm.xiangqing"></span>
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
		var validateDormTarget = (rule, value, callback) => {
			if (self.ruleForm.id || self.ruleForm.chargeDormScope === 'all') {
				callback();
				return;
			}
			if (!value) {
				callback(new Error("请选择宿舍"));
				return;
			}
			callback();
		};
		var validateStudentTarget = (rule, value, callback) => {
			if (self.ruleForm.id) {
				callback();
				return;
			}
			if (!value) {
				callback(new Error("请选择学生范围"));
				return;
			}
			callback();
		};
		return {
			id: '',
			type: '',
			allAllocationOptions: [],
			dormOptions: [],
			studentOptions: [],
			
			
			ro:{
				sushemingcheng : true,
				susheleixing : true,
				susheloudong : true,
				fangjianhao : true,
				yuefen : false,
				shuifei : false,
				dianfei : false,
				zongjine : false,
				xueshengxuehao : true,
				xueshengxingming : true,
				dengjishijian : false,
				xiangqing : false,
				ispay : false,
			},
			
			
			ruleForm: {
				sushemingcheng: '',
				susheleixing: '',
				susheloudong: '',
				fangjianhao: '',
				yuefen: '',
				shuifei: '',
				dianfei: '',
				zongjine: '',
				xueshengxuehao: '',
				xueshengxingming: '',
				dengjishijian: '',
				xiangqing: '',
				chargeDormScope: 'single',
				targetDormKey: '',
				targetStudentNo: '__ALL_STUDENTS__',
			},
		

			
			rules: {
				sushemingcheng: [],
				susheleixing: [],
				susheloudong: [],
				fangjianhao: [],
				chargeDormScope: [
					{ required: true, message: '请选择宿舍范围', trigger: 'change' }
				],
				targetDormKey: [
					{ validator: validateDormTarget, trigger: 'change' }
				],
				targetStudentNo: [
					{ validator: validateStudentTarget, trigger: 'change' }
				],
				yuefen: [
					{ required: true, message: '请输入月份', trigger: 'blur' }
				],
				shuifei: [
					{ required: true, message: '请输入水费', trigger: 'blur' },
					{ validator: validateNumber, trigger: 'blur' },
				],
				dianfei: [
					{ required: true, message: '请输入电费', trigger: 'blur' },
					{ validator: validateNumber, trigger: 'blur' },
				],
				zongjine: [
					{ validator: validateNumber, trigger: 'blur' },
				],
				xueshengxuehao: [],
				xueshengxingming: [],
				dengjishijian: [
					{ required: true, message: '请选择登记时间', trigger: 'change' }
				],
				xiangqing: [
				],
				ispay: [
				],
			}
		};
	},
	props: ["parent"],
	computed: {
		zongjine: {
			get: function () {
				return 0+parseFloat(this.ruleForm.shuifei==""?0:this.ruleForm.shuifei)+parseFloat(this.ruleForm.dianfei==""?0:this.ruleForm.dianfei) || 0
			}
		},



	},
    components: {
    },
	created() {
		this.ruleForm.dengjishijian = this.getCurDate()
	},
	methods: {
		buildDormKey(item) {
			return [item.sushemingcheng, item.susheleixing, item.susheloudong, item.fangjianhao].join("||");
		},
		loadAllocationOptions() {
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
					this.allAllocationOptions = data.data.list || [];
					this.dormOptions = this.getDormOptions(this.allAllocationOptions);
					this.refreshStudentOptions();
				} else {
					this.$message.error(data.msg);
				}
			});
		},
		getDormOptions(list) {
			const map = {};
			list.forEach(item => {
				const value = this.buildDormKey(item);
				if (!map[value]) {
					map[value] = {
						value,
						label: `${item.sushemingcheng || '-'} / ${item.susheleixing || '-'} / ${item.susheloudong || '-'} / ${item.fangjianhao || '-'}`
					};
				}
			});
			return Object.values(map);
		},
		refreshStudentOptions() {
			const baseList = this.getFilteredAllocationsByDorm();
			const options = [{
				label: "全部学生",
				value: "__ALL_STUDENTS__"
			}];
			baseList.forEach(item => {
				options.push({
					label: `${item.xueshengxingming || '-'} (${item.xueshengxuehao || '-'})`,
					value: item.xueshengxuehao
				});
			});
			this.studentOptions = options;
			if (!options.find(item => item.value === this.ruleForm.targetStudentNo)) {
				this.ruleForm.targetStudentNo = "__ALL_STUDENTS__";
			}
			this.applySelectionToForm();
		},
		getFilteredAllocationsByDorm() {
			if (this.ruleForm.chargeDormScope === 'all') {
				return this.allAllocationOptions.slice();
			}
			return this.allAllocationOptions.filter(item => this.buildDormKey(item) === this.ruleForm.targetDormKey);
		},
		onChargeDormScopeChange() {
			if (this.ruleForm.chargeDormScope === 'all') {
				this.ruleForm.targetDormKey = '';
				this.clearDormStudentFields();
			}
			this.refreshStudentOptions();
		},
		onTargetDormChange() {
			this.refreshStudentOptions();
		},
		onTargetStudentChange() {
			this.applySelectionToForm();
		},
		clearDormStudentFields() {
			["sushemingcheng", "susheleixing", "susheloudong", "fangjianhao", "xueshengxuehao", "xueshengxingming"].forEach(key => {
				this.ruleForm[key] = "";
			});
		},
		applySelectionToForm() {
			const selectedList = this.getChargeTargets();
			if (!selectedList.length) {
				this.clearDormStudentFields();
				return;
			}
			const first = selectedList[0];
			this.ruleForm.sushemingcheng = first.sushemingcheng || "";
			this.ruleForm.susheleixing = first.susheleixing || "";
			this.ruleForm.susheloudong = first.susheloudong || "";
			this.ruleForm.fangjianhao = first.fangjianhao || "";
			if (this.ruleForm.targetStudentNo === "__ALL_STUDENTS__") {
				this.ruleForm.xueshengxuehao = this.ruleForm.chargeDormScope === 'all' ? "全部学生" : "";
				this.ruleForm.xueshengxingming = this.ruleForm.chargeDormScope === 'all' ? "全部学生" : "";
			} else {
				this.ruleForm.xueshengxuehao = first.xueshengxuehao || "";
				this.ruleForm.xueshengxingming = first.xueshengxingming || "";
			}
		},
		getChargeTargets() {
			let list = this.getFilteredAllocationsByDorm();
			if (this.ruleForm.targetStudentNo !== "__ALL_STUDENTS__") {
				list = list.filter(item => item.xueshengxuehao === this.ruleForm.targetStudentNo);
			}
			return list;
		},
		buildBatchChargePayloads() {
			return this.getChargeTargets().map(item => ({
				sushemingcheng: item.sushemingcheng,
				susheleixing: item.susheleixing,
				susheloudong: item.susheloudong,
				fangjianhao: item.fangjianhao,
				yuefen: this.ruleForm.yuefen,
				shuifei: this.ruleForm.shuifei,
				dianfei: this.ruleForm.dianfei,
				zongjine: this.zongjine,
				xueshengxuehao: item.xueshengxuehao,
				xueshengxingming: item.xueshengxingming,
				dengjishijian: this.ruleForm.dengjishijian,
				xiangqing: this.ruleForm.xiangqing
			}));
		},
		normalizeChargeForm() {
			["yuefen", "xiangqing"].forEach(key => {
				this.ruleForm[key] = String(this.ruleForm[key] || "").trim();
			});
		},
		submitBatchCharges() {
			const payloads = this.buildBatchChargePayloads();
			if (!payloads.length) {
				this.$message.error("当前条件下没有可生成的水电费记录");
				return;
			}
			Promise.all(payloads.map(item => this.$http({
				url: "shuidianfei/save",
				method: "post",
				data: item
			}))).then(() => {
				this.$message({
					message: `已生成 ${payloads.length} 条水电费记录`,
					type: "success",
					duration: 1500,
					onClose: () => {
						this.parent.showFlag = true;
						this.parent.addOrUpdateFlag = false;
						this.parent.shuidianfeiCrossAddOrUpdateFlag = false;
						this.parent.search();
						this.parent.contentStyleChange();
					}
				});
			}).catch(() => {
				this.$message.error("批量生成水电费失败，请稍后重试");
			});
		},
		
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
						if(o=='yuefen'){
							this.ruleForm.yuefen = obj[o];
							this.ro.yuefen = true;
							continue;
						}
						if(o=='shuifei'){
							this.ruleForm.shuifei = obj[o];
							this.ro.shuifei = true;
							continue;
						}
						if(o=='dianfei'){
							this.ruleForm.dianfei = obj[o];
							this.ro.dianfei = true;
							continue;
						}
						if(o=='zongjine'){
							this.ruleForm.zongjine = obj[o];
							this.ro.zongjine = true;
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
						if(o=='dengjishijian'){
							this.ruleForm.dengjishijian = obj[o];
							this.ro.dengjishijian = true;
							continue;
						}
						if(o=='xiangqing'){
							this.ruleForm.xiangqing = obj[o];
							this.ro.xiangqing = true;
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
			if (!this.id) {
				this.loadAllocationOptions();
			}
			
			
		},
    // 多级联动参数

    info(id) {
      this.$http({
        url: `shuidianfei/info/${id}`,
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
        this.ruleForm = data.data;
        //解决前台上传图片后台不显示的问题
        let reg=new RegExp('../../../upload','g')//g代表全部
        this.ruleForm.xiangqing = this.ruleForm.xiangqing.replace(reg,'../../../dormmanagesys/upload');
        } else {
          this.$message.error(data.msg);
        }
      });
    },


    // 提交
    onSubmit() {
        this.ruleForm.zongjine = this.zongjine
		this.normalizeChargeForm();



























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
		 if(!this.ruleForm.id) {
			 const targets = this.getChargeTargets();
			 if (!targets.length) {
				 this.$message.error("请选择有效的宿舍或学生范围");
				 return false;
			 }
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
				url: "shuidianfei/page", 
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
					   url: `shuidianfei/${!this.ruleForm.id ? "save" : "update"}`,
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
						 this.parent.shuidianfeiCrossAddOrUpdateFlag = false;
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
			 if(!this.ruleForm.id) {
				 this.submitBatchCharges();
				 return;
			 }
			 this.$http({
			   url: `shuidianfei/${!this.ruleForm.id ? "save" : "update"}`,
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
				 this.parent.shuidianfeiCrossAddOrUpdateFlag = false;
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
      this.parent.shuidianfeiCrossAddOrUpdateFlag = false;
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
