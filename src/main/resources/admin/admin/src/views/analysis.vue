<template>
  <div class="analysis-page">
    <section class="analysis-hero">
      <div>
        <h2>宿舍运营数据分析</h2>
        <p>围绕入住分配、门禁出入、请假审批、报修处理和卫生检查，快速判断宿舍管理运行状态。</p>
      </div>
      <el-button type="primary" icon="el-icon-refresh" :loading="loading" @click="loadDashboard">
        刷新数据
      </el-button>
    </section>

    <section class="metric-grid">
      <div v-for="item in metrics" :key="item.label" class="metric-card" @click="openMetricDetail(item.key)">
        <div class="metric-icon">
          <i :class="item.icon"></i>
        </div>
        <div class="metric-content">
          <div class="metric-value">{{ item.value }}</div>
          <div class="metric-label">{{ item.label }}</div>
          <div class="metric-desc">{{ item.desc }}</div>
        </div>
      </div>
    </section>

    <section class="analysis-grid">
      <div class="chart-panel chart-wide">
        <div class="panel-head">
          <div>
            <h3>楼栋入住率</h3>
            <p>按宿舍资源统计床位使用情况</p>
          </div>
          <el-button type="text" @click="openMetricDetail('occupancy')">查看详情</el-button>
        </div>
        <div ref="occupancyChart" class="chart-box"></div>
      </div>

      <div class="chart-panel">
        <div class="panel-head">
          <div>
            <h3>请假审批状态</h3>
            <p>待审核、通过和驳回分布</p>
          </div>
          <el-button type="text" @click="openMetricDetail('leaves')">查看详情</el-button>
        </div>
        <div ref="leaveChart" class="chart-box"></div>
      </div>

      <div class="chart-panel">
        <div class="panel-head">
          <div>
            <h3>报修处理状态</h3>
            <p>反映当前工单处理压力</p>
          </div>
          <el-button type="text" @click="openMetricDetail('repairs')">查看详情</el-button>
        </div>
        <div ref="repairChart" class="chart-box"></div>
      </div>

      <div class="chart-panel">
        <div class="panel-head">
          <div>
            <h3>门禁出入楼栋分布</h3>
            <p>对比不同楼栋出入活跃度</p>
          </div>
          <el-button type="text" @click="openMetricDetail('access')">查看详情</el-button>
        </div>
        <div ref="accessChart" class="chart-box"></div>
      </div>
    </section>

    <el-dialog :title="detailTitle" :visible.sync="detailDialogVisible" width="760px" class="analysis-detail-dialog">
      <el-table :data="detailRows" height="420" stripe border>
        <el-table-column
          v-for="column in detailColumns"
          :key="column.prop"
          :prop="column.prop"
          :label="column.label"
          :width="column.width"
          show-overflow-tooltip
        ></el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
      charts: [],
      summary: {
        totalBeds: 0,
        occupiedBeds: 0,
        occupancyRate: 0,
        totalAccess: 0,
        totalLeaves: 0,
        pendingLeaves: 0,
        totalRepairs: 0,
        pendingRepairs: 0,
        totalHygiene: 0,
      },
      occupancyRows: [],
      leaveRows: [],
      repairRows: [],
      accessRows: [],
      accessDetailRows: [],
      leaveDetailRows: [],
      repairDetailRows: [],
      hygieneDetailRows: [],
      detailDialogVisible: false,
      detailTitle: "",
      detailColumns: [],
      detailRows: [],
    };
  },
  computed: {
    metrics() {
      return [
        {
          key: "occupancy",
          label: "宿舍入住率",
          value: this.summary.occupancyRate + "%",
          desc: this.summary.occupiedBeds + " / " + this.summary.totalBeds + " 个床位已使用",
          icon: "el-icon-house",
        },
        {
          key: "access",
          label: "今日门禁样本",
          value: this.summary.totalAccess,
          desc: "当前门禁出入记录总数",
          icon: "el-icon-s-check",
        },
        {
          key: "leaves",
          label: "待审核请假",
          value: this.summary.pendingLeaves,
          desc: "请假申请总数 " + this.summary.totalLeaves,
          icon: "el-icon-date",
        },
        {
          key: "repairs",
          label: "待处理报修",
          value: this.summary.pendingRepairs,
          desc: "报修工单总数 " + this.summary.totalRepairs,
          icon: "el-icon-warning-outline",
        },
        {
          key: "hygiene",
          label: "卫生检查",
          value: this.summary.totalHygiene,
          desc: "累计宿舍卫生检查记录",
          icon: "el-icon-medal",
        },
      ];
    },
  },
  mounted() {
    this.loadDashboard();
    window.addEventListener("resize", this.resizeCharts);
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.resizeCharts);
    this.charts.forEach(chart => chart && chart.dispose());
  },
  methods: {
    async loadDashboard() {
      this.loading = true;
      try {
        const results = await Promise.all([
          this.fetchPage("sushexinxi/page", { page: 1, limit: 1000 }),
          this.fetchPage("churusushe/page", { page: 1, limit: 1000, sort: "id", order: "desc" }),
          this.fetchPage("qingjia/page", { page: 1, limit: 1000, sort: "id", order: "desc" }),
          this.fetchPage("weixiuxinxi/page", { page: 1, limit: 1000, sort: "id", order: "desc" }),
          this.fetchPage("weishengxinxi/page", { page: 1, limit: 1000, sort: "id", order: "desc" }),
          this.fetchGroup("qingjia", "sfsh"),
          this.fetchGroup("weixiuxinxi", "sfsh"),
          this.fetchGroup("churusushe", "susheloudong"),
        ]);

        const dormPage = results[0];
        const accessPage = results[1];
        const leavePage = results[2];
        const repairPage = results[3];
        const hygienePage = results[4];

        this.leaveRows = results[5];
        this.repairRows = results[6];
        this.accessRows = results[7];
        this.accessDetailRows = accessPage.list || [];
        this.leaveDetailRows = leavePage.list || [];
        this.repairDetailRows = repairPage.list || [];
        this.hygieneDetailRows = hygienePage.list || [];
        this.occupancyRows = this.buildOccupancyRows(dormPage.list || []);

        const totalBeds = this.occupancyRows.reduce((sum, item) => sum + item.totalBeds, 0);
        const occupiedBeds = this.occupancyRows.reduce((sum, item) => sum + item.occupiedBeds, 0);

        this.summary.totalBeds = totalBeds;
        this.summary.occupiedBeds = occupiedBeds;
        this.summary.occupancyRate = totalBeds ? Math.round((occupiedBeds / totalBeds) * 100) : 0;
        this.summary.totalAccess = accessPage.total || 0;
        this.summary.totalLeaves = leavePage.total || 0;
        this.summary.pendingLeaves = this.findGroupTotal(this.leaveRows, "待审核");
        this.summary.totalRepairs = repairPage.total || 0;
        this.summary.pendingRepairs = this.findGroupTotal(this.repairRows, "待审核");
        this.summary.totalHygiene = hygienePage.total || 0;

        this.$nextTick(() => this.renderCharts());
      } catch (error) {
        this.$message.error("数据分析加载失败，请检查接口或登录状态");
      } finally {
        this.loading = false;
      }
    },
    fetchPage(url, params) {
      return this.$http({ url, method: "get", params }).then(({ data }) => {
        if (data && data.code === 0 && data.data) {
          return data.data;
        }
        return { total: 0, list: [] };
      });
    },
    fetchGroup(table, column) {
      return this.$http({
        url: "group/" + table + "/" + column,
        method: "get",
      }).then(({ data }) => {
        if (!data || data.code !== 0 || !data.data) {
          return [];
        }
        return data.data.map(item => ({
          name: item[column] || "未填写",
          total: Number(item.total || 0),
        }));
      });
    },
    buildOccupancyRows(list) {
      const map = {};
      list.forEach(item => {
        const building = item.susheloudong || "未填写楼栋";
        if (!map[building]) {
          map[building] = { name: building, totalBeds: 0, occupiedBeds: 0 };
        }
        map[building].totalBeds += Number(item.kezhurenshu || 0);
        map[building].occupiedBeds += Number(item.yizhurenshu || 0);
      });
      return Object.keys(map).map(key => map[key]);
    },
    findGroupTotal(rows, name) {
      const row = rows.find(item => item.name === name);
      return row ? row.total : 0;
    },
    openMetricDetail(type) {
      const configs = {
        occupancy: {
          title: "楼栋入住率详情",
          columns: [
            { prop: "name", label: "楼栋" },
            { prop: "occupiedBeds", label: "已入住", width: 110 },
            { prop: "totalBeds", label: "总床位", width: 110 },
            { prop: "rate", label: "入住率", width: 110 },
          ],
          rows: this.occupancyRows.map(item => Object.assign({}, item, {
            rate: item.totalBeds ? Math.round((item.occupiedBeds / item.totalBeds) * 100) + "%" : "0%"
          }))
        },
        access: {
          title: "门禁出入详情",
          columns: [
            { prop: "sushemingcheng", label: "宿舍名称" },
            { prop: "susheloudong", label: "楼栋", width: 100 },
            { prop: "fangjianhao", label: "房间号", width: 100 },
            { prop: "xueshengxingming", label: "学生姓名", width: 110 },
            { prop: "churushijian", label: "通行时间", width: 170 },
          ],
          rows: this.accessDetailRows
        },
        leaves: {
          title: "请假审批详情",
          columns: [
            { prop: "biaoti", label: "标题" },
            { prop: "xueshengxingming", label: "学生姓名", width: 110 },
            { prop: "qingjia1", label: "离开日期", width: 130 },
            { prop: "qingjia2", label: "返回日期", width: 130 },
            { prop: "sfsh", label: "审核状态", width: 110 },
          ],
          rows: this.leaveDetailRows
        },
        repairs: {
          title: "报修处理详情",
          columns: [
            { prop: "biaoti", label: "标题" },
            { prop: "susheloudong", label: "楼栋", width: 100 },
            { prop: "fangjianhao", label: "房间号", width: 100 },
            { prop: "xueshengxingming", label: "学生姓名", width: 110 },
            { prop: "sfsh", label: "工单状态", width: 110 },
          ],
          rows: this.repairDetailRows
        },
        hygiene: {
          title: "卫生检查详情",
          columns: [
            { prop: "sushemingcheng", label: "宿舍名称" },
            { prop: "susheloudong", label: "楼栋", width: 100 },
            { prop: "fangjianhao", label: "房间号", width: 100 },
            { prop: "weishengqingkuang", label: "卫生情况", width: 110 },
            { prop: "pingfen", label: "评分", width: 90 },
            { prop: "dengjiriqi", label: "检查日期", width: 130 },
          ],
          rows: this.hygieneDetailRows
        },
      };
      const config = configs[type];
      if (!config) {
        return;
      }
      this.detailTitle = config.title;
      this.detailColumns = config.columns;
      this.detailRows = config.rows || [];
      this.detailDialogVisible = true;
    },
    renderCharts() {
      this.charts.forEach(chart => chart && chart.dispose());
      this.charts = [
        this.renderBar(this.$refs.occupancyChart, this.occupancyRows.map(item => item.name), this.occupancyRows.map(item => item.occupiedBeds), "已入住床位", "#6fbd75"),
        this.renderPie(this.$refs.leaveChart, this.leaveRows),
        this.renderPie(this.$refs.repairChart, this.repairRows),
        this.renderBar(this.$refs.accessChart, this.accessRows.map(item => item.name), this.accessRows.map(item => item.total), "出入次数", "#5bb7d9"),
      ].filter(Boolean);
    },
    renderBar(el, labels, values, name, color) {
      if (!el) {
        return null;
      }
      const chart = this.$echarts.init(el);
      chart.setOption({
        color: [color],
        tooltip: { trigger: "axis" },
        grid: { left: 36, right: 18, top: 32, bottom: 32, containLabel: true },
        xAxis: {
          type: "category",
          data: labels.length ? labels : ["暂无数据"],
          axisLine: { lineStyle: { color: "#cfe4c8" } },
          axisLabel: { color: "#627264", fontSize: 12 },
        },
        yAxis: {
          type: "value",
          axisLine: { show: false },
          splitLine: { lineStyle: { color: "#e6f1e1" } },
          axisLabel: { color: "#627264", fontSize: 12 },
        },
        series: [{ name, type: "bar", barMaxWidth: 34, data: values.length ? values : [0] }],
      });
      return chart;
    },
    renderPie(el, rows) {
      if (!el) {
        return null;
      }
      const chart = this.$echarts.init(el);
      const data = rows.length ? rows.map(item => ({ name: item.name, value: item.total })) : [{ name: "暂无数据", value: 0 }];
      chart.setOption({
        color: ["#6fbd75", "#ffd76d", "#73c0de", "#ee8f8f", "#9bd48f"],
        tooltip: { trigger: "item" },
        legend: { bottom: 0, textStyle: { color: "#627264", fontSize: 12 } },
        series: [{
          type: "pie",
          radius: ["42%", "68%"],
          center: ["50%", "43%"],
          data,
          label: { color: "#263b2e", fontSize: 12 },
        }],
      });
      return chart;
    },
    resizeCharts() {
      this.charts.forEach(chart => chart && chart.resize());
    },
  },
};
</script>

