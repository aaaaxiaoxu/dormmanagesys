<template>
  <div class="home-page">
    <section class="hero-board">
      <div class="hero-copy">
        <div class="hero-badge">
          <i class="el-icon-data-analysis"></i>
          宿舍管理数据统计大屏
        </div>
        <h1>系统运行全景总览</h1>
        <p>
          集成公告播报、入住率、报修处理、请假审核、水电费、论坛互动和考勤统计，
          让管理员与宿管员在首页就能看到宿舍运行情况。
        </p>
      </div>

      <div class="notice-player">
        <div class="player-head">
          <div class="player-title">
            <i class="el-icon-message-solid"></i>
            最新宿舍公告
          </div>
          <div class="player-tag">
            <i class="el-icon-refresh"></i>
            自动滚动
          </div>
        </div>

        <div class="notice-window" v-if="noticeList.length">
          <div
            :class="['notice-marquee', { 'is-static': noticeList.length === 1 }]"
            @mouseenter="noticePaused = true"
            @mouseleave="noticePaused = false"
          >
            <div
              :class="['notice-track', { paused: noticePaused, looping: noticeList.length > 1 }]"
              :style="noticeTrackStyle"
            >
              <div
                v-for="(item, index) in noticeMarqueeList"
                :key="`${item.id || 'notice'}-${index}`"
                class="notice-card"
                @click="openNotice(item)"
              >
                <div class="notice-icon">
                  <i class="el-icon-chat-line-round"></i>
                </div>
                <div class="notice-main">
                  <div class="notice-meta">
                    <span class="notice-role">{{ noticeRoleLabel }}</span>
                    <span class="notice-date">{{ formatNoticeDate(item.addtime) }}</span>
                  </div>
                  <div class="notice-title">{{ item.title || "未命名公告" }}</div>
                  <div class="notice-preview">{{ formatNotice(item.introduction || item.content) }}</div>
                  <div class="notice-action">点击查看完整公告</div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="empty-notice" v-else>
          <i class="el-icon-document"></i>
          <span>当前还没有可播放的公告</span>
        </div>
      </div>
    </section>

    <section class="metric-grid">
      <div class="metric-card blue-card">
        <div class="metric-icon"><i class="el-icon-house"></i></div>
        <div class="metric-value">{{ dashboard.occupancyRate }}%</div>
        <div class="metric-label">宿舍入住率</div>
        <div class="metric-sub">已入住 {{ dashboard.totalOccupiedBeds }} / 总床位 {{ dashboard.totalBeds }}</div>
      </div>
      <div class="metric-card orange-card">
        <div class="metric-icon"><i class="el-icon-warning-outline"></i></div>
        <div class="metric-value">{{ dashboard.pendingRepairs }}</div>
        <div class="metric-label">待处理报修</div>
        <div class="metric-sub">报修总量 {{ dashboard.totalRepairs }}</div>
      </div>
      <div class="metric-card green-card">
        <div class="metric-icon"><i class="el-icon-coin"></i></div>
        <div class="metric-value">{{ dashboard.totalFees }}</div>
        <div class="metric-label">水电费总额</div>
        <div class="metric-sub">未支付 {{ dashboard.unpaidFees }} 笔</div>
      </div>
      <div class="metric-card purple-card">
        <div class="metric-icon"><i class="el-icon-chat-dot-round"></i></div>
        <div class="metric-value">{{ dashboard.forumThreads }}</div>
        <div class="metric-label">论坛交流主题</div>
        <div class="metric-sub">已解决 {{ dashboard.solvedForumThreads }} 条</div>
      </div>
      <div class="metric-card cyan-card">
        <div class="metric-icon"><i class="el-icon-s-check"></i></div>
        <div class="metric-value">{{ dashboard.leavePending }}</div>
        <div class="metric-label">待审核请假</div>
        <div class="metric-sub">请假总数 {{ dashboard.totalLeaves }}</div>
      </div>
      <div class="metric-card dark-card">
        <div class="metric-icon"><i class="el-icon-date"></i></div>
        <div class="metric-value">{{ dashboard.totalAttendanceIssues }}</div>
        <div class="metric-label">考勤异常天数</div>
        <div class="metric-sub">晚归/缺寝/请假累计</div>
      </div>
    </section>

    <section class="chart-grid">
      <div class="chart-card wide-card">
        <div class="chart-head">
          <div>
            <div class="chart-title">楼栋入住率分布</div>
            <div class="chart-desc">按宿舍楼栋统计当前床位使用情况</div>
          </div>
        </div>
        <div class="chart-body" ref="buildingChart"></div>
      </div>

      <div class="chart-card">
        <div class="chart-head">
          <div>
            <div class="chart-title">报修处理状态</div>
            <div class="chart-desc">待审核、已通过、未通过分布</div>
          </div>
        </div>
        <div class="chart-body" ref="repairChart"></div>
      </div>

      <div class="chart-card">
        <div class="chart-head">
          <div>
            <div class="chart-title">请假审核看板</div>
            <div class="chart-desc">展示请假申请审核进度</div>
          </div>
        </div>
        <div class="chart-body" ref="leaveChart"></div>
      </div>

      <div class="chart-card wide-card">
        <div class="chart-head">
          <div>
            <div class="chart-title">月度水电费趋势</div>
            <div class="chart-desc">按月份统计水费、电费和总金额</div>
          </div>
        </div>
        <div class="chart-body" ref="feeChart"></div>
      </div>

      <div class="chart-card">
        <div class="chart-head">
          <div>
            <div class="chart-title">论坛问题状态</div>
            <div class="chart-desc">反映宿舍问题处理进度</div>
          </div>
        </div>
        <div class="chart-body" ref="forumChart"></div>
      </div>

      <div class="chart-card">
        <div class="chart-head">
          <div>
            <div class="chart-title">考勤异常分析</div>
            <div class="chart-desc">晚归、缺寝、请假天数汇总</div>
          </div>
        </div>
        <div class="chart-body" ref="attendanceChart"></div>
      </div>
    </section>

    <section class="admin-panel" v-if="sessionTable == 'users'">
      <div class="admin-head">
        <div>
          <div class="admin-title">门禁识别模拟</div>
          <div class="admin-desc">保留原有首页能力，可继续上传人脸照片进行识别演示。</div>
        </div>
      </div>

      <div class="upload-board">
        <div class="upload-tip">请上传人脸照片进行识别（模拟门禁）</div>
        <el-upload
          class="upload-demo"
          action="dormmanagesys/file/upload2"
          :on-success="handleSuccess"
          :on-error="handleError"
          :before-upload="beforeUpload"
          :show-file-list="false"
        >
          <el-button size="small" type="primary" class="upload-btn">
            <i class="el-icon-upload"></i>
            点击上传
          </el-button>
        </el-upload>
        <p v-if="uploadStatus" class="upload-status">{{ uploadStatus }}</p>

        <img
          v-if="previewUrl"
          :src="previewUrl"
          alt="Uploaded Image"
          class="preview-image"
        />

        <div v-if="kaoqinResult" class="result-container">
          <p><strong>识别结果:</strong> {{ kaoqinResult }}</p>
        </div>
      </div>
    </section>

    <el-dialog
      title="公告详情"
      :visible.sync="noticeDialogVisible"
      width="720px"
      class="notice-dialog"
    >
      <div v-if="selectedNotice.id || selectedNotice.title" class="notice-detail">
        <div class="notice-detail-meta">
          <span class="notice-role">{{ noticeRoleLabel }}</span>
          <span class="notice-date">{{ formatNoticeDate(selectedNotice.addtime) }}</span>
        </div>
        <h3 class="notice-detail-title">{{ selectedNotice.title || "未命名公告" }}</h3>
        <div v-if="selectedNotice.picture" class="notice-detail-image">
          <img :src="getNoticeImage(selectedNotice.picture)" alt="公告图片" />
        </div>
        <div
          v-if="selectedNotice.content"
          class="notice-detail-content rich-text"
          v-html="formatNoticeContent(selectedNotice.content)"
        ></div>
        <div v-else class="notice-detail-content">{{ selectedNotice.introduction || "暂无公告内容" }}</div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import router from "@/router/router-static";

