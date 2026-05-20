package com.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.*;

import com.utils.FaceUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.annotation.IgnoreAuth;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.entity.ConfigEntity;
import com.entity.EIException;
import com.service.ConfigService;
import com.utils.UploadFileUtil;
import com.utils.R;

/**
 * 上传文件映射表
 */
@RestController
@RequestMapping("file")
@SuppressWarnings({"unchecked","rawtypes"})
public class FileController{
	@Autowired
    private ConfigService configService;


	@IgnoreAuth
	@RequestMapping("/upload2")
	public R upload2(@RequestParam("file") MultipartFile file,String type) throws Exception {
		if (file.isEmpty()) {
			throw new EIException("上传文件不能为空");
		}
		// 获取文件的字节数组
		byte[] fileBytes = file.getBytes();
		// 将字节数组转换为 Base64 编码的字符串
		String base64Encoded = Base64.getEncoder().encodeToString(fileBytes);
		String s = FaceUtil.findFace(base64Encoded);
		System.out.println(s);
		return R.ok().put("result", s);
	}
	/**
	 * 上传文件
	 */
	@RequestMapping("/upload")
	public R upload(@RequestParam("file") MultipartFile file,String type) throws Exception {
		if (file.isEmpty()) {
			throw new EIException("上传文件不能为空");
		}
		String originalFilename = file.getOriginalFilename();
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf(".")+1);
		File upload = UploadFileUtil.getUploadDir();
		String fileName = new Date().getTime()+"_"+Math.abs(new Random().nextInt())+"."+fileExt;
		File dest = new File(upload.getAbsolutePath()+"/"+fileName);
		file.transferTo(dest);
		if(StringUtils.isNotBlank(type) && type.equals("1")) {
			ConfigEntity configEntity = configService.selectOne(new EntityWrapper<ConfigEntity>().eq("name", "faceFile"));
			if(configEntity==null) {
				configEntity = new ConfigEntity();
				configEntity.setName("faceFile");
				configEntity.setValue(fileName);
			} else {
				configEntity.setValue(fileName);
			}
			configService.insertOrUpdate(configEntity);
		}
		return R.ok().put("file", fileName);
	}
	
	/**
	 * 下载文件
	 */
	@IgnoreAuth
	@RequestMapping("/download")
	public ResponseEntity<byte[]> download(@RequestParam String fileName) {
		try {
			File file = UploadFileUtil.findUploadFile(fileName);
			if(file != null && file.exists()){
				/*if(!fileService.canRead(file, SessionManager.getSessionUser())){
					getResponse().sendError(403);
				}*/
				HttpHeaders headers = new HttpHeaders();
			    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);    
			    headers.setContentDispositionFormData("attachment", fileName);    
			    return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.CREATED);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
