/*
 * 手机号码格式
 * 只允许以13、15、18开头的号码
 * 如：13012345678、15929224344、18201234676
 */
var regMobile = /^1[3,5,8]\d{9}$/;
/*
 * 固定电话号码格式 因为固定电话格式比较复杂，情况比较多，主要验证了以下类型
 * 如：010-12345678、0912-1234567、(010)-12345678、(0912)1234567、(010)12345678、(0912)-1234567、01012345678、09121234567
 */
var regPhone = /^(^0\d{2}-?\d{8}$)|(^0\d{3}-?\d{7}$)|(^0\d2-?\d{8}$)|(^0\d3-?\d{7}$)$/;
/*
 * Email邮箱 如：zhangsan@163.com、li-si@236.net、wan_gwu999@SEED.NET.TW
 */
var regEmail = /^([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+(\.[a-zA-Z]{2,3})+$/;
/*
 * 身份证15位编码规则：dddddd yymmdd xx p dddddd：6位地区编码 yymmdd: 出生年(两位年)月日，如：910215 xx:
 * 顺序编码，系统产生，无法确定 p: 性别，奇数为男，偶数为女
 * 
 * 身份证18位编码规则：dddddd yyyymmdd xxx y dddddd：6位地区编码 yyyymmdd:
 * 出生年(四位年)月日，如：19910215 xxx：顺序编码，系统产生，无法确定，奇数为男，偶数为女 y: 校验码，该位数值可通过前17位计算获得
 * 
 * 前17位号码加权因子为 Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ] 验证位
 * Y = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ] 如果验证码恰好是10，为了保证身份证是十八位，那么第十八位将用X来代替
 * 校验位计算公式：Y_P = mod( ∑(Ai×Wi),11 ) i为身份证号码1...17 位; Y_P为校验码Y所在校验码数组位置
 */
function validateIdCard(idCard) {
	// 15位和18位身份证号码的正则表达式
	var regIdCard = /^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;
	// 如果通过该验证，说明身份证格式正确，但准确性还需计算
	if (regIdCard.test(idCard)) {
		if (idCard.length == 18) {
			var idCardWi = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10,
					5, 8, 4, 2); // 将前17位加权因子保存在数组里
			var idCardY = new Array(1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2); // 这是除以11后，可能产生的11位余数、验证码，也保存成数组
			var idCardWiSum = 0; // 用来保存前17位各自乖以加权因子后的总和
			for ( var i = 0; i < 17; i++) {
				idCardWiSum += idCard.substring(i, i + 1) * idCardWi[i];
			}
			var idCardMod = idCardWiSum % 11;// 计算出校验码所在数组的位置
			var idCardLast = idCard.substring(17);// 得到最后一位身份证号码
			// 如果等于2，则说明校验码是10，身份证号码最后一位应该是X
			if (idCardMod == 2) {
				if (idCardLast == "X" || idCardLast == "x") {
					// alert("恭喜通过验证啦！");
					return true;
				} else {
					// alert("身份证号码错误！");
					return false;
				}
			} else {
				// 用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
				if (idCardLast == idCardY[idCardMod]) {
					// alert("恭喜通过验证啦！");
					return true;
				} else {
					// alert("身份证号码错误！");
					return false;
				}
			}
		}
	} else {
		// alert("身份证格式不正确!");
		return false;
	}
}
/*
 * 只能为正整数
 */
var regNum = /^\d+$/;
/*
 * 邮政编码
 */
var regPostCode = /^\d{6}$/;
/*
 * 用户名 只能是字母数字下划线，并且以字母开头(5-16位)
 */
var regUserName = /^[a-zA-Z]\w{4,15}$/;
/*
 * IP地址 如：192.168.1.102
 */
var regIP = /^((([1-9]\d?)|(1\d{2})|(2[0-4]\d)|(25[0-5]))\.){3}(([1-9]\d?)|(1\d{2})|(2[0-4]\d)|(25[0-5]))$/;
/*
 * 只能是中文汉字
 */
var regChineseChar = /^[\u4e00-\u9fa5]+$/;
/*
 * 网址 只允许http、https、ftp这三种 如：http://www.baidu.com
 */
var regWeb = /^(([hH][tT]{2}[pP][sS]?)|([fF][tT][pP]))\:\/\/[wW]{3}\.[\w-]+\.\w{2,4}(\/.*)?$/;
/*
 * 日期格式验证 因为日期格式比较多，主要验证了以下类型 2012-05-14、2012/05/6、2012.5.14、20120528
 */
var regDate = /^[1-9]\d{3}([-|\/|\.])?((0\d)|([1-9])|(1[0-2]))\1(([0|1|2]\d)|([1-9])|3[0-1])$/;
/*
 * 调用以上正则表达式的方法 以验证电话号码格式为例
 */
function onCheck(tel) {
	if (regMobile.test(tel)) {
		alert("恭喜通过验证啦！");

	} else {
		alert("格式不正确！");
	}
}

/**
 * 验证营业执照是否合法：营业执照长度须为15位数字，前14位为顺序码， 最后一位为根据GB/T 17710 1999(ISO
 * 7064:1993)的混合系统校验位生成算法 计算得出。此方法即是根据此算法来验证最后一位校验位是否政正确。如果
 * 最后一位校验位不正确，则认为此营业执照号不正确(不符合编码规则)。 以下说明来自于网络:
 * 我国现行的营业执照上的注册号都是15位的，不存在13位的，从07年开始国 家进行了全面的注册号升级就全部都是15位的了，如果你看见的是13位的注
 * 册号那肯定是假的。 15位数字的含义，代码结构工商注册号由14位数字本体码和1位数字校验码
 * 组成，其中本体码从左至右依次为：6位首次登记机关码、8位顺序码。 一、前六位代表的是工商行政管理机关的代码，国家工商行政管理总局用
 * “100000”表示，省级、地市级、区县级登记机关代码分别使用6位行 政区划代码表示。设立在经济技术开发区、高新技术开发区和保税区
 * 的工商行政管理机关（县级或县级以上）或者各类专业分局应由批准 设立的上级机关统一赋予工商行政管理机关代码，并报国家工商行政 管理总局信息化管理部门备案。
 * 二、顺序码是7-14位，顺序码指工商行政管理机关在其管辖范围内按照先 后次序为申请登记注册的市场主体所分配的顺序号。为了便于管理和
 * 赋码，8位顺序码中的第1位（自左至右）采用以下分配规则： 1）内资各类企业使用“0”、“1”、“2”、“3”； 2）外资企业使用“4”、“5”；
 * 3）个体工商户使用“6”、“7”、“8”、“9”。 顺序码是系统根据企业性质情况自动生成的。 顺序码是系统根据企业性质情况自动生成的。
 * 三、校验码是最后一位，校验码用于检验本体码的正确性
 */
function isValidBusCode(busCode) {
	// return true;
	var ret = false;
	if (busCode.length == 15) {
		var sum = 0;
		var s = [];
		var p = [];
		var a = [];
		var m = 10;
		p[0] = m;
		for ( var i = 0; i < busCode.length; i++) {
			a[i] = parseInt(busCode.substring(i, i + 1), m);
			s[i] = (p[i] % (m + 1)) + a[i];
			if (0 == s[i] % m) {
				p[i + 1] = 10 * 2;
			} else {
				p[i + 1] = (s[i] % m) * 2;
			}
		}
		if (1 == (s[14] % m)) {
			// 营业执照编号正确!
			ret = true;
			/*
			 * $("#business_license").removeClass('check');
			 * $("#business_license").parent().siblings(".gddyTstext").text(
			 * "营业执照编号正确！");
			 */
			// alert("营业执照编号正确!");
		} else {
			// 营业执照编号错误!
			ret = false;
			/*
			 * $("#business_license").addClass('check');
			 * $("#business_license").parent().siblings(".gddyTstext").text(
			 * "营业执照编号错误！");
			 */
			// alert("营业执照编号错误!");
		}
	}// 如果营业执照为空
	else if ("" == busCode) {
		/*
		 * $("#business_license").addClass('check');
		 * $("#business_license").parent().siblings(".gddyTstext").text(
		 * "营业执照编号不能为空！");
		 */
		ret = false;
	} else {
		ret = false;
		/*
		 * $("#business_license").addClass('check');
		 * $("#business_license").parent().siblings(".gddyTstext").text(
		 * "营业执照格式不对，必须是15位数的！");
		 */
		// alert("营业执照格式不对，必须是15位数的！");
	}
	return ret;
}
/**
 * 验证组织机构代码是否合法：组织机构代码为8位数字或者拉丁字母+“-”+1位校验码。 验证最后那位校验码是否与根据公式计算的结果相符。 编码规则请参看
 * http://wenku.baidu.com/view/d615800216fc700abb68fc35.html
 */
function isValidOrgCode(orgCode) {
	// return ""==orgCode || orgCode.length==10;
	// return true;
	var ret = false;
	var codeVal = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B",
			"C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
			"P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ];
	var intVal = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
			17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33,
			34, 35 ];
	var crcs = [ 3, 7, 9, 10, 5, 8, 4, 2 ];
	if (!("" == orgCode) && orgCode.length == 10) {
		var sum = 0;
		for ( var i = 0; i < 8; i++) {
			var codeI = orgCode.substring(i, i + 1);
			var valI = -1;
			for ( var j = 0; j < codeVal.length; j++) {
				if (codeI == codeVal[j]) {
					valI = intVal[j];
					break;
				}
			}
			sum += valI * crcs[i];
		}
		var crc = 11 - (sum % 11);

		switch (crc) {
		case 10: {
			crc = "X";
			break;
		}
		default: {
			break;
		}
		}
		// alert("crc="+crc+",inputCrc="+orgCode.substring(9));
		// 最后位验证码正确
		if (crc == orgCode.substring(9)) {
			ret = true;
			$("#agency_code").removeClass('check');
			$("#agency_code").parent().siblings(".gddyTstext").text("正确！");
		} else {
			ret = false;
			$("#agency_code").addClass('check');
			$("#agency_code").parent().siblings(".gddyTstext").text(
					"组织机构代码不正确！");
		}
	} else if ("" == orgCode) {
		ret = false;
		$("#agency_code").addClass('check');
		$("#agency_code").parent().siblings(".gddyTstext").text("组织机构代码不能为空！");
	} else {
		ret = false;
		$("#agency_code").addClass('check');
		$("#agency_code").parent().siblings(".gddyTstext").text(
				"组织机构代码格式不正确，组织机构代码为8位数字或者拉丁字母+“-”+1位校验码，并且字母必须大写！");
	}
	return ret;
}



 
/**
 * 身份证15位编码规则：dddddd yymmdd xx p dddddd：地区码 yymmdd: 出生年月日 xx: 顺序类编码，无法确定 p:
 * 性别，奇数为男，偶数为女
 * <p />
 * 身份证18位编码规则：dddddd yyyymmdd xxx y dddddd：地区码 yyyymmdd: 出生年月日
 * xxx:顺序类编码，无法确定，奇数为男，偶数为女 y: 校验码，该位数值可通过前17位计算获得
 * <p />
 * 18位号码加权因子为(从右到左) Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2,1 ]
 * 验证位 Y = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ] 校验位计算公式：Y_P = mod( ∑(Ai×Wi),11 )
 * i为身份证号码从右往左数的 2...18 位; Y_P为脚丫校验码所在校验码数组位置
 * 
 */  
  
