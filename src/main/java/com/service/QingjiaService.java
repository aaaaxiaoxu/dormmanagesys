package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.entity.QingjiaEntity;
import com.entity.view.QingjiaView;
import com.entity.vo.QingjiaVO;
import com.utils.PageUtils;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 * 维修信息
 *
 * @author 
 * @email 
 * @date 2023-05-08 17:35:32
 */
public interface QingjiaService extends IService<QingjiaEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<QingjiaVO> selectListVO(Wrapper<QingjiaEntity> wrapper);
   	
   	QingjiaVO selectVO(@Param("ew") Wrapper<QingjiaEntity> wrapper);
   	
   	List<QingjiaView> selectListView(Wrapper<QingjiaEntity> wrapper);
   	
   	QingjiaView selectView(@Param("ew") Wrapper<QingjiaEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<QingjiaEntity> wrapper);
   	

}

