/*package com.bjwg.main.test;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Text;


public class Test1 {
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	 public static void main(String[] args) {
	        DocumentBuilderFactory  fct=DocumentBuilderFactory.newInstance();
	        try {
	        	 DocumentBuilder bui=fct.newDocumentBuilder();
		            Document doc=bui.newDocument();
		            Element ps=doc.createElement("ratings");
		            Attr id=doc.createAttribute("id");            
		            id.setNodeValue("1");
		            ps.setAttributeNode(id);
		            doc.appendChild(ps);
		            for (int i = 0; i <getCounts().length; i++) {
		            	  Element p1=doc.createElement("rating");
		 		         
				           
				            Attr id1=doc.createAttribute("id");
				            
				            id1.setNodeValue(""+i);
				          
				            Element name1=doc.createElement("phone");
				            Text na1=doc.createTextNode(getPhones());
				           
				            Element sex1=doc.createElement("count");
				            Text se1=doc.createTextNode(""+getCounts()[i]);
				            
				           
				                ps.appendChild(p1);
				                    p1.appendChild(name1);
				                        p1.setAttributeNode(id1);
				                        name1.appendChild(na1);
				                    p1.appendChild(sex1);
				                        sex1.appendChild(se1);
					}
		          
	          
	            try {
	                FileOutputStream fos=new FileOutputStream(new File("src/rating.xml"));
	                 
	                try {
	                    ((org.apache.crimson.tree.XmlDocument)doc)
	                    .write(fos);
	                } catch (IOException e) {
	                    // TODO Auto-generated catch block
	                    e.printStackTrace();
	                }
	                try {
	                    fos.flush();
	                } catch (IOException e) {
	                    // TODO Auto-generated catch block
	                    e.printStackTrace();
	                }
	                try {
	                    fos.close();
	                } catch (IOException e) {
	                    // TODO Auto-generated catch block
	                    e.printStackTrace();
	                }
	                 
	                 
	            } catch (FileNotFoundException e) {
	                // TODO Auto-generated catch block
	                e.printStackTrace();
	            }
	             
	             
	             
	             
	             
	        } catch (ParserConfigurationException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	         
	    }
	 
	 
	 private static String[] telFirst="134,135,136,137,138,139,150,151,152,157,158,159,187,130,131,132,155,156,133,153".split(",");  
	 public static int[]  getCounts(){  
	     
	       
	      
	       int[] counts=new int[5];
	       
	       for (int i = 0; i < counts.length; i++) {
	    	   counts[i]=(int)(Math.random()*80+20);			
		}
	       //冒泡排序
	       for (int x = 0; x < counts.length; x++) {
			for (int y = x; y < counts.length; y++) {
				if(counts[x]<counts[y]){
					int temp=0;
					temp=counts[x];
					counts[x]=counts[y];
					counts[y]=temp;
					
				}
				
				
			}
		}
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
*/