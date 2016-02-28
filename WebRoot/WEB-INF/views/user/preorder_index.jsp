<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<title>我的预抢</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
<meta name="keywords" content="八戒王国online">
<meta name="description" content="八戒王国online">
<meta http-equiv="Pragma" content="no-cache" />
<link rel="stylesheet" href="<%=basePath%>resources/css/public.css"/>
<link rel="stylesheet" href="<%=basePath%>resources/css/enter.css"/>
<link rel="stylesheet" href="<%=basePath%>resources/css/switch.css"/>

</head>
<body>
<div style="display:none;"><img src="<%=basePath %>resources/images/share-logo-300.png"  /></div>
<div class="bodyheight"><!--bodyheight -->	
    <div class="center90">
    	<p class="p_top">&nbsp;</p>
        <p class="p_12_ts">温馨提示：两种抢标方式只可选择一种；抢购成功需要在2小时内完成付款，否则视为放弃抢购。</p>
    </div>
    <div class="buying_box" data-type="${userExt.settingType }">
    	<form>  	
    	<div class="center90 buying_main">
        	 <p class="p_16">每期固定数量抢标
				<!--<label><input class="mui-switch mui-switch-animbg" type="radio" name="settingType" value="1"></label><span class="month_number"></span>-->
				<span class="mui-switch mui-switch-animbg <c:if test='${userExt.settingType eq 1 }'>checked</c:if>" data-setting-type="1"></span>
				<span class="month_number"><c:if test='${userExt.settingType eq 1 }'>${userExt.settingValue }</c:if></span>
			</p>
			<div class="clear"></div>
        </div>
        <div class="b_bottom"></div>
    	<div class="center90 buying_main">
        	<p class="p_16">选择期数抢标
				<span class="mui-switch mui-switch-animbg <c:if test='${userExt.settingType eq 2 }'>checked</c:if>" data-setting-type="2"></span>
				<!--<span class="periods_number"></span>-->
			</p>       
       		<div class="clear"></div>
        </div>
    	<div class="clear"></div>
    	</form>
    </div>
    <div class="input_number center80" id="input_number">
     	<p class="p_top">&nbsp;</p>
     	<input type="tel" maxlength="6" name="" class="pig_number"/>
        <button class="but but1 confirm_but">确定</button>
        <button class="but but2 abolish_but">取消</button>
     </div>
    
    <ul class="center90 period_ul <c:if test='${userExt.settingType eq 2 }'>show</c:if>">
    	<c:forEach items="${list }" var="l">
	        <!-- 选中了 加 checked_li，没有则不用 -->
	        <li data-project-id="${l.projectId }" <c:if test="${l.num >  0 && userExt.settingType eq 2}">class="checked_li"</c:if>>
	            	${l.name}
	            <c:if test="${l.num >  0 && userExt.settingType eq 2}"><p class="tr num">${l.num}</p></c:if>
	        </li>
    	</c:forEach>
    </ul>
	
	
    <div class="clear"></div>
</div><!--bodyheight -->
<jsp:include page="../common/commonTip.jsp"></jsp:include>
<jsp:include page="../back.jsp">
	<jsp:param value="wpv/urstoreMe" name="backUrl"/>
