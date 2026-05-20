package com.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.annotation.IgnoreAuth;
import com.baidu.aip.face.AipFace;
import com.baidu.aip.face.MatchRequest;
import com.baidu.aip.util.Base64Util;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.entity.ConfigEntity;
import com.service.CommonService;
import com.service.ConfigService;
import com.utils.BaiduUtil;
import com.utils.FileUtil;
import com.utils.R;
import com.utils.CommonUtil;
/**
 * 通用接口
 */
@RestController
public class CommonController{
	@Autowired
	private CommonService commonService;

	private static final Map<String, ExportDefinition> EXPORT_DEFINITIONS = buildExportDefinitions();

    private static AipFace client = null;
    
    @Autowired
    private ConfigService configService;    

	private static Map<String, ExportDefinition> buildExportDefinitions() {
		Map<String, ExportDefinition> definitions = new LinkedHashMap<String, ExportDefinition>();
		definitions.put("xuesheng", new ExportDefinition("学生信息",
				new String[]{"xueshengxuehao", "xueshengxingming", "xingbie", "xueshengdianhua", "banji", "zhuanye"},
				new String[]{"学生学号", "学生姓名", "性别", "学生电话", "班级", "专业"},
				buildStudentImportDefaults()));
		definitions.put("sushexinxi", new ExportDefinition("宿舍信息",
				new String[]{"sushemingcheng", "susheleixing", "susheloudong", "fangjianhao", "kezhurenshu", "yizhurenshu", "youchuangwei"},
				new String[]{"宿舍名称", "宿舍类型", "宿舍楼栋", "房间号", "可住人数", "已住人数", "有床位"}));
		definitions.put("sushefenpei", new ExportDefinition("宿舍分配",
				new String[]{"sushemingcheng", "susheleixing", "susheloudong", "fangjianhao", "xueshengxuehao", "xueshengxingming", "chuangweihao", "fenpeiriqi", "beizhu"},
				new String[]{"宿舍名称", "宿舍类型", "宿舍楼栋", "房间号", "学生学号", "学生姓名", "床位号", "分配日期", "备注"}));
		definitions.put("qingjia", new ExportDefinition("请假记录",
				new String[]{"biaoti", "xueshengxuehao", "xueshengxingming", "qingjia1", "qingjia2", "qingjiayuanyin", "sfsh", "shhf"},
				new String[]{"标题", "学生学号", "学生姓名", "离开日期", "返回日期", "请假原因", "审核状态", "审核回复"}));
		definitions.put("churusushe", new ExportDefinition("门禁出入",
				new String[]{"sushemingcheng", "susheleixing", "susheloudong", "fangjianhao", "churuleixing", "xueshengxuehao", "xueshengxingming", "churushijian", "xiangpian"},
				new String[]{"宿舍名称", "宿舍类型", "宿舍楼栋", "房间号", "通行类型", "学生学号", "学生姓名", "通行时间", "现场照片"}));
		definitions.put("weishengxinxi", new ExportDefinition("卫生检查",
				new String[]{"sushemingcheng", "susheleixing", "susheloudong", "fangjianhao", "weishengqingkuang", "pingfen", "dengjiriqi", "xiangqing", "sfsh", "shhf"},
				new String[]{"宿舍名称", "宿舍类型", "宿舍楼栋", "房间号", "卫生情况", "评分", "登记日期", "检查评语", "审核状态", "审核回复"}));
		definitions.put("weixiuxinxi", new ExportDefinition("报修工单",
				new String[]{"biaoti", "sushemingcheng", "susheleixing", "susheloudong", "fangjianhao", "xueshengxuehao", "xueshengxingming", "weixiuriqi", "weixiuneirong", "sfsh", "shhf"},
				new String[]{"标题", "宿舍名称", "宿舍类型", "宿舍楼栋", "房间号", "学生学号", "学生姓名", "维修日期", "维修内容", "工单状态", "处理备注"}));
		definitions.put("kaoqinxinxi", new ExportDefinition("考勤统计",
				new String[]{"sushemingcheng", "susheleixing", "susheloudong", "fangjianhao", "yuefen", "xueshengxuehao", "xueshengxingming", "wanguitianshu", "queqintianshu", "qingjiatianshu", "dengjishijian", "beizhu"},
				new String[]{"宿舍名称", "宿舍类型", "宿舍楼栋", "房间号", "月份", "学生学号", "学生姓名", "晚归天数", "未归天数", "请假天数", "登记时间", "违纪/处理备注"}));
		return definitions;
	}

