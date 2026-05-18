<template>
	<div class="main-content" :style='{"padding":"30px 0 0 0"}'>
		<!-- 列表页 -->
		<template v-if="showFlag">
			<div v-if="isStudentView" class="roommate-tip">
				<i class="el-icon-user-solid"></i>
				<span>当前页面会显示与你同一宿舍、同一房间的成员信息。</span>
			</div>
			<div v-else class="roommate-tip allocation-tip">
				<i class="el-icon-office-building"></i>
				<span>新增用于首次分配；换宿/换床请使用修改；退宿请使用删除，系统会自动同步宿舍人数和床位状态。</span>
			</div>
			<el-form class="center-form-pv" :style='{"width":"180px","margin":"0 0 20px 20px","position":"absolute","zIndex":"1003"}' :inline="true" :model="searchForm">
				<el-row :style='{"display":"block"}' >
					<div :style='{"margin":"0 0px 15px 0","display":"inline-block"}'>
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">宿舍名称</label>
						<el-input v-model="searchForm.sushemingcheng" placeholder="宿舍名称" clearable></el-input>
					</div>
					<div :style='{"margin":"0 0px 15px 0","display":"inline-block"}'>
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">学生姓名</label>
						<el-input v-model="searchForm.xueshengxingming" placeholder="学生姓名" clearable></el-input>
					</div>
					<el-button :style='{"border":"2px solid #4e6ae2","cursor":"pointer","padding":"0 20px","outline":"none","margin":"0px 0 5px 0","color":"#4e6ae2","borderRadius":"40px","background":"#fff","width":"160px","fontSize":"14px","height":"40px"}' type="success" @click="search()">查询</el-button>
				</el-row>

				<el-row :style='{"width":"170px","margin":"10px 0 0","flexDirection":"column","display":"flex"}'>
					<el-button :style='{"border":"2px solid #4e6ae2","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#4e6ae2","borderRadius":"40px","background":"#fff","width":"160px","fontSize":"14px","height":"40px"}' v-if="isAuth('sushefenpei','新增')" type="success" @click="addOrUpdateHandler()">新增</el-button>
					<el-button :style='{"border":"0","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#fff","borderRadius":"40px","background":"linear-gradient(135deg,#6bbf7b,#8ccf65)","width":"160px","fontSize":"14px","height":"40px"}' v-if="isAuth('sushefenpei','新增') && !isStudentView" type="success" icon="el-icon-magic-stick" @click="openAutoAssignDialog()">一键分配</el-button>
					<el-button :style='{"border":"2px solid #4e6ae2","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#4e6ae2","borderRadius":"40px","background":"#fff","width":"160px","fontSize":"14px","height":"40px"}' v-if="isAuth('sushefenpei','删除')" :disabled="dataListSelections.length <= 0" type="danger" @click="deleteHandler()">删除</el-button>




				</el-row>
			</el-form>
			
			<!-- <div> -->
				<el-table class="tables"
					:stripe='false'
					:style='{"padding":"0","boxShadow":" 0px 4px 10px 0px rgba(0,0,0,0.3020)","borderColor":"#eee","margin":"0 0 15px 210px","borderWidth":"1px 0 0 1px","background":"#fff","width":"calc(100% - 230px)","borderStyle":"solid"}' 
					v-if="isAuth('sushefenpei','查看')"
					:data="dataList"
					v-loading="dataListLoading"
				@selection-change="selectionChangeHandler">
					<el-table-column :resizable='true' type="selection" align="center" width="50"></el-table-column>
					<el-table-column :resizable='true' :sortable='true' label="序号" type="index" width="50" />
					<el-table-column :resizable='true' :sortable='true'  
						prop="sushemingcheng"
					label="宿舍名称">
						<template slot-scope="scope">
							{{scope.row.sushemingcheng}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="susheleixing"
					label="宿舍类型">
						<template slot-scope="scope">
							{{scope.row.susheleixing}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="susheloudong"
					label="宿舍楼栋">
						<template slot-scope="scope">
							{{scope.row.susheloudong}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="fangjianhao"
					label="房间号">
						<template slot-scope="scope">
							{{scope.row.fangjianhao}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="xueshengxuehao"
					label="学生学号">
						<template slot-scope="scope">
							{{scope.row.xueshengxuehao}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="xueshengxingming"
					label="学生姓名">
						<template slot-scope="scope">
							{{scope.row.xueshengxingming}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="chuangweihao"
					label="床位号">
						<template slot-scope="scope">
							{{scope.row.chuangweihao}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="fenpeiriqi"
					label="分配日期">
						<template slot-scope="scope">
							{{scope.row.fenpeiriqi}}
						</template>
					</el-table-column>
					<el-table-column width="300" label="操作">
						<template slot-scope="scope">
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if=" isAuth('sushefenpei','查看')" type="success" size="mini" @click="addOrUpdateHandler(scope.row.id,'info')">详情</el-button>
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if="isAuth('sushefenpei','水电费')" type="success" size="mini" @click="shuidianfeiCrossAddOrUpdateHandler(scope.row,'cross','','','')">水电费</el-button>
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if="isAuth('sushefenpei','进入')" type="success" size="mini" @click="jinrususheCrossAddOrUpdateHandler(scope.row,'cross','','','')">进入</el-button>
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if="isAuth('sushefenpei','出入')" type="success" size="mini" @click="churususheCrossAddOrUpdateHandler(scope.row,'cross','','','')">出入</el-button>
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if="isAuth('sushefenpei','维修')" type="success" size="mini" @click="weixiuxinxiCrossAddOrUpdateHandler(scope.row,'cross','','','')">维修</el-button>
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if="isAuth('sushefenpei','卫生')" type="success" size="mini" @click="weishengxinxiCrossAddOrUpdateHandler(scope.row,'cross','','','')">卫生</el-button>
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if="isAuth('sushefenpei','考勤')" type="success" size="mini" @click="kaoqinxinxiCrossAddOrUpdateHandler(scope.row,'cross','','','')">考勤</el-button>
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if=" isAuth('sushefenpei','修改')" type="primary" size="mini" @click="addOrUpdateHandler(scope.row.id)">换宿/换床</el-button>





							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if="isAuth('sushefenpei','删除') " type="danger" size="mini" @click="deleteHandler(scope.row.id)">退宿</el-button>
						</template>
					</el-table-column>
				</el-table>
				<el-pagination
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
					:style='{"padding":"0","margin":"20px 0 10px 210px","whiteSpace":"nowrap","color":"#333","textAlign":"center","width":"calc(100% - 230px)","fontWeight":"500"}'
				></el-pagination>
			<!-- </div> -->
		</template>
		
		<!-- 添加/修改页面  将父组件的search方法传递给子组件-->
		<add-or-update v-if="addOrUpdateFlag" :parent="this" ref="addOrUpdate"></add-or-update>

		<shuidianfei-cross-add-or-update v-if="shuidianfeiCrossAddOrUpdateFlag" :parent="this" ref="shuidianfeiCrossaddOrUpdate"></shuidianfei-cross-add-or-update>
		<jinrusushe-cross-add-or-update v-if="jinrususheCrossAddOrUpdateFlag" :parent="this" ref="jinrususheCrossaddOrUpdate"></jinrusushe-cross-add-or-update>
		<churusushe-cross-add-or-update v-if="churususheCrossAddOrUpdateFlag" :parent="this" ref="churususheCrossaddOrUpdate"></churusushe-cross-add-or-update>
		<weixiuxinxi-cross-add-or-update v-if="weixiuxinxiCrossAddOrUpdateFlag" :parent="this" ref="weixiuxinxiCrossaddOrUpdate"></weixiuxinxi-cross-add-or-update>
		<weishengxinxi-cross-add-or-update v-if="weishengxinxiCrossAddOrUpdateFlag" :parent="this" ref="weishengxinxiCrossaddOrUpdate"></weishengxinxi-cross-add-or-update>
		<kaoqinxinxi-cross-add-or-update v-if="kaoqinxinxiCrossAddOrUpdateFlag" :parent="this" ref="kaoqinxinxiCrossaddOrUpdate"></kaoqinxinxi-cross-add-or-update>

		<el-dialog
			title="一键分配宿舍"
			:visible.sync="autoAssignDialogVisible"
			width="980px"
			class="auto-assign-dialog"
			append-to-body
		>
			<el-alert
				title="系统会按筛选条件自动匹配未分配学生和空余床位，预览不会写入数据。确认分配后会生成入住记录并同步宿舍人数。"
				type="success"
				:closable="false"
				show-icon
			></el-alert>
			<el-form class="auto-assign-form" :model="autoAssignForm" label-width="86px">
				<el-row :gutter="16">
					<el-col :span="8">
						<el-form-item label="班级">
							<el-select v-model="autoAssignForm.banji" filterable clearable placeholder="全部班级">
								<el-option v-for="item in autoAssignOptions.banji" :key="item" :label="item" :value="item"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="8">
						<el-form-item label="专业">
							<el-select v-model="autoAssignForm.zhuanye" filterable clearable placeholder="全部专业">
								<el-option v-for="item in autoAssignOptions.zhuanye" :key="item" :label="item" :value="item"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="8">
						<el-form-item label="性别">
							<el-select v-model="autoAssignForm.xingbie" clearable placeholder="全部性别" @change="autoAssignGenderChange">
								<el-option v-for="item in autoAssignOptions.xingbie" :key="item" :label="item" :value="item"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="8">
						<el-form-item label="宿舍类型">
							<el-select v-model="autoAssignForm.susheleixing" filterable clearable placeholder="全部类型" @change="autoAssignDormTypeChange">
								<el-option v-for="item in autoAssignOptions.susheleixing" :key="item" :label="item" :value="item"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="8">
						<el-form-item label="楼栋">
							<el-select v-model="autoAssignForm.susheloudong" filterable clearable placeholder="全部楼栋">
								<el-option v-for="item in autoAssignOptions.susheloudong" :key="item" :label="item" :value="item"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="8">
						<el-form-item label="房间号">
							<el-select v-model="autoAssignForm.fangjianhao" filterable clearable placeholder="全部房间">
								<el-option v-for="item in autoAssignOptions.fangjianhao" :key="item" :label="item" :value="item"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="8">
						<el-form-item label="学生学号">
							<el-input v-model="autoAssignForm.xueshengxuehao" clearable placeholder="可输入学号关键词"></el-input>
						</el-form-item>
					</el-col>
					<el-col :span="8">
						<el-form-item label="学生姓名">
							<el-input v-model="autoAssignForm.xueshengxingming" clearable placeholder="可输入姓名关键词"></el-input>
						</el-form-item>
					</el-col>
					<el-col :span="8">
						<el-form-item label="宿舍名称">
							<el-select v-model="autoAssignForm.sushemingcheng" filterable clearable placeholder="全部宿舍">
								<el-option v-for="item in autoAssignOptions.sushemingcheng" :key="item" :label="item" :value="item"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
				</el-row>
			</el-form>
			<div v-if="autoAssignResult" class="auto-assign-summary">
				<div class="summary-card">
					<span>可分配</span>
					<strong>{{autoAssignResult.successCount || 0}}</strong>
				</div>
				<div class="summary-card">
					<span>跳过/失败</span>
					<strong>{{autoAssignResult.failedCount || 0}}</strong>
				</div>
				<div class="summary-card">
					<span>模式</span>
					<strong>{{autoAssignResult.previewOnly ? '预览' : '已执行'}}</strong>
				</div>
			</div>
			<el-tabs v-if="autoAssignResult" class="auto-assign-tabs">
				<el-tab-pane :label="'预览分配 ' + (autoAssignResult.successCount || 0)">
					<el-table :data="autoAssignResult.successList || []" height="260" stripe border>
						<el-table-column prop="xueshengxuehao" label="学号" width="130"></el-table-column>
						<el-table-column prop="xueshengxingming" label="姓名" width="120"></el-table-column>
						<el-table-column prop="sushemingcheng" label="宿舍名称"></el-table-column>
						<el-table-column prop="susheloudong" label="楼栋" width="110"></el-table-column>
						<el-table-column prop="fangjianhao" label="房间号" width="110"></el-table-column>
						<el-table-column prop="chuangweihao" label="床位号" width="110"></el-table-column>
					</el-table>
				</el-tab-pane>
				<el-tab-pane :label="'未分配原因 ' + (autoAssignResult.failedCount || 0)">
					<el-table :data="autoAssignResult.failedList || []" height="260" stripe border>
						<el-table-column prop="xueshengxuehao" label="学号" width="130"></el-table-column>
						<el-table-column prop="xueshengxingming" label="姓名" width="120"></el-table-column>
						<el-table-column prop="reason" label="原因"></el-table-column>
					</el-table>
				</el-tab-pane>
			</el-tabs>
			<span slot="footer" class="dialog-footer">
				<el-button @click="autoAssignDialogVisible = false">关闭</el-button>
				<el-button @click="resetAutoAssignForm">重置条件</el-button>
				<el-button type="primary" icon="el-icon-view" :loading="autoAssignLoading" @click="previewAutoAssign">生成预览</el-button>
				<el-button type="success" icon="el-icon-check" :loading="autoAssignExecuting" :disabled="!autoAssignResult || !autoAssignResult.successCount" @click="executeAutoAssign">确认分配</el-button>
			</span>
		</el-dialog>




	</div>
</template>

<script>
//$graphType1
//$buttonName1
//$subNameList1
import axios from 'axios'
import AddOrUpdate from "./add-or-update";
import shuidianfeiCrossAddOrUpdate from "../shuidianfei/add-or-update";
import jinrususheCrossAddOrUpdate from "../jinrusushe/add-or-update";
import churususheCrossAddOrUpdate from "../churusushe/add-or-update";
import weixiuxinxiCrossAddOrUpdate from "../weixiuxinxi/add-or-update";
import weishengxinxiCrossAddOrUpdate from "../weishengxinxi/add-or-update";
import kaoqinxinxiCrossAddOrUpdate from "../kaoqinxinxi/add-or-update";
export default {
  data() {
    return {
      searchForm: {
        key: ""
      },
      form:{},
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false,
      dataListSelections: [],
      autoAssignDialogVisible: false,
      autoAssignLoading: false,
      autoAssignExecuting: false,
      autoAssignStudents: [],
      autoAssignDorms: [],
      autoAssignForm: {
        banji: '',
        zhuanye: '',
        xingbie: '',
        sushemingcheng: '',
        susheleixing: '',
        susheloudong: '',
        fangjianhao: '',
        xueshengxuehao: '',
        xueshengxingming: ''
      },
      autoAssignOptions: {
        banji: [],
        zhuanye: [],
        xingbie: ['男', '女'],
        sushemingcheng: [],
        susheleixing: [],
        susheloudong: [],
        fangjianhao: []
      },
      autoAssignResult: null,
      autoAssignPreviewKey: '',
      showFlag: true,
      sfshVisiable: false,
      shForm: {},
      chartVisiable: false,
      chartVisiable1: false,
      chartVisiable2: false,
      chartVisiable3: false,
      chartVisiable4: false,
      chartVisiable5: false,
      addOrUpdateFlag:false,
      shuidianfeiCrossAddOrUpdateFlag: false,
      jinrususheCrossAddOrUpdateFlag: false,
      churususheCrossAddOrUpdateFlag: false,
      weixiuxinxiCrossAddOrUpdateFlag: false,
      weishengxinxiCrossAddOrUpdateFlag: false,
      kaoqinxinxiCrossAddOrUpdateFlag: false,
      layouts: ["total","prev","pager","next","sizes","jumper"],

    };
  },
  computed: {
    isStudentView() {
      return this.$storage.get('sessionTable') === 'xuesheng';
    }
  },
  created() {
    this.init();
    this.getDataList();
    this.contentStyleChange()
  },
  mounted() {
  },
  filters: {
    htmlfilter: function (val) {
      return val.replace(/<[^>]*>/g).replace(/undefined/g,'');
    }
  },
  components: {
    AddOrUpdate,
    shuidianfeiCrossAddOrUpdate,
    jinrususheCrossAddOrUpdate,
    churususheCrossAddOrUpdate,
    weixiuxinxiCrossAddOrUpdate,
    weishengxinxiCrossAddOrUpdate,
    kaoqinxinxiCrossAddOrUpdate,
  },
  methods: {

    contentStyleChange() {
      this.contentPageStyleChange()
    },
    // 分页
    contentPageStyleChange(){
      let arr = []

      // if(this.contents.pageTotal) arr.push('total')
      // if(this.contents.pageSizes) arr.push('sizes')
      // if(this.contents.pagePrevNext){
      //   arr.push('prev')
      //   if(this.contents.pagePager) arr.push('pager')
      //   arr.push('next')
      // }
      // if(this.contents.pageJumper) arr.push('jumper')
      // this.layouts = arr.join()
      // this.contents.pageEachNum = 10
    },

    shuidianfeiCrossAddOrUpdateHandler(row,type,crossOptAudit,statusColumnName,tips,statusColumnValue){
      this.showFlag = false;
      this.addOrUpdateFlag = false;
      this.shuidianfeiCrossAddOrUpdateFlag = true;
      this.$storage.set('crossObj',row);
      this.$storage.set('crossTable','sushefenpei');
      this.$storage.set('statusColumnName',statusColumnName);
      this.$storage.set('statusColumnValue',statusColumnValue);
      this.$storage.set('tips',tips);
	if(statusColumnName!=''&&!statusColumnName.startsWith("[")) {
		var obj = this.$storage.getObj('crossObj');
		for (var o in obj){
		  if(o==statusColumnName && obj[o]==statusColumnValue){
		    this.$message({
		      message: tips,
		      type: "success",
		      duration: 1500,
		      onClose: () => {
			this.getDataList();
		      }
		    });
		      this.showFlag = true;
		      this.shuidianfeiCrossAddOrUpdateFlag = false;
			return;
		  }
		}
	}
      this.$nextTick(() => {
      this.$refs.shuidianfeiCrossaddOrUpdate.init(row.id,type);
      });
    },
    jinrususheCrossAddOrUpdateHandler(row,type,crossOptAudit,statusColumnName,tips,statusColumnValue){
      this.showFlag = false;
      this.addOrUpdateFlag = false;
      this.jinrususheCrossAddOrUpdateFlag = true;
      this.$storage.set('crossObj',row);
      this.$storage.set('crossTable','sushefenpei');
      this.$storage.set('statusColumnName',statusColumnName);
      this.$storage.set('statusColumnValue',statusColumnValue);
      this.$storage.set('tips',tips);
	if(statusColumnName!=''&&!statusColumnName.startsWith("[")) {
		var obj = this.$storage.getObj('crossObj');
		for (var o in obj){
		  if(o==statusColumnName && obj[o]==statusColumnValue){
		    this.$message({
		      message: tips,
		      type: "success",
		      duration: 1500,
		      onClose: () => {
			this.getDataList();
		      }
		    });
		      this.showFlag = true;
		      this.jinrususheCrossAddOrUpdateFlag = false;
			return;
		  }
		}
	}
      this.$nextTick(() => {
      this.$refs.jinrususheCrossaddOrUpdate.init(row.id,type);
      });
    },
    churususheCrossAddOrUpdateHandler(row,type,crossOptAudit,statusColumnName,tips,statusColumnValue){
      this.showFlag = false;
      this.addOrUpdateFlag = false;
      this.churususheCrossAddOrUpdateFlag = true;
      this.$storage.set('crossObj',row);
      this.$storage.set('crossTable','sushefenpei');
      this.$storage.set('statusColumnName',statusColumnName);
      this.$storage.set('statusColumnValue',statusColumnValue);
      this.$storage.set('tips',tips);
	if(statusColumnName!=''&&!statusColumnName.startsWith("[")) {
		var obj = this.$storage.getObj('crossObj');
		for (var o in obj){
		  if(o==statusColumnName && obj[o]==statusColumnValue){
		    this.$message({
		      message: tips,
		      type: "success",
		      duration: 1500,
		      onClose: () => {
			this.getDataList();
		      }
		    });
		      this.showFlag = true;
		      this.churususheCrossAddOrUpdateFlag = false;
			return;
		  }
		}
	}
      this.$nextTick(() => {
      this.$refs.churususheCrossaddOrUpdate.init(row.id,type);
      });
    },
    weixiuxinxiCrossAddOrUpdateHandler(row,type,crossOptAudit,statusColumnName,tips,statusColumnValue){
      this.showFlag = false;
      this.addOrUpdateFlag = false;
      this.weixiuxinxiCrossAddOrUpdateFlag = true;
      this.$storage.set('crossObj',row);
      this.$storage.set('crossTable','sushefenpei');
      this.$storage.set('statusColumnName',statusColumnName);
      this.$storage.set('statusColumnValue',statusColumnValue);
      this.$storage.set('tips',tips);
	if(statusColumnName!=''&&!statusColumnName.startsWith("[")) {
		var obj = this.$storage.getObj('crossObj');
		for (var o in obj){
		  if(o==statusColumnName && obj[o]==statusColumnValue){
		    this.$message({
		      message: tips,
		      type: "success",
		      duration: 1500,
		      onClose: () => {
			this.getDataList();
		      }
		    });
		      this.showFlag = true;
		      this.weixiuxinxiCrossAddOrUpdateFlag = false;
			return;
		  }
		}
	}
      this.$nextTick(() => {
      this.$refs.weixiuxinxiCrossaddOrUpdate.init(row.id,type);
      });
    },
    weishengxinxiCrossAddOrUpdateHandler(row,type,crossOptAudit,statusColumnName,tips,statusColumnValue){
      this.showFlag = false;
      this.addOrUpdateFlag = false;
      this.weishengxinxiCrossAddOrUpdateFlag = true;
      this.$storage.set('crossObj',row);
      this.$storage.set('crossTable','sushefenpei');
      this.$storage.set('statusColumnName',statusColumnName);
      this.$storage.set('statusColumnValue',statusColumnValue);
      this.$storage.set('tips',tips);
	if(statusColumnName!=''&&!statusColumnName.startsWith("[")) {
		var obj = this.$storage.getObj('crossObj');
		for (var o in obj){
		  if(o==statusColumnName && obj[o]==statusColumnValue){
		    this.$message({
		      message: tips,
		      type: "success",
		      duration: 1500,
		      onClose: () => {
			this.getDataList();
		      }
		    });
		      this.showFlag = true;
		      this.weishengxinxiCrossAddOrUpdateFlag = false;
			return;
		  }
		}
	}
      this.$nextTick(() => {
      this.$refs.weishengxinxiCrossaddOrUpdate.init(row.id,type);
      });
    },
    kaoqinxinxiCrossAddOrUpdateHandler(row,type,crossOptAudit,statusColumnName,tips,statusColumnValue){
      this.showFlag = false;
      this.addOrUpdateFlag = false;
      this.kaoqinxinxiCrossAddOrUpdateFlag = true;
      this.$storage.set('crossObj',row);
      this.$storage.set('crossTable','sushefenpei');
      this.$storage.set('statusColumnName',statusColumnName);
      this.$storage.set('statusColumnValue',statusColumnValue);
      this.$storage.set('tips',tips);
	if(statusColumnName!=''&&!statusColumnName.startsWith("[")) {
		var obj = this.$storage.getObj('crossObj');
		for (var o in obj){
		  if(o==statusColumnName && obj[o]==statusColumnValue){
		    this.$message({
		      message: tips,
		      type: "success",
		      duration: 1500,
		      onClose: () => {
			this.getDataList();
		      }
		    });
		      this.showFlag = true;
		      this.kaoqinxinxiCrossAddOrUpdateFlag = false;
			return;
		  }
		}
	}
      this.$nextTick(() => {
      this.$refs.kaoqinxinxiCrossaddOrUpdate.init(row.id,type);
      });
    },







    init () {
    },
    search() {
      this.pageIndex = 1;
      this.getDataList();
    },
    openAutoAssignDialog() {
      this.autoAssignDialogVisible = true;
      this.autoAssignResult = null;
      this.autoAssignPreviewKey = '';
      this.loadAutoAssignOptions();
    },
    loadAutoAssignOptions() {
      Promise.all([
        this.$http({
          url: "xuesheng/list",
          method: "get",
          params: {
            page: 1,
            limit: 1000
          }
        }),
        this.$http({
          url: "sushexinxi/list",
          method: "get",
          params: {
            page: 1,
            limit: 1000,
            sort: "susheloudong",
            order: "asc"
          }
        })
      ]).then(([studentRes, dormRes]) => {
        this.autoAssignStudents = studentRes.data && studentRes.data.code === 0 ? (studentRes.data.data.list || []) : [];
        this.autoAssignDorms = dormRes.data && dormRes.data.code === 0 ? (dormRes.data.data.list || []) : [];
        this.refreshAutoAssignOptions();
      });
    },
    refreshAutoAssignOptions() {
      this.autoAssignOptions.banji = this.getUniqueValues(this.autoAssignStudents, "banji");
      this.autoAssignOptions.zhuanye = this.getUniqueValues(this.autoAssignStudents, "zhuanye");
      this.autoAssignOptions.sushemingcheng = this.getUniqueValues(this.autoAssignDorms, "sushemingcheng");
      this.autoAssignOptions.susheleixing = this.getUniqueValues(this.autoAssignDorms, "susheleixing");
      this.autoAssignOptions.susheloudong = this.getUniqueValues(this.autoAssignDorms, "susheloudong");
      this.autoAssignOptions.fangjianhao = this.getUniqueValues(this.autoAssignDorms, "fangjianhao");
    },
    getUniqueValues(list, key) {
      return Array.from(new Set((list || []).map(item => item[key]).filter(item => item)));
    },
    autoAssignGenderChange() {
      if (!this.autoAssignForm.xingbie || this.autoAssignForm.susheleixing) {
        return;
      }
      const matchedType = this.autoAssignOptions.susheleixing.find(item => String(item).indexOf(this.autoAssignForm.xingbie) !== -1);
      if (matchedType) {
        this.autoAssignForm.susheleixing = matchedType;
      }
    },
    autoAssignDormTypeChange() {
      if (!this.autoAssignForm.susheleixing || this.autoAssignForm.xingbie) {
        return;
      }
      if (String(this.autoAssignForm.susheleixing).indexOf("男") !== -1) {
        this.autoAssignForm.xingbie = "男";
      } else if (String(this.autoAssignForm.susheleixing).indexOf("女") !== -1) {
        this.autoAssignForm.xingbie = "女";
      }
    },
    resetAutoAssignForm() {
      this.autoAssignForm = {
        banji: '',
        zhuanye: '',
        xingbie: '',
        sushemingcheng: '',
        susheleixing: '',
        susheloudong: '',
        fangjianhao: '',
        xueshengxuehao: '',
        xueshengxingming: ''
      };
      this.autoAssignResult = null;
      this.autoAssignPreviewKey = '';
    },
    buildAutoAssignPayload(previewOnly) {
      return Object.assign({}, this.autoAssignForm, {
        previewOnly: previewOnly
      });
    },
    getAutoAssignFormKey() {
      return JSON.stringify(this.buildAutoAssignPayload(true));
    },
    previewAutoAssign() {
      this.submitAutoAssign(true);
    },
    executeAutoAssign() {
      if (this.autoAssignPreviewKey !== this.getAutoAssignFormKey()) {
        this.$message.warning("筛选条件已变更，请重新生成预览后再确认分配");
        return;
      }
      this.$confirm("确认按照当前预览结果写入入住分配记录吗？", "确认分配", {
        confirmButtonText: "确认分配",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.submitAutoAssign(false);
      });
    },
    submitAutoAssign(previewOnly) {
      if (previewOnly) {
        this.autoAssignLoading = true;
      } else {
        this.autoAssignExecuting = true;
      }
      this.$http({
        url: "sushefenpei/autoAssign",
        method: "post",
        data: this.buildAutoAssignPayload(previewOnly)
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.autoAssignResult = data;
          this.autoAssignPreviewKey = previewOnly ? this.getAutoAssignFormKey() : '';
          this.$message.success(data.msg || "操作成功");
          if (!previewOnly) {
            this.getDataList();
          }
        } else {
          this.$message.error(data.msg || "操作失败");
        }
        this.autoAssignLoading = false;
        this.autoAssignExecuting = false;
      }).catch(() => {
        this.autoAssignLoading = false;
        this.autoAssignExecuting = false;
        this.$message.error("一键分配请求失败");
      });
    },

    // 获取数据列表
    getDataList() {
      this.dataListLoading = true;
      let params = {
        page: this.pageIndex,
        limit: this.pageSize,
        sort: 'id',
        order: 'desc',
      }
           if(this.searchForm.sushemingcheng!='' && this.searchForm.sushemingcheng!=undefined){
            params['sushemingcheng'] = '%' + this.searchForm.sushemingcheng + '%'
          }
           if(this.searchForm.xueshengxingming!='' && this.searchForm.xueshengxingming!=undefined){
            params['xueshengxingming'] = '%' + this.searchForm.xueshengxingming + '%'
          }
      this.$http({
        url: "sushefenpei/page",
        method: "get",
        params: params
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.dataList = data.data.list;
          this.totalPage = data.data.total;
        } else {
          this.dataList = [];
          this.totalPage = 0;
        }
        this.dataListLoading = false;
      });
    },
    // 每页数
    sizeChangeHandle(val) {
      this.pageSize = val;
      this.pageIndex = 1;
      this.getDataList();
    },
    // 当前页
    currentChangeHandle(val) {
      this.pageIndex = val;
      this.getDataList();
    },
    // 多选
    selectionChangeHandler(val) {
      this.dataListSelections = val;
    },
    // 添加/修改
    addOrUpdateHandler(id,type) {
      this.showFlag = false;
      this.addOrUpdateFlag = true;
      this.crossAddOrUpdateFlag = false;
      if(type!='info'){
        type = 'else';
      }
      this.$nextTick(() => {
        this.$refs.addOrUpdate.init(id,type);
      });
    },
    // 下载
    download(file){
      window.open(`${file}`)
    },
    // 删除
    deleteHandler(id) {
      var ids = id
        ? [Number(id)]
        : this.dataListSelections.map(item => {
            return Number(item.id);
          });
      this.$confirm(`确定进行[${id ? "删除" : "批量删除"}]操作?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "sushefenpei/delete",
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
    },


  }

};
</script>
<style lang="scss" scoped>
	.roommate-tip {
		display: flex;
		align-items: center;
		gap: 10px;
		margin: 0 20px 20px;
		padding: 12px 16px;
		border: 1px solid rgba(135, 154, 108, 0.28);
		border-radius: 12px;
		background: linear-gradient(135deg, rgba(245, 248, 240, 0.96), rgba(234, 239, 226, 0.92));
		color: #546045;
		font-size: 13px;
		line-height: 1.6;
		box-shadow: 0 8px 24px rgba(91, 103, 76, 0.08);
	}

	.roommate-tip i {
		font-size: 16px;
		color: #7d8d63;
	}

	.allocation-tip {
		background: linear-gradient(135deg, rgba(244, 246, 239, 0.98), rgba(232, 236, 224, 0.94));
	}

	.auto-assign-dialog ::v-deep .el-dialog {
		border-radius: 14px;
		overflow: hidden;
	}

	.auto-assign-dialog ::v-deep .el-dialog__header {
		background: linear-gradient(135deg, #eff8e8, #e6f7f1);
		border-bottom: 1px solid rgba(114, 177, 94, 0.22);
	}

	.auto-assign-dialog ::v-deep .el-dialog__title {
		color: #315a3a;
		font-size: 18px;
		font-weight: 700;
	}

	.auto-assign-form {
		margin-top: 18px;
		padding: 18px 18px 2px;
		border-radius: 12px;
		background: #fbfef8;
		border: 1px solid rgba(137, 195, 112, 0.22);
	}

	.auto-assign-form ::v-deep .el-select,
	.auto-assign-form ::v-deep .el-input {
		width: 100%;
	}

	.auto-assign-summary {
		display: grid;
		grid-template-columns: repeat(3, minmax(0, 1fr));
		gap: 12px;
		margin: 16px 0 8px;
	}

	.summary-card {
		padding: 14px 16px;
		border-radius: 10px;
		background: linear-gradient(135deg, #f7fbe9, #ecf9f3);
		border: 1px solid rgba(102, 166, 87, 0.22);
	}

	.summary-card span {
		display: block;
		color: #6f8064;
		font-size: 13px;
		margin-bottom: 6px;
	}

	.summary-card strong {
		color: #315a3a;
		font-size: 24px;
		line-height: 1;
	}

	.auto-assign-tabs ::v-deep .el-tabs__item {
		font-size: 15px;
	}
	
	.center-form-pv {
	  .el-date-editor.el-input {
	    width: auto;
	  }
	}
	
	.el-input {
	  width: auto;
	}
	
	// form
	.center-form-pv .el-input  ::v-deep .el-input__inner {
				border: 2px solid #4e6ae2;
				border-radius: 4px;
				padding: 0 12px;
				box-shadow: 5px 2px 0px 0px #4e6ae2;
				outline: none;
				color: #333;
				width: 160px;
				font-size: 14px;
				height: 40px;
			}
	
	.center-form-pv .el-select  ::v-deep .el-input__inner {
				border: 2px solid #4e6ae2;
				border-radius: 4px;
				padding: 0 10px;
				box-shadow: 5px 2px 0px 0px #4e6ae2;
				outline: none;
				color: #333;
				width: 160px;
				font-size: 14px;
				height: 40px;
			}
	
	.center-form-pv .el-date-editor  ::v-deep .el-input__inner {
				border: 2px solid #4e6ae2;
				border-radius: 4px;
				padding: 0 10px 0 30px;
				box-shadow: 5px 2px 0px 0px #4e6ae2;
				outline: none;
				color: #333;
				width: 160px;
				font-size: 14px;
				height: 40px;
			}
	
	// table
	.el-table  ::v-deep .el-table__header-wrapper thead {
				color: #fff;
				font-weight: 500;
				width: 100%;
			}
	
	.el-table  ::v-deep .el-table__header-wrapper thead tr {
				background: #fff;
			}
	
	.el-table  ::v-deep .el-table__header-wrapper thead tr th {
				padding: 12px 0;
				background: rgba(78, 106, 226, 1);
				border-color: #eee;
				border-width: 0 1px 1px 0;
				border-style: solid;
				text-align: center;
			}

	.el-table  ::v-deep .el-table__header-wrapper thead tr th .cell {
				padding: 0 10px;
				word-wrap: normal;
				word-break: break-all;
				white-space: normal;
				font-weight: bold;
				display: inline-block;
				vertical-align: middle;
				width: 100%;
				line-height: 24px;
				position: relative;
				text-overflow: ellipsis;
			}

	
	.el-table  ::v-deep .el-table__body-wrapper tbody {
				width: 100%;
			}

	.el-table  ::v-deep .el-table__body-wrapper tbody tr {
				background: #fff;
			}
	
	.el-table  ::v-deep .el-table__body-wrapper tbody tr td {
				padding: 12px 0;
				color: #999;
				background: #fff;
				border-color: #eee;
				border-width: 0 1px 1px 0;
				border-style: solid;
				text-align: center;
			}
	
		
	.el-table  ::v-deep .el-table__body-wrapper tbody tr:hover td {
				padding: 12px 0;
				color: #000;
				border-color: #eee;
				border-width: 0 1px 1px 0;
				border-style: solid;
				text-align: center;
			}
	
	.el-table  ::v-deep .el-table__body-wrapper tbody tr td {
				padding: 12px 0;
				color: #999;
				background: #fff;
				border-color: #eee;
				border-width: 0 1px 1px 0;
				border-style: solid;
				text-align: center;
			}

	.el-table  ::v-deep .el-table__body-wrapper tbody tr td .cell {
				padding: 0 10px;
				overflow: hidden;
				word-break: break-all;
				white-space: normal;
				line-height: 24px;
				text-overflow: ellipsis;
			}
	
	// pagination
	.main-content .el-pagination  ::v-deep .el-pagination__total {
				margin: 0 10px 0 0;
				color: #666;
				font-weight: 400;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}
	
	.main-content .el-pagination  ::v-deep .btn-prev {
				border: none;
				border-radius: 2px;
				padding: 0;
				margin: 0 5px;
				color: #666;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				min-width: 35px;
				height: 28px;
			}
	
	.main-content .el-pagination  ::v-deep .btn-next {
				border: none;
				border-radius: 2px;
				padding: 0;
				margin: 0 5px;
				color: #666;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				min-width: 35px;
				height: 28px;
			}
	
	.main-content .el-pagination  ::v-deep .btn-prev:disabled {
				border: none;
				cursor: not-allowed;
				border-radius: 2px;
				padding: 0;
				margin: 0 5px;
				color: #C0C4CC;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}
	
	.main-content .el-pagination  ::v-deep .btn-next:disabled {
				border: none;
				cursor: not-allowed;
				border-radius: 2px;
				padding: 0;
				margin: 0 5px;
				color: #C0C4CC;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}

	.main-content .el-pagination  ::v-deep .el-pager {
				padding: 0;
				margin: 0;
				display: inline-block;
				vertical-align: top;
			}

	.main-content .el-pagination  ::v-deep .el-pager .number {
				cursor: pointer;
				padding: 0 4px;
				margin: 0 5px;
				color: #666;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: #f4f4f5;
				text-align: center;
				min-width: 30px;
				height: 28px;
			}
	
	.main-content .el-pagination  ::v-deep .el-pager .number:hover {
				cursor: pointer;
				padding: 0 4px;
				margin: 0 5px;
				color: #4e6ae2;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: #f4f4f5;
				text-align: center;
				min-width: 30px;
				height: 28px;
			}
	
	.main-content .el-pagination  ::v-deep .el-pager .number.active {
				cursor: default;
				padding: 0 4px;
				margin: 0 5px;
				color: #FFF;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: #4e6ae2;
				text-align: center;
				min-width: 30px;
				height: 28px;
			}
	
	.main-content .el-pagination  ::v-deep .el-pagination__sizes {
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}
	
	.main-content .el-pagination  ::v-deep .el-pagination__sizes .el-input {
				margin: 0 5px;
				width: 100px;
				position: relative;
			}
	
	.main-content .el-pagination  ::v-deep .el-pagination__sizes .el-input .el-input__inner {
				border: 1px solid #DCDFE6;
				cursor: pointer;
				padding: 0 25px 0 8px;
				color: #606266;
				display: inline-block;
				font-size: 13px;
				line-height: 28px;
				border-radius: 3px;
				outline: 0;
				background: #FFF;
				width: 100%;
				text-align: center;
				height: 28px;
			}
	
	.main-content .el-pagination  ::v-deep .el-pagination__sizes .el-input span.el-input__suffix {
				top: 0;
				position: absolute;
				right: 0;
				height: 100%;
			}
	
	.main-content .el-pagination  ::v-deep .el-pagination__sizes .el-input .el-input__suffix .el-select__caret {
				cursor: pointer;
				color: #C0C4CC;
				width: 25px;
				font-size: 14px;
				line-height: 28px;
				text-align: center;
			}
	
	.main-content .el-pagination  ::v-deep .el-pagination__jump {
				margin: 0 0 0 24px;
				color: #606266;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}
	
	.main-content .el-pagination  ::v-deep .el-pagination__jump .el-input {
				border-radius: 3px;
				padding: 0 2px;
				margin: 0 2px;
				display: inline-block;
				width: 50px;
				font-size: 14px;
				line-height: 18px;
				position: relative;
				text-align: center;
				height: 28px;
			}
	
	.main-content .el-pagination  ::v-deep .el-pagination__jump .el-input .el-input__inner {
				border: 1px solid #DCDFE6;
				cursor: pointer;
				padding: 0 3px;
				color: #606266;
				display: inline-block;
				font-size: 14px;
				line-height: 28px;
				border-radius: 3px;
				outline: 0;
				background: #FFF;
				width: 100%;
				text-align: center;
				height: 28px;
			}
</style>
