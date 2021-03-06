package com.rm.utils;

import java.util.Random;

public class getRandomCharAndNumr {

    /**
     * 获取随机字母数字组合
     * 
     * @param length
     *            字符串长度
     * @return
     */
    public static String getRandomCharAndNumrMethod(Integer length) {
        String str = "rm";
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            boolean b = random.nextBoolean();
            if (b) { // 字符串
                int choice = random.nextBoolean() ? 65 : 97; //取得65大写字母还是97小写字母
                str += (char) (choice + random.nextInt(26));// 取得大写字母
            } else { // 数字
                str += String.valueOf(random.nextInt(10));
            }
        }
        return str;
    }
    public static void main(String[] args) {
    	System.out.println(getRandomCharAndNumr.getRandomCharAndNumrMethod(10));
	}
}