<style lang="scss" scoped>
.analysis-page {
  padding: 22px 20px 32px;
  color: #263b2e;
}

.analysis-hero {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 18px;
  padding: 22px 24px;
  margin-bottom: 18px;
  background:
    radial-gradient(circle at 0 0, rgba(255, 243, 196, 0.78), transparent 32%),
    linear-gradient(135deg, rgba(255, 255, 255, 0.96), rgba(238, 248, 231, 0.96));
  border: 1px solid #cfe4c8;
  border-radius: 14px;
  box-shadow: 0 12px 26px rgba(57, 111, 73, 0.1);
}

.analysis-hero h2 {
  margin: 0 0 8px;
  font-size: 24px;
  line-height: 1.25;
}

.analysis-hero p {
  margin: 0;
  color: #627264;
  font-size: 15px;
}

.metric-grid {
  display: grid;
  grid-template-columns: repeat(5, minmax(150px, 1fr));
  gap: 14px;
  margin-bottom: 18px;
}

.metric-card,
.chart-panel {
  background: rgba(255, 255, 255, 0.95);
  border: 1px solid #cfe4c8;
  border-radius: 14px;
  box-shadow: 0 10px 24px rgba(57, 111, 73, 0.09);
}

.metric-card {
  display: flex;
  gap: 12px;
  align-items: center;
  cursor: pointer;
  min-height: 96px;
  padding: 16px;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.metric-card:hover {
  box-shadow: 0 16px 30px rgba(57, 111, 73, 0.14);
  transform: translateY(-2px);
}

.metric-icon {
  display: grid;
  place-items: center;
  width: 42px;
  height: 42px;
  color: #2f7c43;
  background: #dff5e1;
  border-radius: 12px;
  font-size: 20px;
}

.metric-value {
  font-size: 25px;
  line-height: 1;
  font-weight: 800;
  color: #263b2e;
}

.metric-label {
  margin-top: 6px;
  font-size: 15px;
  font-weight: 700;
}

.metric-desc {
  margin-top: 4px;
  font-size: 13px;
  color: #627264;
}

.analysis-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(280px, 1fr));
  gap: 16px;
}

.chart-wide {
  grid-column: span 2;
}

.chart-panel {
  padding: 16px 18px 12px;
}

.panel-head {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  margin-bottom: 8px;
}

.panel-head h3 {
  margin: 0 0 4px;
  font-size: 17px;
}

.panel-head p {
  margin: 0;
  color: #627264;
  font-size: 13px;
}

.chart-box {
  width: 100%;
  height: 300px;
}

.analysis-detail-dialog ::v-deep .el-dialog {
  border-radius: 14px;
  overflow: hidden;
}

@media (max-width: 1180px) {
  .metric-grid {
    grid-template-columns: repeat(3, minmax(160px, 1fr));
  }
}

@media (max-width: 860px) {
  .analysis-hero {
    align-items: flex-start;
    flex-direction: column;
  }

  .metric-grid,
  .analysis-grid {
    grid-template-columns: 1fr;
  }

  .chart-wide {
    grid-column: span 1;
  }
}
</style>
