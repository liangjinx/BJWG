//上传图片的大小控制
var isIE = /msie/i.test(navigator.userAgent) && !window.opera;  
var u = window.navigator.userAgent;
function fileChange(target,id,p_name,p_index) {   
    var fileSize = 0;         
    if (isIE && !target.files) {      
          var filePath = target.value;     
          var fileSystem = new ActiveXObject("Scripting.FileSystemObject");  
            
          if(!fileSystem.FileExists(filePath)){  
             alertMsg("附件不存在，请重新输入！");  
             return false;  
          }  
          var file = fileSystem.GetFile (filePath);  
          fileSize = file.Size;     
    } else {     
          fileSize = target.files[0].size;   
    }    
    var size = fileSize / 1024;  
    if(size>5000){   
         alertMsg("图片大小不能大于5M！");   
         var file=document.getElementById(id);   
         file.outerHTML=file.outerHTML; 
         $("#"+id).change(function(){
     		fileChange(this,id,p_name,p_index);
         });
         return false; 
    }    
    if(size<=0){  
        alertMsg("图片大小不能为0M！");   
        var file=document.getElementById(id);   
        file.outerHTML=file.outerHTML; 
        $("#"+id).change(function(){
     		fileChange(this,id,p_name,p_index);
        });
        return false; 
    }  
    var url=null;
    if (!!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/) || !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/) || u.indexOf('Android') > -1 
    		|| u.indexOf('Linux') > -1 || u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1) {
    	url = window.webkitURL.createObjectURL(target.files[0]);
    }else{
    	url = window.URL.createObjectURL(target.files[0]);
    }
    if (url) {
	    //用户资料
	    if('user_info' == p_name){
			$('.img_box img').attr('src',url);
			$('.img_box img').css({'width':'80px','height':'80px','vertical-align':'initial'});
			$('#allProjectForm').submit();
        }else if('attestation_enterprise' == p_name){
        	$('.leftbox #pic_1').hide();
			$('.leftbox .jia #img_1').attr('src',url);
			$('.leftbox .jia #img_1').css({'width':'118px','height':'88px','vertical-align':'initial', 'padding-top':'0'});
        }else if('attestation_personage' == p_name){
        	$('.leftbox #pic_'+p_index).hide();
			$('.leftbox .jia #img_'+p_index).attr('src',url);
			$('.leftbox .jia #img_'+p_index).css({'width':'118px','height':'88px','vertical-align':'initial', 'padding-top':'0'});
        }else if('set_up_shop' == p_name){
        	$('.user_box .p1').html('');
            $('.user_box').css("background","url("+url+") no-repeat");
			$('.user_box').css("background-size","100% 100%");
        }else if('goods_edit' == p_name){
        	$('.user_box .p1,.p2').html('');
        	$('.user_box').css("background","url("+url+") no-repeat");
        	$('.user_box').css("background-size","100% 100%");
        }else if('store_manage' == p_name){
        	$('.bigimg').attr('src',url);
            $('#allProjectForm').submit();
        }else if('broadcasting' == p_name){
        	$("#w-img"+p_index).attr("src",url).show();
        	$("#w-img"+p_index).attr("style","height:70px");
            $("img"+p_index).hide();
            $("#close"+p_index).show();
            var pic_count = $('#goods_pic li').length;
            if (pic_count >4) {
                $(this).closest('.bg_color').hide();
            }
        }
    }
    return true;
};


//ajax上传图片
function uploadFileAjax(obj,path,p_name){
	var val=$(obj).val();
	if(!val)return;
	//判断后缀名
	var reg=/.(gif|jpg|jpeg|png|bmp|GIF|JPG|JPEG|PNG|BMP)/;
	var index=val.lastIndexOf(".");
	if(!reg.test(val.substr(index))){
		alert("文件必须是gif、jpg、jpeg、png、bmp");
		return;
	}
	var url=null;
    if (!!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/) || !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/) || u.indexOf('Android') > -1 
    		|| u.indexOf('Linux') > -1 || u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1) {
    	url = window.webkitURL.createObjectURL(obj.files[0]);
    }else{
    	url = window.URL.createObjectURL(obj.files[0]);
    }
	$.ajaxFileUpload({  
      url: path,//上传地址  
      secureuri :false,
      fileElementId :obj.id,//file控件id
      dataType : 'json',
      success : function (data){
      	if(data.status == 1){
      	    if (url) {
      		    //用户资料
      		    if('user_info' == p_name){
      				$('.img_box img').attr('src',url);
      				$('.img_box img').css({'width':'80px','height':'80px','vertical-align':'initial'});
      		    }else if('user_info_pc' == p_name){
      		    	$('#headImg').attr('src',url);
      				$('#headImg').css({'width':'90px','height':'90px','vertical-align':'initial'});
      		    }
      	    }
      	}else{
      		alert(data.msg);
      	}
      },
      error: function(data, status, e){
          alert(data.msg);
      }
  });  
}