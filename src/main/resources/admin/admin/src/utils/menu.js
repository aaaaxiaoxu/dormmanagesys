const menu = {
  list() {
    return [
      {
        backMenu: [
          {
            child: [
              {
                appFrontIcon: "cuIcon-similar",
                buttons: ["新增", "查看", "修改", "删除"],
                menu: "学生",
                menuJump: "列表",
                tableName: "xuesheng",
              },
              {
                appFrontIcon: "cuIcon-similar",
                buttons: ["新增", "查看", "修改", "删除"],
                menu: "宿管员",
                menuJump: "列表",
                tableName: "suguan",
              },
            ],
            menu: "人员管理",
          },
          {
            child: [
              {
                appFrontIcon: "cuIcon-cardboard",
                buttons: ["新增", "查看", "修改", "删除", "分配"],
                menu: "宿舍信息",
                menuJump: "列表",
                tableName: "sushexinxi",
              },
            ],
            menu: "宿舍信息管理",
          },
          {
            child: [
              {
                appFrontIcon: "cuIcon-rank",
                buttons: ["查看", "新增", "修改", "删除", "水电费", "考勤"],
                menu: "宿舍分配",
                menuJump: "列表",
                tableName: "sushefenpei",
              },
            ],
            menu: "宿舍档案",
          },
          {
            child: [
              {
                appFrontIcon: "cuIcon-pay",
                buttons: ["查看", "新增", "修改", "删除"],
                menu: "水电费",
                menuJump: "列表",
                tableName: "shuidianfei",
              },
              {
                appFrontIcon: "cuIcon-attentionfavor",
                buttons: ["查看", "新增", "修改", "删除"],
                menu: "出入宿舍",
                menuJump: "列表",
                tableName: "churusushe",
              },

              {
                appFrontIcon: "cuIcon-send",
                buttons: ["查看", "新增", "修改", "删除"],
                menu: "访客登记",
                menuJump: "列表",
                tableName: "jinrusushe",
              },
              {
                appFrontIcon: "cuIcon-brand",
                buttons: ["查看", "新增", "修改", "删除", "审核"],
                menu: "宿舍报修",
                menuJump: "列表",
                tableName: "weixiuxinxi",
              },
              {
                appFrontIcon: "cuIcon-brand",
                buttons: ["查看", "修改", "删除", "审核"],
                menu: "请假信息",
                menuJump: "列表",
                tableName: "qingjia",
              },
              {
                appFrontIcon: "cuIcon-album",
                buttons: ["查看", "新增", "修改", "删除", "审核"],
                menu: "宿舍卫生",
                menuJump: "列表",
                tableName: "weishengxinxi",
              },
              {
                appFrontIcon: "cuIcon-send",
                buttons: ["查看", "新增", "修改", "删除"],
                menu: "考勤信息",
                menuJump: "列表",
                tableName: "kaoqinxinxi",
              },
            ],
            menu: "日常事务",
          },
          {
            child: [
              {
                appFrontIcon: "cuIcon-group",
                buttons: ["新增", "查看", "修改", "删除"],
                menu: "论坛交流",
                tableName: "forum",
              },
              {
                appFrontIcon: "cuIcon-service",
                buttons: ["查看", "新增"],
                menu: "AI客服",
                tableName: "messages",
              },
              {
                appFrontIcon: "cuIcon-news",
                buttons: ["新增", "查看", "修改", "删除"],
                menu: "宿舍公告",
                tableName: "news",
              },
            ],
            menu: "互动公告",
          },
        ],
        frontMenu: [],
        hasBackLogin: "是",
        hasBackRegister: "否",
        hasFrontLogin: "否",
        hasFrontRegister: "否",
        roleName: "管理员",
        tableName: "users",
      },
      {
        backMenu: [
          {
            child: [
              {
                appFrontIcon: "cuIcon-similar",
                buttons: ["新增", "查看", "修改", "删除"],
                menu: "学生",
                menuJump: "列表",
                tableName: "xuesheng",
              },
              {
                appFrontIcon: "cuIcon-cardboard",
                buttons: ["新增", "查看", "修改", "删除", "分配"],
                menu: "宿舍信息",
                menuJump: "列表",
                tableName: "sushexinxi",
              },
            ],
            menu: "宿舍信息管理",
          },
          {
            child: [
              {
                appFrontIcon: "cuIcon-rank",
                buttons: ["查看", "新增", "修改", "删除", "水电费", "考勤"],
                menu: "宿舍分配",
                menuJump: "列表",
                tableName: "sushefenpei",
              },
            ],
            menu: "宿舍基础",
          },
          {
            child: [
              {
                appFrontIcon: "cuIcon-pay",
                buttons: ["查看", "新增", "修改", "删除"],
                menu: "水电费",
                menuJump: "列表",
                tableName: "shuidianfei",
              },
              {
                appFrontIcon: "cuIcon-attentionfavor",
                buttons: ["查看", "新增", "修改", "删除"],
                menu: "出入宿舍",
                menuJump: "列表",
                tableName: "churusushe",
              },
              {
                appFrontIcon: "cuIcon-brand",
                buttons: ["查看", "新增", "修改", "删除", "审核"],
                menu: "宿舍报修",
                menuJump: "列表",
                tableName: "weixiuxinxi",
              },
              {
                appFrontIcon: "cuIcon-brand",
                buttons: ["查看", "修改", "删除", "审核"],
                menu: "请假信息",
                menuJump: "列表",
                tableName: "qingjia",
              },
              {
                appFrontIcon: "cuIcon-album",
                buttons: ["查看", "新增", "修改", "删除", "审核"],
                menu: "宿舍卫生",
                menuJump: "列表",
                tableName: "weishengxinxi",
              },
              {
                appFrontIcon: "cuIcon-send",
                buttons: ["查看", "新增", "修改", "删除"],
                menu: "考勤信息",
                menuJump: "列表",
                tableName: "kaoqinxinxi",
              },
            ],
            menu: "事务处理",
          },
          {
            child: [
              {
                appFrontIcon: "cuIcon-group",
                buttons: ["新增", "查看", "修改", "删除"],
                menu: "论坛交流",
                tableName: "forum",
              },
              {
                appFrontIcon: "cuIcon-service",
                buttons: ["查看", "新增"],
                menu: "AI客服",
                tableName: "messages",
              },
              {
                appFrontIcon: "cuIcon-news",
                buttons: [ "查看","新增","删除","修改" ],
                menu: "公告管理",
                tableName: "news",
              },
            ],
            menu: "互动公告",
          },
        ],
        frontMenu: [],
        hasBackLogin: "是",
        hasBackRegister: "否",
        hasFrontLogin: "否",
        hasFrontRegister: "否",
        roleName: "宿管员",
        tableName: "suguan",
      },
      {
        backMenu: [
          {
            child: [
              {
                appFrontIcon: "cuIcon-rank",
                buttons: ["查看",  "出入", "维修", "卫生"],
                menu: "宿舍分配",
                menuJump: "列表",
                tableName: "sushefenpei",
              },
              {
                appFrontIcon: "cuIcon-pay",
                buttons: ["查看", "支付"],
                menu: "水电费",
                menuJump: "列表",
                tableName: "shuidianfei",
              },
            ],
            menu: "我的宿舍",
          },
          {
            child: [
              {
                appFrontIcon: "cuIcon-attentionfavor",
                buttons: ["查看", "新增"],
                menu: "出入宿舍",
                menuJump: "列表",
                tableName: "churusushe",
              },
              {
                appFrontIcon: "cuIcon-brand",
                buttons: ["查看", "新增", "删除"],
                menu: "宿舍报修",
                menuJump: "列表",
                tableName: "weixiuxinxi",
              },
              {
                appFrontIcon: "cuIcon-brand",
                buttons: ["查看", "新增"],
                menu: "请假信息",
                menuJump: "列表",
                tableName: "qingjia",
              },
              {
                appFrontIcon: "cuIcon-service",
                buttons: ["查看", "新增"],
                menu: "AI客服",
                tableName: "messages",
              },
            ],
            menu: "生活服务",
          },
          {
            child: [
              {
                appFrontIcon: "cuIcon-album",
                buttons: ["查看"],
                menu: "宿舍卫生",
                menuJump: "列表",
                tableName: "weishengxinxi",
              },
              {
                appFrontIcon: "cuIcon-send",
                buttons: ["查看"],
                menu: "考勤信息",
                menuJump: "列表",
                tableName: "kaoqinxinxi",
              },
            ],
            menu: "查询记录",
          },
          {
            child: [
              {
                appFrontIcon: "cuIcon-group",
                buttons: ["新增", "查看", "修改", "删除"],
                menu: "论坛交流",
                tableName: "forum",
              },
              {
                appFrontIcon: "cuIcon-service",
                buttons: ["查看", "新增"],
                menu: "AI客服",
                tableName: "messages",
              },
            ],
            menu: "互动公告",
          },
        ],
        frontMenu: [],
        hasBackLogin: "是",
        hasBackRegister: "否",
        hasFrontLogin: "是",
        hasFrontRegister: "是",
        roleName: "学生",
        tableName: "xuesheng",
      },
    ];
  },
};
export default menu;
