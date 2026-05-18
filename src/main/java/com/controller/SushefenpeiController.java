package com.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Map;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import com.utils.ValidatorUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.annotation.IgnoreAuth;

import com.entity.SushefenpeiEntity;
import com.entity.SushexinxiEntity;
import com.entity.XueshengEntity;
import com.entity.view.SushefenpeiView;

import com.service.SushefenpeiService;
import com.service.SushexinxiService;
import com.service.TokenService;
import com.service.XueshengService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MD5Util;
import com.utils.MPUtil;
import com.utils.CommonUtil;
import java.io.IOException;

/**
 * 宿舍分配
 * 后端接口
 * @author 
 * @email 
 * @date 2023-05-08 17:35:32
 */
@RestController
@RequestMapping("/sushefenpei")
public class SushefenpeiController {
    @Autowired
    private SushefenpeiService sushefenpeiService;
    @Autowired
    private SushexinxiService sushexinxiService;
    @Autowired
    private XueshengService xueshengService;


    


    /**
     * 后端列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,SushefenpeiEntity sushefenpei,
		HttpServletRequest request){
		String tableName = request.getSession().getAttribute("tableName").toString();
		SushefenpeiEntity currentDorm = null;
		if(tableName.equals("xuesheng")) {
			String username = (String)request.getSession().getAttribute("username");
			currentDorm = getCurrentStudentDorm(username);
			if(currentDorm != null
					&& StringUtils.isNotBlank(currentDorm.getSushemingcheng())
					&& StringUtils.isNotBlank(currentDorm.getSusheloudong())
					&& StringUtils.isNotBlank(currentDorm.getFangjianhao())) {
				sushefenpei.setSushemingcheng(currentDorm.getSushemingcheng());
				sushefenpei.setSusheleixing(currentDorm.getSusheleixing());
				sushefenpei.setSusheloudong(currentDorm.getSusheloudong());
				sushefenpei.setFangjianhao(currentDorm.getFangjianhao());
				sushefenpei.setXueshengxuehao(null);
			}
		}
        EntityWrapper<SushefenpeiEntity> ew = new EntityWrapper<SushefenpeiEntity>();
		if(tableName.equals("xuesheng")) {
			if(currentDorm != null
					&& StringUtils.isNotBlank(currentDorm.getSushemingcheng())
					&& StringUtils.isNotBlank(currentDorm.getSusheloudong())
					&& StringUtils.isNotBlank(currentDorm.getFangjianhao())) {
				ew.eq("sushemingcheng", currentDorm.getSushemingcheng());
				ew.eq("susheloudong", currentDorm.getSusheloudong());
				ew.eq("fangjianhao", currentDorm.getFangjianhao());
			} else {
				ew.eq("id", -1);
			}
		}

		PageUtils page = sushefenpeiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, sushefenpei), params), params));

        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,SushefenpeiEntity sushefenpei, 
		HttpServletRequest request){
        EntityWrapper<SushefenpeiEntity> ew = new EntityWrapper<SushefenpeiEntity>();

		PageUtils page = sushefenpeiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, sushefenpei), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( SushefenpeiEntity sushefenpei){
       	EntityWrapper<SushefenpeiEntity> ew = new EntityWrapper<SushefenpeiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( sushefenpei, "sushefenpei")); 
        return R.ok().put("data", sushefenpeiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(SushefenpeiEntity sushefenpei){
        EntityWrapper< SushefenpeiEntity> ew = new EntityWrapper< SushefenpeiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( sushefenpei, "sushefenpei")); 
		SushefenpeiView sushefenpeiView =  sushefenpeiService.selectView(ew);
		return R.ok("查询宿舍分配成功").put("data", sushefenpeiView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        SushefenpeiEntity sushefenpei = sushefenpeiService.selectById(id);
        return R.ok().put("data", sushefenpei);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        SushefenpeiEntity sushefenpei = sushefenpeiService.selectById(id);
        return R.ok().put("data", sushefenpei);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody SushefenpeiEntity sushefenpei, HttpServletRequest request){
    	sushefenpei.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	//ValidatorUtils.validateEntity(sushefenpei);
        String validateMsg = validateAllocation(sushefenpei);
        if(StringUtils.isNotBlank(validateMsg)) {
            return R.error(validateMsg);
        }
        sushefenpeiService.insert(sushefenpei);
        syncDormStatus(sushefenpei);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody SushefenpeiEntity sushefenpei, HttpServletRequest request){
    	sushefenpei.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	//ValidatorUtils.validateEntity(sushefenpei);
        String validateMsg = validateAllocation(sushefenpei);
        if(StringUtils.isNotBlank(validateMsg)) {
            return R.error(validateMsg);
        }
        sushefenpeiService.insert(sushefenpei);
        syncDormStatus(sushefenpei);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody SushefenpeiEntity sushefenpei, HttpServletRequest request){
        SushefenpeiEntity oldData = sushefenpeiService.selectById(sushefenpei.getId());
        //ValidatorUtils.validateEntity(sushefenpei);
        String validateMsg = validateAllocation(sushefenpei);
        if(StringUtils.isNotBlank(validateMsg)) {
            return R.error(validateMsg);
        }
        sushefenpeiService.updateById(sushefenpei);//全部更新
        syncDormStatus(sushefenpei);
        syncDormStatus(oldData);
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        List<SushefenpeiEntity> deleteList = sushefenpeiService.selectBatchIds(Arrays.asList(ids));
        sushefenpeiService.deleteBatchIds(Arrays.asList(ids));
        if(deleteList != null){
            for (SushefenpeiEntity item : deleteList) {
                syncDormStatus(item);
            }
        }
        return R.ok();
    }
    
	









    private SushefenpeiEntity getCurrentStudentDorm(String username) {
        EntityWrapper<SushefenpeiEntity> currentDormWrapper = new EntityWrapper<SushefenpeiEntity>();
        currentDormWrapper.eq("xueshengxuehao", username);
        return sushefenpeiService.selectOne(currentDormWrapper);
    }

    private String validateAllocation(SushefenpeiEntity sushefenpei) {
        if(sushefenpei == null) {
            return "分配信息不能为空";
        }
        if(StringUtils.isBlank(sushefenpei.getXueshengxuehao())) {
            return "请选择学生";
        }
        if(StringUtils.isBlank(sushefenpei.getSushemingcheng())
                || StringUtils.isBlank(sushefenpei.getSusheleixing())
                || StringUtils.isBlank(sushefenpei.getSusheloudong())
                || StringUtils.isBlank(sushefenpei.getFangjianhao())) {
            return "请选择完整的宿舍信息";
        }
        if(StringUtils.isBlank(sushefenpei.getChuangweihao())) {
            return "请选择床位号";
        }

        EntityWrapper<XueshengEntity> studentInfoWrapper = new EntityWrapper<XueshengEntity>();
        studentInfoWrapper.eq("xueshengxuehao", sushefenpei.getXueshengxuehao());
        XueshengEntity student = xueshengService.selectOne(studentInfoWrapper);
        if(student == null) {
            return "未找到对应的学生信息";
        }

        EntityWrapper<SushexinxiEntity> dormInfoWrapper = new EntityWrapper<SushexinxiEntity>();
        dormInfoWrapper.eq("sushemingcheng", sushefenpei.getSushemingcheng());
        dormInfoWrapper.eq("susheleixing", sushefenpei.getSusheleixing());
        dormInfoWrapper.eq("susheloudong", sushefenpei.getSusheloudong());
        dormInfoWrapper.eq("fangjianhao", sushefenpei.getFangjianhao());
        SushexinxiEntity dorm = sushexinxiService.selectOne(dormInfoWrapper);
        if(dorm == null) {
            return "未找到对应的宿舍信息";
        }

        String studentGender = normalizeStudentGender(student.getXingbie());
        String dormGender = normalizeDormGender(dorm.getSusheleixing());
        if(StringUtils.isNotBlank(studentGender)
                && StringUtils.isNotBlank(dormGender)
                && !StringUtils.equals(studentGender, dormGender)) {
            return "学生性别与宿舍类型不匹配，当前学生为" + student.getXingbie() + "，不能分配到" + dorm.getSusheleixing() + "宿舍";
        }

        EntityWrapper<SushefenpeiEntity> studentWrapper = new EntityWrapper<SushefenpeiEntity>();
        studentWrapper.eq("xueshengxuehao", sushefenpei.getXueshengxuehao());
        if(sushefenpei.getId() != null) {
            studentWrapper.ne("id", sushefenpei.getId());
        }
        if(sushefenpeiService.selectCount(studentWrapper) > 0) {
            return "该学生已分配宿舍，请使用修改功能进行换宿或换床";
        }

        EntityWrapper<SushefenpeiEntity> bedWrapper = new EntityWrapper<SushefenpeiEntity>();
        bedWrapper.eq("sushemingcheng", sushefenpei.getSushemingcheng());
        bedWrapper.eq("susheloudong", sushefenpei.getSusheloudong());
        bedWrapper.eq("fangjianhao", sushefenpei.getFangjianhao());
        bedWrapper.eq("chuangweihao", sushefenpei.getChuangweihao());
        if(sushefenpei.getId() != null) {
            bedWrapper.ne("id", sushefenpei.getId());
        }
        if(sushefenpeiService.selectCount(bedWrapper) > 0) {
            return "该床位已有人入住，请重新选择";
        }
        return null;
    }

    private String normalizeStudentGender(String gender) {
        if(StringUtils.isBlank(gender)) {
            return null;
        }
        if(gender.contains("男")) {
            return "男";
        }
        if(gender.contains("女")) {
            return "女";
        }
        return gender.trim();
    }

    private String normalizeDormGender(String dormType) {
        if(StringUtils.isBlank(dormType)) {
            return null;
        }
        if(dormType.contains("男")) {
            return "男";
        }
        if(dormType.contains("女")) {
            return "女";
        }
        return dormType.trim();
    }

    private void syncDormStatus(SushefenpeiEntity sushefenpei) {
        if(sushefenpei == null || StringUtils.isBlank(sushefenpei.getSushemingcheng())
                || StringUtils.isBlank(sushefenpei.getSusheloudong())
                || StringUtils.isBlank(sushefenpei.getFangjianhao())) {
            return;
        }
        EntityWrapper<SushexinxiEntity> dormWrapper = new EntityWrapper<SushexinxiEntity>();
        dormWrapper.eq("sushemingcheng", sushefenpei.getSushemingcheng());
        dormWrapper.eq("susheloudong", sushefenpei.getSusheloudong());
        dormWrapper.eq("fangjianhao", sushefenpei.getFangjianhao());
        SushexinxiEntity dorm = sushexinxiService.selectOne(dormWrapper);
        if(dorm == null){
            return;
        }

        EntityWrapper<SushefenpeiEntity> allocationWrapper = new EntityWrapper<SushefenpeiEntity>();
        allocationWrapper.eq("sushemingcheng", dorm.getSushemingcheng());
        allocationWrapper.eq("susheloudong", dorm.getSusheloudong());
        allocationWrapper.eq("fangjianhao", dorm.getFangjianhao());
        int currentCount = sushefenpeiService.selectCount(allocationWrapper);

        int capacity = 0;
        try {
            capacity = Integer.parseInt(StringUtils.defaultIfBlank(dorm.getKezhurenshu(), "0"));
        } catch (Exception e) {
            capacity = 0;
        }

        int occupiedCount = capacity > 0 ? Math.min(currentCount, capacity) : currentCount;

        dorm.setYizhurenshu(String.valueOf(occupiedCount));
        dorm.setYouchuangwei(occupiedCount < capacity ? "是" : "否");
        dorm.setGengxinshijian(new Date());
        sushexinxiService.updateById(dorm);
    }
}
