package com.bjwg.main.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

/**
 * excel 解析
 * 
 * @author Allen
 * @version 创建时间：2015-8-21 下午06:58:25
 * @Modified By:Administrator Version: 1.0 jdk : 1.6 类说明：
 */

public class ExcelMaker {

	private Map<Integer,List<Vector<String>>> readXls(String filePath) throws IOException {
		InputStream is = new FileInputStream(filePath);
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);

		Map<Integer,List<Vector<String>>> vMap = new HashMap<Integer, List<Vector<String>>>();
		// 循环工作表Sheet
		for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
			HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
			if (hssfSheet == null) {
				continue;
			}
			List<Vector<String>> vList = new ArrayList<Vector<String>>();
			// 循环行Row
			for (int rowNum = 0; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
				HSSFRow hssfRow = hssfSheet.getRow(rowNum);
				if (hssfRow == null) {
					continue;
				}

				Vector<String> v = new Vector<String>();
				// 循环列Cell
				for (int cellNum = 0; cellNum <= hssfRow.getLastCellNum(); cellNum++) {
					HSSFCell hssfCell = hssfRow.getCell(cellNum);
					if (hssfCell == null) {
						continue;
					}
					v.add(getValue(hssfCell));
					//System.out.print(getValue(hssfCell));
				}
				vList.add(v);
			}
			vMap.put(numSheet, vList);
		}
		return vMap;
	}

	@SuppressWarnings("static-access")
	private String getValue(HSSFCell hssfCell) {
		if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
			return String.valueOf(hssfCell.getBooleanCellValue());
		} else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
			return String.valueOf(hssfCell.getNumericCellValue());
		} else {
			return String.valueOf(hssfCell.getStringCellValue());
		}
	}
	
	public static void main(String[] args) {
		String rex = "^[0-9+]\\d{0,}. ";
		String s = "5. 第三次来买了真的不错！";
		ConsoleUtil.println(s.replaceAll(rex, ""));
		ExcelMaker excelMaker = new ExcelMaker();
		try {
			List<Vector<String>> vList = excelMaker.readXls("E:\\工作文档\\需求文档\\好站点商家评论.xls").get(0);
			int count = 0;
			for (Vector<String> vector : vList) {
				count++;
				//ConsoleUtil.println(count +"-- > " + vector.get(0));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
