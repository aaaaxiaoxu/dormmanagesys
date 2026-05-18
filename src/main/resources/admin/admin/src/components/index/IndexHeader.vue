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
			font-size: 22px !important;
			font-weight: 700;
			letter-spacing: 0.02em;
			color: #0f172a !important;
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
			border-radius: 12px;
			padding: 0 14px;
			transition: all 0.2s ease;
		}

		.nickname {
			color: #334155 !important;
			background: rgba(226, 232, 240, 0.72);
		}

		.logout {
			color: #516146 !important;
			background: rgba(229, 235, 221, 0.92);
		}

		.logout:hover {
			background: rgba(214, 224, 201, 0.98);
		}
	}
</style>