var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ];// 加权因子
var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ];// 身份证验证位值.10代表X
function IdCardValidate(idCard) {   
    idCard = trim(idCard.replace(/ /g, ""));   
    if (idCard.length == 15) {   
        return isValidityBrithBy15IdCard(idCard);   
    } else if (idCard.length == 18) {   
        var a_idCard = idCard.split("");// 得到身份证数组
        if(isValidityBrithBy18IdCard(idCard)&&isTrueValidateCodeBy18IdCard(a_idCard)){   
            return true;   
        }else {   
            return false;   
        }   
    } else {   
        return false;   
    }   
}   
/**
 * 判断身份证号码为18位时最后的验证位是否正确
 * 
 * @param a_idCard
 *            身份证号码数组
 * @return
 */  
function isTrueValidateCodeBy18IdCard(a_idCard) {   
    var sum = 0; // 声明加权求和变量
    if (a_idCard[17].toLowerCase() == 'x') {   
        a_idCard[17] = 10;// 将最后位为x的验证码替换为10方便后续操作
    }   
    for ( var i = 0; i < 17; i++) {   
        sum += Wi[i] * a_idCard[i];// 加权求和
    }   
    valCodePosition = sum % 11;// 得到验证码所位置
    if (a_idCard[17] == ValideCode[valCodePosition]) {   
        return true;   
    } else {   
        return false;   
    }   
}   
/**
 * 通过身份证判断是男是女
 * 
 * @param idCard
 *            15/18位身份证号码
 * @return 'female'-女、'male'-男
 */  
