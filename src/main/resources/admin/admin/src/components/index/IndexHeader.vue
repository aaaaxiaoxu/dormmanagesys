<template>
	<div class="navbar">
		<div class="title" :style='{"display":"block"}'>
			<el-image v-if="false" class="title-img" :style='{"width":"44px","objectFit":"cover","borderRadius":"100%","float":"left","height":"44px"}' src="http://codegen.caihongy.cn/20201114/7856ba26477849ea828f481fa2773a95.jpg" fit="cover" />
			<span class="title-name" :style='{"padding":"0 0 0 12px","lineHeight":"44px","fontSize":"20px","color":"#000","float":"left"}'>{{this.$project.projectName}}</span>
		</div>
		<div class="right" :style='{"position":"absolute","right":"20px","top":"8px","display":"flex"}'>
			<div :style='{"cursor":"pointer","margin":"0 15px","lineHeight":"44px","color":"#333"}' class="nickname">{{this.$storage.get('role')}} {{this.$storage.get('adminName')}}</div>
			<!-- <div :style='{"cursor":"pointer","margin":"0 25px","lineHeight":"44px","color":"#666"}' v-if="this.$storage.get('role')!='管理员'" class="logout" @click="onIndexTap">退出到前台</div> -->
			<div :style='{"cursor":"pointer","margin":"0 15px","lineHeight":"44px","color":"#666"}' class="logout" @click="onLogout">退出登录</div>
		</div>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				dialogVisible: false,
				ruleForm: {},
				user: {},
			};
		},
		created() {
			
		},
		mounted() {
			let sessionTable = this.$storage.get("sessionTable")
			this.$http({
				url: sessionTable + '/session',
				method: "get"
			}).then(({
				data
			}) => {
				if (data && data.code === 0) {
					this.user = data.data;
					this.$storage.set('userid',data.data.id);
				} else {
					let message = this.$message
					message.error(data.msg);
				}
			});
		},
		methods: {
			onLogout() {
				let storage = this.$storage
				let router = this.$router
				storage.clear()
				router.replace({
					name: "login"
				});
			},
			onIndexTap(){
				window.location.href = `${this.$base.indexUrl}`
			},
		}
	};
</script>


<style lang="scss" scoped>
	.navbar {
		width: 100%;
		display: flex;
		align-items: center;
		justify-content: space-between;
		color: #0f172a;

		.title {
			display: flex !important;
			align-items: center;
			min-width: 0;
		}

		.title-name {
			padding-left: 0 !important;
			float: none !important;
			line-height: 1.2 !important;
			font-size: 23px !important;
			font-weight: 700;
			letter-spacing: 0;
			color: #263b2e !important;
		}

		.right {
			position: static !important;
			display: flex !important;
			align-items: center;
			gap: 12px;
			margin-left: auto;
		}

		.nickname,
		.logout {
			margin: 0 !important;
			line-height: 40px !important;
			border-radius: 10px;
			padding: 0 14px;
			transition: all 0.2s ease;
			font-size: 15px;
			font-weight: 600;
		}

		.nickname {
			color: #438f55 !important;
			background: rgba(223, 245, 225, 0.9);
		}

		.logout {
			color: #2f7c43 !important;
			background: rgba(255, 243, 196, 0.9);
		}

		.logout:hover {
			background: rgba(255, 235, 151, 0.98);
		}
	}
</style>