</jsp:include>
</body>
<script src="<%=basePath%>resources/js/layer/layer.js"></script>
<script>
$(function(){
    var __defaultType = $.trim( $('.buying_box').data('type') ),
		__settingType = __defaultType;// 抢标类型


    // 提交数据处理
    function submit(json, calllback){
        $.ajax({
            url : "<%=basePath%>wpv/urpreorderSet",
            dataType : "json",
            data: json,
            success : function(result) {
                calllback && calllback(result);
            },
            error : function() {
                alert("服务端异常");
            }
        });
    }

    // 弹层输入数据
    function showLayer(opts) {
        var layer_height = 190,
            layer_width = $(window).width() * 90 / 100,
            window_heigit = $(window).height(),
            offset = 'auto';

        if(window_heigit <= layer_height){ offset = "0px";}
        if(layer_width >= 640){layer_width = "576";}

        // 确定、取消回调处理
        var callbackFn = function (callbackType, index, context) {
            if (!$.isPlainObject(opts)) return;
            //console.log(121212);
            if (opts[callbackType] && typeof opts[callbackType] === 'function') {
                opts[callbackType].call(context, index);
            }
        };

        // 打开层
        return layer.open({
            type: 1,
            title:'设置抢购数量',
            shade: 0.6,
            area: [layer_width + 'px', layer_height + 'px'],
            offset: offset,
            shadeClose: true, //点击遮罩关闭层
            scrollbar: true,
            shift:1, //0-6的动画形式，-1不开启
            content: $("#input_number"),
            success: function(layerEle, index){
            	
                // 确定
                $(layerEle).find('.confirm_but').off('click').on('click',function () {
                    callbackFn('yesFn', index, layerEle);
                    //layer.close(index);
                });

                // 取消
                $(layerEle).find('.abolish_but, .layui-layer-ico').off('click').on('click',function () {
                    callbackFn('cancelFn', index, layerEle);
                    layer.close(index);
                });
            }

        });
    }

    // 抢标类型处理
    $('.mui-switch').click(function(){
        var $self = $(this),
            $parent = $self.closest('.buying_main'),
            pig_number;

        __settingType = $self.data('settingType');

        if (!$self.hasClass('checked')) {
            $('.mui-switch').removeClass('checked');
            $self.addClass('checked');

            switch (__settingType) {
                case 1: // 每期固定数量抢标
                    $('.period_ul').removeClass('show').fadeOut('slow');
                    showLayer({
                        yesFn     : function (index) {
                            var $layer = $(this);

                            pig_number = $layer.find('.pig_number').val();
                            
                            pig_number = pig_number === '' ? 0 : pig_number;

                            var successHandle = function () {
                                $('.month_number').text(pig_number).fadeIn();
                                $('.period_ul li').removeClass('checked_li').find('.num').remove();;
                            };

                            // 提交数据
                            submit({
                                settingType : __settingType,
                                projectId   : null,
                                num         : pig_number,
                                cancel      : false
                            }, successHandle);
                            
                            layer.close(index);
                        }
                        , cancelFn : function (index) {
                        	var monthNumber = $self.next('.month_number').text();
						
                            //$self.removeClass('checked');
							
							
							if (monthNumber === '') {
								$('.period_ul').fadeIn("slow");
								$('.mui-switch').removeClass('checked').eq(1).addClass('checked');
								$self.next('.month_number').fadeOut('fast');
								__settingType = 2;
							} else {
								$self.next('.month_number').fadeIn('fast');
								//__settingType = 1;
							}
							
                            //$self.removeClass('checked');
                            //$self.next('.month_number').text('');
							
							
                        }
                    });
                    break;
                case 2: // 选择期数抢标
                    $('.period_ul').fadeIn("slow");
                    $('.month_number').fadeOut();
                    //$('.month_number').text('');
                    break;
            }
        }
    });

    // 期数选择
    $('.period_ul li').on('click', function (e) {
        var $self = $(this),
            __projectId = $self.data('projectId'),
            __num;

        if ($self.hasClass('checked_li')) { // 取消
			
			if (confirm('您真的希望取消本期抢标吗？')) {
		
				var cancelHandle = function () {
					$self.removeClass('checked_li');
					$self.find('.num').remove();
					$('.month_number').text('');
				};
				
				// 提交数据
				submit({
					settingType : __settingType,
					projectId   : __projectId,
					num         : null,
					cancel      : true
				}, cancelHandle);
			
			}

        } else { // 选择
            showLayer({
                yesFn     : function (index) {
                    var $layer = $(this);
                     __num = $layer.find('.pig_number').val();
                     
                     if(__num == ''){
                    	 alert("请输入正确的数量，至少为1");
                    	 return ;
                     }
                    var successHandle = function () {
                        $self.addClass('checked_li');
                        $self.append('<p class="tr num">'+ __num +'</p>');
                        $('.month_number').text('');
                    };
                    //successHandle();
                    // 提交数据
                    submit({
                        settingType : __settingType,
                        projectId   : __projectId,
                        num         : __num,
                        cancel      : false
                    }, successHandle);
                    
                    layer.close(index);
                }
                
            });
        }
    });

    // 对输入数量进行控制，防止输入字符串
    $('.pig_number').on('keyup', function () {
        var $self = $(this);

        if (!/^[0-9]\d{0,5}$/i.test($self.val())) {
            $self.val('');
        }
    })
})
</script>
</html>
