package com.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.entity.SuguanEntity;
import com.entity.view.SuguanView;
import com.entity.vo.SuguanVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;


/**
 * 学生
 * 
 * @author 
 * @email 
 * @date 
 */
public interface SuguanDao extends BaseMapper<SuguanEntity> {
	
	List<SuguanVO> selectListVO(@Param("ew") Wrapper<SuguanEntity> wrapper);
	
	SuguanVO selectVO(@Param("ew") Wrapper<SuguanEntity> wrapper);
	
	List<SuguanView> selectListView(@Param("ew") Wrapper<SuguanEntity> wrapper);

	List<SuguanView> selectListView(Pagination page,@Param("ew") Wrapper<SuguanEntity> wrapper);
	
	SuguanView selectView(@Param("ew") Wrapper<SuguanEntity> wrapper);
	

}