export default {
  data() {
    return {
      sessionTable: "",
      role: "",
      userId: "",
      kaoqinResult: "",
      uploadStatus: "",
      previewUrl: "",
      selectedFile: null,
      noticeList: [],
      noticePaused: false,
      noticeDialogVisible: false,
      selectedNotice: {},
      chartInstances: [],
      dashboard: {
        occupancyRate: 0,
        totalBeds: 0,
        totalOccupiedBeds: 0,
        pendingRepairs: 0,
        totalRepairs: 0,
        totalFees: 0,
        unpaidFees: 0,
        forumThreads: 0,
        solvedForumThreads: 0,
        leavePending: 0,
        totalLeaves: 0,
        totalAttendanceIssues: 0
      },
      dashboardData: {
        dorms: [],
        allocations: [],
        repairs: [],
        leaves: [],
        fees: [],
        forums: [],
        attendance: []
      }
    };
  },
  computed: {
    noticeRoleLabel() {
      if (this.sessionTable === "xuesheng") {
        return "学生";
      }
      if (this.sessionTable === "suguan") {
        return "宿管";
      }
      return "管理员";
    },
    noticeMarqueeList() {
      if (this.noticeList.length <= 1) {
        return this.noticeList;
      }
      return this.noticeList.concat(this.noticeList);
    },
    noticeTrackStyle() {
      if (this.noticeList.length <= 1) {
        return {};
      }
      const duration = Math.max(this.noticeList.length * 5, 18);
      return {
        animationDuration: `${duration}s`
      };
    }
  },
  mounted() {
    this.sessionTable = this.$storage.get("sessionTable");
    this.role = this.$storage.get("role");
    this.userId = this.$storage.get("userId");
    this.init();
    this.getNoticeList();
    this.loadDashboardData();
    window.addEventListener("resize", this.handleResize);
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.handleResize);
    this.disposeCharts();
  },
  methods: {
    beforeUpload(file) {
      this.selectedFile = file;
      const reader = new FileReader();
      reader.onload = e => {
        this.previewUrl = e.target.result;
      };
      reader.readAsDataURL(file);
      return true;
    },
    handleSuccess(response) {
      this.uploadStatus = "上传成功";
      try {
        const result = JSON.parse(response.result);
        if (result) {
          this.$message({
            type: "success",
            message: "识别成功"
          });
          this.$http({
            url: `xuesheng/detail/${result}`,
            method: "post"
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.kaoqinResult =
                "识别成功 姓名 " + data.data.xueshengxingming + " 学号 " + data.data.xueshengxuehao;
            } else {
              this.$message.error(data.msg);
            }
          });
        }
      } catch (error) {
        console.error("解析结果出错", error);
      }
    },
    handleError(error) {
      this.uploadStatus = "上传失败";
      console.error("上传失败", error);
    },
    getNoticeList() {
      this.$http({
        url: "news/page",
        method: "get",
        params: {
          page: 1,
          limit: 8,
          sort: "id",
          order: "desc"
        }
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.noticeList = data.data.list || [];
        } else {
          this.noticeList = [];
        }
      });
    },
    loadDashboardData() {
      const buildParams = (sortField = "id") => ({
        page: 1,
        limit: 1000,
        sort: sortField,
        order: "desc"
      });

      Promise.all([
        this.$http({ url: "sushexinxi/page", method: "get", params: buildParams("susheloudong") }),
        this.$http({ url: "sushefenpei/page", method: "get", params: buildParams("fenpeiriqi") }),
        this.$http({ url: "weixiuxinxi/page", method: "get", params: buildParams("weixiuriqi") }),
        this.$http({ url: "qingjia/page", method: "get", params: buildParams("addtime") }),
        this.$http({ url: "shuidianfei/page", method: "get", params: buildParams("dengjishijian") }),
        this.$http({ url: "forum/page", method: "get", params: buildParams("addtime") }),
        this.$http({ url: "kaoqinxinxi/page", method: "get", params: buildParams("dengjishijian") })
      ]).then(responses => {
        const [dormsRes, allocationsRes, repairsRes, leavesRes, feesRes, forumsRes, attendanceRes] = responses;
        this.dashboardData = {
          dorms: this.getListData(dormsRes),
          allocations: this.getListData(allocationsRes),
          repairs: this.getListData(repairsRes),
          leaves: this.getListData(leavesRes),
          fees: this.getListData(feesRes),
          forums: this.getListData(forumsRes),
          attendance: this.getListData(attendanceRes)
        };
        this.buildMetrics();
        this.$nextTick(() => {
          this.renderCharts();
        });
      }).catch(() => {
        this.$message.error("统计数据加载失败，请稍后重试");
      });
    },
    getListData(response) {
      const data = response && response.data;
      if (data && data.code === 0 && data.data) {
        return data.data.list || [];
      }
      return [];
    },
    buildMetrics() {
      const dorms = this.dashboardData.dorms;
      const repairs = this.dashboardData.repairs;
      const leaves = this.dashboardData.leaves;
      const fees = this.dashboardData.fees;
      const forums = this.dashboardData.forums.filter(item => !item.parentid);
      const attendance = this.dashboardData.attendance;

      const totalBeds = dorms.reduce((sum, item) => sum + this.toNumber(item.kezhurenshu), 0);
      const totalOccupiedBeds = dorms.reduce((sum, item) => {
        const capacity = this.toNumber(item.kezhurenshu);
        const occupied = this.toNumber(item.yizhurenshu);
        return sum + this.getSafeOccupiedBeds(occupied, capacity);
      }, 0);
      const pendingRepairs = repairs.filter(item => !item.sfsh || item.sfsh === "待审核").length;
      const unpaidFees = fees.filter(item => item.ispay !== "已支付").length;
      const solvedForumThreads = forums.filter(item => item.isdone === "关闭").length;
      const leavePending = leaves.filter(item => !item.sfsh || item.sfsh === "待审核").length;
      const totalAttendanceIssues = attendance.reduce((sum, item) => {
        return sum + this.toNumber(item.wanguitianshu) + this.toNumber(item.queqintianshu) + this.toNumber(item.qingjiatianshu);
      }, 0);

      this.dashboard = {
        occupancyRate: totalBeds ? Math.min((totalOccupiedBeds / totalBeds) * 100, 100).toFixed(1) : 0,
        totalBeds,
        totalOccupiedBeds,
        pendingRepairs,
        totalRepairs: repairs.length,
        totalFees: fees.reduce((sum, item) => sum + this.toNumber(item.zongjine), 0).toFixed(0),
        unpaidFees,
        forumThreads: forums.length,
        solvedForumThreads,
        leavePending,
        totalLeaves: leaves.length,
        totalAttendanceIssues
      };
    },
    renderCharts() {
      this.disposeCharts();
      this.renderBuildingChart();
      this.renderRepairChart();
      this.renderLeaveChart();
      this.renderFeeChart();
      this.renderForumChart();
      this.renderAttendanceChart();
    },
    renderBuildingChart() {
      const map = {};
      this.dashboardData.dorms.forEach(item => {
        const key = this.normalizeBuildingLabel(item.susheloudong);
        if (!map[key]) {
          map[key] = { beds: 0, occupied: 0 };
        }
        const capacity = this.toNumber(item.kezhurenshu);
        map[key].beds += capacity;
        map[key].occupied += this.getSafeOccupiedBeds(this.toNumber(item.yizhurenshu), capacity);
      });
      const labels = Object.keys(map).sort((a, b) => this.compareBuildingLabel(a, b));
      const rates = labels.map(label => {
        const item = map[label];
        return item.beds ? Number(Math.min((item.occupied / item.beds) * 100, 100).toFixed(1)) : 0;
      });
      this.createChart(this.$refs.buildingChart, {
        color: ["#38bdf8"],
        tooltip: { trigger: "axis" },
        grid: { left: 55, right: 20, top: 40, bottom: 35 },
        xAxis: {
          type: "category",
          data: labels,
          axisLabel: { color: "#64748b" },
          axisLine: { lineStyle: { color: "rgba(148,163,184,0.35)" } }
        },
        yAxis: {
          type: "value",
          max: 100,
          axisLabel: { color: "#64748b", formatter: "{value}%" },
          splitLine: { lineStyle: { color: "rgba(148,163,184,0.18)" } }
        },
        series: [
          {
            name: "入住率",
            type: "bar",
            barWidth: 24,
            data: rates,
            itemStyle: {
              borderRadius: [10, 10, 0, 0],
              color: new this.$echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: "#60a5fa" },
                { offset: 1, color: "#0ea5e9" }
              ])
            }
          }
        ]
      });
    },
    getSafeOccupiedBeds(occupied, capacity) {
      if (capacity <= 0) {
        return Math.max(occupied, 0);
      }
      return Math.min(Math.max(occupied, 0), capacity);
    },
    normalizeBuildingLabel(value) {
      const label = String(value || "").trim();
      return label || "未分配楼栋";
    },
    compareBuildingLabel(a, b) {
      const aLabel = this.normalizeBuildingLabel(a);
      const bLabel = this.normalizeBuildingLabel(b);
      const aMatch = aLabel.match(/\d+/);
      const bMatch = bLabel.match(/\d+/);
      if (aMatch && bMatch) {
        const diff = Number(aMatch[0]) - Number(bMatch[0]);
        if (diff !== 0) {
          return diff;
        }
      }
      return aLabel.localeCompare(bLabel, "zh-Hans-CN");
    },
    renderRepairChart() {
      const statusMap = {
        待审核: 0,
        已通过: 0,
        未通过: 0
      };
      this.dashboardData.repairs.forEach(item => {
        const key = item.sfsh || "待审核";
        statusMap[key] = (statusMap[key] || 0) + 1;
      });
      this.createChart(this.$refs.repairChart, {
        color: ["#f59e0b", "#34d399", "#f87171"],
        tooltip: { trigger: "item" },
        legend: { bottom: 0, textStyle: { color: "#64748b" } },
        series: [
          {
            type: "pie",
            radius: ["48%", "72%"],
            center: ["50%", "45%"],
            label: { color: "#475569" },
            data: Object.keys(statusMap).map(key => ({ name: key, value: statusMap[key] }))
          }
        ]
      });
    },
    renderLeaveChart() {
      const statusMap = {
        待审核: 0,
        已通过: 0,
        未通过: 0
      };
      this.dashboardData.leaves.forEach(item => {
        const key = this.normalizeReviewStatus(item.sfsh);
        statusMap[key] = (statusMap[key] || 0) + 1;
      });
      this.createChart(this.$refs.leaveChart, {
        color: ["#38bdf8", "#22c55e", "#fb7185"],
        tooltip: {
          trigger: "item",
          formatter: "{b}: {c} 条 ({d}%)"
        },
        legend: {
          bottom: 0,
          left: "center",
          itemWidth: 12,
          itemHeight: 12,
          textStyle: { color: "#64748b", fontSize: 13 }
        },
        series: [
          {
            type: "pie",
            radius: ["42%", "68%"],
            center: ["50%", "45%"],
            avoidLabelOverlap: true,
            itemStyle: {
              borderColor: "#f8fafc",
              borderWidth: 4
            },
            label: {
              color: "#475569",
              formatter: "{b}\n{c}条"
            },
            labelLine: {
              length: 10,
              length2: 10
            },
            data: Object.keys(statusMap).map(key => ({ name: key, value: statusMap[key] }))
          }
        ]
      });
    },
    normalizeReviewStatus(value) {
      const status = String(value || "").trim();
      if (!status || status === "待审核") {
        return "待审核";
      }
      if (status === "是" || status === "已通过") {
        return "已通过";
      }
      if (status === "否" || status === "未通过") {
        return "未通过";
      }
      return "待审核";
    },
    renderFeeChart() {
      const monthMap = {};
      this.dashboardData.fees.forEach(item => {
        const period = this.parseFeePeriod(item);
        const key = period.sortKey;
        if (!monthMap[key]) {
          monthMap[key] = {
            label: period.label,
            water: 0,
            electric: 0,
            total: 0
          };
        }
        monthMap[key].water += this.toNumber(item.shuifei);
        monthMap[key].electric += this.toNumber(item.dianfei);
        monthMap[key].total += this.toNumber(item.zongjine);
      });
      const keys = Object.keys(monthMap).sort();
      const labels = keys.map(key => monthMap[key].label);
      this.createChart(this.$refs.feeChart, {
        color: ["#38bdf8", "#f97316", "#22c55e"],
        tooltip: {
          trigger: "axis",
          axisPointer: {
            type: "shadow",
            shadowStyle: {
              color: "rgba(148,163,184,0.08)"
            }
          },
          backgroundColor: "rgba(15, 23, 42, 0.92)",
          borderWidth: 0,
          textStyle: {
            color: "#e2e8f0"
          },
          formatter: params => {
            if (!params || !params.length) {
              return "";
            }
            const lines = [`<div style="margin-bottom:8px;font-weight:600;">${params[0].axisValue}</div>`];
            params.forEach(item => {
              lines.push(
                `<div style="display:flex;align-items:center;justify-content:space-between;gap:16px;">
                  <span>${item.marker}${item.seriesName}</span>
                  <strong>${Number(item.value || 0).toFixed(1)} 元</strong>
                </div>`
              );
            });
            return lines.join("");
          }
        },
        legend: {
          top: 6,
          left: "center",
          itemWidth: 16,
          itemHeight: 10,
          textStyle: {
            color: "#64748b",
            fontSize: 13
          }
        },
        grid: { left: 60, right: 28, top: 62, bottom: 68 },
        xAxis: {
          type: "category",
          data: labels,
          axisLabel: {
            color: "#64748b",
            interval: 0,
            margin: 14,
            formatter: value => this.formatFeeAxisLabel(value)
          },
          axisTick: { show: false },
          axisLine: { lineStyle: { color: "rgba(148,163,184,0.35)" } }
        },
        yAxis: {
          type: "value",
          name: "金额（元）",
          nameTextStyle: {
            color: "#94a3b8",
            padding: [0, 0, 8, 0]
          },
          axisLabel: {
            color: "#64748b",
            formatter: value => `${value}`
          },
          splitLine: {
            lineStyle: {
              color: "rgba(148,163,184,0.18)",
              type: "dashed"
            }
          }
        },
        series: [
          {
            name: "水费",
            type: "bar",
            stack: "fee",
            barMaxWidth: 36,
            emphasis: { focus: "series" },
            itemStyle: {
              borderRadius: [0, 0, 10, 10],
              color: new this.$echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: "#67d4ff" },
                { offset: 1, color: "#2f9fe4" }
              ])
            },
            data: keys.map(key => Number(monthMap[key].water.toFixed(1)))
          },
          {
            name: "电费",
            type: "bar",
            stack: "fee",
            barMaxWidth: 36,
            emphasis: { focus: "series" },
            itemStyle: {
              borderRadius: [10, 10, 0, 0],
              color: new this.$echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: "#ff9a3d" },
                { offset: 1, color: "#ff6a00" }
              ])
            },
            data: keys.map(key => Number(monthMap[key].electric.toFixed(1)))
          },
          {
            name: "总金额",
            type: "line",
            smooth: true,
            symbol: "circle",
            symbolSize: 8,
            yAxisIndex: 0,
            z: 10,
            lineStyle: {
              width: 3,
              color: "#22c55e"
            },
            itemStyle: {
              color: "#ffffff",
              borderColor: "#22c55e",
              borderWidth: 2
            },
            areaStyle: {
              color: new this.$echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: "rgba(34,197,94,0.18)" },
                { offset: 1, color: "rgba(34,197,94,0.02)" }
              ])
            },
            data: keys.map(key => Number(monthMap[key].total.toFixed(1)))
          }
        ]
      });
    },
    formatFeeAxisLabel(value) {
      const label = String(value || "");
      const match = label.match(/(\d{4})年(\d{1,2})月/);
      if (!match) {
        return label;
      }
      return `${match[1]}年\n${match[2]}月`;
    },
    parseFeePeriod(item) {
      const rawMonth = String(item.yuefen || "").trim();
      const fallbackDate = String(item.dengjishijian || item.addtime || "");
      let year = "";
      let month = "";

      const yearMonthMatch = rawMonth.match(/(20\d{2})[^\d]?(\d{1,2})/);
      if (yearMonthMatch) {
        year = yearMonthMatch[1];
        month = yearMonthMatch[2];
      } else {
        const monthMatch = rawMonth.match(/(\d{1,2})/);
        if (monthMatch) {
          month = monthMatch[1];
        }
        const fallbackYearMatch = fallbackDate.match(/(20\d{2})/);
        if (fallbackYearMatch) {
          year = fallbackYearMatch[1];
        }
      }

      const normalizedMonth = this.normalizeMonth(month);
      const normalizedYear = year || "0000";
      return {
        sortKey: `${normalizedYear}-${normalizedMonth}`,
        label: `${normalizedYear}年${Number(normalizedMonth)}月`
      };
    },
    normalizeMonth(value) {
      const month = Number(value);
      if (month >= 1 && month <= 12) {
        return String(month).padStart(2, "0");
      }
      return "00";
    },
    renderForumChart() {
      const statusMap = {
        开放: 0,
        关闭: 0
      };
      this.dashboardData.forums
        .filter(item => !item.parentid)
        .forEach(item => {
          const key = item.isdone || "开放";
          statusMap[key] = (statusMap[key] || 0) + 1;
        });
      this.createChart(this.$refs.forumChart, {
        color: ["#fbbf24", "#60a5fa", "#34d399", "#94a3b8"],
        tooltip: { trigger: "axis" },
        grid: { left: 40, right: 20, top: 40, bottom: 30 },
        xAxis: {
          type: "category",
          data: Object.keys(statusMap),
          axisLabel: { color: "#64748b" },
          axisLine: { lineStyle: { color: "rgba(148,163,184,0.35)" } }
        },
        yAxis: {
          type: "value",
          axisLabel: { color: "#64748b" },
          splitLine: { lineStyle: { color: "rgba(148,163,184,0.18)" } }
        },
        series: [
          {
            type: "bar",
            barWidth: 26,
            data: Object.keys(statusMap).map(key => statusMap[key]),
            itemStyle: {
              borderRadius: [8, 8, 0, 0]
            }
          }
        ]
      });
    },
    renderAttendanceChart() {
      const totalLate = this.dashboardData.attendance.reduce((sum, item) => sum + this.toNumber(item.wanguitianshu), 0);
      const totalAbsent = this.dashboardData.attendance.reduce((sum, item) => sum + this.toNumber(item.queqintianshu), 0);
      const totalLeave = this.dashboardData.attendance.reduce((sum, item) => sum + this.toNumber(item.qingjiatianshu), 0);
      this.createChart(this.$refs.attendanceChart, {
        color: ["#fb7185", "#f97316", "#38bdf8"],
        tooltip: { trigger: "axis" },
        grid: { left: 50, right: 20, top: 40, bottom: 35 },
        xAxis: {
          type: "category",
          data: ["晚归", "缺寝", "请假"],
          axisLabel: { color: "#64748b" },
          axisLine: { lineStyle: { color: "rgba(148,163,184,0.35)" } }
        },
        yAxis: {
          type: "value",
          axisLabel: { color: "#64748b" },
          splitLine: { lineStyle: { color: "rgba(148,163,184,0.18)" } }
        },
        series: [
          {
            name: "异常天数",
            type: "bar",
            data: [totalLate, totalAbsent, totalLeave],
            barWidth: 28,
            itemStyle: {
              borderRadius: [10, 10, 0, 0]
            }
          }
        ]
      });
    },
    createChart(dom, option) {
      if (!dom) {
        return;
      }
      const chart = this.$echarts.init(dom, "macarons");
      chart.setOption(option);
      this.chartInstances.push(chart);
    },
    disposeCharts() {
      this.chartInstances.forEach(chart => {
        if (chart && !chart.isDisposed()) {
          chart.dispose();
        }
      });
      this.chartInstances = [];
    },
    handleResize() {
      this.chartInstances.forEach(chart => {
        if (chart && !chart.isDisposed()) {
          chart.resize();
        }
      });
    },
    toNumber(value) {
      const num = Number(value);
      return Number.isFinite(num) ? num : 0;
    },
    openNotice(item) {
      this.selectedNotice = { ...item };
      this.noticeDialogVisible = true;
    },
    formatNotice(content) {
      const text = (content || "").replace(/<[^>]+>/g, "").replace(/\s+/g, " ").trim();
      if (!text) {
        return "暂无公告内容";
      }
      return text.length > 78 ? text.slice(0, 78) + "..." : text;
    },
    formatNoticeContent(content) {
      if (!content) {
        return "暂无公告内容";
      }
      return String(content).replace(/\.\.\/\.\.\/\.\.\/upload/g, "../../../dormmanagesys/upload");
    },
    getNoticeImage(picture) {
      const firstImage = String(picture).split(",")[0];
      if (!firstImage) {
        return "";
      }
      return firstImage.substring(0, 4) === "http" ? firstImage : `${this.$base.url}${firstImage}`;
    },
    formatNoticeDate(value) {
      if (!value) {
        return "";
      }
      return String(value).replace("T", " ").slice(0, 16);
    },
    init() {
      if (this.$storage.get("Token")) {
        this.$http({
          url: `${this.$storage.get("sessionTable")}/session`,
          method: "get"
        }).then(({ data }) => {
          if (data && data.code != 0) {
            router.push({ name: "login" });
          }
        });
      } else {
        router.push({ name: "login" });
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.home-page {
  min-height: 100%;
  padding: 18px;
  background:
    radial-gradient(circle at 12% 12%, rgba(111, 127, 95, 0.07), transparent 20%),
    linear-gradient(180deg, rgba(241, 245, 249, 0.78) 0%, rgba(238, 243, 248, 0.42) 100%);
}

.hero-board,
.chart-card,
.admin-panel {
  border-radius: 22px;
  border: 1px solid rgba(148, 163, 184, 0.16);
  box-shadow: 0 12px 30px rgba(15, 23, 42, 0.06);
}

.hero-board {
  padding: 28px;
  display: grid;
  grid-template-columns: minmax(320px, 1.1fr) minmax(0, 1fr);
  gap: 22px;
  align-items: start;
  background:
    linear-gradient(180deg, rgba(248, 250, 252, 0.98), rgba(241, 245, 249, 0.96));
}

.hero-copy,
.notice-player {
  min-width: 0;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 14px;
  border-radius: 999px;
  background: rgba(227, 235, 218, 0.9);
  color: #55664b;
  margin-bottom: 16px;
}

.hero-copy h1 {
  margin: 0 0 14px;
  color: #0f172a;
  font-size: 36px;
}

.hero-copy p {
  margin: 0;
  color: #475569;
  line-height: 1.9;
  max-width: 720px;
}

.notice-player {
  border-radius: 24px;
  padding: 20px;
  background: rgba(255, 255, 255, 0.72);
  border: 1px solid rgba(148, 163, 184, 0.14);
}

.player-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 10px;
  margin-bottom: 16px;
}

.player-title,
.player-tag {
  display: inline-flex;
  align-items: center;
  gap: 8px;
}

.player-title {
  color: #0f172a;
  font-weight: 700;
}

.player-tag {
  color: #64748b;
  font-size: 13px;
}

.notice-window {
  min-height: 188px;
  overflow: hidden;
  width: 100%;
}

.notice-marquee {
  overflow: hidden;
  width: 100%;
}

.notice-track {
  display: flex;
  align-items: stretch;
  gap: 16px;
  min-width: 0;
}

.notice-track.looping {
  width: max-content;
  animation: notice-marquee-scroll 18s linear infinite;
}

.notice-track.paused {
  animation-play-state: paused;
}

.notice-marquee.is-static .notice-track {
  width: 100%;
}

.notice-card {
  display: flex;
  gap: 16px;
  border-radius: 22px;
  padding: 22px;
  min-height: 188px;
  width: 320px;
  flex: 0 0 320px;
  background: linear-gradient(135deg, rgba(241, 245, 249, 0.98), rgba(226, 232, 240, 0.92));
  cursor: pointer;
  transition: transform 0.25s ease, box-shadow 0.25s ease;
}

.notice-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 16px 30px rgba(15, 23, 42, 0.12);
}

