<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><title>微信WeixinJSBridge API</title>
<meta charset=utf-8>
<script type="text/javascript" src="<%=basePath %>resources/js/core.js"></script>
<script type="text/javascript" src="<%=basePath %>resources/js/sha1.js"></script>
<script type="text/javascript">
(function(){
	var a=document.getElementsByTagName("html")[0];
	window.Session={appDomain:a.getAttribute("data-app-domain")||"",staticDomain:a.getAttribute("data-static-domain")||""}
})();
 
window.registNS=function(fullNS,isIgnorSelf){
	var reg=/^[_$a-z]+[_$a-z0-9]*/i;var nsArray=fullNS.split(".");
	var sEval="";
	var sNS="";
	var n=isIgnorSelf?nsArray.length-1:nsArray.length;
	for(var i=0;i<n;i++){
	    if(!reg.test(nsArray[i])){throw new Error("Invalid namespace:"+nsArray[i]+"");
	    	return
	    }
	    if(i!=0){
	    	sNS+="."
	    }
	    sNS+=nsArray[i];
	    sEval+="if(typeof("+sNS+")=='undefined') "+sNS+"=new Object();
	    else "+sNS+";"
	}
	if(sEval!=""){
		return eval(sEval)
	}
	return{}
 
};
 
</script>
 
</head>
<body>
<section class=mod-page-body>
<div class="mod-page-main wordwrap clearfix">
    <div class=mod-pageheader></div>
    <div class=mod-pagecontent>
    <div class=mod-weixinjsapi>
        <div class=x-desc>微信客户端自带的Js Api：WeixinJSBridge</div>
        <div id=WeixinJsApi>
                <input type=button id=imagePreview value="图片预览"></input>
                <input type=button id=profile value="查看profile"></input>
            <a href="weixin://profile/gh_412d74fbb474">企业微信小助手</a>
                <input type=button id=shareWeibo value="分享微博"></input>
                <input type=button id=shareFB value="分享facebook"></input>
                <input type=button id=addContact value="添加联系人"></input>
                <input type=button id=scanQRCode value="扫描二维码"></input>
                <input type=button id=jumpToBizProfile value="跳转到指定公众账号页面"></input>
            <input type=button id=toggleMenuBtn value="隐藏右上角按钮"></input>
            <input type=button id=toggleToolbar value="隐藏底部导航栏"></input>
            <input type=button id=getNetType value="获取网络状态"></input>
                <input type=button id=closeWindow value="关闭"></input>
                <input type=button id=getBrandWCPayRequest value="发起公众号微信支付"></input>
                <input type=button id=setPageState value="设置页面状态"></input>
                <input type=button id=sendEmail value="发邮件"></input>
                <input type=button id=openSpecificView value="微信团队打开webView,跳到指定页面"></input>
                <input type=button id=getCanIAPPay value="getCanIAPPay"></input>
                <input type=button id=getBrandIAPPayRequest value="发起公众号IAP支付"></input>
                <input type=button id=openUrlByExtBrowser value="用safari打开指定链接"></input>
                <input type=button id=openProductView value="跳转微信商品页"></input>
                <input type=button id=openLocation value="查看地理位置"></input>
                <input type=button id=timelineCheckIn value="朋友圈签到"></input>
                <input type=button id=getBrandWCPayCreateCreditCardRequest value="开通微信信用卡"></input>
                <input type=button id=geoLocation value="获取地理位置"></input>
                <input type=button id=getInstallState value="获取某app是否安装"></input>
                <input type=button id=editAddress value="公众号编辑收货地址"></input>
                <input type=button id=getLatestAddress value="公众号获取最近的收货地址"></input>
                <input type=button id=launch3rdApp value="启动第三方APP"></input>
                <input type=button id=jumpWCMall value="跳转微信商品购买界面"></input>
                <input type=button id=addEmoticon value="添加表情"></input>
                <input type=button id=cancelAddEmoticon value="取消下载某表情"></input>
                <input type=button id=hasEmoticon value="查询是否存在某表情"></input>
             
        </div>
    </div>
</div>
</div>
</section>
 
<script>
function onBridgeReady() {
    WeixinJSBridge.on('menu:share:appmessage', function(argv) 
    {
        WeixinJSBridge.invoke('sendAppMessage',{
                    "link":"http://m.exmail.qq.com/",
                    "desc":"desc",
                    "title":"title for WeiXinJsBridge"
        }, function(res) {
            WeixinJSBridge.log(res.err_msg);
        });
    });
    WeixinJSBridge.on('menu:share:timeline', function(argv) 
    {
    WeixinJSBridge.invoke("shareTimeline",{
        "link":"http://m.exmail.qq.com",
        "img_url":"http://rescdn.qqmail.com/bizmail/zh_CN/htmledition/images/bizmail/v3/logo1ca3fe.png",
        "img_width":"172",
        "img_height":"40",
        "desc":"i am description",
        "title":"just test from WeixinJsBridge"
        },
        function(e){
        alert(e.err_msg);
        })
    });
}
 
