<template>
	<div class="main-content" :style='{"padding":"30px 0 0 0"}'>
		<!-- 列表页 -->
		<template v-if="showFlag">
			<div class="attendance-tip">
				<i class="el-icon-warning-outline"></i>
				<span>考勤统计用于登记晚归、未归和违纪备注，作为宿舍管理、评优和异常提醒依据。</span>
			</div>
			<el-form class="center-form-pv" :style='{"width":"180px","margin":"0 0 20px 20px","position":"absolute","zIndex":"1003"}' :inline="true" :model="searchForm">
				<el-row :style='{"display":"block"}' >
					<div v-if="!isStudentView" :style='{"margin":"0 0px 15px 0","display":"inline-block"}'>
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">宿舍名称</label>
						<el-input v-model="searchForm.sushemingcheng" placeholder="宿舍名称" clearable></el-input>
					</div>
					<div v-if="!isStudentView" :style='{"margin":"0 0px 15px 0","display":"inline-block"}'>
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">楼栋</label>
						<el-input v-model="searchForm.susheloudong" placeholder="宿舍楼栋" clearable></el-input>
					</div>
					<div :style='{"margin":"0 0px 15px 0","display":"inline-block"}'>
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">月份</label>
						<el-input v-model="searchForm.yuefen" placeholder="月份" clearable></el-input>
					</div>
					<div v-if="!isStudentView" :style='{"margin":"0 0px 15px 0","display":"inline-block"}'>
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">学生姓名</label>
						<el-input v-model="searchForm.xueshengxingming" placeholder="学生姓名" clearable></el-input>
					</div>
					<div :style='{"margin":"0 0px 15px 0","display":"inline-block"}' class="select">
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">异常类型</label>
						<el-select clearable v-model="searchForm.abnormalType" placeholder="异常类型">
							<el-option v-for="item in abnormalTypeOptions" :key="item" :label="item" :value="item"></el-option>
						</el-select>
					</div>
					<el-button :style='{"border":"2px solid #4e6ae2","cursor":"pointer","padding":"0 20px","outline":"none","margin":"0px 0 5px 0","color":"#4e6ae2","borderRadius":"40px","background":"#fff","width":"160px","fontSize":"14px","height":"40px"}' type="success" @click="search()">查询</el-button>
				</el-row>

				<el-row :style='{"width":"170px","margin":"10px 0 0","flexDirection":"column","display":"flex"}'>
						<el-button :style='{"border":"0","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#fff","borderRadius":"40px","background":"linear-gradient(135deg,#5fb98a,#86cc6a)","width":"160px","fontSize":"14px","height":"40px"}' v-if="isAuth('kaoqinxinxi','新增') && !isStudentView" type="success" icon="el-icon-edit-outline" @click="addOrUpdateHandler()">登记异常</el-button>
						<el-button :style='{"border":"2px solid #5fb98a","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#3f8d67","borderRadius":"40px","background":"#f6fff8","width":"160px","fontSize":"14px","height":"40px"}' v-if="!isStudentView" type="success" icon="el-icon-refresh" @click="rebuildMonthlyAttendance()">重算月考勤</el-button>
						<el-button :style='{"border":"2px solid #5fb98a","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#3f8d67","borderRadius":"40px","background":"#f6fff8","width":"160px","fontSize":"14px","height":"40px"}' v-if="$storage.get('sessionTable') !== 'xuesheng'" type="success" icon="el-icon-download" @click="$exportTable('kaoqinxinxi')">导出Excel</el-button>
						<el-button :style='{"border":"2px solid #e0b64a","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#9c7427","borderRadius":"40px","background":"#fffaf0","width":"160px","fontSize":"14px","height":"40px"}' v-if="isAuth('kaoqinxinxi','新增') && !isStudentView" type="warning" icon="el-icon-upload2" @click="$importTable('kaoqinxinxi', getDataList)">导入Excel</el-button>
						<el-button :style='{"border":"2px solid #4e6ae2","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#4e6ae2","borderRadius":"40px","background":"#fff","width":"160px","fontSize":"14px","height":"40px"}' v-if="isAuth('kaoqinxinxi','删除') && !isStudentView" :disabled="dataListSelections.length <= 0" type="danger" @click="deleteHandler()">删除</el-button>




				</el-row>
			</el-form>

			<div class="attendance-summary">
				<div class="summary-card">
					<span>晚归累计</span>
					<strong>{{attendanceStats.late}}</strong>
				</div>
				<div class="summary-card">
					<span>未归累计</span>
					<strong>{{attendanceStats.absent}}</strong>
				</div>
				<div class="summary-card">
					<span>违纪备注</span>
					<strong>{{attendanceStats.violation}}</strong>
				</div>
			</div>

			<!-- <div> -->
				<el-table class="tables"
					:stripe='false'
					:style='{"padding":"0","boxShadow":" 0px 4px 10px 0px rgba(0,0,0,0.3020)","borderColor":"#eee","margin":"0 0 15px 210px","borderWidth":"1px 0 0 1px","background":"#fff","width":"calc(100% - 230px)","borderStyle":"solid"}' 
					v-if="isAuth('kaoqinxinxi','查看')"
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
						prop="yuefen"
					label="月份">
						<template slot-scope="scope">
							{{scope.row.yuefen}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="xueshengxuehao"
					label="学生学号"
					v-if="!isStudentView">
						<template slot-scope="scope">
							{{scope.row.xueshengxuehao}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="xueshengxingming"
					label="学生姓名"
					v-if="!isStudentView">
						<template slot-scope="scope">
							{{scope.row.xueshengxingming}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="wanguitianshu"
					label="晚归天数">
						<template slot-scope="scope">
							{{scope.row.wanguitianshu}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'
						prop="queqintianshu"
					label="未归天数">
						<template slot-scope="scope">
							{{scope.row.queqintianshu}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="qingjiatianshu"
					label="请假天数">
						<template slot-scope="scope">
							{{scope.row.qingjiatianshu}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="dengjishijian"
					label="登记时间">
						<template slot-scope="scope">
							{{scope.row.dengjishijian}}
						</template>
					</el-table-column>
					<el-table-column label="异常等级" width="120">
						<template slot-scope="scope">
							<el-tag :type="abnormalLevelType(scope.row)" size="mini">{{abnormalLevelText(scope.row)}}</el-tag>
						</template>
					</el-table-column>
					<el-table-column prop="beizhu" label="违纪/处理备注">
						<template slot-scope="scope">
							<span v-html="scope.row.beizhu"></span>
						</template>
					</el-table-column>
					<el-table-column width="300" label="操作">
						<template slot-scope="scope">
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if=" isAuth('kaoqinxinxi','查看')" type="success" size="mini" @click="addOrUpdateHandler(scope.row.id,'info')">详情</el-button>
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if=" isAuth('kaoqinxinxi','修改') && !isStudentView" type="primary" size="mini" @click="addOrUpdateHandler(scope.row.id)">补充处理</el-button>





							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if="isAuth('kaoqinxinxi','删除') && !isStudentView" type="danger" size="mini" @click="deleteHandler(scope.row.id)">删除</el-button>
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





	</div>
</template>

<script>
//$graphType1
//$buttonName1
//$subNameList1
import axios from 'axios'
import AddOrUpdate from "./add-or-update";
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
      abnormalTypeOptions: ['晚归', '未归', '违纪'],
      attendanceStats: {
        late: 0,
        absent: 0,
        violation: 0
      },
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
      layouts: ["total","prev","pager","next","sizes","jumper"],

    };
  },
  created() {
    this.init();
    this.getDataList();
    this.loadAttendanceStats();
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
  },
  computed: {
    isStudentView() {
      return this.$storage.get('sessionTable') === 'xuesheng';
    }
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








    init () {
    },
    search() {
      this.pageIndex = 1;
      this.getDataList();
      this.loadAttendanceStats();
    },
    currentMonth() {
      const now = new Date();
      const month = now.getMonth() + 1;
      return `${now.getFullYear()}-${month < 10 ? '0' + month : month}`;
    },
    rebuildMonthlyAttendance() {
      const yuefen = this.searchForm.yuefen || this.currentMonth();
      this.$confirm(`确定根据门禁出入和请假记录重算 ${yuefen} 的月考勤吗？`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "kaoqinxinxi/rebuildMonthly",
          method: "post",
          params: { yuefen }
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({
              message: `${data.msg || '重算完成'}，共更新${data.count || 0}名学生`,
              type: "success",
              duration: 1500,
              onClose: () => {
                this.search();
              }
            });
          } else {
            this.$message.error((data && data.msg) || "重算失败");
          }
        });
      }).catch(() => {});
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
           if(this.searchForm.susheloudong!='' && this.searchForm.susheloudong!=undefined){
            params['susheloudong'] = '%' + this.searchForm.susheloudong + '%'
          }
           if(this.searchForm.yuefen!='' && this.searchForm.yuefen!=undefined){
            params['yuefen'] = '%' + this.searchForm.yuefen + '%'
          }
           if(this.searchForm.xueshengxingming!='' && this.searchForm.xueshengxingming!=undefined){
            params['xueshengxingming'] = '%' + this.searchForm.xueshengxingming + '%'
          }
      this.$http({
        url: "kaoqinxinxi/page",
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
        this.dataList = this.filterAttendanceList(this.dataList);
        if (this.searchForm.abnormalType) {
          this.totalPage = this.dataList.length;
        }
        this.dataListLoading = false;
      });
    },
    buildAttendanceQueryParams() {
      let params = {
        page: 1,
        limit: 1000,
        sort: 'id',
        order: 'desc',
      }
      if(this.searchForm.sushemingcheng!='' && this.searchForm.sushemingcheng!=undefined){
        params['sushemingcheng'] = '%' + this.searchForm.sushemingcheng + '%'
      }
      if(this.searchForm.susheloudong!='' && this.searchForm.susheloudong!=undefined){
        params['susheloudong'] = '%' + this.searchForm.susheloudong + '%'
      }
      if(this.searchForm.yuefen!='' && this.searchForm.yuefen!=undefined){
        params['yuefen'] = '%' + this.searchForm.yuefen + '%'
      }
      if(this.searchForm.xueshengxingming!='' && this.searchForm.xueshengxingming!=undefined){
        params['xueshengxingming'] = '%' + this.searchForm.xueshengxingming + '%'
      }
      return params;
    },
    loadAttendanceStats() {
      this.$http({
        url: "kaoqinxinxi/page",
        method: "get",
        params: this.buildAttendanceQueryParams()
      }).then(({ data }) => {
        const list = data && data.code === 0 ? this.filterAttendanceList(data.data.list || []) : [];
        this.attendanceStats = {
          late: list.reduce((sum, item) => sum + this.numberValue(item.wanguitianshu), 0),
          absent: list.reduce((sum, item) => sum + this.numberValue(item.queqintianshu), 0),
          violation: list.filter(item => this.hasViolationRemark(item)).length
        };
      });
    },
    filterAttendanceList(list) {
      if (!this.searchForm.abnormalType) {
        return list || [];
      }
      return (list || []).filter(item => {
        if (this.searchForm.abnormalType === '晚归') {
          return this.numberValue(item.wanguitianshu) > 0;
        }
        if (this.searchForm.abnormalType === '未归') {
          return this.numberValue(item.queqintianshu) > 0;
        }
        if (this.searchForm.abnormalType === '违纪') {
          return this.hasViolationRemark(item);
        }
        return true;
      });
    },
    numberValue(value) {
      const num = parseInt(value, 10);
      return Number.isNaN(num) ? 0 : num;
    },
    hasViolationRemark(item) {
      const remark = String(item && item.beizhu ? item.beizhu : '').replace(/<[^>]+>/g, '').replace(/&nbsp;/g, '').trim();
      return remark.length > 0;
    },
    abnormalLevelText(row) {
      const score = this.numberValue(row.wanguitianshu) + this.numberValue(row.queqintianshu) * 2 + (this.hasViolationRemark(row) ? 2 : 0);
      if (score >= 5) {
        return '高风险';
      }
      if (score >= 2) {
        return '需关注';
      }
      return '正常';
    },
    abnormalLevelType(row) {
      const text = this.abnormalLevelText(row);
      if (text === '高风险') {
        return 'danger';
      }
      if (text === '需关注') {
        return 'warning';
      }
      return 'success';
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
          url: "kaoqinxinxi/delete",
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
	.attendance-tip {
		display: flex;
		align-items: center;
		gap: 10px;
		margin: 0 20px 20px;
		padding: 12px 16px;
		border: 1px solid rgba(101, 178, 121, 0.26);
		border-radius: 12px;
		background: linear-gradient(135deg, rgba(248, 252, 236, 0.98), rgba(232, 248, 241, 0.94));
		color: #3f6349;
		font-size: 14px;
		line-height: 1.6;
		box-shadow: 0 8px 24px rgba(82, 139, 92, 0.08);
	}

	.attendance-tip i {
		color: #d48b36;
		font-size: 18px;
	}

	.attendance-summary {
		display: grid;
		grid-template-columns: repeat(3, minmax(0, 1fr));
		gap: 12px;
		margin: 0 20px 16px 210px;
		width: calc(100% - 230px);
	}

	.summary-card {
		padding: 14px 16px;
		border-radius: 10px;
		background: linear-gradient(135deg, #f7fbe9, #ecf9f3);
		border: 1px solid rgba(102, 166, 87, 0.22);
		box-shadow: 0 8px 24px rgba(82, 139, 92, 0.08);
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
