const base = {
    get() {
        return {
            url : "http://localhost:8080/dormmanagesys/",
            name: "dormmanagesys",
            // 退出到首页链接
            indexUrl: 'http://localhost:8080/dormmanagesys/front/dist/index.html'
        };
    },
    getProjectName(){
        return {
            projectName: "宿舍管理系统"
        } 
    }
}
export default base
