package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.entity.SuguanEntity;
import com.entity.view.SuguanView;
import com.entity.vo.SuguanVO;
import com.utils.PageUtils;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 * 学生
 *
 * @author 
 * @email 
 * @date 
 */
public interface SuguanService extends IService<SuguanEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<SuguanVO> selectListVO(Wrapper<SuguanEntity> wrapper);
   	
   	SuguanVO selectVO(@Param("ew") Wrapper<SuguanEntity> wrapper);
   	
   	List<SuguanView> selectListView(Wrapper<SuguanEntity> wrapper);
   	
   	SuguanView selectView(@Param("ew") Wrapper<SuguanEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<SuguanEntity> wrapper);
   	

}