	private static Map<String, String> buildStudentImportDefaults() {
		Map<String, String> defaults = new LinkedHashMap<String, String>();
		defaults.put("mima", "123456");
		return defaults;
	}

	private static class ExportDefinition {
		private String title;
		private String[] columns;
		private String[] labels;
		private Map<String, String> importDefaults;

		private ExportDefinition(String title, String[] columns, String[] labels) {
			this(title, columns, labels, new LinkedHashMap<String, String>());
		}

		private ExportDefinition(String title, String[] columns, String[] labels, Map<String, String> importDefaults) {
			this.title = title;
			this.columns = columns;
			this.labels = labels;
			this.importDefaults = importDefaults;
		}
	}

	/**
	 * 白名单数据导出
	 */
	@RequestMapping("/export/{tableName}")
	public void exportTable(@PathVariable("tableName") String tableName, HttpServletRequest request, HttpServletResponse response) throws IOException {
		if("xuesheng".equals(String.valueOf(request.getSession().getAttribute("tableName")))) {
			response.setStatus(HttpServletResponse.SC_FORBIDDEN);
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write("{\"code\":403,\"msg\":\"学生端不支持导出Excel\"}");
			return;
		}
		ExportDefinition definition = EXPORT_DEFINITIONS.get(tableName);
		if(definition == null) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write("{\"code\":500,\"msg\":\"暂不支持导出该数据表\"}");
			return;
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", tableName);
		params.put("columns", StringUtils.join(definition.columns, ","));
		List<Map<String, Object>> rows = commonService.selectExportRows(params);
		HSSFWorkbook workbook = buildWorkbook(definition, rows);
		String filename = URLEncoder.encode(definition.title + "-" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".xls", "UTF-8").replace("+", "%20");
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + filename);
		workbook.write(response.getOutputStream());
		response.flushBuffer();
	}

	private HSSFWorkbook buildWorkbook(ExportDefinition definition, List<Map<String, Object>> rows) {
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet(definition.title);
		HSSFRow header = sheet.createRow(0);
		for(int i = 0; i < definition.labels.length; i++) {
			HSSFCell cell = header.createCell(i);
			cell.setCellValue(definition.labels[i]);
		}
		SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(int i = 0; i < rows.size(); i++) {
			HSSFRow row = sheet.createRow(i + 1);
			Map<String, Object> data = rows.get(i);
			for(int j = 0; j < definition.columns.length; j++) {
				HSSFCell cell = row.createCell(j);
				Object value = getColumnValue(data, definition.columns[j]);
				if(value instanceof Date) {
					cell.setCellValue(dateTimeFormat.format((Date) value));
				} else {
					cell.setCellValue(value == null ? "" : String.valueOf(value).replaceAll("<[^>]+>", "").replace("&nbsp;", " "));
				}
			}
		}
		for(int i = 0; i < definition.labels.length; i++) {
			sheet.autoSizeColumn(i);
		}
		return workbook;
	}

	/**
	 * 白名单Excel数据导入
	 */
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping("/import/{tableName}")
	public R importTable(@PathVariable("tableName") String tableName, @RequestParam("file") MultipartFile file, HttpServletRequest request) throws Exception {
		if("xuesheng".equals(String.valueOf(request.getSession().getAttribute("tableName")))) {
			return R.error(403, "学生端不支持导入Excel");
		}
		ExportDefinition definition = EXPORT_DEFINITIONS.get(tableName);
		if(definition == null) {
			return R.error("暂不支持导入该数据表");
		}
		if(file == null || file.isEmpty()) {
			return R.error("请选择需要导入的Excel文件");
		}
		InputStream inputStream = file.getInputStream();
		try {
			Workbook workbook = WorkbookFactory.create(inputStream);
			Sheet sheet = workbook.getSheetAt(0);
			if(sheet == null || sheet.getLastRowNum() < 1) {
				return R.error("Excel没有可导入的数据");
			}
			DataFormatter formatter = new DataFormatter();
			int imported = 0;
			for(int i = 1; i <= sheet.getLastRowNum(); i++) {
				Row row = sheet.getRow(i);
				if(row == null) {
					continue;
				}
				List<String> columns = new ArrayList<String>();
				List<Object> values = new ArrayList<Object>();
				boolean hasValue = false;
				for(int j = 0; j < definition.columns.length; j++) {
					columns.add(definition.columns[j]);
					String value = getImportCellValue(row, j, formatter);
					if(StringUtils.isNotBlank(value)) {
						hasValue = true;
					}
					values.add(StringUtils.isBlank(value) ? null : value);
				}
				if(!hasValue) {
					continue;
				}
				for(Entry<String, String> entry : definition.importDefaults.entrySet()) {
					if(!columns.contains(entry.getKey())) {
						columns.add(entry.getKey());
						values.add(entry.getValue());
					}
				}
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("table", tableName);
				params.put("columns", StringUtils.join(columns, ","));
				params.put("values", values);
				commonService.insertImportRow(params);
				imported++;
			}
			return R.ok().put("count", imported);
		} finally {
			inputStream.close();
		}
	}

	private String getImportCellValue(Row row, int columnIndex, DataFormatter formatter) {
		Cell cell = row.getCell(columnIndex);
		if(cell == null) {
			return "";
		}
		return StringUtils.trimToEmpty(formatter.formatCellValue(cell));
	}

	private Object getColumnValue(Map<String, Object> row, String column) {
		if(row == null) {
			return null;
		}
		if(row.containsKey(column)) {
			return row.get(column);
		}
		for(String key : row.keySet()) {
			if(column.equalsIgnoreCase(key)) {
				return row.get(key);
			}
		}
		return null;
	}

	/**
	 * 获取table表中的column列表(联动接口)
	 * @param table
	 * @param column
	 * @return
	 */
	@IgnoreAuth
	@RequestMapping("/option/{tableName}/{columnName}")
	public R getOption(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName,@RequestParam(required = false) String conditionColumn,@RequestParam(required = false) String conditionValue,String level,String parent) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", tableName);
		params.put("column", columnName);
		if(StringUtils.isNotBlank(level)) {
			params.put("level", level);
		}
		if(StringUtils.isNotBlank(parent)) {
			params.put("parent", parent);
		}
        if(StringUtils.isNotBlank(conditionColumn)) {
            params.put("conditionColumn", conditionColumn);
        }
        if(StringUtils.isNotBlank(conditionValue)) {
            params.put("conditionValue", conditionValue);
        }
		List<String> data = commonService.getOption(params);
		return R.ok().put("data", data);
	}
	
	/**
	 * 根据table中的column获取单条记录
	 * @param table
	 * @param column
	 * @return
	 */
	@IgnoreAuth
	@RequestMapping("/follow/{tableName}/{columnName}")
	public R getFollowByOption(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName, @RequestParam String columnValue) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", tableName);
		params.put("column", columnName);
		params.put("columnValue", columnValue);
		Map<String, Object> result = commonService.getFollowByOption(params);
		return R.ok().put("data", result);
	}
	
	/**
	 * 修改table表的sfsh状态
	 * @param table
	 * @param map
	 * @return
	 */
	@RequestMapping("/sh/{tableName}")
	public R sh(@PathVariable("tableName") String tableName, @RequestBody Map<String, Object> map) {
		map.put("table", tableName);
		commonService.sh(map);
		return R.ok();
	}
	
	/**
	 * 获取需要提醒的记录数
	 * @param tableName
	 * @param columnName
	 * @param type 1:数字 2:日期
	 * @param map
	 * @return
	 */
	@IgnoreAuth
	@RequestMapping("/remind/{tableName}/{columnName}/{type}")
	public R remindCount(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName, 
						 @PathVariable("type") String type,@RequestParam Map<String, Object> map) {
		map.put("table", tableName);
		map.put("column", columnName);
		map.put("type", type);
		
		if(type.equals("2")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			Date remindStartDate = null;
			Date remindEndDate = null;
			if(map.get("remindstart")!=null) {
				Integer remindStart = Integer.parseInt(map.get("remindstart").toString());
				c.setTime(new Date()); 
				c.add(Calendar.DAY_OF_MONTH,remindStart);
				remindStartDate = c.getTime();
				map.put("remindstart", sdf.format(remindStartDate));
			}
			if(map.get("remindend")!=null) {
				Integer remindEnd = Integer.parseInt(map.get("remindend").toString());
				c.setTime(new Date());
				c.add(Calendar.DAY_OF_MONTH,remindEnd);
				remindEndDate = c.getTime();
				map.put("remindend", sdf.format(remindEndDate));
			}
		}
		
		int count = commonService.remindCount(map);
		return R.ok().put("count", count);
	}
	
	/**
	 * 单列求和
	 */
	@IgnoreAuth
	@RequestMapping("/cal/{tableName}/{columnName}")
	public R cal(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", tableName);
		params.put("column", columnName);
		Map<String, Object> result = commonService.selectCal(params);
		return R.ok().put("data", result);
	}
	
	/**
	 * 分组统计
	 */
	@IgnoreAuth
	@RequestMapping("/group/{tableName}/{columnName}")
	public R group(@PathVariable("tableName") String tableName, @PathVariable("columnName") String columnName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", tableName);
		params.put("column", columnName);
		List<Map<String, Object>> result = commonService.selectGroup(params);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for(Map<String, Object> m : result) {
			for(String k : m.keySet()) {
				if(m.get(k) instanceof Date) {
					m.put(k, sdf.format((Date)m.get(k)));
				}
			}
		}
		return R.ok().put("data", result);
	}
	
	/**
	 * （按值统计）
	 */
	@IgnoreAuth
	@RequestMapping("/value/{tableName}/{xColumnName}/{yColumnName}")
	public R value(@PathVariable("tableName") String tableName, @PathVariable("yColumnName") String yColumnName, @PathVariable("xColumnName") String xColumnName) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", tableName);
		params.put("xColumn", xColumnName);
		params.put("yColumn", yColumnName);
		List<Map<String, Object>> result = commonService.selectValue(params);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for(Map<String, Object> m : result) {
			for(String k : m.keySet()) {
				if(m.get(k) instanceof Date) {
					m.put(k, sdf.format((Date)m.get(k)));
				}
			}
		}
		return R.ok().put("data", result);
	}

	/**
 	 * （按值统计）时间统计类型
	 */
	@IgnoreAuth
	@RequestMapping("/value/{tableName}/{xColumnName}/{yColumnName}/{timeStatType}")
	public R valueDay(@PathVariable("tableName") String tableName, @PathVariable("yColumnName") String yColumnName, @PathVariable("xColumnName") String xColumnName, @PathVariable("timeStatType") String timeStatType) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("table", tableName);
		params.put("xColumn", xColumnName);
		params.put("yColumn", yColumnName);
		params.put("timeStatType", timeStatType);
		List<Map<String, Object>> result = commonService.selectTimeStatValue(params);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for(Map<String, Object> m : result) {
			for(String k : m.keySet()) {
				if(m.get(k) instanceof Date) {
					m.put(k, sdf.format((Date)m.get(k)));
				}
			}
		}
		return R.ok().put("data", result);
	}
	
    /**
     * 人脸比对
     * 
     * @param face1 人脸1
     * @param face2 人脸2
     * @return
     */
    @RequestMapping("/matchFace")
    @IgnoreAuth
    public R matchFace(String face1, String face2,HttpServletRequest request) {
        return CommonUtil.matchFace(face1, face2);
    }

    @RequestMapping("/matchRegisteredFace")
    @IgnoreAuth
    public R matchRegisteredFace(String face2, HttpServletRequest request) {
        Long userId = (Long) request.getSession().getAttribute("userId");
        return CommonUtil.matchRegisteredFace(face2, userId);
    }

    @RequestMapping("/registerFace")
    @IgnoreAuth
    public R registerFace(String face, HttpServletRequest request) {
        Long userId = (Long) request.getSession().getAttribute("userId");
        return CommonUtil.registerRegisteredFace(face, userId);
    }


}
