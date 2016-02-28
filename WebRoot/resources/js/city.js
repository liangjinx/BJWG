
function cityName(webroot,areaid){
	var code = $("#province").val();
	if($('#province_txt')){
		$('#province_txt').text($("#province option:selected").text());
	}
	$.ajax({  
	   		type: "POST",  
	        url: webroot + 'auth/city',  
	        data: "areaId="+areaid,
	        dataType: "json",
	        success: function(data){
 			var option = "";
	        $.each(data, function (i, item) {
               //循环获取数据      
               var id = item.areaId; 
               var parentId = item.parent; 
               var name = item.name;
               if(areaid !=null && areaid != "" && parseInt(areaid) == parentId){
	               option += "<option value='"+id+"' selected='selected'>"+name+"</option>";
               }
               if(option == ""){
            	   $("#city_txt").text("");
               }else if(i == 0){
            	  $("#city_txt").text(name);
               }
           });  
	        if(option == ""){
	        	$("#city_txt").text("");
	        }
			$("#select_city").html(option); 
			var cityNa = $("#select_city").val();
			//不出现灰色背景
			if(null == cityNa ){
				$("#select_city").attr("disabled",true).css({"background-color":"white"});
			}else{
				$("#select_city").attr("disabled",false);
			}
		}  
	});  
	
}

//获取城市	
function cityName2(city){
	var areaId = $("#province").val();
	$.ajax({  
	   		type: "POST",  
	        url: '/wpv/uajsonCityV2',  
	        data: "areaId="+areaId,
	        success: function(data){
	        var json = eval("("+data+")"); 
 			var option = "";
	        $.each(json.des, function (i, item) {
                   //循环获取数据      
                   var id = item.areaId; 
                   var name = item.name;  
                   if(city !=null && city != "" && city == id){
		               option += "<option value='"+id+"' selected='selected'>"+name+"</option>";
                   }else if(name != '县' && name !='市' && name != '省直辖县级行政单位'){
                   		if(name == '市辖区'){
                   			name = item.parentName;
                   		}
	                   option += "<option value='"+id+"'>"+name+"</option>";
                   }
               });  
				$("#city").html(option); 
				var cityNa = $("#city").val();
				if(null == cityNa){
					$("#city").attr("disabled",true);
				}else{
					$("#city").attr("disabled",false);
				}
			}  
	});  
}	

function cityTxt(){
	$('#city_txt').text($("#select_city option:selected").text());
}