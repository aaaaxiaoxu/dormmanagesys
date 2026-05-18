package com.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.annotation.IgnoreAuth;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.entity.ForumEntity;
import com.entity.view.ForumView;
import com.service.ForumService;
import com.utils.MPUtil;
import com.utils.PageUtils;
import com.utils.R;

/**
 * 交流论坛
 * 后端接口
 */
@RestController
@RequestMapping("/forum")
public class ForumController {
    @Autowired
    private ForumService forumService;

    /**
     * 后端列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params, ForumEntity forum, HttpServletRequest request) {
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
        PageUtils page = forumService.queryPage(params,
                MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, forum), params), params));
        return R.ok().put("data", page);
    }

    /**
     * 前端列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params, ForumEntity forum, HttpServletRequest request) {
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
        PageUtils page = forumService.queryPage(params,
                MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, forum), params), params));
        return R.ok().put("data", page);
    }

    /**
     * 列表
     */
    @IgnoreAuth
    @RequestMapping("/flist")
    public R flist(@RequestParam Map<String, Object> params, ForumEntity forum, HttpServletRequest request) {
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
        PageUtils page = forumService.queryPage(params,
                MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, forum), params), params));
        return R.ok().put("data", page);
    }

    /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ForumEntity forum) {
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
        ew.allEq(MPUtil.allEQMapPre(forum, "forum"));
        ForumView forumView = forumService.selectView(ew);
        return R.ok("查询交流论坛成功").put("data", forumView);
    }

    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id) {
        ForumEntity forum = forumService.selectById(id);
        return R.ok().put("data", forum);
    }

    /**
     * 前端详情
     */
    @IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id) {
        ForumEntity forum = forumService.selectById(id);
        return R.ok().put("data", forum);
    }

    /**
     * 论坛详情及回复树
     */
    @RequestMapping("/list/{id}")
    public R list(@PathVariable("id") String id) {
        ForumEntity forum = forumService.selectById(id);
        if (forum == null) {
            return R.error("帖子不存在或已删除");
        }
        getChilds(forum);
        return R.ok().put("data", forum);
    }

    private ForumEntity getChilds(ForumEntity forum) {
        List<ForumEntity> childs = forumService.selectList(new EntityWrapper<ForumEntity>()
                .eq("parentid", forum.getId())
                .orderBy("addtime", true)
                .orderBy("id", true));
        if (childs == null || childs.size() == 0) {
            return null;
        }
        forum.setChilds(childs);
        for (ForumEntity forumEntity : childs) {
            getChilds(forumEntity);
        }
        return forum;
    }

    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ForumEntity forum, HttpServletRequest request) {
        R validateResult = validateReplyAvailability(forum);
        if (validateResult != null) {
            return validateResult;
        }
        fillCreateFields(forum, request);
        forumService.insert(forum);
        return R.ok();
    }

    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody ForumEntity forum, HttpServletRequest request) {
        R validateResult = validateReplyAvailability(forum);
        if (validateResult != null) {
            return validateResult;
        }
        fillCreateFields(forum, request);
        forumService.insert(forum);
        return R.ok();
    }

    private void fillCreateFields(ForumEntity forum, HttpServletRequest request) {
        forum.setId(new Date().getTime() + new Double(Math.floor(Math.random() * 1000)).longValue());
        forum.setUserid((Long) request.getSession().getAttribute("userId"));
        forum.setUsername((String) request.getSession().getAttribute("username"));
        forum.setAvatarurl(resolveRoleLabel(request, forum.getAvatarurl()));
        if (forum.getParentid() == null) {
            forum.setParentid(0L);
        }
        if (forum.getParentid() == 0L) {
            if (forum.getIsdone() == null || "".equals(forum.getIsdone())) {
                forum.setIsdone("开放");
            }
            if (!"开放".equals(forum.getIsdone()) && !"关闭".equals(forum.getIsdone())) {
                forum.setIsdone("开放");
            }
        } else {
            ForumEntity parent = forumService.selectById(forum.getParentid());
            if (parent != null && (forum.getTitle() == null || "".equals(forum.getTitle()))) {
                forum.setTitle(parent.getTitle());
            }
            forum.setIsdone(null);
        }
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody ForumEntity forum, HttpServletRequest request) {
        ForumEntity oldForum = forumService.selectById(forum.getId());
        if (oldForum == null) {
            return R.error("帖子不存在或已删除");
        }

        Long currentUserId = (Long) request.getSession().getAttribute("userId");
        if (!oldForum.getUserid().equals(currentUserId)) {
            return R.error("您只能修改自己发布的内容");
        }

        forum.setUserid(oldForum.getUserid());
        forum.setUsername(oldForum.getUsername());
        forum.setAvatarurl(oldForum.getAvatarurl());
        forum.setParentid(oldForum.getParentid());
        forum.setAddtime(oldForum.getAddtime());

        if (forum.getParentid() != null && forum.getParentid() != 0L) {
            forum.setIsdone(oldForum.getIsdone());
        } else {
            if (!"开放".equals(forum.getIsdone()) && !"关闭".equals(forum.getIsdone())) {
                forum.setIsdone(oldForum.getIsdone() == null ? "开放" : oldForum.getIsdone());
            }
        }

        forumService.updateById(forum);
        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids, HttpServletRequest request) {
        String tableName = String.valueOf(request.getSession().getAttribute("tableName"));
        boolean privileged = isPrivileged(tableName);
        Long currentUserId = (Long) request.getSession().getAttribute("userId");

        List<Long> deleteIds = new ArrayList<Long>();
        for (Long id : Arrays.asList(ids)) {
            ForumEntity forum = forumService.selectById(id);
            if (forum == null) {
                continue;
            }
            if (privileged || forum.getUserid().equals(currentUserId)) {
                collectDeleteIds(id, deleteIds);
            }
        }

        if (deleteIds.size() == 0) {
            return R.error("没有可删除的数据");
        }

        forumService.deleteBatchIds(deleteIds);
        return R.ok();
    }

    private boolean isPrivileged(String tableName) {
        return "users".equals(tableName) || "suguan".equals(tableName);
    }

    private R validateReplyAvailability(ForumEntity forum) {
        if (forum.getParentid() == null || forum.getParentid() == 0L) {
            return null;
        }
        ForumEntity parent = forumService.selectById(forum.getParentid());
        if (parent == null) {
            return R.error("评论对象不存在或已删除");
        }
        ForumEntity rootForum = getRootForum(parent);
        if (rootForum == null) {
            return R.error("帖子不存在或已删除");
        }
        if (!"开放".equals(rootForum.getIsdone())) {
            return R.error("当前帖子已关闭评论");
        }
        return null;
    }

    private ForumEntity getRootForum(ForumEntity forum) {
        ForumEntity current = forum;
        while (current != null && current.getParentid() != null && current.getParentid() != 0L) {
            current = forumService.selectById(current.getParentid());
        }
        return current;
    }

    private void collectDeleteIds(Long forumId, List<Long> deleteIds) {
        if (forumId == null || deleteIds.contains(forumId)) {
            return;
        }
        deleteIds.add(forumId);
        List<ForumEntity> childs = forumService.selectList(new EntityWrapper<ForumEntity>().eq("parentid", forumId));
        for (ForumEntity child : childs) {
            collectDeleteIds(child.getId(), deleteIds);
        }
    }

    private String resolveRoleLabel(HttpServletRequest request, String originalAvatarurl) {
        Object roleName = request.getSession().getAttribute("role");
        if (roleName != null && !"".equals(String.valueOf(roleName))) {
            return String.valueOf(roleName);
        }
        Object tableName = request.getSession().getAttribute("tableName");
        if ("suguan".equals(tableName)) {
            return "宿管";
        }
        if ("xuesheng".equals(tableName)) {
            return "学生";
        }
        if ("users".equals(tableName)) {
            return "管理员";
        }
        if (originalAvatarurl != null && !"".equals(originalAvatarurl)) {
            return originalAvatarurl;
        }
        return "用户";
    }
}
