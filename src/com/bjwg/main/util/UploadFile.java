package com.bjwg.main.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import sun.util.logging.resources.logging;

import com.bjwg.main.constant.StatusConstant.Status;
import com.bjwg.main.constant.FileConstant;
import com.bjwg.main.constant.SysConstant;
import com.bjwg.main.model.SysConfig;
import com.bjwg.main.service.SysConfigService;
/**
 * @author Administrator
 * @version 创建时间：2015-3-10 上午10:56:22
 * @Modified By:Administrator
 * Version: 
 * 类说明： 图片上传处理
 */

public class UploadFile {
	
	public static final Logger  logger = LoggerFactory.getLogger("LOGISTICS-COMPONENT"); 
	
	
	/**
	 * 上传单个文件 本地服务器   
	 * @param request
	 * @param type 
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	public static Map<String, Object> uploadSingleFile(HttpServletRequest request, String type) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			if(StringUtils.isEmptyNo(type)){
				
				map.put("status", Status.fileTypeNullity);
				return map;
			}
			
			//转型为MultipartHttpRequest(重点的所在)  
			MultipartHttpServletRequest multipartRequest  =  (MultipartHttpServletRequest) request;  
			
			//  获得第1张图片（根据前台的name名称得到上传的文件）   
			MultipartFile imgFile  =  multipartRequest.getFile("imgFile"); 
			
			String fileName = imgFile.getOriginalFilename();
			
			if(!StringUtils.isNotEmpty(fileName)){
				
				map.put("status", Status.fileNotExist);
				return map;
			}
			/*下面调用的方法，主要是用来检测上传的文件是否属于允许上传的类型范围内，及根据传入的路径名 
			 *自动创建文件夹和文件名，返回的File文件我们可以用来做其它的使用，如得到保存后的文件名路径等 
			 *这里我就先不做多的介绍。 
			 */  
			long size = imgFile.getSize();
			
			SysConfigService sysConfigService = (SysConfigService)SpringFactory.getBean("sysConfigServiceImpl");
			
			List<String> codeList = new ArrayList<String>(Arrays.asList(SysConstant.UPLOAD_FILE_LIMIT_TYPE,SysConstant.UPLOAD_FILE_MAX_SIZE,SysConstant.PROJECT_IMG_UPLOAD_ROOT_PATH,SysConstant.PROJECT_IMG_ACCESS_URL));
			List<SysConfig> list = sysConfigService.queryList(codeList);
			
			if(MyUtils.isListEmpty(list) || list.size() != codeList.size()){
				
				map.put("status", Status.fileUploadConfigNoExist);
				return map;
			}
			
			//获取路径
			String uploadPath = null;
			//文件最大MB
			String maxSize = null;
			//文件类型
			List<String> suffixList = null;
			//文件访问根路径
			String accessUrl = null;
			
			for (SysConfig sc : list) {
				
				if(SysConstant.UPLOAD_FILE_LIMIT_TYPE.equals(sc.getCode())){
					
					suffixList = new ArrayList<String>(Arrays.asList(sc.getValue().split(",")));
				}else if(SysConstant.UPLOAD_FILE_MAX_SIZE.equals(sc.getCode())){
					
					maxSize = sc.getValue();
				}else if(SysConstant.PROJECT_IMG_ACCESS_URL.equals(sc.getCode())){
					
					accessUrl = sc.getValue();
				}else{
					uploadPath = sc.getValue();
				}
			}
			
			if(StringUtils.isEmptyNo(uploadPath)){
				
				map.put("status", Status.filePathNotExist);
				return map;
			}
			
			//定义上载文件的最大字节(默认10MB)
			if(size > (1024 * 1024 * Long.valueOf(maxSize))){
				
				map.put("status", Status.fileOverMax);
				map.put("maxSize", maxSize);
				return map;
			}
			
