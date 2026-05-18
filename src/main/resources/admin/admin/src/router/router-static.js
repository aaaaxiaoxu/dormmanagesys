import Vue from "vue";
//配置路由
import VueRouter from "vue-router";
Vue.use(VueRouter);
//1.创建组件
import Index from "@/views/index";
import Home from "@/views/home";
import Login from "@/views/login";
import NotFound from "@/views/404";
import UpdatePassword from "@/views/update-password";
import pay from "@/views/pay";
import register from "@/views/register";
import center from "@/views/center";
import news from "@/views/modules/news/list";
import aboutus from "@/views/modules/aboutus/list";
import xuesheng from "@/views/modules/xuesheng/list";
import jinrusushe from "@/views/modules/jinrusushe/list";
import weishengxinxi from "@/views/modules/weishengxinxi/list";
import weixiuxinxi from "@/views/modules/weixiuxinxi/list";
import qingjia from "@/views/modules/qingjia/list";
import churusushe from "@/views/modules/churusushe/list";
import forum from "@/views/modules/forum/list";
import systemintro from "@/views/modules/systemintro/list";
import shuidianfei from "@/views/modules/shuidianfei/list";
import sushefenpei from "@/views/modules/sushefenpei/list";
import sushexinxi from "@/views/modules/sushexinxi/list";
import suguan from "@/views/modules/suguan/list";
import messages from "@/views/modules/messages/list";
import kaoqinxinxi from "@/views/modules/kaoqinxinxi/list";
import config from "@/views/modules/config/list";
import analysis from "@/views/analysis";

//2.配置路由   注意：名字
const routes = [
  {
    path: "/index",
    name: "系统首页",
    component: Index,
    children: [
      {
        // 这里不设置值，是把main作为默认页面
        path: "/",
        name: "系统首页",
        component: Home,
        meta: { icon: "", title: "center" },
      },
      {
        path: "/updatePassword",
        name: "修改密码",
        component: UpdatePassword,
        meta: { icon: "", title: "updatePassword" },
      },
      {
        path: "/pay",
        name: "支付",
        component: pay,
        meta: { icon: "", title: "pay" },
      },
      {
        path: "/center",
        name: "个人信息",
        component: center,
        meta: { icon: "", title: "center" },
      },
      {
        path: "/news",
        name: "宿舍公告",
        component: news,
      },
      {
        path: "/aboutus",
        name: "关于我们",
        component: aboutus,
      },
      {
        path: "/xuesheng",
        name: "学生档案",
        component: xuesheng,
      },
      {
        path: "/suguan",
        name: "宿管员",
        component: suguan,
      },
      {
        path: "/jinrusushe",
        name: "访客登记",
        component: jinrusushe,
      },
      {
        path: "/weishengxinxi",
        name: "卫生检查",
        component: weishengxinxi,
      },
      {
        path: "/weixiuxinxi",
        name: "报修工单",
        component: weixiuxinxi,
      },
      {
        path: "/qingjia",
        name: "请假申请",
        component: qingjia,
      },
      {
        path: "/churusushe",
        name: "门禁出入",
        component: churusushe,
      },
      {
        path: "/forum",
        name: "宿舍论坛",
        component: forum,
      },
      {
        path: "/systemintro",
        name: "系统简介",
        component: systemintro,
      },
      {
        path: "/shuidianfei",
        name: "水电费",
        component: shuidianfei,
      },
      {
        path: "/sushefenpei",
        name: "入住分配",
        component: sushefenpei,
      },
      {
        path: "/sushexinxi",
        name: "宿舍资源",
        component: sushexinxi,
      },
      {
        path: "/messages",
        name: "AI客服",
        component: messages,
      },
      {
        path: "/kaoqinxinxi",
        name: "考勤统计",
        component: kaoqinxinxi,
      },
      {
        path: "/analysis",
        name: "数据分析",
        component: analysis,
      },
      {
        path: "/config",
        name: "轮播图管理",
        component: config,
      },
    ],
  },
  {
    path: "/login",
    name: "login",
    component: Login,
    meta: { icon: "", title: "login" },
  },
  {
    path: "/register",
    name: "register",
    component: register,
    meta: { icon: "", title: "register" },
  },
  {
    path: "/",
    name: "系统首页",
    redirect: "/index",
  } /*默认跳转路由*/,
  {
    path: "*",
    component: NotFound,
  },
];
//3.实例化VueRouter  注意：名字
const router = new VueRouter({
  mode: "hash",
  /*hash模式改为history*/
  routes, // （缩写）相当于 routes: routes
});
const originalPush = VueRouter.prototype.push;
//修改原型对象中的push方法
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch((err) => err);
};
export default router;
