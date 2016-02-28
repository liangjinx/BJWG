<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset=utf-8>
<script type="text/javascript" src="<%=basePath %>resources/js/core.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/js/sha1.js"></script>
<script>
	var support = false;
	$(document).ready(function () {
		var ua = navigator.userAgent.toLowerCase();
		if(ua.match(/MicroMessenger/i)=="micromessenger") {
			var v = ua.match(/MicroMessenger\/([0-9]{1}).([0-9]{1}).([0-9]{1})/i);
			v = (v+'');
			var dot = v.indexOf(".");
			v = v.substring(15,dot);
			//alert(v);
			//版本大于5.0才支持
			if(parseInt(v) >= 5){
				support = true;
				$("#a_wxAddress").attr("href","javascript:editAddress();");
			}
		}
	});
</script>
</head>
<body>

<%--
<div>
    <label>showerror</label>
    <textarea id="showerror"></textarea>
    <!--<div id="showerror"></div>-->
    <label>code</label>
    <input type="text" id="txtcode" /><br />

    <textarea id="txtinfo"></textarea>
    <label>accesstoken</label>
    <input type="text" id="txtaccesstoken" />
</div>

<div id="showtestresult"></div>

<label for="redhref">href测试</label> <input type="text" id="redhref" /><br />
<label for="redhref">加密前参数</label>  <input name="44" id="signpre" type="text" /><br />

<input type="button" id="getaddress2" onclick="editAddress()" value="获取地址" style="height: 100px;width: 100px;"/><br />

<div id="divinfo"></div>
<div id="resvalues">返回结果：</div>
--%>

<%-- 邮编 --%>
<input name=zipcode id="zipcode" type="hidden" />
<%-- 省、市、具体地址 --%>
<input name="provinceName" id="province" type="hidden" value=""/>
<input name="cityName" id="city" type="hidden" value=""/>
<input name="address" id="address" type="hidden" value=""/>
<%-- 联系人、电话 --%>
<input name="contactMan" id="contactMan" type="hidden" value=""/>
<input name="contactPhone" id="contactPhone" type="hidden" value=""/>