			//获取上传文件类型的扩展名,先得到.的位置，再截取从.的下一个位置到文件的最后，最后得到扩展名  
			String ext = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length()); 
			
			//对扩展名进行小写转换  
			ext = ext.toLowerCase();
			
			//如果扩展名属于允许上传的类型，则创建文件
			if(suffixList.contains(ext)){  
				
				String pathName = fileName.toLowerCase();
				
				InputStream inputStream = imgFile.getInputStream();
				
				String suffix = fileName.substring(fileName.lastIndexOf("."));
				
				int des = 0;
				
				if(suffix.equals(".jpg") || suffix.equals(".jpeg"))
				{
					Map<String, String> map2 = ExifTester.getImginputStream(inputStream);
					
					if(!MyUtils.isMapEmpty(map2)){
						
						ConsoleUtil.println(map2.get("Orientation") + map.get("orientation"));
						
						String orientation = map2.get("orientation");
						
						if(StringUtils.isNotEmpty(orientation) && (orientation.equals("5") || orientation.equals("6") || orientation.equals("7") || orientation.equals("8")))
						{	 
							des = 90;
						}
					}
					inputStream = imgFile.getInputStream();
				}
				
				
				String fileAccessPath = "/" + MyUtils.getYYYYMMDD(0)+"/";
					
				if(FileConstant.UPLOAD_HEAD_IMG.equals(type)){
					
					fileAccessPath += ToolKit.getInstance().getSingleConfig(type);
				}
				
				uploadPath = uploadPath + fileAccessPath;
				
//				if("yes".equals(ToolKit.getInstance().getSingleConfig("test"))){
					
//					fileAccessPath = "/resources/"+fileAccessPath+"/";
//				}
				
				fileAccessPath = accessUrl + fileAccessPath +"/";
				
				String newFileName = System.currentTimeMillis() + MyUtils.random(4) + "" +suffix;
				
				ConsoleUtil.println("文件上传路径："+uploadPath + "，文件名称："+newFileName);
				
				File localFile = new File(uploadPath,newFileName);
				
//				FileUtils.makeDir(localFile);
				
				//手动设置以下权限。
				localFile.setWritable(true, false);
				
		        if(!localFile.exists()){
		        	
		        	localFile.mkdirs();  
		        }
		        
		        //保存上传的文件  
			    imgFile.transferTo(localFile); 
			    
			    map.put("status", Status.success);
			    map.put("filePath", fileAccessPath + newFileName);
			    map.put("sourceName", fileName);
			    map.put("newFileName", newFileName);
			    map.put("fileSize", size);
			    map.put("suffix", suffix);
				return map;
			} 
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("上传文件出错",e);
			map.put("status", Status.fileUploadError);
		}  
		return map;
	}
	
	/**
	 * 单张图片上传 阿里云服务器
	 * @param request
	 * @param type 
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws IllegalStateException 
	 
	public static String uploadSingleFileToALiYun(HttpServletRequest request, String type) {
		String pathName = "";
		try {
			//转型为MultipartHttpRequest(重点的所在)  
			MultipartHttpServletRequest multipartRequest  =  (MultipartHttpServletRequest) request;  
			
			//  获得第1张图片（根据前台的name名称得到上传的文件）   
			MultipartFile imgFile  =  multipartRequest.getFile("imgFile"); 
			
			//保存第一张图片  
			if(!(imgFile.getOriginalFilename() ==null || "".equals( imgFile.getOriginalFilename()))) {  
			/*下面调用的方法，主要是用来检测上传的文件是否属于允许上传的类型范围内，及根据传入的路径名 
			*自动创建文件夹和文件名，返回的File文件我们可以用来做其它的使用，如得到保存后的文件名路径等 
			*这里我就先不做多的介绍。 
			  
				String fileName = imgFile.getOriginalFilename();
				if( !StringUtils.isNotEmpty( fileName )){
					return null;
				}
				
				long size = imgFile.getSize();
        		
        		//定义上载文件的最大字节(默认10MB)
        		if(size > UploadFile.FILE_MAX_SIZE){

        			return "max";
        		}
				
				//获取上传文件类型的扩展名,先得到.的位置，再截取从.的下一个位置到文件的最后，最后得到扩展名  
			    String ext = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());  
			    //对扩展名进行小写转换  
			    ext = ext.toLowerCase();
			    if(suffixList.contains(ext)) {  //如果扩展名属于允许上传的类型，则创建文件  
			    	
			    	pathName = fileName.toLowerCase();
			    	
			    	InputStream inputStream = imgFile.getInputStream();

			    	String suffix = fileName.substring(fileName.lastIndexOf("."));
			    	//
			    	int des = 0;
			    	if(suffix.equals(".jpg") || suffix.equals(".jpeg"))
			    	{
				        Map<String, String> map = ExifTester.getImginputStream(inputStream);
				        
				        if(!MyUtils.isMapEmpty(map)){
					        ConsoleUtil.println( map.get("Orientation") + map.get("orientation"));
					        String orientation = map.get("orientation");
					        
					        if(StringUtils.isNotEmpty(orientation) && (orientation.equals("5") || orientation.equals("6") || orientation.equals("7") || orientation.equals("8")))
							 {	 
					        	 des = 90;
					        }
				        }
				        inputStream = imgFile.getInputStream();
			    	}
			    	
			       //上传图片服务器
    				UploadService uploadService = new UploadServiceImpl();
    				 
    				pathName = uploadService.uploadImage(pathName, inputStream, size,false,des);
			        
//    				http://img.hzd.com/upload/2015-04-30/1430386015959587870.jpg
    				pathName = pathName.replace(root, "");
    				
			    } 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}  
        return pathName;  
	}*/
	
	
	
	
	
	
	/***
	  * 手机端上传一张图片
	  * @param request
	  * @param response
	  * @param m
	  * @param type 上传的类型 0：商铺 1：服务
	  * @param id	商铺id或服务id
	  * @return
	  
	 public static Map<String, Object> upload(HttpServletRequest request,Map<String, String> m,Integer degree,Boolean markIcon){  
		 
		 Status status = Status.fileNotExist;
		 
		 Map<String, Object> map = new HashMap<String, Object>();
		 
		 //创建一个通用的多部分解析器.     
		 CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());  
		 
		 multipartResolver.setDefaultEncoding("UTF-8");
		 
		 try {
			 //判断 request 是否有文件上传,即多部分请求...    
			 if(multipartResolver.isMultipart(request))
			 {  
				 //判断 request 是否有文件上传,即多部分请求...    
				 MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)(request);  
				 
				 multiRequest.setCharacterEncoding("UTF-8");
				 
				 Iterator<String> iter = multiRequest.getFileNames(); 
				 
				 while(iter.hasNext()){
					 
					 String key = iter.next();
					 
					 List<MultipartFile> fileList = multiRequest.getFiles(key); 
					 
					 if(m.containsKey(key)){
						 
						 MultipartFile file = fileList.get(0);
							 
						 String fileName = file.getOriginalFilename();
						 
						 long size = file.getSize();
						 
						 //定义上载文件的最大字节(默认2MB)
						 if(size > FileUtils.FILE_MAX_SIZE){
							 
							 status = status.fileOverMax;
							 
							 continue;
							 
						 }else if(StringUtils.isNotEmpty(fileName)){
							 
							 fileName = fileName.toLowerCase();
							 
							 String suffix = fileName.substring(fileName.lastIndexOf("."));
							 
							 if(!suffixList.contains(suffix.toLowerCase()))
							 {
								 status = status.fileOnlySuffix;
								 continue;
							 }else
							 {
								 
								 InputStream inputStream = file.getInputStream();
								 
								 if(!MyUtils.isIntegerGtZero(degree))
								 {	 
									 if(suffix.equals(".jpg") || suffix.equals(".jpeg"))
									 {
										 Map<String, String> map2 = ExifTester.getImginputStream(inputStream);
								        
										 if(!MyUtils.isMapEmpty(map2)){
											 
											 String orientation = map2.get("orientation");
											 
											 if(orientation.equals("5") || orientation.equals("6") || orientation.equals("7") || orientation.equals("8"))
											 {
												 degree = 90;
											 }
										 }
									 }
								 }
								 inputStream = file.getInputStream();
								 
								 
								 UploadService uploadService = new UploadServiceImpl();
								 
								 String imgUrl = uploadService.uploadImage(fileName, inputStream, size, markIcon,degree);
								 String imgDomain = ToolKit.getInstance().getSingleConfig("imgUrl");
								 //截取图片url相对路径
								 map.put(key, imgUrl.substring(imgUrl.indexOf(imgDomain)+imgDomain.length()));
								 map.put("name", file.getOriginalFilename());
								 
								 
								 status = Status.success;
							 }
						 }
						 
					 }
				 }
				 
			 }  
			 
			 map.put("status", status);
			 
		 }catch (Exception e) {
			 
			 status = status.fileUploadError;
			 
			 map.put("status", status);
			 
			 e.printStackTrace();
			 throw e;
			 
		 }finally{
			 
			 return map;  
		 }
	 } 
	*/
	
	 
	/***
	 * 上传多张图片    
	 * @param request
	 * @param integer 
	 * @param i 
	 * @param response
	 * @return
	 
	 public static Map<String, Object> uploadBatch(HttpServletRequest request,Map<String, String> m,boolean markIcon){  
		 
		 	//创建一个通用的多部分解析器.     
       CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());  
       
       multipartResolver.setDefaultEncoding("UTF-8");
       
       Map<String, Object> returnMap = new HashMap<String, Object>();
       
       Status status = Status.fileNotExist;
       
       try {
	         //判断 request 是否有文件上传,即多部分请求...    
	        if(multipartResolver.isMultipart(request))  
	        {  
	             //判断 request 是否有文件上传,即多部分请求...    
	            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)(request);  
	            
	            multiRequest.setCharacterEncoding("UTF-8");
	            Iterator<String> iter = multiRequest.getFileNames(); 
	            
	            //先检测文件是否符合要求
	            while(iter.hasNext()){
					 
					 String key = iter.next();
					 
					 List<MultipartFile> fileList = multiRequest.getFiles(key); 
					 
					 if(m.containsKey(key) && !MyUtils.isListEmpty(fileList)){
			            		
	            		for (MultipartFile file : fileList) {
							
	            			long size = file.getSize();
		            		
		            		//定义上载文件的最大字节(默认10MB)
		            		if(size > FileUtils.FILE_MAX_SIZE){
		            			
		            			returnMap.put("status", Status.fileOverMax);
		            			return returnMap;
		            		}
		            		//判断图片是否存在
		            		if(!(file.getOriginalFilename() ==null || "".equals( file.getOriginalFilename()))) {
		            			
		            			//图片名
		            			String pathName = file.getOriginalFilename();
		            			
		            			if(!StringUtils.isNotEmpty(pathName)){
		            				
		            				returnMap.put("status", Status.fileNotExist);
			            			return returnMap;
		            			}
		            			//获取上传文件类型的扩展名,先得到.的位置，再截取从.的下一个位置到文件的最后，最后得到扩展名  
		            			String ext = pathName.substring(pathName.lastIndexOf("."),pathName.length());  
		            			//对扩展名进行小写转换  
		            			ext = ext.toLowerCase();
		            			
		            			if(!suffixList.contains(ext)) {
		            				
		            				returnMap.put("status", Status.fileOnlySuffix);
			            			return returnMap;
		            			}
		            		}
	            		}
					 }
	            }
				 
	            iter = multiRequest.getFileNames();
	            
	            JSONObject jsonObject = new JSONObject();
	            
				while(iter.hasNext()){
					 
					 String key = iter.next();
					 
					 List<MultipartFile> fileList = multiRequest.getFiles(key); 
					 
					 if(m.containsKey(key) && !MyUtils.isListEmpty(fileList)){
			            		
						JSONArray jsonArray = new JSONArray();
						
	            		for (MultipartFile file : fileList) {
	            			
	            			//判断图片是否存在
		            		if(!(file.getOriginalFilename() ==null || "".equals( file.getOriginalFilename()))) {
		            			
		            			String pathFile = "";
		            			
		            			long size = file.getSize();
		            			
		            			//图片名
		            			String pathName = file.getOriginalFilename();
		            			
		            			//获取上传文件类型的扩展名,先得到.的位置，再截取从.的下一个位置到文件的最后，最后得到扩展名  
		            			String ext = pathName.substring(pathName.lastIndexOf("."),pathName.length());  
		            			//对扩展名进行小写转换  
		            			ext = ext.toLowerCase();
		            			
		            			pathName = new Date().getTime() + MyUtils.random(4) + ext;
		            			
		            			InputStream inputStream = file.getInputStream();
		            			
		            			Integer degree = null;
		            			
		            			if(ext.equals(".jpg") || ext.equals(".jpeg"))
		            			{
		            				Map<String, String> map2 = ExifTester.getImginputStream(inputStream);
		            				
		            				if(!MyUtils.isMapEmpty(map2)){
		            					
		            					String orientation = map2.get("orientation");
		            					
		            					if(orientation.equals("5") || orientation.equals("6") || orientation.equals("7") || orientation.equals("8"))
		            					{
		            						degree = 90;
		            					}
		            				}
		            			}
		            			
		            			inputStream = file.getInputStream();
		            			
		            			//上传图片服务器
		            			UploadService uploadService = new UploadServiceImpl();
		            			
		            			String imgUrl = uploadService.uploadImage(pathName, inputStream, size, markIcon,degree);
		            			String imgDomain = ToolKit.getInstance().getSingleConfig("imgUrl");
		            			//截取图片url相对路径
		            			pathFile = imgUrl.substring(imgUrl.indexOf(imgDomain)+imgDomain.length());
		            			
		            			JSONObject object = new JSONObject();
		            			object.put("path_"+key, pathFile);
		            			object.put("pathName_"+key, file.getOriginalFilename());
		            			object.put("size_"+key, size);
		            			jsonArray.add(object);
		            			
		            			status = Status.success;
		            		}
						}
	            		if(jsonArray != null && jsonArray.size() > 0){
	            			
	            			jsonObject.put(key, jsonArray);
	            		}
					 }
				}
				
				returnMap.put("file", jsonObject);
	        }
	        
		 }catch (Exception e) {
			status = Status.serverError;
			e.getStackTrace();
		 }finally{
			 
			 returnMap.put("status", status);
			 return returnMap;
		 }
	 } */
}