if (typeof WeixinJSBridge === "undefined"){
    if (document.addEventListener){
        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
    }
}else{
    onBridgeReady();
}
 
    var menuHidden=!1,toolbarHidden=!1,netType={"network_type:wifi":"wifi网络","network_type:edge":"非wifi,包含3G/2G","network_type:fail":"网络断开连接","network_type:wwan":"2g或者3g"};
    document.addEventListener("WeixinJSBridgeReady",function(){
            document.getElementById("imagePreview").addEventListener(
            "click",function(){
                                WeixinJSBridge.invoke("imagePreview",{
                "urls":[
                "http://rescdn.qqmail.com/bizmail/zh_CN/htmledition/images/bizmail/v3/logo1ca3fe.png",
                "http://rescdn.qqmail.com/bizmail/zh_CN/htmledition/images/bizmail/v3/icons_features1ca3fe.png",
                "http://rescdn.qqmail.com/bizmail/zh_CN/htmledition/images/bizmail/v3/icons_workStyle1ca3fe.png"
                ],
                "current":"http://rescdn.qqmail.com/bizmail/zh_CN/htmledition/images/bizmail/v3/icons_features1ca3fe.png"
                })
                        },!1),
        document.getElementById("profile").addEventListener(
            "click",function(){
                alert("profile clicked");
                WeixinJSBridge.invoke("profile",{
                    "username":"gh_412d74fbb474",
                    "nickname":"企业微信小助手"    
                })
            },!1),
        document.getElementById("shareWeibo").addEventListener(
            "click",function(){
                WeixinJSBridge.invoke("shareWeibo",{
                    "type":"link",
                    "link":"http://m.exmail.qq.com"
                },
                function(e){
                    alert(e.err_msg);
                })
            },!1),
        document.getElementById("shareFB").addEventListener(
            "click",function(){
                WeixinJSBridge.invoke("shareFB",{
                    "link":"http://m.exmail.qq.com"
                })
            },!1),
        document.getElementById("scanQRCode").addEventListener(
            "click",function(){
                WeixinJSBridge.invoke("scanQRCode",{
                })
            },!1),
        document.getElementById("addEmoticon").addEventListener(
            "click",function(){
                WeixinJSBridge.invoke("addEmoticon",{
                    "url":"http://rescdn.qqmail.com/bizmail/zh_CN/htmledition/images/bizmail/v3/icons_features1ca3fe.png",
                    "thumb_url":"http://rescdn.qqmail.com/bizmail/zh_CN/htmledition/images/bizmail/v3/logo1ca3fe.png"
 
                },
                function(e){
                                        alert(e.err_msg);
                                })
            },!1),
        document.getElementById("cancelAddEmoticon").addEventListener(
            "click",function(){
                WeixinJSBridge.invoke("cancelAddEmoticon",{
                    "url":"http://rescdn.qqmail.com/bizmail/zh_CN/htmledition/images/bizmail/v3/icons_features1ca3fe.png"
 
                },
                function(e){
                                        alert(e.err_msg);
                                })
            },!1),
        document.getElementById("hasEmoticon").addEventListener(
            "click",function(){
                WeixinJSBridge.invoke("hasEmoticon",{
                    "url":"http://rescdn.qqmail.com/bizmail/zh_CN/htmledition/images/bizmail/v3/icons_features1ca3fe.png"
 
                },
                function(e){
                                        alert(e.err_msg);
                                })
            },!1),
        document.getElementById("addContact").addEventListener(
            "click",function(){
                WeixinJSBridge.invoke("addContact",{
                    "webtype":"1",
                    "username":"gh_412d74fbb474"
                },
                function(e){
                    alert(e.err_msg);
                })
            },!1),
        document.getElementById("jumpToBizProfile").addEventListener(
            "click",function(){
                WeixinJSBridge.invoke("jumpToBizProfile",{
                    "tousername":"gh_2248a2ade13e"
                },
                function(e){
                    alert(e.err_msg);
                })
            },!1),
        document.getElementById("toggleMenuBtn").addEventListener(
            "click",function(){
                menuHidden?
                (WeixinJSBridge.call("showOptionMenu"),menuHidden=!1,this.value="隐藏右上角按钮")
                :
                (WeixinJSBridge.call("hideOptionMenu"),menuHidden=!0,this.value="显示右上角按钮")
            },!1),
        document.getElementById("toggleToolbar").addEventListener(
            "click",function(){
                toolbarHidden?
                (WeixinJSBridge.call("showToolbar"),toolbarHidden=!1,this.value="隐藏底部导航栏")
                :
                (WeixinJSBridge.call("hideToolbar"),toolbarHidden=!0,this.value="显示底部导航栏")
            },!1),
        document.getElementById("getNetType").addEventListener(
            "click",function(){
                WeixinJSBridge.invoke("getNetworkType",{},
                    function(e){
                        alert(netType[e.err_msg])
                    })
            },!1),
         document.getElementById("closeWindow").addEventListener(
                        "click",function(){
                                WeixinJSBridge.invoke("closeWindow",{},function(e){})
                        },!1),
        document.getElementById("getBrandWCPayRequest").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("getBrandWCPayRequest",{
                "appId" : "wx265a5bf049bf66c2", //公众号名称，由商户传⼊入
                "timeStamp" : "189026618", //时间戳 这⾥里随意使⽤用了⼀一个值
                "nonceStr" : "adssdasssd13d", //随机串
                "package" :
                "body=xxx&fee_type=1&input_charset=GBK&notify_url=http&out_trade_no=16642817866003386000&partner=1900000109&return_url=http&spbill_create_ip=127.0.0.1&total_fee=1&sign=273B7EEEE642A8E41F27213D8517E0E4", //扩展字段，由商户传⼊入
                "signType" : "SHA1", //微信签名⽅方式:sha1
                "paySign" : "b737015b5b1eabe5db580945a07eac08c7bb55f8" //微信签名
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("setPageState").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("setPageState",{
                "state" : "1"
                })
            },!1),
 
        document.getElementById("sendEmail").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("sendEmail",{
                "title" : "title!",
                "content" : "i am an Email!", //时间戳 这⾥里随意使⽤用了⼀一个值
                },
                function(e){
        //          alert(e.err_msg)
                })
            },!1),
        document.getElementById("openSpecificView").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("openSpecificView",{
                "specificview" : "contacts"
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("getCanIAPPay").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("getCanIAPPay",{  },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("getBrandIAPPayRequest").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("getBrandIAPPayRequest",{
                "appId" : "wx265a5bf049bf66c2", //公众号名称，由商户传⼊入
                "timeStamp" : "189026618", //时间戳 这⾥里随意使⽤用了⼀一个值
                "nonceStr" : "adssdasssd13d", //随机串
                "package" : "bankType=CITIC_CREDIT&bankName=%e4%b8%ad%e4%bf%a1%e9%93%b6%e8%a1%8c&sign=CF8922F49431FFE8A1834D0B32B25CE3",
                //扩展字段，由商户传⼊入
                "signType" : "SHA1", //微信签名⽅方式:sha1
                "paySign" : "1e6f13f78ca0ec43fbb80899087f77568af66987" //微信签名
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("openLocation").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("openProductView",{   
                "latitude" : 23.113, //纬度
                "longitude" : 113.23, //经度
                "name" : "TIT创意园", //POI名称
                "address" : "⼲⼴广州市海珠区新港中路397号", //地址
                "scale" : 14, //地图缩放级别
                "infoUrl" : "http://weixin.qq.com/", //查看位置界⾯面底部的超链接                
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("timelineCheckIn").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("timelineCheckIn",{   
                "img_url": "http://mmsns.qpic.cn/mmsns/RLllkTm3DUdV24xbZnKicx9jJWxXI0Bq84zzbtibGuRyk/0", // 分享到朋友圈的缩略图
                "img_width": "640",　// 图⽚片的⻓长度
                "img_height": "640", // 图⽚片⾼高度
                "link": "http://news.qq.com/zt2012/cxkyym/index.htm",　// 连接地址
                "desc": "这个是描述啊啊", // 描述
                "title": "朝鲜称中国渔船越界捕捞", // 分享标题
                "latitude" : 23.113, //纬度
                "longitude" : 113.23, //经度
                "poiId" : "dianping_2331037", //商户id
                "poiName" : "TIT创意园", //POI名称
                "poiAddress" : "⼲⼴广州市海珠区新港中路397号", //地址
                "poiScale" : 14, //地图缩放级别
                "poiInfoUrl" : "http://weixin.qq.com/" //查看位置界⾯面底部的超链接
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("geoLocation").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("geoLocation",{   
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("getBrandWCPayCreateCreditCardRequest").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("getBrandWCPayCreateCreditCardRequest",{  
                "appId" : "wx265a5bf049bf66c2", //公众号名称，由商户传⼊入
                "timeStamp" : "189026618", //时间戳 这⾥里随意使⽤用了⼀一个值
                "nonceStr" : "adssdasssd13d", //随机串
                "package" : "bankType=CITIC_CREDIT&bankName=%e4%b8%ad%e4%bf%a1%e9%93%b6%e8%a1%8c&sign= CF8922F49431FFE8A1834D0B32B25CE3",
                //扩展字段，由商户传⼊入
                "signType" : "SHA1", //微信签名⽅方式:sha1
                "paySign" : "1e6f13f78ca0ec43fbb80899087f77568af66987" //微信签名
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("getInstallState").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("getInstallState",{   
                    "packageUrl":"teamcircle://"
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("openProductView").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("openProductView",{   
                    "productInfo":"json"
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("getLatestAddress").addEventListener(
                "click",function(){
                WeixinJSBridge.invoke("getLatestAddress",{  
                    "appId" : "wx265a5bf049bf66c2", //公众号名称，由商户传⼊入
                    "timeStamp" : "189026618", //时间戳 这⾥里随意使⽤用了⼀一个值
                    "nonceStr" : "adssdasssd13d", //随机串
                    "signType" : "SHA1", //微信签名⽅方式:sha1
                    "addrSign" : "b737015b5b1eabe5db580945a07eac08c7bb55f8", //微信签名
                    "scope"    : "snsapi"
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
            alert('${appId}'+"--"+'${timeStamp}'+"--"+'${nonceStr}'+"--"+'${addrSign}');
        document.getElementById("editAddress").addEventListener(
                "click",function(){
                WeixinJSBridge.invoke("editAddress",{   
                    "appId" : '${appId}', //公众号名称，由商户传⼊入
                    "timeStamp" : '${timeStamp}', //时间戳 这⾥里随意使⽤用了⼀一个值
                    "nonceStr" : '${nonceStr}', //随机串
                    "signType" : "SHA1", //微信签名⽅方式:sha1
                    "addrSign" : '${addrSign}', //微信签名
                    "scope"    : "jsapi_address"
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("launch3rdApp").addEventListener(
                "click",function(){
                WeixinJSBridge.invoke("launch3rdApp",{  
                    "appId" : "wx265a5bf049bf66c2", //公众号名称，由商户传⼊入
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("jumpWCMall").addEventListener(
                "click",function(){
                WeixinJSBridge.invoke("jumpWCMall",{    
                    "appId" : "wx265a5bf049bf66c2", //公众号名称，由商户传⼊入
                    "funcId":"1000"
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1),
        document.getElementById("openUrlByExtBrowser").addEventListener(
            "click",function(){
            WeixinJSBridge.invoke("openUrlByExtBrowser",{
                "url" : "http://m.exmail.qq.com"
                },
                function(e){
                    alert(e.err_msg)
                })
            },!1)
        }
    );
</script>
  <!-- 
  <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
  
  <script type="text/javascript">
	var js_timestamp = '${js_timeStamp}';
	var timestamp = '${timeStamp}';
	var nonceStr = '${nonceStr}';
	var js_nonceStr = '${js_nonceStr}';
	var signature = '${signature}';
	var addrSign = '${addrSign}';
	var appId = '${appId}';
	
	$(document).ready(function(){
		wx.config({
		    debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		    appId: appId,//'wx61286443bbef2e4f', // 必填，公众号的唯一标识
		    timestamp: js_timestamp, // 必填，生成签名的时间戳
		    nonceStr: js_nonceStr, // 必填，生成签名的随机串
		    signature: signature,// 必填，签名，见附录1
		    jsApiList: ['getLatestAddress'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		});
		
		wx.ready(function(){
			getLatestAddress();
		});
	
		wx.error(function(res){
			//alert('error');
		    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
		
		});
	});
		
		
	function checkApi() {
		wx.checkJsApi({
	    jsApiList: ['getLatestAddress'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
	    success: function(res) {
	    	//alert('abc');
	       // 以键值对的形式返回，可用的api值true，不可用为false
	       // 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
	       }
		});
	}
	function getLatestAddress() {
		wx.getLatestAddress({
			appId:appId,
		    scope:'jsapi_address',
		    signType:'SHA1',
			timestamp: timestamp, // 位置签名时间戳，仅当需要兼容6.0.2版本之前时提供
		    nonceStr: nonceStr, // 位置签名随机串，仅当需要兼容6.0.2版本之前时提供
		    addrSign: signature, // 位置签名，仅当需要兼容6.0.2版本之前时提供，详见附录4
		    success: function (res) {
		        var userName = res.userName; // 收货人姓名
		        var telNumber = res.telNumber; // 收货人电话
		        var postalCode = res.postalCode; // 邮编
		        var provinceName = res.provinceName; // 国标收货地址第一级地址
		        var cityName = res.cityName; // 国标收货地址第二级地址
		        var countryName = res.countryName; // 国标收货地址第三级地址
		        var address = res.address; // 详细收货地址信息
		        var nationalCode = res.nationalCode; // 收货地址国家码
		    },
		    fail: function (data) {
		    	alert('获取当前位置失败，请手动选择');
		    	//window.location.href = '<%=basePath%>index/province';
		    }
		});
	}
	</script>
	 </script>
  </head>
  
  <body>
  	<div id="WeixinJsApi"></div>
  </body>
</html>