.notice-icon {
  width: 58px;
  height: 58px;
  border-radius: 18px;
  flex: 0 0 58px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  font-size: 24px;
  background: linear-gradient(135deg, #839370, #6b7a5b);
}

.notice-title {
  color: #0f172a;
  font-size: 22px;
  font-weight: 700;
  margin-bottom: 12px;
}

.notice-meta {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 12px;
}

.notice-role {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 58px;
  height: 28px;
  padding: 0 12px;
  border-radius: 999px;
  background: rgba(227, 235, 218, 0.92);
  color: #55664b;
  font-size: 13px;
  font-weight: 700;
}

.notice-date {
  color: #8a9485;
  font-size: 13px;
}

.notice-preview {
  color: #475569;
  line-height: 1.8;
  font-size: 15px;
  display: -webkit-box;
  overflow: hidden;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
}

.notice-action {
  margin-top: 14px;
  color: #6b7a5b;
  font-size: 13px;
  font-weight: 700;
}

.empty-notice {
  min-height: 188px;
  border-radius: 22px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 12px;
  color: #64748b;
  background: rgba(255, 255, 255, 0.72);
}

.notice-detail-meta {
  display: flex;
  align-items: center;
  gap: 12px;
}

.notice-detail-title {
  margin: 16px 0 18px;
  color: #0f172a;
  font-size: 24px;
}

.notice-detail-image {
  margin-bottom: 18px;
}

.notice-detail-image img {
  max-width: 100%;
  border-radius: 16px;
}

.notice-detail-content {
  color: #475569;
  line-height: 1.9;
  word-break: break-word;
}

.rich-text :deep(img) {
  max-width: 100%;
}

@keyframes notice-marquee-scroll {
  from {
    transform: translateX(0);
  }
  to {
    transform: translateX(calc(-50% - 8px));
  }
}

.metric-grid {
  margin-top: 22px;
  display: grid;
  grid-template-columns: repeat(6, minmax(0, 1fr));
  gap: 16px;
}

.metric-card {
  min-height: 168px;
  border-radius: 20px;
  padding: 22px;
  color: #fff;
  box-shadow: 0 10px 24px rgba(15, 23, 42, 0.08);
  border: 1px solid rgba(148, 163, 184, 0.1);
}

.blue-card { background: linear-gradient(160deg, #727f61, #85946f); }
.orange-card { background: linear-gradient(160deg, #82745f, #948671); }
.green-card { background: linear-gradient(160deg, #61795c, #768f70); }
.purple-card { background: linear-gradient(160deg, #6f7360, #858a73); }
.cyan-card { background: linear-gradient(160deg, #5f7668, #728b7c); }
.dark-card { background: linear-gradient(160deg, #5a6354, #6b7564); }

.metric-icon {
  width: 48px;
  height: 48px;
  border-radius: 16px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.1);
  font-size: 22px;
}

.metric-value {
  margin-top: 26px;
  font-size: 30px;
  font-weight: 700;
}

.metric-label {
  margin-top: 10px;
  font-size: 15px;
  opacity: 0.94;
}

.metric-sub {
  margin-top: 10px;
  color: rgba(255, 255, 255, 0.76);
  line-height: 1.6;
  font-size: 13px;
}

.chart-grid {
  margin-top: 22px;
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 18px;
}

.chart-card {
  padding: 20px;
  background:
    linear-gradient(180deg, rgba(248, 250, 252, 0.98), rgba(241, 245, 249, 0.96));
}

.wide-card {
  grid-column: span 2;
}

.chart-head {
  margin-bottom: 12px;
}

.chart-title {
  color: #0f172a;
  font-size: 18px;
  font-weight: 700;
}

.chart-desc {
  margin-top: 8px;
  color: #64748b;
  font-size: 13px;
}

.chart-body {
  height: 320px;
}

.admin-panel {
  margin-top: 24px;
  padding: 26px;
  background: linear-gradient(180deg, rgba(248, 250, 252, 0.98), rgba(241, 245, 249, 0.96));
}

.admin-title {
  color: #0f172a;
  font-size: 24px;
  font-weight: 700;
}

.admin-desc {
  margin-top: 8px;
  color: #64748b;
}

.upload-board {
  margin-top: 20px;
  border-radius: 18px;
  padding: 24px;
  background: rgba(255, 255, 255, 0.72);
  text-align: center;
  border: 1px solid rgba(148, 163, 184, 0.16);
}

.upload-tip {
  color: #334155;
  margin-bottom: 16px;
}

.upload-btn {
  border: none;
  border-radius: 14px;
  background: linear-gradient(135deg, #839370, #6b7a5b);
}

.upload-status {
  color: #5a694d;
  margin-top: 12px;
}

.preview-image {
  max-width: 240px;
  width: 100%;
  border-radius: 18px;
  margin-top: 16px;
  box-shadow: 0 16px 36px rgba(0, 0, 0, 0.24);
}

.result-container {
  margin-top: 18px;
  border-radius: 18px;
  padding: 16px;
  color: #4f5e44;
  background: rgba(227, 235, 218, 0.92);
}

@media (max-width: 1400px) {
  .metric-grid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }

  .chart-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 1100px) {
  .hero-board {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .home-page {
    padding: 12px;
  }

  .hero-board,
  .admin-panel,
  .chart-card {
    padding: 16px;
  }

  .metric-grid,
  .chart-grid {
    grid-template-columns: 1fr;
  }

  .wide-card {
    grid-column: span 1;
  }

  .hero-copy h1 {
    font-size: 28px;
  }

  .player-head {
    flex-direction: column;
    align-items: flex-start;
  }

  .notice-card {
    width: 280px;
    flex-basis: 280px;
  }

  .chart-body {
    height: 280px;
  }
}
</style>