function maleOrFemalByIdCard(idCard){   
    idCard = trim(idCard.replace(/ /g, ""));// 对身份证号码做处理。包括字符间有空格。
    if(idCard.length==15){   
        if(idCard.substring(14,15)%2==0){   
            return 'female';   
        }else{   
            return 'male';   
        }   
    }else if(idCard.length ==18){   
        if(idCard.substring(14,17)%2==0){   
            return 'female';   
        }else{   
            return 'male';   
        }   
    }else{   
        return null;   
    }   
// 可对传入字符直接当作数组来处理
// if(idCard.length==15){
// alert(idCard[13]);
// if(idCard[13]%2==0){
// return 'female';
// }else{
// return 'male';
// }
// }else if(idCard.length==18){
// alert(idCard[16]);
// if(idCard[16]%2==0){
// return 'female';
// }else{
// return 'male';
// }
// }else{
// return null;
// }
}   
 /**
	 * 验证18位数身份证号码中的生日是否是有效生日
	 * 
	 * @param idCard
	 *            18位书身份证字符串
	 * @return
	 */  
function isValidityBrithBy18IdCard(idCard18){   
    var year =  idCard18.substring(6,10);   
    var month = idCard18.substring(10,12);   
    var day = idCard18.substring(12,14);   
    var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
    // 这里用getFullYear()获取年份，避免千年虫问题
    if(temp_date.getFullYear()!=parseFloat(year)   
          ||temp_date.getMonth()!=parseFloat(month)-1   
          ||temp_date.getDate()!=parseFloat(day)){   
            return false;   
    }else{   
        return true;   
    }   
}   
  /**
	 * 验证15位数身份证号码中的生日是否是有效生日
	 * 
	 * @param idCard15
	 *            15位书身份证字符串
	 * @return
	 */  
  function isValidityBrithBy15IdCard(idCard15){   
      var year =  idCard15.substring(6,8);   
      var month = idCard15.substring(8,10);   
      var day = idCard15.substring(10,12);   
      var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
      // 对于老身份证中的你年龄则不需考虑千年虫问题而使用getYear()方法
      if(temp_date.getYear()!=parseFloat(year)   
              ||temp_date.getMonth()!=parseFloat(month)-1   
              ||temp_date.getDate()!=parseFloat(day)){   
                return false;   
        }else{   
            return true;   
        }   
  }   
