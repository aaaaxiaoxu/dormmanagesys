package com.controller;

import com.annotation.IgnoreAuth;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.entity.QingjiaEntity;
import com.entity.view.QingjiaView;
import com.service.QingjiaService;
import com.utils.MPUtil;
import com.utils.PageUtils;
import com.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 维修信息
 * 后端接口
 * @author 
 * @email 
 * @date 2023-05-08 17:35:32
 */
@RestController
@RequestMapping("/qingjia")
public class QingjiaController {
    @Autowired
    private QingjiaService qingjiaService;

    /**
     * 后端列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,QingjiaEntity qingjia,
		HttpServletRequest request){
		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("xuesheng")) {
			qingjia.setXueshengxuehao((String)request.getSession().getAttribute("username"));
		}
        EntityWrapper<QingjiaEntity> ew = new EntityWrapper<QingjiaEntity>();

		PageUtils page = qingjiaService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, qingjia), params), params));

        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,QingjiaEntity qingjia, 
		HttpServletRequest request){
        EntityWrapper<QingjiaEntity> ew = new EntityWrapper<QingjiaEntity>();

		PageUtils page = qingjiaService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, qingjia), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( QingjiaEntity qingjia){
       	EntityWrapper<QingjiaEntity> ew = new EntityWrapper<QingjiaEntity>();
      	ew.allEq(MPUtil.allEQMapPre( qingjia, "qingjia")); 
        return R.ok().put("data", qingjiaService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(QingjiaEntity qingjia){
        EntityWrapper< QingjiaEntity> ew = new EntityWrapper< QingjiaEntity>();
 		ew.allEq(MPUtil.allEQMapPre( qingjia, "qingjia")); 
		QingjiaView qingjiaView =  qingjiaService.selectView(ew);
		return R.ok("查询维修信息成功").put("data", qingjiaView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        QingjiaEntity qingjia = qingjiaService.selectById(id);
        return R.ok().put("data", qingjia);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        QingjiaEntity qingjia = qingjiaService.selectById(id);
        return R.ok().put("data", qingjia);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody QingjiaEntity qingjia, HttpServletRequest request){
    	qingjia.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	//ValidatorUtils.validateEntity(qingjia);
        qingjiaService.insert(qingjia);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody QingjiaEntity qingjia, HttpServletRequest request){
    	qingjia.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	//ValidatorUtils.validateEntity(qingjia);
        qingjiaService.insert(qingjia);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody QingjiaEntity qingjia, HttpServletRequest request){
        //ValidatorUtils.validateEntity(qingjia);
        qingjiaService.updateById(qingjia);//全部更新
        return R.ok();
    }

    /**
     * 审核
     */
    @RequestMapping("/shBatch")
    @Transactional
    public R update(@RequestBody Long[] ids, @RequestParam String sfsh, @RequestParam String shhf){
        List<QingjiaEntity> list = new ArrayList<QingjiaEntity>();
        for(Long id : ids) {
            QingjiaEntity qingjia = qingjiaService.selectById(id);
            qingjia.setSfsh(sfsh);
            qingjia.setShhf(shhf);
            list.add(qingjia);
        }
        qingjiaService.updateBatchById(list);
        return R.ok();
    }


    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        qingjiaService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    
	









}
