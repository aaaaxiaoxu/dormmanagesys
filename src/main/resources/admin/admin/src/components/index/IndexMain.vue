<template>
	<div :class="['layout-shell', { 'is-aside-collapsed': asideCollapsed }]">
		<button class="nav-toggle" :title="asideCollapsed ? '展开导航' : '收起导航'" @click="asideCollapsed = !asideCollapsed">
			<i :class="asideCollapsed ? 'el-icon-s-unfold' : 'el-icon-s-fold'"></i>
		</button>
		<index-aside v-if="'vertical' == 'vertical'" class="layout-aside"></index-aside>
		<el-main :class='"vertical" == "vertical" ? "layout-main" : "layout-main is-horizontal"'>
			<index-header class="layout-header"></index-header>
			<index-aside v-if="'vertical' == 'horizontal'" :style='{"width":"100%","borderColor":"#efefef","borderStyle":"solid","background":"#304156","borderWidth":"0 0 1px 0","height":"auto"}'></index-aside>
			<bread-crumbs :title="title" class="bread-crumbs"></bread-crumbs>
			<router-view class="router-view"></router-view>
		</el-main>
	</div>
</template>

<script>
	import IndexAside from '@/components/index/IndexAsideStatic'
	import IndexHeader from '@/components/index/IndexHeader'
	import menu from "@/utils/menu";
	export default {
		components: {
			IndexAside,
			IndexHeader
		},
		data() {
			return {
				menuList: [],
				role: "",
				currentIndex: -2,
				itemMenu: [],
				title: '',
				asideCollapsed: false
			};
		},
		mounted() {
			let menus = menu.list();
			this.menuList = menus;
			this.role = this.$storage.get("role");
		},
		created() {
			this.init();
			console.log(console.log(this.$route.path))
		},
		methods: {
			init(){
				this.$nextTick(()=>{
					
				})
			},
			menuHandler(menu) {
				this.$router.push({
					name: menu.tableName
				});
				this.title = menu.menu;
			},
			titleChange(index, menus) {
				this.currentIndex = index
				this.itemMenu = menus;
				console.log(menus);
			},
			homeChange(index) {
				this.itemMenu = [];
				this.title = ""
				this.currentIndex = index
				this.$router.push({
					name: 'home'
				});
			},
			centerChange(index) {
				this.itemMenu = [{
					"buttons": ["新增", "查看", "修改", "删除"],
					"menu": "修改密码",
					"tableName": "updatePassword"
				}, {
					"buttons": ["新增", "查看", "修改", "删除"],
					"menu": "个人信息",
					"tableName": "center"
				}];
				this.title = ""
				this.currentIndex = index
				this.$router.push({
					name: 'home'
				});
				
			}
		}
	};
</script>
<style lang="scss" scoped>
	.layout-shell {
		height: 100%;
		background:
			radial-gradient(circle at 8% 0, rgba(255, 243, 196, 0.72), transparent 22%),
			radial-gradient(circle at 100% 12%, rgba(216, 239, 250, 0.7), transparent 24%),
			linear-gradient(180deg, #f6fbf1 0%, #eef8e7 100%);
	}

	.layout-aside {
		transition: transform 0.25s ease;
		box-shadow: 14px 0 30px rgba(57, 111, 73, 0.1);
		padding: 0 0 100px;
		overflow: hidden;
		top: 0;
		left: 0;
		background: linear-gradient(180deg, #f8fff4 0%, #e6f6dd 100%);
		bottom: 0;
		width: 216px;
		font-size: 0;
		position: fixed;
		height: 100%;
		z-index: 1001;
		border-right: 1px solid #cfe4c8;
	}

	.layout-main {
		transition: margin-left 0.25s ease;
		min-height: 100%;
		padding: 0;
		margin: 0 0 0 216px;
		display: block;
		position: relative;
		background:
			radial-gradient(circle at 100% 0, rgba(216, 239, 250, 0.78), transparent 20%),
			linear-gradient(180deg, #f8fcf4 0%, #eff8ea 100%);
	}

	.layout-main.is-horizontal {
		margin: 0;
	}

	.layout-header {
		transition: left 0.25s ease, width 0.25s ease;
		padding: 14px 26px;
		align-items: center;
		top: 0;
		left: 216px;
		background: rgba(255, 255, 255, 0.88);
		backdrop-filter: blur(14px);
		display: flex;
		width: calc(100% - 216px);
		position: fixed;
		justify-content: center;
		font-weight: 550;
		z-index: 1004;
		border-bottom: 1px solid rgba(207, 228, 200, 0.9);
		box-shadow: 0 10px 26px rgba(57, 111, 73, 0.08);
	}

	.bread-crumbs {
		padding: 12px 18px;
		margin: 86px 20px 0;
		border-radius: 14px;
		background: rgba(255, 255, 255, 0.82);
		width: calc(100% - 40px);
		border: 1px solid rgba(207, 228, 200, 0.9);
		box-shadow: 0 8px 22px rgba(57, 111, 73, 0.07);
	}

	.nav-toggle {
		align-items: center;
		background: #fff;
		border: 1px solid rgba(111, 189, 117, 0.36);
		border-radius: 12px;
		box-shadow: 0 8px 18px rgba(57, 111, 73, 0.12);
		color: #2f7c43;
		cursor: pointer;
		display: flex;
		height: 38px;
		justify-content: center;
		left: 18px;
		position: fixed;
		top: 18px;
		width: 38px;
		z-index: 1010;
	}

	.nav-toggle i {
		font-size: 18px;
	}

	.is-aside-collapsed {
		.layout-aside {
			transform: translateX(-216px);
		}

		.layout-main {
			margin-left: 0;
		}

		.layout-header {
			left: 0;
			width: 100%;
		}
	}

	.router-view {
		padding-bottom: 24px;
	}

	a {
		text-decoration: none;
		color: #438f55;
	}

	a:hover {
		color: #2f7c43;
	}
	
	.el-main {
		padding: 0;
		display: block;
	}

	.nav-list {
		width: 100%;
		margin: 0 auto;
		text-align: left;
		margin-top: 20px;

		.nav-title {
			display: inline-block;
			font-size: 15px;
			color: #333;
			padding: 15px 25px;
			border: none;
		}

		.nav-title.active {
			color: #555;
			cursor: default;
			background-color: #fff;
		}
	}

	.nav-item {
		margin-top: 20px;
		background: #FFFFFF;
		padding: 15px 0;

		.menu {
			padding: 15px 25px;
		}
	}
	
	.detail-form-content {
	    background: transparent;
	}

	@media (max-width: 992px) {
		.layout-aside {
			width: 200px;
		}

		.layout-main {
			margin-left: 200px;
		}

		.layout-header {
			left: 200px;
			width: calc(100% - 200px);
			padding: 12px 18px;
		}
	}
</style>