// 去掉字符串头尾空格
function trim(str) {   
    return str.replace(/(^\s*)|(\s*$)/g, "");   
}









































/** 
 * author:qiaoyongjun 
 * StrNo:用户输入的身份证件号码 
 * _id:用来承载错误信息的控件ID号,用来进行友好提示 
 *判断身份证号码格式函数 
 *公民身份号码是特征组合码， 
 *排列顺序从左至右依次为：六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码 
 *如果验证通过　返回 true 
 */  
function isChinaIDCard(StrNo, _Id) {  
    var error = document.getElementById(_Id);  
    StrNo = StrNo.toString();  
    if (StrNo.length == 15) {  
        if (!isValidDate("19" + StrNo.substr(6, 2), StrNo.substr(8, 2),  
                StrNo.substr(10, 2), _Id)) {  
            return false;  
        }  
    } else if (StrNo.length == 18) {  
        if (!isValidDate(StrNo.substr(6, 4), StrNo.substr(10, 2), StrNo  
                .substr(12, 2), _Id)) {  
            return false;  
        }  
    } else {  
        error.innerHTML = "";  
        error.innerHTML = "输入的身份证号码必须为15位或者18位！";  
        return false;  
    }  
  
    if (StrNo.length == 18) {  
        var a, b, c  
        if (!isNumber(StrNo.substr(0, 17))) {  
  
            error.innerHTML = "";  
            error.innerHTML = "身份证号码错误,前17位不能含有英文字母！";  
            return false;  
  
        }  
        a = parseInt(StrNo.substr(0, 1)) * 7 + parseInt(StrNo.substr(1, 1))  
                * 9 + parseInt(StrNo.substr(2, 1)) * 10;  
        a = a + parseInt(StrNo.substr(3, 1)) * 5  
                + parseInt(StrNo.substr(4, 1)) * 8  
                + parseInt(StrNo.substr(5, 1)) * 4;  
        a = a + parseInt(StrNo.substr(6, 1)) * 2  
                + parseInt(StrNo.substr(7, 1)) * 1  
                + parseInt(StrNo.substr(8, 1)) * 6;  
        a = a + parseInt(StrNo.substr(9, 1)) * 3  
                + parseInt(StrNo.substr(10, 1)) * 7  
                + parseInt(StrNo.substr(11, 1)) * 9;  
        a = a + parseInt(StrNo.substr(12, 1)) * 10  
                + parseInt(StrNo.substr(13, 1)) * 5  
                + parseInt(StrNo.substr(14, 1)) * 8;  
        a = a + parseInt(StrNo.substr(15, 1)) * 4  
                + parseInt(StrNo.substr(16, 1)) * 2;  
        b = a % 11;  
        if (b == 2) //最后一位为校验位    
        {  
            c = StrNo.substr(17, 1).toUpperCase(); //转为大写X    
        } else {  
            c = parseInt(StrNo.substr(17, 1));  
        }  
        switch (b) {  
        case 0:  
            if (c != 1) {  
                error.innerHTML = "";  
                error.innerHTML = "身份证号码校验位错:最后一位应该为:1";  
                return false;  
            }  
            break;  
        case 1:  
            if (c != 0) {  
                error.innerHTML = "";  
                error.innerHTML = "身份证号码校验位错:最后一位应该为:0";  
                return false;  
            }  
            break;  
        case 2:  
            if (c != "X") {  
                error.innerHTML = "";  
                error.innerHTML = "身份证号码校验位错:最后一位应该为:X";  
                return false;  
            }  
            break;  
        case 3:  
            if (c != 9) {  
                error.innerHTML = "";  
                error.innerHTML = "身份证号码校验位错:最后一位应该为:9";  
                return false;  
            }  
            break;  
        case 4:  
            if (c != 8) {  
                error.innerHTML = "";  
                error.innerHTML = "身份证号码校验位错:最后一位应该为:8";  
                return false;  
            }  
            break;  
        case 5:  
            if (c != 7) {  
                error.innerHTML = "";  
                error.innerHTML = "身份证号码校验位错:最后一位应该为:7";  
                return false;  
            }  
            break;  
        case 6:  
            if (c != 6) {  
                error.innerHTML = "";  
                error.innerHTML = "身份证号码校验位错:最后一位应该为:6";  
                return false;  
            }  
            break;  
        case 7:  
            if (c != 5) {  
                error.innerHTML = "";  
                error.innerHTML = "身份证号码校验位错:最后一位应该为:5";  
                return false;  
            }  
            break;  
        case 8:  
            if (c != 4) {  
                error.innerHTML = "";  
                error.innerHTML = "身份证号码校验位错:最后一位应该为:4";  
                return false;  
            }  
            break;  
        case 9:  
            if (c != 3) {  
                error.innerHTML = "";  
                error.innerHTML = "身份证号码校验位错:最后一位应该为:3";  
                return false;  
            }  
            break;  
        case 10:  
            if (c != 2) {  
                error.innerHTML = "";  
                error.innerHTML = "身份证号码校验位错:最后一位应该为:2";  
                return false;  
            }  
        }  
    } else {//15位身份证号    
        if (!isNumber(StrNo)) {  
            error.innerHTML = "";  
            error.innerHTML = "身份证号码错误,前15位不能含有英文字母！";  
            return false;  
        }  
    }  
    return true;  
  
}  
/** 
 * 验证身份证件中的日期是否合法有效 
 * @param iY 
 * @param iM 
 * @param iD 
 * @param _id 
 * @return 
 */  
