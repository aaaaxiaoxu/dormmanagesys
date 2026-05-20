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
import java.util.HashSet;
import java.util.List;
import java.util.Set;
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
        normalizeAllocationBedNo(sushefenpei);
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
        normalizeAllocationBedNo(sushefenpei);
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
        normalizeAllocationBedNo(sushefenpei);
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

    /**
     * 一键分配宿舍
     */
    @RequestMapping("/autoAssign")
    @Transactional
    public R autoAssign(@RequestBody Map<String, Object> params, HttpServletRequest request){
        boolean previewOnly = getBooleanParam(params, "previewOnly");
        List<XueshengEntity> students = selectAssignableStudents(params);
        List<SushexinxiEntity> dorms = selectAvailableDorms(params);
        List<Map<String, Object>> successList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> failedList = new ArrayList<Map<String, Object>>();

        if(students == null || students.isEmpty()) {
            return R.ok("没有符合条件的未分配学生")
                    .put("previewOnly", previewOnly)
                    .put("successCount", 0)
                    .put("failedCount", 0)
                    .put("successList", successList)
                    .put("failedList", failedList);
        }
        if(dorms == null || dorms.isEmpty()) {
            for(XueshengEntity student : students) {
                failedList.add(buildAutoAssignFailure(student, "没有符合条件的宿舍资源"));
            }
            return R.ok("没有符合条件的宿舍资源")
                    .put("previewOnly", previewOnly)
                    .put("successCount", 0)
                    .put("failedCount", failedList.size())
                    .put("successList", successList)
                    .put("failedList", failedList);
        }

        Map<Long, Set<String>> occupiedBedMap = buildOccupiedBedMap(dorms);
        long seed = new Date().getTime();
        int sequence = 0;
        for(XueshengEntity student : students) {
            if(isStudentAllocated(student.getXueshengxuehao())) {
                failedList.add(buildAutoAssignFailure(student, "该学生已分配宿舍"));
                continue;
            }
            SushexinxiEntity matchedDorm = null;
            String matchedBed = null;
            for(SushexinxiEntity dorm : dorms) {
                if(!isGenderMatched(student, dorm)) {
                    continue;
                }
                matchedBed = findFirstAvailableBed(dorm, occupiedBedMap.get(dorm.getId()));
                if(StringUtils.isNotBlank(matchedBed)) {
                    matchedDorm = dorm;
                    break;
                }
            }

            if(matchedDorm == null || StringUtils.isBlank(matchedBed)) {
                failedList.add(buildAutoAssignFailure(student, "没有符合性别和空床位规则的宿舍"));
                continue;
            }

            SushefenpeiEntity allocation = buildAutoAllocation(student, matchedDorm, matchedBed, seed + sequence++);
            String validateMsg = validateAllocation(allocation);
            if(StringUtils.isNotBlank(validateMsg)) {
                failedList.add(buildAutoAssignFailure(student, validateMsg));
                continue;
            }

            if(!previewOnly) {
                sushefenpeiService.insert(allocation);
                syncDormStatus(allocation);
            }
            Set<String> occupiedBeds = occupiedBedMap.get(matchedDorm.getId());
            if(occupiedBeds == null) {
                occupiedBeds = new HashSet<String>();
                occupiedBedMap.put(matchedDorm.getId(), occupiedBeds);
            }
            occupiedBeds.add(matchedBed);
            successList.add(buildAutoAssignSuccess(allocation));
        }

        return R.ok(previewOnly ? "一键分配预览完成" : "一键分配完成")
                .put("previewOnly", previewOnly)
                .put("successCount", successList.size())
                .put("failedCount", failedList.size())
                .put("successList", successList)
                .put("failedList", failedList);
    }
    
	









    private SushefenpeiEntity getCurrentStudentDorm(String username) {
        EntityWrapper<SushefenpeiEntity> currentDormWrapper = new EntityWrapper<SushefenpeiEntity>();
        currentDormWrapper.eq("xueshengxuehao", username);
        return sushefenpeiService.selectOne(currentDormWrapper);
    }

    private List<XueshengEntity> selectAssignableStudents(Map<String, Object> params) {
        EntityWrapper<XueshengEntity> wrapper = new EntityWrapper<XueshengEntity>();
        addEqCondition(wrapper, "banji", getStringParam(params, "banji"));
        addEqCondition(wrapper, "zhuanye", getStringParam(params, "zhuanye"));
        addEqCondition(wrapper, "xingbie", getStringParam(params, "xingbie"));
        addLikeCondition(wrapper, "xueshengxuehao", getStringParam(params, "xueshengxuehao"));
        addLikeCondition(wrapper, "xueshengxingming", getStringParam(params, "xueshengxingming"));
        return xueshengService.selectList(wrapper);
    }

    private List<SushexinxiEntity> selectAvailableDorms(Map<String, Object> params) {
        EntityWrapper<SushexinxiEntity> wrapper = new EntityWrapper<SushexinxiEntity>();
        addEqCondition(wrapper, "susheloudong", getStringParam(params, "susheloudong"));
        addEqCondition(wrapper, "susheleixing", getStringParam(params, "susheleixing"));
        addLikeCondition(wrapper, "sushemingcheng", getStringParam(params, "sushemingcheng"));
        addLikeCondition(wrapper, "fangjianhao", getStringParam(params, "fangjianhao"));
        wrapper.orderBy("susheloudong", true);
        wrapper.orderBy("fangjianhao", true);
        return sushexinxiService.selectList(wrapper);
    }

    private void addEqCondition(EntityWrapper<?> wrapper, String column, String value) {
        if(StringUtils.isNotBlank(value)) {
            wrapper.eq(column, value);
        }
    }

    private void addLikeCondition(EntityWrapper<?> wrapper, String column, String value) {
        if(StringUtils.isNotBlank(value)) {
            wrapper.like(column, value);
        }
    }

    private boolean isStudentAllocated(String studentNo) {
        if(StringUtils.isBlank(studentNo)) {
            return false;
        }
        EntityWrapper<SushefenpeiEntity> wrapper = new EntityWrapper<SushefenpeiEntity>();
        wrapper.eq("xueshengxuehao", studentNo);
        return sushefenpeiService.selectCount(wrapper) > 0;
    }

    private Map<Long, Set<String>> buildOccupiedBedMap(List<SushexinxiEntity> dorms) {
        Map<Long, Set<String>> occupiedBedMap = new HashMap<Long, Set<String>>();
        for(SushexinxiEntity dorm : dorms) {
            Set<String> beds = new HashSet<String>();
            EntityWrapper<SushefenpeiEntity> wrapper = new EntityWrapper<SushefenpeiEntity>();
            wrapper.eq("sushemingcheng", dorm.getSushemingcheng());
            wrapper.eq("susheloudong", dorm.getSusheloudong());
            wrapper.eq("fangjianhao", dorm.getFangjianhao());
            List<SushefenpeiEntity> allocations = sushefenpeiService.selectList(wrapper);
            if(allocations != null) {
                for(SushefenpeiEntity allocation : allocations) {
                    if(StringUtils.isNotBlank(allocation.getChuangweihao())) {
                        beds.add(normalizeBedNo(allocation.getChuangweihao()));
                    }
                }
            }
            occupiedBedMap.put(dorm.getId(), beds);
        }
        return occupiedBedMap;
    }

    private boolean isGenderMatched(XueshengEntity student, SushexinxiEntity dorm) {
        String studentGender = normalizeStudentGender(student.getXingbie());
        String dormGender = normalizeDormGender(dorm.getSusheleixing());
        return StringUtils.isBlank(studentGender)
                || StringUtils.isBlank(dormGender)
                || StringUtils.equals(studentGender, dormGender);
    }

    private String findFirstAvailableBed(SushexinxiEntity dorm, Set<String> occupiedBeds) {
        int capacity = parseCapacity(dorm.getKezhurenshu());
        if(capacity <= 0) {
            return null;
        }
        Set<String> beds = occupiedBeds == null ? new HashSet<String>() : occupiedBeds;
        for(int i = 1; i <= capacity; i++) {
            String bedNo = formatBedNo(i);
            if(!beds.contains(normalizeBedNo(bedNo))) {
                return bedNo;
            }
        }
        return null;
    }

    private int parseCapacity(String capacityValue) {
        try {
            return Integer.parseInt(StringUtils.defaultIfBlank(capacityValue, "0"));
        } catch (Exception e) {
            return 0;
        }
    }

    private SushefenpeiEntity buildAutoAllocation(XueshengEntity student, SushexinxiEntity dorm, String bedNo, Long id) {
        SushefenpeiEntity allocation = new SushefenpeiEntity();
        allocation.setId(id);
        allocation.setSushemingcheng(dorm.getSushemingcheng());
        allocation.setSusheleixing(dorm.getSusheleixing());
        allocation.setSusheloudong(dorm.getSusheloudong());
        allocation.setFangjianhao(dorm.getFangjianhao());
        allocation.setXueshengxuehao(student.getXueshengxuehao());
        allocation.setXueshengxingming(student.getXueshengxingming());
        allocation.setChuangweihao(bedNo);
        allocation.setFenpeiriqi(new Date());
        allocation.setBeizhu("系统一键分配");
        return allocation;
    }

    private Map<String, Object> buildAutoAssignSuccess(SushefenpeiEntity allocation) {
        Map<String, Object> item = new HashMap<String, Object>();
        item.put("xueshengxuehao", allocation.getXueshengxuehao());
        item.put("xueshengxingming", allocation.getXueshengxingming());
        item.put("sushemingcheng", allocation.getSushemingcheng());
        item.put("susheloudong", allocation.getSusheloudong());
        item.put("fangjianhao", allocation.getFangjianhao());
        item.put("chuangweihao", allocation.getChuangweihao());
        return item;
    }

    private Map<String, Object> buildAutoAssignFailure(XueshengEntity student, String reason) {
        Map<String, Object> item = new HashMap<String, Object>();
        item.put("xueshengxuehao", student == null ? "" : student.getXueshengxuehao());
        item.put("xueshengxingming", student == null ? "" : student.getXueshengxingming());
        item.put("reason", reason);
        return item;
    }

    private String getStringParam(Map<String, Object> params, String key) {
        if(params == null || params.get(key) == null) {
            return null;
        }
        return String.valueOf(params.get(key)).trim();
    }

    private boolean getBooleanParam(Map<String, Object> params, String key) {
        String value = getStringParam(params, key);
        return "true".equalsIgnoreCase(value) || "1".equals(value) || "是".equals(value);
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
        normalizeAllocationBedNo(sushefenpei);

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

        if(isBedOccupied(sushefenpei)) {
            return "该床位已有人入住，请重新选择";
        }
        return null;
    }

    private void normalizeAllocationBedNo(SushefenpeiEntity sushefenpei) {
        if(sushefenpei != null && StringUtils.isNotBlank(sushefenpei.getChuangweihao())) {
            sushefenpei.setChuangweihao(normalizeBedNo(sushefenpei.getChuangweihao()));
        }
    }

    private boolean isBedOccupied(SushefenpeiEntity sushefenpei) {
        EntityWrapper<SushefenpeiEntity> wrapper = new EntityWrapper<SushefenpeiEntity>();
        wrapper.eq("sushemingcheng", sushefenpei.getSushemingcheng());
        wrapper.eq("susheloudong", sushefenpei.getSusheloudong());
        wrapper.eq("fangjianhao", sushefenpei.getFangjianhao());
        List<SushefenpeiEntity> allocations = sushefenpeiService.selectList(wrapper);
        String targetBedNo = normalizeBedNo(sushefenpei.getChuangweihao());
        for(SushefenpeiEntity allocation : allocations) {
            if(sushefenpei.getId() != null && sushefenpei.getId().equals(allocation.getId())) {
                continue;
            }
            if(targetBedNo.equals(normalizeBedNo(allocation.getChuangweihao()))) {
                return true;
            }
        }
        return false;
    }

    private String normalizeBedNo(String bedNo) {
        if(StringUtils.isBlank(bedNo)) {
            return "";
        }
        String value = bedNo.trim();
        String digits = value.replaceAll("[^0-9]", "");
        if(StringUtils.isNotBlank(digits)) {
            return formatBedNo(Integer.parseInt(digits));
        }
        int chineseNumber = parseChineseBedNumber(value);
        if(chineseNumber > 0) {
            return formatBedNo(chineseNumber);
        }
        return value;
    }

    private String formatBedNo(int bedNo) {
        return bedNo + "号床";
    }

    private int parseChineseBedNumber(String value) {
        String text = value.replace("号床", "").replace("床", "").replace("号", "").trim();
        String[] numerals = {"零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"};
        for(int i = 1; i < numerals.length; i++) {
            if(numerals[i].equals(text)) {
                return i;
            }
        }
        if(text.startsWith("十") && text.length() == 2) {
            for(int i = 1; i < numerals.length; i++) {
                if(numerals[i].equals(text.substring(1))) {
                    return 10 + i;
                }
            }
        }
        if(text.endsWith("十") && text.length() == 2) {
            int tens = parseChineseBedNumber(text.substring(0, 1));
            if(tens > 0) {
                return tens * 10;
            }
        }
        if(text.length() == 3 && text.substring(1, 2).equals("十")) {
            int tens = parseChineseBedNumber(text.substring(0, 1));
            int ones = parseChineseBedNumber(text.substring(2));
            if(tens > 0 && ones > 0) {
                return tens * 10 + ones;
            }
        }
        return 0;
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