<script>
    var codestring = "";
    var access_tokenstring = "";
    //保存timestamp，提交用
    var oldTimeStamp;
    //保存nonceStr,提交用
    var oldNonceStr; 
    var sign;
    var isaccget = false;

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }
    function getTimeStamp() {
        var timestamp = new Date().getTime();
        //一定要转换字符串
        var timestampstring = timestamp.toString();
        oldTimeStamp = timestampstring;
        return timestampstring;
    }

    //得到随机字符串
    function getNonceStr() {
        var $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var maxPos = $chars.length;
        var noceStr = "";
        for (i = 0; i < 32; i++) {
            noceStr += $chars.charAt(Math.floor(Math.random() * maxPos));
        }
        oldNonceStr = noceStr;
        return noceStr;
    }

    //拼接url传参字符串
    function perapara(objvalues, isencode) {
        var parastring = "";
        for (var key in objvalues) {
            isencode = isencode || false;
            if (isencode) {
                parastring += (key + "=" + encodeURIComponent(objvalues[key]) + "&");
            }
            else {
                parastring += (key + "=" + objvalues[key] + "&");
            }
        }
        parastring = parastring.substr(0, parastring.length - 1);
        return parastring;
    }
    
    
    function getSign(beforesingstring) {
        sign = CryptoJS.SHA1(beforesingstring).toString();
        return sign;
    }

    
    $(document).ready(function () {
        //codestring = getcode();
        //$("#txtcode").val(codestring);
        getaccesstoken(codestring);
        //$("#txtaccesstoken").val(access_tokenstring);
    	//alert(getSign('accesstoken=OezXcEiiBSKSxW0eoylIeBFk1b8VbNtfWALJ5g6aMgZHaqZwK4euEskSn78Qd5pLsfQtuMdgmhajVM5QDm24W8X3tJ18kz5mhmkUcI3RoLm7qGgh1cEnCHejWQo8s5L3VvsFAdawhFxUuLmgh5FRA&appid=wx17ef1eaef46752cb&noncestr=123456&timestamp=1384841012&url=http://open.weixin.qq.com/'));
    });
    
  	//获取CODE
    var getcodeobj = {
        appid: getappid(),
        redirect_uri: window.location.href,
        response_type: "code",
        scope: "snsapi_base",
        state: "1"
    };
    function getappid() {
    	//换成自已的appid
        return "wxbe1733e33bb01bdf"; 
    }
  	//得到用户code
    function getcode() {
        /*var code = getQueryString("code");
        if (!code) {
            var getcodeparas = $.extend(getcodeobj, {
                redirect_uri: window.location.href
            });
            window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?" + perapara(getcodeparas) + "#wechat_redirect";
        }
        else {
            return code;
        }*/
    }
  	
  	//得到用户accesstoken
    function getaccesstoken(code) {
        //"https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx265a5bf049bf66c2&secret=ba255676aca99338070ad58c147471c9&code="+code+"&grant_type=authorization_code";
        /*var url = "<=basePath%>userAddress/getAccessToken";
        $.ajax({
            type: "POST",  //默认是GET
            dataType: "text",
            url: url,
            data: "code=" + code,
            async: false,  //异步
            cache: false, //不加载缓存
            success: function (obj) {
                access_tokenstring = obj;
          isaccget = true;
            },
            error: function (req, msg, ex) {
                $("#showerror").val(req.responseText.toString());
            }
        });*/
        isaccget = true;
        access_tokenstring = '${sessionScope.access_token}';
    }
  	
    var signparasobj = {
        "accesstoken": "",
        "appid": getappid(),
        "noncestr": "",
        "timestamp": "",
        "url": ""
    };
    
    function editAddress() {
    	
    	$("#contactMan").val("");
       	$("#contactPhone").val("");
       	$("#zipcode").val("");
       	$("#province").val("");
       	$("#city").val("");
       	$("#address").val("");
        //签名
        var signparas = $.extend(signparasobj, {
            "accesstoken": access_tokenstring,
            "noncestr": getNonceStr(),
            "timestamp": getTimeStamp(),
            "url": window.location.href
        });
        //$("#signpre").val(perapara(signparas));
        //签名
        var signstring = getSign(perapara(signparas));
        if (isaccget) {
            WeixinJSBridge.invoke('editAddress',
                    {
                        "appId": getappid(),
                        "scope": "jsapi_address",
                        "signType": "sha1",
                        "addrSign": signstring,
                        "timeStamp": oldTimeStamp,
                        "nonceStr": oldNonceStr
                    }
                    ,
                    function (res) {
                        var ff = ''; 
                        //var obj = resvalues != null ? resvalues : document.getElementById('resvalues'); 
                        if (res == null) { 
                        	//obj.innerText = '获取微信收货地址失败';
                        	//提示
                        	alert('获取微信收货地址失败');
                        	//开启好站点本地的收货地址
                        	$("#a_wxAddress").attr("href","javascript:payAddress('<%=basePath%>userAddress/visit');");
                        }
                        else {
                            /*打印返回信息
                            for (var key in res)
                            { 
                            	var js = 'res.' + key + ' = ' + res[key].toString() + '\n'; 
                            	ff = ff + js; 
                            }
                           	//obj.innerText = ff;
                           	*/
                           	if(res.userName && res.userName != 'undefined' && res.telNumber && res.telNumber != 'undefined'){
                           		
	                           	$("#contactMan").val(res.userName);
	                           	$("#contactPhone").val(res.telNumber);
	                           	$("#zipcode").val(res.addressPostalCode);
	                           	$("#province").val(res.proviceFirstStageName);
	                           	if(res.addressCitySecondStageName !='县' && res.addressCitySecondStageName != res.proviceFirstStageName 
	                           			&& res.addressCitySecondStageName !='省直辖县级行政区划' && res.addressCitySecondStageName != '自治区直辖县级行政区划'){
		                           	$("#city").val(res.addressCitySecondStageName);
	                           	}
	                           	$("#address").val(res.addressCountiesThirdStageName+' '+res.addressDetailInfo);
	                           	
	                           	if($("#a_wxAddress").attr("page") == 'shopping'){
	                           		
		                           	$("#a_wxAddress").html("<div class=\"info_content\"><h4>"+res.userName+"<span>"+res.telNumber+"</span></h4><div class=\"concreteness_adres\">"+res.proviceFirstStageName+$("#city").val()+" "+res.addressCountiesThirdStageName+res.addressDetailInfo+"</div><div class=\"news_adres\"><img src=\"/resources/images/cart/shopping_9.png\" alt=\"点击添加/更换地址\" /></div></div>");
	                           	}else{
	                           		
		                           	$("#a_wxAddress").html("<p class=\"buyer_name\" id=\"wxAddress_contactMan\">"+res.userName+"<span id=\"wxAddress_contactPhone\">"+res.telNumber+"</span></p><p class=\"buyer_addr\" id=\"wxAddress_detailAddress\">"+res.proviceFirstStageName+$("#city").val()+" "+res.addressCountiesThirdStageName+res.addressDetailInfo+"</p>");
	                           	}
	                           	
	                           	//$("#wxAddress_contactMan").html(res.userName);
	                           	//$("#wxAddress_contactPhone").html(res.telNumber);
	                           	//$("#wxAddress_detailAddress").html(res.addressCountiesThirdStageName+' '+res.addressDetailInfo);
	                           	//选择了地址
	                           	$("#hasAddress").val("yes");
                           	}else{
                           		
								if($("#a_wxAddress").attr("page") == 'shopping'){
	                           		
		                           	$("#a_wxAddress").html("<div class=\"info_content\"><div class=\"adres_empty\">您未填写上门服务的地址！</div><div class=\"news_adres2\"><img src=\"/resources/images/cart/shopping_9.png\" alt=\"点击添加/更换地址\" /></div></div>");
	                           	}else{
	                           		
		                           	$("#a_wxAddress").html("<div class=\"info_content\"><div class=\"adres_empty\">您未填写上门服务的地址！</div><div class=\"news_adres2\"><img src=\"/resources/images/cart/shopping_9.png\" alt=\"点击添加/更换地址\" /></div></div>");
	                           	}
                           		
	                           	$("#hasAddress").val("no");
                           	}
                        }
                    });
        }
    }
</script>
</body>
</html>
