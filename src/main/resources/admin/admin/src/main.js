import Vue from 'vue'
import App from '@/App.vue'
// element ui 完全引入
import ElementUI from 'element-ui'
import '@/assets/css/element-variables.scss'
import '@/assets/css/style.scss'
// 加载路由
// import router from '@/router/router-static.js';
import router from '@/router/router-static.js';
// 面包屑导航，注册为全局组件
import BreadCrumbs from '@/components/common/BreadCrumbs'
// 引入echart
import * as echarts from 'echarts'
import 'echarts-wordcloud'
// 引入echart主题
// import  '@/assets/js/echarts-theme-macarons.js'
import 'echarts/theme/macarons.js'
// ajax
import http from '@/utils/http.js'
// 基础配置
import base from '@/utils/base'
// 工具类
import { isAuth, getCurDate, getCurDateTime } from '@/utils/utils'
// storage 封装
import storage from "@/utils/storage";
// 上传组件
import FileUpload from "@/components/common/FileUpload";
import ExcelFileUpload from "@/components/common/ExcelFileUpload";
// 富文本编辑组件
import Editor from "@/components/common/Editor";
// api 接口
import api from '@/utils/api'
// 数据校验工具类
import * as validate from '@/utils/validate.js'
// 后台地图
import VueAMap from 'vue-amap'
import '@/icons'
//excel导出
import JsonExcel from 'vue-json-excel'
//打印
import printJS from 'print-js'
//MD5
import md5 from 'js-md5';

// 后台地图
Vue.use(VueAMap)
VueAMap.initAMapApiLoader({
  //key: 'ca04cee7ac952691aa67a131e6f0cee0',
  key: '001d42eaa139dc53fd655e7c23c0187e',
  plugin: ['AMap.Autocomplete', 'AMap.PlaceSearch', 'AMap.Scale', 'AMap.OverView', 'AMap.ToolBar', 'AMap.MapType', 'AMap.PolyEditor', 'AMap.CircleEditor', 'AMap.Geocoder','AMap.CitySearch'],
  // 默认高德 sdk 版本为 1.4.4
  v: '1.4.4'
})
Vue.prototype.$validate = validate
Vue.prototype.$http = http // ajax请求方法
Vue.prototype.$echarts = echarts
Vue.prototype.$base = base.get()
Vue.prototype.$project = base.getProjectName()
Vue.prototype.$storage = storage
Vue.prototype.$api = api
// 判断权限方法
Vue.prototype.isAuth = isAuth
Vue.prototype.getCurDateTime = getCurDateTime
Vue.prototype.getCurDate = getCurDate
Vue.prototype.$exportTable = function(tableName) {
  const showExportError = (blob, fallback) => {
    if (blob instanceof Blob) {
      const reader = new FileReader();
      reader.onload = () => {
        try {
          const data = JSON.parse(reader.result);
          this.$message.error((data && data.msg) || fallback);
        } catch (e) {
          this.$message.error(fallback);
        }
      };
      reader.readAsText(blob);
      return;
    }
    this.$message.error(fallback);
  };
  http({
    url: `export/${tableName}`,
    method: 'get',
    responseType: 'blob'
  }).then(res => {
    const contentType = res.headers['content-type'] || 'application/vnd.ms-excel';
    const blob = new Blob([res.data], { type: contentType });
    if (contentType.indexOf('application/json') !== -1) {
      showExportError(blob, '导出失败');
      return;
    }
    const disposition = res.headers['content-disposition'] || '';
    const match = disposition.match(/filename\*=UTF-8''([^;]+)/);
    const filename = match ? decodeURIComponent(match[1]) : `${tableName}.xls`;
    const link = document.createElement('a');
    link.href = window.URL.createObjectURL(blob);
    link.download = filename;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    window.URL.revokeObjectURL(link.href);
    this.$message.success('导出成功');
  }).catch(error => {
    showExportError(error && error.response && error.response.data, '导出失败');
  });
}
Vue.prototype.$importTable = function(tableName, onSuccess) {
  const input = document.createElement('input');
  input.type = 'file';
  input.accept = '.xls,.xlsx';
  input.style.display = 'none';
  document.body.appendChild(input);
  input.onchange = () => {
    const file = input.files && input.files[0];
    document.body.removeChild(input);
    if (!file) {
      return;
    }
    const formData = new FormData();
    formData.append('file', file);
    http({
      url: `import/${tableName}`,
      method: 'post',
      data: formData
    }).then(({ data }) => {
      if (data && data.code === 0) {
        this.$message.success(data.msg || `导入成功，共${data.count || 0}条`);
        if (typeof onSuccess === 'function') {
          onSuccess.call(this);
        }
      } else {
        this.$message.error((data && data.msg) || '导入失败');
      }
    }).catch(() => {
      this.$message.error('导入失败');
    });
  };
  input.click();
}
// Vue.prototype.$base = base
Vue.use(ElementUI, { size: 'medium', zIndex: 3000 });
Vue.config.productionTip = false
// 组件全局组件
Vue.component('bread-crumbs', BreadCrumbs)
Vue.component('file-upload', FileUpload)
Vue.component('excel-file-upload', ExcelFileUpload)
Vue.component('editor', Editor)
//excel导出
Vue.component('downloadExcel', JsonExcel)
//MD5
Vue.prototype.$md5 = md5;
new Vue({
  render: h => h(App),
  router
}).$mount('#app')
