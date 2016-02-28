package com.bjwg.main.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.bjwg.main.model.rating;

public class selectXML {
public static List<rating> selectXML(HttpServletRequest request,int pid) throws DocumentException {
	 String url=request.getRealPath("/")+"WEB-INF/config/rating.xml";
		rating rt;
    // 使用了dom4j解析xml
    // 读取目录下用来测试的test.xml文件，取得xml主内容
    Document document = (Document) new SAXReader().read(url).getDocument();
    //获取根目录ID
   String fid=document.getRootElement().attributeValue("id");
   if(fid==null){
	   return null; 
   }
int id= Integer.parseInt(document.getRootElement().attributeValue("id"));
 if(id!=pid){
	 return null;     
 }else{
 List<rating> ratings=new ArrayList<rating>();
    
    // 遍历文档根节点（wuxialist）下的子节点列表，即txtbook节点的集合
    for(Element txtbook : (List<Element>)document.getRootElement().elements()){
    	
    	
    	rt=new rating();
        rt.setPhone(txtbook.element("phone").getText());
        rt.setCount(Integer.parseInt(txtbook.element("count").getText()));
        ratings.add(rt);
    	//取得txtbook节点下的name节点的内容
       //System.out.println(i+"."+txtbook.element("phone").getText());
       
       // i++; //原来这里少些了这一行，先补上
    }
    
    for (int x = 0; x <ratings.size()-1; x++) {
		
	int temp=0;
    for (int y = x+1; y < ratings.size(); y++) {
    	if(ratings.get(x).getCount()<ratings.get(y).getCount()){
    		temp=ratings.get(x).getCount();
    		ratings.get(x).setCount(ratings.get(y).getCount());
    		ratings.get(y).setCount(temp);
    	}
		
	}}
	return ratings;
 }
}
}
