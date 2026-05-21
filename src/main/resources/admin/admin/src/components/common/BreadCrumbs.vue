<template>
	<div class="breadcrumb-preview">
		<el-breadcrumb :style='{"fontSize":"14px","lineHeight":"14px"}' separator="Ξ">
			<transition-group name="breadcrumb" class="box">
				<el-breadcrumb-item v-for="(item,index) in levelList" :key="item.path">
					<span v-if="item.redirect==='noRedirect'||index==levelList.length-1" class="no-redirect">{{ item.name }}</span>
					<a v-else @click.prevent="handleLink(item)">{{ item.name }}</a>
				</el-breadcrumb-item>
			</transition-group>
		</el-breadcrumb>
	</div>
</template>

<script>
import pathToRegexp from 'path-to-regexp'
import { generateTitle } from '@/utils/i18n'
import menu from '@/utils/menu'
import storage from '@/utils/storage'
export default {
  data() {
    return {
      levelList: null
    }
  },
  watch: {
    $route() {
      this.getBreadcrumb()
    }
  },
  created() {
    this.getBreadcrumb()
  },
  methods: {
    generateTitle,
    getBreadcrumb() {
      // only show routes with meta.title
      let route = this.$route
      let matched = route.matched.filter(item => item.meta)
      matched = [{ path: '/index' }].concat(matched)

      this.levelList = matched
        .filter(item => item.meta)
        .map(item => Object.assign({}, item, {
          name: this.resolveRouteName(item)
        }))
    },
    resolveRouteName(route) {
      if (route.path === '/index') {
        return '系统首页'
      }
      const tableName = String(route.path || '').replace(/^\//, '')
      const menuName = this.getRoleMenuName(tableName)
      return menuName || route.name
    },
    getRoleMenuName(tableName) {
      if (!tableName) {
        return ''
      }
      const role = storage.get('role') || '管理员'
      const menus = menu.list()
      for (let i = 0; i < menus.length; i++) {
        if (menus[i].roleName !== role || !menus[i].backMenu) {
          continue
        }
        for (let j = 0; j < menus[i].backMenu.length; j++) {
          const children = menus[i].backMenu[j].child || []
          for (let k = 0; k < children.length; k++) {
            if (children[k].tableName === tableName) {
              return children[k].menu
            }
          }
        }
      }
      return ''
    },
    isDashboard(route) {
      const name = route && route.name
      if (!name) {
        return false
      }
      return name.trim().toLocaleLowerCase() === 'Index'.toLocaleLowerCase()
    },
    pathCompile(path) {
      // To solve this problem https://github.com/PanJiaChen/vue-element-admin/issues/561
      const { params } = this.$route
      var toPath = pathToRegexp.compile(path)
      return toPath(params)
    },
    handleLink(item) {
      const { redirect, path } = item
      if (redirect) {
        this.$router.push(redirect)
        return
      }
      this.$router.push(path)
    },
  }
}
</script>

<style lang="scss" scoped>
	.el-breadcrumb {
		&  ::v-deep .el-breadcrumb__separator {
		  		  margin: 0 9px;
		  		  color: #94a3b8;
		  		  font-weight: 500;
		  		}
		
		&  ::v-deep .el-breadcrumb__inner a {
		  		  color: #64748b;
		  		  display: inline-block;
		  		}
		
		&  ::v-deep .el-breadcrumb__inner {
		  		  color: #0f172a;
		  		  display: inline-block;
		  		  font-weight: 600;
		  		}
	}
</style>
