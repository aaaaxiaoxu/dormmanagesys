package com.entity.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;


/**
 * 维修信息
 * 手机端接口返回实体辅助类 
 * （主要作用去除一些不必要的字段）
 * @author 
 * @email 
 * @date 2023-05-08 17:35:32
 */
public class QingjiaVO implements Serializable {
	private static final long serialVersionUID = 1L;

	 			

		
	/**
	 * 学生学号
	 */
	
	private String xueshengxuehao;
		
	/**
	 * 学生姓名
	 */
	
	private String xueshengxingming;

	/**
	 * 日期
	 */

	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd")
	@DateTimeFormat
	private Date qingjia1;

	/**
	 * 日期
	 */

	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd")
	@DateTimeFormat
	private Date qingjia2;

	/**
	 * 请假原因
	 */

	private String qinjiayuanyin;
		
	/**
	 * 是否审核
	 */
	
	private String sfsh;
		
	/**
	 * 审核回复
	 */
	
	private String shhf;

	public String getXueshengxuehao() {
		return xueshengxuehao;
	}

	public void setXueshengxuehao(String xueshengxuehao) {
		this.xueshengxuehao = xueshengxuehao;
	}

	public String getXueshengxingming() {
		return xueshengxingming;
	}

	public void setXueshengxingming(String xueshengxingming) {
		this.xueshengxingming = xueshengxingming;
	}

	public Date getQingjia1() {
		return qingjia1;
	}

	public void setQingjia1(Date qingjia1) {
		this.qingjia1 = qingjia1;
	}

	public Date getQingjia2() {
		return qingjia2;
	}

	public void setQingjia2(Date qingjia2) {
		this.qingjia2 = qingjia2;
	}

	public String getQinjiayuanyin() {
		return qinjiayuanyin;
	}

	public void setQinjiayuanyin(String qinjiayuanyin) {
		this.qinjiayuanyin = qinjiayuanyin;
	}

	public String getSfsh() {
		return sfsh;
	}

	public void setSfsh(String sfsh) {
		this.sfsh = sfsh;
	}

	public String getShhf() {
		return shhf;
	}

	public void setShhf(String shhf) {
		this.shhf = shhf;
	}
}
