<template>
	<div class="layout-shell">
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
				title: ''
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
			radial-gradient(circle at top left, rgba(59, 130, 246, 0.08), transparent 18%),
			linear-gradient(180deg, #eff4fb 0%, #edf2f8 100%);
	}

	.layout-aside {
		box-shadow: 18px 0 36px rgba(15, 23, 42, 0.08);
		padding: 0 0 100px;
		overflow: hidden;
		top: 0;
		left: 0;
		background: linear-gradient(180deg, #0f172a 0%, #172033 100%);
		bottom: 0;
		width: 216px;
		font-size: 0;
		position: fixed;
		height: 100%;
		z-index: 1001;
		border-right: 1px solid rgba(148, 163, 184, 0.12);
	}

	.layout-main {
		min-height: 100%;
		padding: 0;
		margin: 0 0 0 216px;
		display: block;
		position: relative;
		background:
			radial-gradient(circle at 100% 0, rgba(148, 163, 184, 0.12), transparent 20%),
			linear-gradient(180deg, #f4f7fb 0%, #edf2f7 100%);
	}

	.layout-main.is-horizontal {
		margin: 0;
	}

	.layout-header {
		padding: 14px 26px;
		align-items: center;
		top: 0;
		left: 216px;
		background: rgba(248, 250, 252, 0.92);
		backdrop-filter: blur(14px);
		display: flex;
		width: calc(100% - 216px);
		position: fixed;
		justify-content: center;
		font-weight: 550;
		z-index: 1004;
		border-bottom: 1px solid rgba(148, 163, 184, 0.16);
		box-shadow: 0 10px 30px rgba(15, 23, 42, 0.06);
	}

	.bread-crumbs {
		padding: 12px 18px;
		margin: 86px 20px 0;
		border-radius: 16px;
		background: rgba(255, 255, 255, 0.82);
		width: calc(100% - 40px);
		border: 1px solid rgba(148, 163, 184, 0.18);
		box-shadow: 0 8px 24px rgba(15, 23, 42, 0.05);
	}

	.router-view {
		padding-bottom: 24px;
	}

	a {
		text-decoration: none;
		color: #475569;
	}

	a:hover {
		color: #6f7f5f;
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
