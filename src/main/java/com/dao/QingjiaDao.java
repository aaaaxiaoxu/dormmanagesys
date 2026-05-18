package com.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.entity.QingjiaEntity;
import com.entity.view.QingjiaView;
import com.entity.vo.QingjiaVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;


/**
 * 维修信息
 * 
 * @author 
 * @email 
 * @date 2023-05-08 17:35:32
 */
public interface QingjiaDao extends BaseMapper<QingjiaEntity> {
	
	List<QingjiaVO> selectListVO(@Param("ew") Wrapper<QingjiaEntity> wrapper);
	
	QingjiaVO selectVO(@Param("ew") Wrapper<QingjiaEntity> wrapper);
	
	List<QingjiaView> selectListView(@Param("ew") Wrapper<QingjiaEntity> wrapper);

	List<QingjiaView> selectListView(Pagination page,@Param("ew") Wrapper<QingjiaEntity> wrapper);
	
	QingjiaView selectView(@Param("ew") Wrapper<QingjiaEntity> wrapper);
	

}
