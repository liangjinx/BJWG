package com.bjwg.main.test;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.bjwg.main.model.rating;


public class test2 {

	public static final String  s="aa";
	public static void main(String[] args) throws ParseException {
	
		Date now = new Date();
		System.out.println(now);
		
	/*	rating rt;
    // 使用了dom4j解析xml
    // 读取目录下用来测试的test.xml文件，取得xml主内容
    Document document = (Document) new SAXReader().read("src/rating.xml").getDocument();
    //获取根目录ID
 int id=Integer.parseInt(document.getRootElement().attributeValue("id"));
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
    System.out.println("size="+ratings.size());*/
}

}
