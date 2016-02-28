$(function(){
	if($('#_temp_addr_id').length>0){
		$('form [name=addressId]').val($('#default_addr_id').val());
	}
	
	$('#btnSave').click(function(){
		/*var name = $('[name=contactMan]').val();
		var province = $('[name=province]').val();
		var city = $('[name=city]').val();
		var address = $('[name=address]').val();
		var mobile = $('[name=contactPhone]').val();*/
		if($('[name=savedCount]').val()>=10){
			alert('您已经保存了10个地址,不能再新增了');
			return;
		}
		if(!validateData()){
			return;
		}
		$('#form').attr('action',__base_path__+'pc/pv/address/saveAddress').submit();
	});
	$('#btnEditSave').click(function(){
		var name = $('#form [name=name]').val();
		var province = $('#form [name=province]').val();
		var city = $('#form [name=city]').val();
		var address = $('#form [name=address]').val();
		var mobile = $('#form [name=mobile]').val();
		if(!validateData()){
			return;
		}
		$('#form').attr('action',__base_path__+'pc/pv/address/saveEditAddress').submit();
	});
	$('table .btnDelete').click(function(){
		var r=confirm("确认删除?");
		if(r){
			$('form [name=addressId]').val($(this).parent().attr('data-addr'));
			$('#form').attr('action',__base_path__+'pc/pv/address/del').submit();
		}
	})
	
	function validateData(){
		var name = $('[name=contactMan]').val();
		var province = $('[name=province]').val();
		var city = $('[name=city]').val();
		var address = $('[name=address]').val();
		var mobile = $('[name=contactPhone]').val();
		if(name==''){
			alert('请输入联系人姓名');
			return;
		}
		if(province==''){
			alert('请选择省份');
			return;
		}
		if($('[name=city]>option').length>0 && city==''){
			alert('请选择城市');
			return;
		}
		if(address==''){
			alert('请输入详细地址');
			return;
		}
		if(mobile=='' || !/^((1)+\d{10})$/.test(mobile)){
			alert('请输入有效的联系号码');
			return;
		}
		return true;
	}
})





