function isValidDate(iY, iM, iD, _id) {  
    if (iY > 2200 || iY < 1900 || !isNumber(iY)) {  
        document.getElementById(_id).innerHTML = "";  
        document.getElementById(_id).innerHTML = "输入身份证号,年度" + iY + "非法！";  
        return false;  
    }  
    if (iM > 12 || iM <= 0 || !isNumber(iM)) {  
        document.getElementById(_id).innerHTML = "";  
        document.getElementById(_id).innerHTML = "输入身份证号,月份" + iM + "非法！";  
        return false;  
    }  
    if (iD > 31 || iD <= 0 || !isNumber(iD)) {  
        document.getElementById(_id).innerHTML = "";  
        document.getElementById(_id).innerHTML = "输入身份证号,日期" + iD + "非法！";  
        return false;  
    }  
    return true;  
}  
/** 
 * 验证是否为数字 
 * @param oNum 
 * @return 
 */  
function isNumber(oNum) {  
    if (!oNum)  
        return false;  
    var strP = /^\d+(\.\d+)?$/;  
    if (!strP.test(oNum))  
        return false;  
    try {  
        if (parseFloat(oNum) != oNum)  
            return false;  
    } catch (ex) {  
        return false;  
    }  
    return true;  
}




//bankno为银行卡号 banknoInfo为显示提示信息的DIV或其他控件
function luhmCheck(bankno){
    var lastNum=bankno.substr(bankno.length-1,1);//取出最后一位（与luhm进行比较）
 
    var first15Num=bankno.substr(0,bankno.length-1);//前15或18位
    var newArr=new Array();
    for(var i=first15Num.length-1;i>-1;i--){    //前15或18位倒序存进数组
    newArr.push(first15Num.substr(i,1));
    }
    var arrJiShu=new Array();  //奇数位*2的积 <9
    var arrJiShu2=new Array(); //奇数位*2的积 >9
     
    var arrOuShu=new Array();  //偶数位数组
    for(var j=0;j<newArr.length;j++){
    if((j+1)%2==1){//奇数位
        if(parseInt(newArr[j])*2<9)
        arrJiShu.push(parseInt(newArr[j])*2);
        else
        arrJiShu2.push(parseInt(newArr[j])*2);
    }
    else //偶数位
    arrOuShu.push(newArr[j]);
    }
     
    var jishu_child1=new Array();//奇数位*2 >9 的分割之后的数组个位数
    var jishu_child2=new Array();//奇数位*2 >9 的分割之后的数组十位数
    for(var h=0;h<arrJiShu2.length;h++){
    jishu_child1.push(parseInt(arrJiShu2[h])%10);
    jishu_child2.push(parseInt(arrJiShu2[h])/10);
    }       
     
    var sumJiShu=0; //奇数位*2 < 9 的数组之和
    var sumOuShu=0; //偶数位数组之和
    var sumJiShuChild1=0; //奇数位*2 >9 的分割之后的数组个位数之和
    var sumJiShuChild2=0; //奇数位*2 >9 的分割之后的数组十位数之和
    var sumTotal=0;
    for(var m=0;m<arrJiShu.length;m++){
    sumJiShu=sumJiShu+parseInt(arrJiShu[m]);
    }
     
    for(var n=0;n<arrOuShu.length;n++){
    sumOuShu=sumOuShu+parseInt(arrOuShu[n]);
    }
     
    for(var p=0;p<jishu_child1.length;p++){
    sumJiShuChild1=sumJiShuChild1+parseInt(jishu_child1[p]);
    sumJiShuChild2=sumJiShuChild2+parseInt(jishu_child2[p]);
    }     
    //计算总和
    sumTotal=parseInt(sumJiShu)+parseInt(sumOuShu)+parseInt(sumJiShuChild1)+parseInt(sumJiShuChild2);
     
    //计算Luhm值
    var k= parseInt(sumTotal)%10==0?10:parseInt(sumTotal)%10;       
    var luhm= 10-k;
     
    if(lastNum==luhm){
    $("#banknoInfo").html("Luhm验证通过");
    return true;
    }
    else{
    $("#banknoInfo").html("银行卡号必须符合Luhm校验");
    return false;
    }       
}