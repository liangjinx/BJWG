console.log(new Date().getTime() + 1000*60*60*10);
		$(function(){
			$.each($('.time_reduce'),function(index,value){
				
				 var d_date = parseInt($(value).data('countdown'));
				 console.log(d_date);
				 if(d_date){
				 	var $count = $(value).find('.d_count_down');
					var clear_time = setInterval(function(){
					 	var obj = timer(clear_time,d_date);
					 	if(obj){
					 		
					 		if(obj.dd == 0 && obj.hh == 0 && obj.mm == 0 && obj.ss == 0){
					 			
					 			var fresh = $(value).data('fresh');
					 			if(fresh && fresh != ''){
					 				window.location.href=fresh;
					 			}
					 		}
					 		
					 		$count.html((obj.dd != '' ? obj.dd + '天' : '')+ (obj.hh > 0 ? obj.hh +'时' : '') + obj.mm +'分'+ obj.ss + '秒');   //自定义输出格式
					 	}else{
					 		$count.html('0分0秒'); //自定义结束语
					 		if($("#buy_now").length<=0 && $("#count_down").length>0){
					 			var fresh = $(value).data('fresh');
					 			window.location.href=fresh;
					 		}
					 	};

					},1000);
				 }
			});
			function timer(timeid,timestamp){
					var nowTime = new Date().getTime();
					if(timestamp <= nowTime){
						clearInterval(timeid);
						return null;
					}else{
						var ts = ((new Date(timestamp)) - (new Date()));//计算剩余的毫秒数  
		                var dd = Math.floor(ts / 1000 / 60 / 60 / 24);//计算剩余的天数
		                var hh = Math.floor(ts / 1000 / 60 / 60);//计算剩余的小时数  
		                var mm = Math.floor(ts / 1000 / 60 % 60);//计算剩余的分钟数  
		                var ss = Math.floor(ts / 1000 % 60);//计算剩余的秒数  
		                dd = checkTime(dd);
		                if(dd == 0){
		                	dd = '';
		                }else {
		                	dd = dd;
		                }
		               //hh = checkTime(hh);
		                if(dd == ''){
		                	hh = checkTime(hh);
		                }else{
		                	hh = parseInt(hh)%24;
		                	hh = checkTime(hh);
		                }
		                mm = checkTime(mm);  
		                ss = checkTime(ss);
		                if(parseInt(hh) <= 0 && parseInt(mm) <= 0 && parseInt(ss) <= 0){
		                	clearInterval(timeid);
		                }
		                //console.log('dd:'+dd+",hh:"+hh+",mm:"+mm+",ss:"+ss);
		                return {
		                	dd : dd,		//天
		                	hh : hh,		//时
		                	mm : mm,		//分
		                	ss : ss			//秒
		                }
					}
	         
		    }
		    function checkTime(i){
		       if (i < 10) {    
		           i = "0" + i;    
		        }else if(i <= 0){
		        	i = '00';
		        }
		       return i;    
		    } 
		})