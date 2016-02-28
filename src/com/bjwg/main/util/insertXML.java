package com.bjwg.main.util;

import java.io.*;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.*;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;




public class insertXML {
	
	
	 public static void insertXML(HttpServletRequest request,int pid,int num) {
		
		 Document doc = DocumentHelper.createDocument();
		  doc.addProcessingInstruction("xml-stylesheet", "type='text/xsl href='project.xsl'");
		  Element root = doc.addElement("projects").addAttribute("id",""+pid);
		  int counts[]=getCounts(num);
		  for (int i = 0; i < counts.length; i++) {
			  System.out.println("coun++"+counts[i]);
		
		  Element eltStu1 = root.addElement("project").addAttribute("id", ""+i+1);
		  Element eltName1 = eltStu1.addElement("phone");
		  Element eltAge1 = eltStu1.addElement("count");
		  eltName1.setText(getPhones());
		  eltAge1.setText(""+counts[i]);
		  
		  }
		  String url=request.getRealPath("/")+"WEB-INF/config/rating.xml";
		  try {
		   OutputFormat format = new OutputFormat("    ", true);
		   format.setEncoding("gb2312");
		   // 可以把System.out改为你要的流。
		   XMLWriter xmlWriter = new XMLWriter(new PrintWriter(url), format);
		   xmlWriter.write(doc);
		   xmlWriter.close();
		  } catch (IOException e) {
		   e.printStackTrace();
		  }
	    }
	 
	 
	 private static String[] telFirst="134,135,136,137,138,139,150,151,152,157,158,159,187,130,131,132,155,156,133,153".split(",");  
	 public static int[]  getCounts(int num){
		
	     //获取总项目所放猪仔的60%
	       int limit1=(int)(num*0.6);
	       //基数
	        int  base=(int)(limit1*0.05);
	        //范围
	        int scope=(limit1-base*6)/6;
	       int[] counts=new int[5];
	       
	       
	       for (int i = 0; i < counts.length; i++) {
	    	   counts[i]=(int)(Math.random()*scope+base);			
		}
	   	int temp=0;
	       //冒泡排序
	   	for(int i=1;i<counts.length;i++){
	   		for (int j=0;j<counts.length-i;j++){
	   		if(counts[j]<counts[j+1]){
	   		 temp=counts[j];
	   		counts[j]=counts[j+1];
	   		counts[j+1]=temp;
	   		}}}
	   
	     return counts;
	        
	    }  
	 
	 
	 
	 
	 
	 
	 

	    public static String getPhones() {  
	    	  int index=getNum(0,telFirst.length-1);  
		        String first=telFirst[index];  
		        String second=String.valueOf(getNum(1,888)+10000).substring(1);  
		        String thrid=String.valueOf(getNum(1,9100)+10000).substring(1); 
		        return first+second+thrid;
	    }  
	
	    public static int getNum(int start,int end) {  
	        return (int)(Math.random()*(end-start+1)+start);  
	    }  
	 
}
