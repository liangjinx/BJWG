function controlProcess(qu,firstNum,num,size,lastNum,showId){

	var w = window.innerWidth;
	
	var per = 100 * (35 / w);

	//第一个区间，35px/销量 等比例划分
	if(qu == -1){
	
		per = ( per / firstNum ) * num;
	
		//最后一个区间，超出首尾差值则100%，否则超出部分按照等比例划分
	}else if(qu == size - 1){
		
		per = (100/size)*(size - 1);
		
		if(lastNum + lastNum - firstNum  < num){
			
			per = 100;
		}else{
			per = per + ((lastNum + 100 - num)  / 100 ) * (100 - per);
		}
		//中间区间，按照首尾差值等比例划分
	}else{
		
		var per2 = (100/size)*(size - 1);
		
		var dis = lastNum - firstNum;
		
		var over = num - firstNum;
		
		per2 = (over / dis) * per2;
		
		per += per2;
	}
	$("#"+showId).animate({width: '+'+per+'%'}, "slow");
}