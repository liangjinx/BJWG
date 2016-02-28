$(function() {
		$('.cancel').click(function() {
			var r=confirm("确定取消订单?");
			if(r){
				var self = $(this);
				
				$.ajax({
					type : 'POST',
					dataType : 'json',
					url : __base_path__+'pc/pv/order/cancel',
					cache : false,
					data : {
						orderId : self.parent().parent().attr('data-order')
					},
					success : function(data) {
						if (data.msg == 'success') {
							alert('取消成功')
							window.location.href=window.location.href;
						} else {
							alert(data.data.text);
						}
					},
					error : function() {
						alert('error');
					}
				});
			}
		});
		
		$('.delete').click(function() {
			var r=confirm("确定删除订单?");
			if(r){
				var self = $(this);
				
				$.ajax({
					type : 'POST',
					dataType : 'json',
					url : __base_path__+'pc/pv/order/del',
					cache : false,
					data : {
						orderId : self.parent().parent().attr('data-order')
					},
					success : function(data) {
						if (data.msg == 'success') {
							alert('删除成功')
							window.location.href=window.location.href;
						} else {
							alert(data.data.text);
						}
					},
					error : function() {
						alert('error');
					}
				});
			}
		});
		
		$('.confirm').click(function() {
			var r=confirm("确定确认收货?");
			if(r){
				var self = $(this);
				
				$.ajax({
					type : 'POST',
					dataType : 'json',
					url : __base_path__+'pc/pv/order/confirm',
					cache : false,
					data : {
						orderId : self.parent().parent().attr('data-order')
					},
					success : function(data) {
						if (data.msg == 'success') {
							alert('确认收货成功')
							window.location.href=window.location.href;
						} else {
							alert(data.data.text);
						}
					},
					error : function() {
						alert('error');
					}
				});
			}
		});
});