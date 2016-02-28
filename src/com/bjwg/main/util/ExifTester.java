package com.bjwg.main.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.Tag;
import com.drew.metadata.exif.ExifIFD0Directory;

/**
 * @author chen
 * @version 创建时间：2015-5-11 下午02:04:01
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */

public class ExifTester {
	
	
	public static final String LINE = "-";
   public static final String RIGHT_PARENTHESES = "]";
   
   
   public static void main(String[] args) throws Exception {
       File file = new File("D:/qq/IMG_20150511_151122.jpg");
       Map<String, String> map = getImageInfoOfExif(file);
       ConsoleUtil.println("##### the image file informations");
       HandleMap(map);
       ConsoleUtil.println( map.get("Orientation"));
       for (int i = 0; i < 20; i++) {
    	   ConsoleUtil.println(new Random().nextInt(100));
       }
    }

   /**
    * print the abstracts of image file 
    * @param imagesInfo
    */
   @SuppressWarnings("unused")
   private static void printImagesInfo(List<Map<String, String>> imagesInfo) {
       if(!imagesInfo.isEmpty()){
           for(Map<String, String> map: imagesInfo){
               HandleMap(map);
               ConsoleUtil.println("======================================");
           }
       }
   }

   /**
    * @param map
    */
   private static void HandleMap(Map<String, String> map) {
       Iterator<String> iterator = map.keySet().iterator();
       while (iterator.hasNext()) {
           String name = iterator.next();
           String value = map.get(name);
           printInfo(name, value);
       }
   }

   /**
    * @param name
    * @param value
    */
   private static void printInfo(String name, String value) {
       ConsoleUtil.println(name + " : " + value);
   }

   /**
    * get the abstracts of the image file
    * @param jpegFile
    * @return
    * @throws JpegProcessingException
    * @throws IOException
    */
   @SuppressWarnings({"rawtypes" })
   public static Map<String, String> getImageInfoOfExif(File jpegFile) throws JpegProcessingException, IOException {
       Metadata metadata = JpegMetadataReader.readMetadata(jpegFile);
       Directory exifDirectory = metadata.getDirectory(ExifIFD0Directory.class);
       Collection tags = exifDirectory.getTags();
       Iterator iterator = tags.iterator();
       Map<String, String> abstractsMap = new HashMap<String, String>();
       while (iterator.hasNext()) {
           Tag tag = (Tag) iterator.next();
           String[] tagArrays = tag.toString().split(LINE);
           String[] abstracts = tagArrays[0].trim().split(RIGHT_PARENTHESES);
           abstractsMap.put(abstracts[1].trim(), tagArrays[1].trim());
       }
      /* if (exifDirectory.containsTag(ExifIFD0Directory.TAG_WIN_AUTHOR)) {
	    	   ConsoleUtil.println("->Pic author is "
	    	     + exifDirectory.getDescription(ExifIFD0Directory.TAG_WIN_AUTHOR));
	    }
       if (exifDirectory.containsTag(ExifIFD0Directory.TAG_ORIENTATION)) {
    	   ConsoleUtil.println("->Pic TAG_ORIENTATION is "
    	     + exifDirectory.getDescription(ExifIFD0Directory.TAG_ORIENTATION));
       }*/
       return abstractsMap;
   }
   
   /**
    * handle more than one image files
    * @param files
    * @return
    * @throws JpegProcessingException
    * @throws IOException
    */
   @SuppressWarnings("unused")
   private static List<Map<String, String>> getImageInfoOfExif(List<File> files) throws JpegProcessingException, IOException{
       if(files == null)return null;
       List<Map<String, String>> list = new ArrayList<Map<String,String>>();
       if(files.size() > 0){
           for(File file: files){
               Map<String, String> map = getImageInfoOfExif(file);
               list.add(map);
           }
       }
       return list;
   }
   
   /**
    * 
    * @param jpegFile
    * @return
    * @throws JpegProcessingException
    * @throws IOException
    */
   @SuppressWarnings({"rawtypes", "finally" })
   public static Map<String, String> getImginputStream(InputStream jpegFile){
	   Map<String, String> abstractsMap = null;
       try {
    	   Metadata metadata = JpegMetadataReader.readMetadata(jpegFile);
		   Directory exifDirectory = metadata.getDirectory(ExifIFD0Directory.class);
		   if(null == exifDirectory){
			   return null;
		   }
		   Collection tags = exifDirectory.getTags();
		   Iterator iterator = tags.iterator();
//		   Map<String, String> abstractsMap = new HashMap<String, String>();
		   abstractsMap = new HashMap<String, String>();
		   while (iterator.hasNext()) {
		       Tag tag = (Tag) iterator.next();
		       String[] tagArrays = tag.toString().split(LINE);
		       String[] abstracts = tagArrays[0].trim().split(RIGHT_PARENTHESES);
		       abstractsMap.put(abstracts[1].trim(), tagArrays[1].trim());
		   }
		   if(exifDirectory.containsTag(ExifIFD0Directory.TAG_ORIENTATION)){
			   int orientation = exifDirectory.getInt(ExifIFD0Directory.TAG_ORIENTATION);
			   abstractsMap.put("orientation", orientation+"");
		   }
		   
//		   return abstractsMap;
		} catch (JpegProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MetadataException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			return abstractsMap;
		}
   }
   
	/*case 1: return "Top, left side (Horizontal / normal)";  水平/正常
	case 2: return "Top, right side (Mirror horizontal)";  水平镜像
	case 3: return "Bottom, right side (Rotate 180)";  旋转180
	case 4: return "Bottom, left side (Mirror vertical)";  镜面垂直
	case 5: return "Left side, top (Mirror horizontal and rotate 270 CW)";  水平镜像、顺时针旋转270度
	case 6: return "Right side, top (Rotate 90 CW)";  顺时针旋转90度
	case 7: return "Right side, bottom (Mirror horizontal and rotate 90 CW)";  水平镜像、顺时针旋转90度
	case 8: return "Left side, bottom (Rotate 270 CW)";  顺时针旋转270度   	*/
   
}
