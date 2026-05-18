<template>
	<div class="main-content" :style='{"padding":"30px 0 0 0"}'>
		<!-- 列表页 -->
		<template v-if="showFlag">
			<div class="hygiene-tip">
				<i class="el-icon-medal"></i>
				<span>卫生检查以宿舍为单位记录打扫情况、评分和检查评语，系统会按最新记录汇总平均分和排行榜。</span>
			</div>
			<el-form class="center-form-pv" :style='{"width":"180px","margin":"0 0 20px 20px","position":"absolute","zIndex":"1003"}' :inline="true" :model="searchForm">
				<el-row :style='{"display":"block"}' >
					<div :style='{"margin":"0 0px 15px 0","display":"inline-block"}'>
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">宿舍名称</label>
						<el-input v-model="searchForm.sushemingcheng" placeholder="宿舍名称" clearable></el-input>
					</div>
					<div :style='{"margin":"0 0px 15px 0","display":"inline-block"}'>
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">楼栋</label>
						<el-input v-model="searchForm.susheloudong" placeholder="宿舍楼栋" clearable></el-input>
					</div>
					<div :style='{"margin":"0 0px 15px 0","display":"inline-block"}' class="select" label="卫生情况" prop="weishengqingkuang">
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">卫生情况</label>
						<el-select  @change="weishengqingkuangChange" clearable v-model="searchForm.weishengqingkuang" placeholder="请选择卫生情况">
							<el-option v-for="(item,index) in weishengqingkuangOptions" v-bind:key="index" :label="item" :value="item"></el-option>
						</el-select>
					</div>
					<div :style='{"margin":"0 0px 15px 0","display":"inline-block"}' class="select">
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">是否通过</label>
						<el-select  @change="sfshChange" clearable v-model="searchForm.sfsh" placeholder="是否通过">
							<el-option v-for="(item,index) in sfshOptions" v-bind:key="index" :label="item" :value="item"></el-option>
						</el-select>
					</div>
					<div :style='{"margin":"0 0px 15px 0","display":"inline-block"}' class="date">
						<label :style='{"margin":"0 10px 0 0","color":"#666","textAlign":"center","display":"inline-block","width":"auto","lineHeight":"40px","fontSize":"14px","fontWeight":"500","height":"40px"}' class="item-label">检查日期</label>
						<el-date-picker value-format="yyyy-MM-dd" v-model="searchForm.dengjiriqi" type="date" placeholder="检查日期" clearable></el-date-picker>
					</div>
					<el-button :style='{"border":"2px solid #4e6ae2","cursor":"pointer","padding":"0 20px","outline":"none","margin":"0px 0 5px 0","color":"#4e6ae2","borderRadius":"40px","background":"#fff","width":"160px","fontSize":"14px","height":"40px"}' type="success" @click="search()">查询</el-button>
				</el-row>

				<el-row :style='{"width":"170px","margin":"10px 0 0","flexDirection":"column","display":"flex"}'>
					<el-button :style='{"border":"0","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#fff","borderRadius":"40px","background":"linear-gradient(135deg,#5fb98a,#86cc6a)","width":"160px","fontSize":"14px","height":"40px"}' v-if="isAuth('weishengxinxi','新增')" type="success" icon="el-icon-edit-outline" @click="addOrUpdateHandler()">登记检查</el-button>
					<el-button :style='{"border":"2px solid #6bbf7b","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#477a4f","borderRadius":"40px","background":"#fff","width":"160px","fontSize":"14px","height":"40px"}' v-if="isAuth('weishengxinxi','查看')" type="success" icon="el-icon-medal" @click="openHygieneRanking()">评分排行</el-button>
					<el-button :style='{"border":"2px solid #6bbf7b","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#477a4f","borderRadius":"40px","background":"#fff","width":"160px","fontSize":"14px","height":"40px"}' v-if="isAuth('weishengxinxi','查看')" type="success" icon="el-icon-download" @click="$exportTable('weishengxinxi')">导出Excel</el-button>
					<el-button :style='{"border":"2px solid #4e6ae2","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#4e6ae2","borderRadius":"40px","background":"#fff","width":"160px","fontSize":"14px","height":"40px"}' v-if="isAuth('weishengxinxi','删除')" :disabled="dataListSelections.length <= 0" type="danger" @click="deleteHandler()">删除</el-button>


					<el-button :style='{"border":"2px solid #4e6ae2","cursor":"pointer","padding":"0 24px","margin":"0 10px 5px 0","outline":"none","color":"#4e6ae2","borderRadius":"40px","background":"#fff","width":"160px","fontSize":"14px","height":"40px"}' v-if="isAuth('weishengxinxi','审核')" :disabled="dataListSelections.length <= 0" type="danger" @click="shBatchDialog()">批量审核</el-button>


				</el-row>
			</el-form>

			<div class="hygiene-summary">
				<div class="summary-card">
					<span>检查记录</span>
					<strong>{{hygieneStats.total}}</strong>
				</div>
				<div class="summary-card">
					<span>平均评分</span>
					<strong>{{hygieneStats.averageScore}}</strong>
				</div>
				<div class="summary-card">
					<span>优秀宿舍</span>
					<strong>{{hygieneStats.excellentCount}}</strong>
				</div>
			</div>

			<!-- <div> -->
				<el-table class="tables"
					:stripe='false'
					:style='{"padding":"0","boxShadow":" 0px 4px 10px 0px rgba(0,0,0,0.3020)","borderColor":"#eee","margin":"0 0 15px 210px","borderWidth":"1px 0 0 1px","background":"#fff","width":"calc(100% - 230px)","borderStyle":"solid"}' 
					v-if="isAuth('weishengxinxi','查看')"
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
						prop="weishengqingkuang"
					label="卫生情况">
						<template slot-scope="scope">
							{{scope.row.weishengqingkuang}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="dengjiriqi"
					label="登记日期">
						<template slot-scope="scope">
							{{scope.row.dengjiriqi}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="pingfen"
					label="评分">
						<template slot-scope="scope">
							<div class="score-cell">
								<span>{{normalizeScore(scope.row.pingfen)}}分</span>
								<el-progress :percentage="normalizeScore(scope.row.pingfen)" :stroke-width="8" :show-text="false"></el-progress>
							</div>
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="xiangqing" label="检查评语">
						<template slot-scope="scope">
							<span v-html="scope.row.xiangqing"></span>
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="shhf" label="审核回复"></el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="sfsh" label="审核状态">
						<template slot-scope="scope">
							<span style="margin-right:10px" v-if="scope.row.sfsh=='是'">通过</span>
							<span style="margin-right:10px" v-if="scope.row.sfsh=='否'">未通过</span>
							<span style="margin-right:10px" v-if="scope.row.sfsh=='待审核'">待审核</span>
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' v-if="isAuth('weishengxinxi','审核')" prop="sfsh" label="审核">
						<template slot-scope="scope">
							<el-button  type="text" size="small" @click="shDialog(scope.row)">审核</el-button>
						</template>
					</el-table-column>
					<el-table-column width="300" label="操作">
						<template slot-scope="scope">
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if=" isAuth('weishengxinxi','查看')" type="success" size="mini" @click="addOrUpdateHandler(scope.row.id,'info')">详情</el-button>
							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if=" isAuth('weishengxinxi','修改')" type="primary" size="mini" @click="addOrUpdateHandler(scope.row.id)">修改</el-button>





							<el-button :style='{"border":"1px solid rgba(135, 154, 108, 1)","cursor":"pointer","padding":"0 10px","margin":"0 10px 5px 0","outline":"none","color":"rgba(135, 154, 108, 1)","borderRadius":"4px","background":"#fff","width":"auto","fontSize":"14px","height":"32px"}' v-if="isAuth('weishengxinxi','删除') " type="danger" size="mini" @click="deleteHandler(scope.row.id)">删除</el-button>
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


		<el-dialog title="审核" :visible.sync="sfshVisiable" width="50%">
			<el-form ref="form" :model="form" label-width="80px">
				<el-form-item label="审核状态">
					<el-select v-model="shForm.sfsh" placeholder="审核状态">
						<el-option label="通过" value="是"></el-option>
						<el-option label="不通过" value="否"></el-option>
						<el-option label="待审核" value="待审核"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item class="input" label="评分" prop="pingfen">
					<el-input v-model="shForm.pingfen" placeholder="评分" ></el-input>
				</el-form-item>
				<el-form-item label="内容">
					<el-input type="textarea" :rows="8" v-model="shForm.shhf"></el-input>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button @click="shDialog">取 消</el-button>
				<el-button type="primary" @click="shHandler">确 定</el-button>
			</span>
		</el-dialog>
		<el-dialog title="批量审核" :visible.sync="sfshBatchVisiable" width="50%">
			<el-form ref="form" :model="form" label-width="80px">
				<el-form-item label="审核状态">
					<el-select v-model="shBatchForm.sfsh" placeholder="审核状态">
						<el-option label="通过" value="是"></el-option>
						<el-option label="不通过" value="否"></el-option>
						<el-option label="待审核" value="待审核"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="内容">
					<el-input type="textarea" :rows="8" v-model="shBatchForm.shhf"></el-input>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button @click="shBatchDialog">取 消</el-button>
				<el-button type="primary" @click="shBatchHandler">确 定</el-button>
			</span>
		</el-dialog>
		<el-dialog title="卫生评分排行榜" :visible.sync="hygieneRankingVisible" width="720px" class="hygiene-ranking-dialog">
			<el-table :data="hygieneRanking" height="380" stripe>
				<el-table-column type="index" label="排名" width="70"></el-table-column>
				<el-table-column prop="sushemingcheng" label="宿舍名称"></el-table-column>
				<el-table-column prop="susheloudong" label="楼栋" width="110"></el-table-column>
				<el-table-column prop="fangjianhao" label="房间号" width="110"></el-table-column>
				<el-table-column label="评分" width="180">
					<template slot-scope="scope">
						<div class="score-cell">
							<span>{{scope.row.normalizedScore}}分</span>
							<el-progress :percentage="scope.row.normalizedScore" :stroke-width="8" :show-text="false"></el-progress>
						</div>
					</template>
				</el-table-column>
			</el-table>
		</el-dialog>



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
      showFlag: true,
      sfshVisiable: false,
      shForm: {},
      sfshBatchVisiable: false,
      shBatchForm: {
        sfsh:'',
        shhf:''
      },
      batchIds:[], 
      hygieneStats: {
        total: 0,
        averageScore: 0,
        excellentCount: 0
      },
      hygieneRankingVisible: false,
      hygieneRanking: [],
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
    this.loadHygieneStats();
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
        this.sfshOptions = "是,否,待审核".split(',');
          this.weishengqingkuangOptions = "已打扫,未打扫".split(',')
    },
    search() {
      this.pageIndex = 1;
      this.getDataList();
      this.loadHygieneStats();
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
           if(this.searchForm.weishengqingkuang!='' && this.searchForm.weishengqingkuang!=undefined){
            params['weishengqingkuang'] = this.searchForm.weishengqingkuang
          }
          if(this.searchForm.sfsh!='' && this.searchForm.sfsh!=undefined){
            params['sfsh'] = this.searchForm.sfsh
          }
          if(this.searchForm.dengjiriqi!='' && this.searchForm.dengjiriqi!=undefined){
            params['dengjiriqi_start'] = this.searchForm.dengjiriqi
            params['dengjiriqi_end'] = this.searchForm.dengjiriqi
          }
      this.$http({
        url: "weishengxinxi/page",
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
    buildHygieneQueryParams() {
      let params = {
        page: 1,
        limit: 1000,
        sort: 'pingfen',
        order: 'desc',
      }
      if(this.searchForm.sushemingcheng!='' && this.searchForm.sushemingcheng!=undefined){
        params['sushemingcheng'] = '%' + this.searchForm.sushemingcheng + '%'
      }
      if(this.searchForm.susheloudong!='' && this.searchForm.susheloudong!=undefined){
        params['susheloudong'] = '%' + this.searchForm.susheloudong + '%'
      }
      if(this.searchForm.weishengqingkuang!='' && this.searchForm.weishengqingkuang!=undefined){
        params['weishengqingkuang'] = this.searchForm.weishengqingkuang
      }
      if(this.searchForm.sfsh!='' && this.searchForm.sfsh!=undefined){
        params['sfsh'] = this.searchForm.sfsh
      }
      if(this.searchForm.dengjiriqi!='' && this.searchForm.dengjiriqi!=undefined){
        params['dengjiriqi_start'] = this.searchForm.dengjiriqi
        params['dengjiriqi_end'] = this.searchForm.dengjiriqi
      }
      return params;
    },
    loadHygieneStats() {
      this.$http({
        url: "weishengxinxi/page",
        method: "get",
        params: this.buildHygieneQueryParams()
      }).then(({ data }) => {
        const list = data && data.code === 0 ? (data.data.list || []) : [];
        this.buildHygieneStats(list);
        this.hygieneRanking = this.buildHygieneRanking(list);
      });
    },
    buildHygieneStats(list) {
      const scores = (list || []).map(item => this.normalizeScore(item.pingfen)).filter(score => score > 0);
      const totalScore = scores.reduce((sum, score) => sum + score, 0);
      this.hygieneStats = {
        total: (list || []).length,
        averageScore: scores.length ? Math.round(totalScore / scores.length) : 0,
        excellentCount: scores.filter(score => score >= 90).length
      };
    },
    buildHygieneRanking(list) {
      return (list || [])
        .map(item => Object.assign({}, item, {
          normalizedScore: this.normalizeScore(item.pingfen)
        }))
        .sort((a, b) => b.normalizedScore - a.normalizedScore)
        .slice(0, 20);
    },
    openHygieneRanking() {
      this.hygieneRankingVisible = true;
      this.loadHygieneStats();
    },
    normalizeScore(score) {
      const value = parseInt(score, 10);
      if (Number.isNaN(value) || value < 0) {
        return 0;
      }
      if (value > 100) {
        return 100;
      }
      return value;
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
    // 审核窗口
    shDialog(row){
      this.sfshVisiable = !this.sfshVisiable;
      if(row){
        this.shForm = {
          sushemingcheng: row.sushemingcheng,
          susheleixing: row.susheleixing,
          susheloudong: row.susheloudong,
          fangjianhao: row.fangjianhao,
          xueshengxuehao: row.xueshengxuehao,
          xueshengxingming: row.xueshengxingming,
          weishengqingkuang: row.weishengqingkuang,
          dengjiriqi: row.dengjiriqi,
		  pingfen: row.pingfen,
          xiangqing: row.xiangqing,
          sfsh: row.sfsh,
          shhf: row.shhf,
          id: row.id
        }
      }
    },
    // 审核
    shHandler(){
      this.$confirm(`确定操作?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "weishengxinxi/update",
          method: "post",
          data: this.shForm
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({
              message: "操作成功",
              type: "success",
              duration: 1500,
              onClose: () => {
                this.getDataList();
                this.loadHygieneStats();
                this.shDialog()
              }
            });
          } else {
            this.$message.error(data.msg);
          }
        });
      });
    },
    //批量审核窗口
    shBatchDialog(){
      this.sfshBatchVisiable = !this.sfshBatchVisiable;
      this.batchIds = this.dataListSelections.map(item => {
            return Number(item.id);
          });
    },
    //批量审核
    shBatchHandler(){
      this.$confirm(`确定一键审核操作?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        this.$http({
          url: "weishengxinxi/shBatch?sfsh="+this.shBatchForm.sfsh+"&shhf="+this.shBatchForm.shhf,
          method: "post",
          data: this.batchIds
        }).then(({ data }) => {
          if (data && data.code === 0) {
            this.$message({
              message: "操作成功",
              type: "success",
              duration: 1500,
              onClose: () => {
                this.getDataList();
                this.loadHygieneStats();
                this.shBatchDialog()
              }
            });
          } else {
            this.$message.error(data.msg);
          }
        });
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
          url: "weishengxinxi/delete",
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
	.hygiene-tip {
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

	.hygiene-tip i {
		color: #58a873;
		font-size: 18px;
	}

	.hygiene-summary {
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

	.score-cell {
		display: grid;
		grid-template-columns: 48px minmax(80px, 1fr);
		align-items: center;
		gap: 8px;
	}

	.score-cell span {
		color: #315a3a;
		font-weight: 700;
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
