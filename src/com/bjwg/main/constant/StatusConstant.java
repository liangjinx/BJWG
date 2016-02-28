package com.bjwg.main.constant;
/**
 * @author chen
 * @version 创建时间：2015-4-13 上午11:10:48
 * @Modified By:Administrator
 * Version: 1.0
 * jdk : 1.6
 * 类说明：
 */

public class StatusConstant {

	
	/**
	 * json请求处理结果类型枚举
	 * @author Carter
	 * @createTime 2015-4-8 下午02:58:19
	 * @description 
	 */
	public enum Status
	{
		
		
		/**
		 * 请求成功
		 */
		success(1,"success","请求成功"),
		
		/**
		 * 企业用户和个人用户区别
		 */
		ep(2,"ep","您是企业用户，请选择正确的登录方式"),
		
		/**
		 * 企业用户和个人用户区别
		 */
		ep2(3,"ep","您是个人用户，请选择正确的登录方式"),
		
		
		
		/**
		 * 登录再参加抢猪腿活动
		 */
		loginActive(-111,"login","请登录后再参加活动"),
		/**
		 * 本期已抢完，静待下期
		 */
		buyFinish(-112,"buyFinish","本期已抢购完成，请关注平台下期开抢"),
		/**
		 * 号码已经没有那么多了，请给他人留点机会
		 */
		outofCode(-113,"outofCode","号码已经没有那么多了，请给他人留点机会"),
		
		/**
		 * 号码已经没有那么多了，请给他人留点机会
		 */
		restart(-115,"restart","上一期已结束，本期现在开始"),
		
	
		
		
		
		
		/**
		 * 缺少参数
		 */
		missParam(-1,"miss parameter","缺少参数"),
		/**
		 * 参数格式错误
		 */
		paramFormatError(-2,"parameter format error","参数格式错误"),
		/**
		 * 请求的数据不存在
		 */
		dataNotExists(-3,"requested data not exists","请求的数据不存在"),
		/**
		 * 服务器错误
		 */
		serverError(-4,"server error","服务器错误"),
		
		/**
		 * token值无效
		 */
		tokenNullity(-5,"token nullity","token值无效"),
		/**
		 * 请求资源无效
		 */
		urlNullity(-6,"url nullity","请求资源无效"),
		/**
		 * 请重新登录
		 */
		login_first(-7,"login first","请重新登录"),
		/**
		 * 保存失败
		 */
		saveFail(-8,"save fail","保存失败"), 
		
		/**
		 * 验证码获取间隔时间过短
		 */
		getVerifyCodeIntervalTooShort(-9,"get verify code interval too Short","验证码获取间隔时间过短"),
		/**
		 * 验证码已失效
		 */
		verifyCodeTimeout(-10,"verify code timeout","验证码已失效"),
		/**
		 * 验证码无效
		 */
		verifyCodeInvalid(-11,"verifyCode Invalid","验证码无效"),
		/**
		 * 验证码发送失败
		 */
		verifyCodeSendFail(-11,"verifyCode Invalid","验证码发送失败"),
		
		/**
		 * 文件超过制定大小
		 */
		fileOverMax(-12,"file size over max","上传的文件超过指定大小(2M)"),
		/**
		 * 文件只能上传规定格式的
		 */
		fileOnlySuffix(-13,"file only upload .jpg,.png,.docx,.rar,.zip","文件只能上传规定格式的。如.jpg,.png,.docx,.rar,.zip"),
		/**
		 * 文件上传出错
		 */
		fileUploadError(-14,"file upload error","文件上传出错"),
		/**
		 * 文件不存在
		 */
		fileNotExist(-15,"file not exist","文件不存在"),
		
		/**
		 * 用户统一标识不能为空，且长度不能超过29
		 */
		unionidNullity(-16,"unionid nullity","用户统一标识不能为空，且长度只能是29位"),
		/**
		 * 用户统一标识不能为空，且长度不能超过29
		 */
		openidNullity(-17,"openid nullity","普通用户的标识不能为空，且长度只能是28位"),
		/**
		 * 用户昵称不能为空，且长度不能超过45
		 */
		nicknameNullity(-18,"nnickname nullity","用户昵称不能为空，且长度不能超过45位"),
		/**
		 * 性别不能为空，且值只能是1和2
		 */
		sexNullity(-19,"sex nullity","性别不能为空，且值只能是1(男)和2(女)"),
		/**
		 * 省份长度不能超过45
		 */
		provinceNullity(-20,"province nullity","省份长度不能超过45位"),
		/**
		 * 城市长度不能超过45
		 */
		cityNullity(-21,"city nullity","城市长度不能超过45位"),
		
		/**
		 * 国家长度不能超过45
		 */
		countryNullity(-22,"country nullity","国家长度不能超过45位"),
		
		/**
		 * 用户头像不能超过255
		 */
		headimgNullity(-23,"headimg nullity","用户头像不能超过255位"),
		/**
		 * 特权不能超过255
		 */
		privilegeNullity(-24,"privilege nullity","特权不能超过255位"),
		/**
		 * qq的openid不能为空，且长度只能是32位
		 */
		qqOpenidNullity(-25,"qq openid nullity","qq的openid不能为空，且长度只能是32位"),
		/**
		 * qq40*40头像不能为空，且长度只能是32位
		 */
		qqFigureurlNullity(-26,"figureurl_qq_1 nullity","qq40*40头像URL不能为空，且长度不能超过255位"),
		/**
		 * qq40*40头像不能为空，且长度只能是32位
		 */
		qqFigureurl2Nullity(-27,"figureurl_qq_2 nullity","qq100*100头像URL长度不能超过255位"),
		/**
		 * qq空间50*50头像URL长度不能超过255位
		 */
		qqFigureurl3Nullity(-28,"figureurl_qq_3 nullity","qq空间50*50头像URL长度不能超过255位"),
		/**
		 * qq空间100*100头像URL长度不能超过255位
		 */
		qqFigureurl4Nullity(-29,"figureurl_qq_4 nullity","qqq空间100*100头像URL长度不能超过255位"),
		/**
		 * qq空间30*30头像URL长度不能超过255位
		 */
		qqFigureurl5Nullity(-30,"figureurl_qq_5 nullity","qqq空间30*30头像URL长度不能超过255位"),
		/**
		 * 黄钻等级必须为数字
		 */
		yellowVipLevelNullity(-31,"yellow_vip_level nullity","黄钻等级必须为数字"),
		/**
		 * 会员等级必须为数字
		 */
		levelNullity(-32,"level nullity","会员等级必须为数字"),
		/**
		 * 用户名不能为空，且长度不能超过45位
		 */
		usernameNullity(-33,"username nullity","用户名不能为空，且长度不能超过45位"),
		/**
		 * 密码不能为空且长度不能超过32位
		 */
		passwordNullity(-34,"password nullity","密码不能为空且长度不能超过32位"),
		/**
		 * 用户名或密码不正确
		 */
		usernameorPasswordIncorrect(-35,"username or password incorrect","用户名或密码不正确"),
		/**
		 * 登录type只能是0和1
		 */
		loginTypeNullity(-36,"login type nullity","登录方式不正确"),
		/**
		 * 用户不存在
		 */
		userNotExistedNullity(-37,"user not existed","用户不存在"), 
		/**
		 * 用户已存在
		 */
		userExistedNullity(-38,"user existed","用户已存在"), 
		/**
		 * 用户手机未绑定
		 */
		userPhoneInactive(-39,"user phone is inactive","用户手机未绑定"), 
		/**
		 * 服务价格无效
		 */
		servicePriceNullity(-40,"service price nullity","服务价格无效"), 
		/**
		 * 服务名称不能为空，且长度不能超过255位
		 */
		serviceNameNullity(-41,"service name nullity","服务名称不能为空，且长度不能超过255位"), 
		/**
		 * 描述长度不能超过255位
		 */
		descNullity(-42,"summary nullity","描述长度不能超过255位"), 
		/**
		 * 图片id不能为空，只能是数字且长度必须小于等于10位
		 */
		imgidNullity(-43,"img id Nullity","图片id不能为空，只能是数字且长度必须小于等于10位"), 
		/**
		 * 用户id不能为空且只长度只能是10位
		 */
		useridNullity(-44,"userid Nullity","用户id不能为空且只长度只能是10位"), 
		/**
		 * 手机号不能为空且长度只能是11位
		 */
		mobilePhoneNullity(-45,"mobilePhone Nullity","手机号不能为空且长度只能是11位"), 
		/**
		 * 验证码不能为空且长度只能是4位
		 */
		verifyCodeNullity(-46,"verifyCode Nullity","验证码不能为空且长度只能是4位"),
		
		/**
		 * 关键字过长
		 */
		keywordsTooLong(-50,"keywords too long","关键字过长"),
		/**
		 * 类别无效
		 */
		categoryIdNullity(-51,"categoryId nullity","类别无效"),
		/**
		 * 排序无效
		 */
		orderbyNullity(-52,"sort nullity","排序无效"),
		/**
		 * 省市编号无效
		 */
		cityCodeNullity(-53,"city code nullity","省市编号无效"),
		/**
		 * 手机号不能为空，只能是数字且长度不能超过15位
		 */
		phoneNullity(-62,"phone Nullity","手机号不能为空，只能是数字且长度不能超过15位"), 
		/**
		 * 手机号已存在
		 */
		phoneExist(-63,"phone exist","手机号已存在"), 
		
		/**
		 * 评论内容不能为空且长度必须小于等于4000
		 */
		commentContentNullity(-76,"comment Content Nullity","评论内容不能为空且长度必须小于等于4000"),
		/**
		 * 同一用户和手机号不允许重复绑定
		 */
		phoneBindingRepeat(-77,"phone Binding Repeat","同一用户和手机号不允许重复绑定"),
		/**
		 * 手机号已被其他用户绑定
		 */
		phoneAlreadyBindingWithOtherUser(-78,"phone Already Binding With Other User","手机号已被其他用户绑定"),
		/**
		 * 反馈内容不能为空且长度必须小于等于500
		 */
		opinionContentNullity(-79,"opinion Content Nullity","反馈内容不能为空且长度必须小于等于500"),
		/**
		 * 反馈联系方式长度必须小于小于等于255
		 */
		opinionContactNullity(-80,"opinion Contact Nullity","反馈联系方式长度必须小于小于等于255"),
		/**
		 * 无法评论自己的店铺
		 */
		canNotCommentBySelf(-81,"can Not Comment by Self","无法评论自己的店铺"),
		/**
		 * 用户名已存在
		 */
		userNameAlreadyExis(-83,"userName Already Exis","用户名已存在"),
		/**
		 * 版本号无效
		 */
		versionCodeInvalid(-90, "version code invalid", "版本号无效"),
		/**
		 * 密码错误
		 */
		passwordInvalid(-91, "password Invalid", "密码错误"),
		
		/**
		 * 手机号对应的用户不存在
		 */
		phoneUserIsNotExist(-206, "user is not exist", "手机号对应的用户不存在"),
		/**
		 * 银行卡号id无效
		 */
		bankCardIdNullity(-207, "user bank card id nullity", "银行卡号id不能为空，只能是数字且长度必须小于等于10位"),
		/**
		 * 提现失败，记录不存在
		 */
		takeCashFail(-208, "take cash fail", "提现失败，记录不存在"),
		/**
		 * 余额记录不存在
		 */
		balanceNotExist(-209, "balance record not exist", "余额记录不存在"),
		/**
		 * 银行卡记录不存在
		 */
		bankCardNotExist(-210, "bank card record not exist", "银行卡记录不存在"),
		/**
		 * 提现金额无效
		 */
		takeCashMoneyNullity(-211, "take cash money nullity", "提现金额无效,必须是正数"),
		/**
		 * 提现金额不足
		 */
		takeCashMoneyNotEnough(-212, "take cash money not enough", "提现金额不足"),
		/**
		 * 支付密码不正确
		 */
		payPasswordIncorrect(-213, "payPasswordIncorrect", "支付密码不正确"),
		/**
		 * 支付密码不存在
		 */
		payPasswordNotExist(-300, "payPasswordNotExist", "未设置支付密码，请在“钱包管理”中设置支付密码"),
		/**
		 * 支付密码已存在，不能再设置一遍
		 */
		payPasswordForbidSet(-214, "pay password forbid set", "已有支付密码，禁止设置支付密码"),
		/**
		 * 支付密码输入错误超过限制次数
		 */
		payPasswordErrorOverLimit(-215, "pay password incorrect count over limit", "您当天支付密码输入错误已超过5次，请明天再提现"),
		
		/**
		 * 银行卡类型无效
		 */
		bankCardTypeNullity(-216, "user bank card type nullity", "银行卡类型无效"),
		/**
		 * 银行卡户名无效
		 */
		bankCardNameNullity(-217, "user bank card accountName nullity", "银行卡户名不能为空且长度不能超过255"),
		/**
		 * 银行卡号无效
		 */
		bankCardNoNullity(-217, "user bank card NO nullity", "银行卡号不能为空且长度不能超过19位"),
		/**
		 * 银行卡联系方式
		 */
		bankCardLinkNullity(-217, "user bank card link type nullity", "银行卡联系方式长度不能超过15位"),
		
		/**
		 * 订单id无效
		 */
		orderIdNullity(-400, "order id is nullity", "订单id无效"),
		/**
		 * 订单不存在
		 */
		orderNotExist(-401, "order is not exist", "订单不存在"),
		/**
		 * 订单不能取消
		 */
		orderCannotCancel(-402, "orderCannotCancel", "订单不能取消"),
		/**
		 * 订单不能取消，已超过最后确认回报方式时间
		 */
		orderCannotCancelOverTime(-702, "orderCannotCancelOverTime", "领活猪的订单不能取消，订单已超过规定时间"),
		/**
		 * 订单不能确认收货
		 */
		orderCannotConfirmReceive(-402, "orderCannotConfirmReceive", "只有待收货的订单才能确认收货"),
		/**
		 * 订单不能删除
		 */
		orderCannotDelete(-402, "order can not delete", "只有取消和已完成的订单才能删除"),
		/**
		 * 已付款的订单要24小时后才能取消
		 */
		orderPayedOnly24HoursCancel(-403, "order can be canceled after 24 hours", "已付款的订单要24小时后才能申请退款"),
		/**
		 * 订单不能支付，已过支付时间
		 */
		orderCannotPayOverTime(-403, "orderCannotPayOverTime", "订单已过有效支付时间"),
		/**
		 * 订单不能付款
		 */
		orderCannotPay(-404, "order can not pay", "只有未付款的订单才能付款"),
		/**
		 * 金额无效
		 */
		moneyNullity(-404, "money is nullity", "金额不能为空且只能是正数"),
		/**
		 * 余额不足，不能支付
		 */
		moneyNotEnough(-405, "money not enough", "余额不足"),
		/**
		 * 订单数据错误
		 */
		orderDataError(-406, "order is not yours", "请确认当前订单是否属于您"),
		/**
		 * 两次密码输入不一致
		 */
		payPasswordNotSame(-407, "set password is not same", "两次密码输入不一致"),
		/**
		 * 密码无效
		 */
		payPasswordNullity(-408, "pay password is nullity", "支付密码不能为空，长度为6位"),
		/**
		 * 新密码无效
		 */
		payPasswordNewNullity(-409, "new pay password is nullity", "新支付密码不能为空，且为6位数字"),
		/**
		 * 确认密码无效
		 */
		payPasswordConfirmNullity(-410, "confirm pay password is nullity", "确认支付密码不能为空，且为6位数字"),
		/**
		 * 数据异常
		 */
		dataErrorAccessAgain(-450, "dataErrorAccessAgain", "获取当前用户openid失败，请重新进入公众号，即可完成支付"),
		/**
		 * 消息内容无效
		 */
		messageContentNullity(-452, "message content is nullity", "消息内容不能为空，且长度不能超过255位"),
		/**
		 * 订单只能是待服务状态才能去服务
		 */
		orderCanServiceOnly(-453, "order can service only limit status", "订单只能是待服务状态才能去服务"),
		
		/**
		 * 抢购id不能为空且只长度只能是10位
		 */
		projectidNullity(-500,"projectidNullity","抢购id不能为空且只长度只能是10位"),
		/**
		 * 抢购数量无效
		 */
		purchaseNumNullity(-501,"purchaseNumNullity","抢购数量无效"),
		/**
		 * 已售完
		 */
		saleOverNullity(-502,"saleOverNullity","很抱歉，当前抢购已售完"),
		/**
		 * 数量不足
		 */
		saleNumNotEnough(-503,"saleNumNotEnough","数量不足"),
		/**
		 * 备注无效
		 */
		remarkNullity(-504,"remarkNullity","备注不能超过200个字符"),
		/**
		 * 回报类型无效
		 */
		rewardsTypeNullity(-505,"rewardsTypeNullity","回报类型无效，只能是1~4之间"),
		/**
		 * 分割方式无效
		 */
		divisionTypeNullity(-506,"divisionTypeNullity","分割方式无效"),
		/**
		 * 分割方式明细无效
		 */
		divisionTypeDetailNullity(-506,"divisionTypeDetailNullity","分割方式无效"),
		/**
		 * 包装方式无效
		 */
		packageSpecNullity(-507,"packageSpecNullity","包装方式无效，只能是1或2"),
		/**
		 * 配置项不存在
		 */
		configDataNotExist(-508,"configDataNotExist","配置项不存在"),
		/**
		 * 粗分割配置项不存在
		 */
		thickFeeConfigNullity(-509,"thickFeeConfigNullity","粗分割配置项不存在"),
		/**
		 * 细分割配置项不存在
		 */
		thinFeeConfigNullity(-510,"thinFeeConfigNullity","细分割配置项不存在"),
		/**
		 * 包装费配置项不存在
		 */
		packageFeeConfigNullity(-511,"packageFeeConfigNullity","包装费配置项不存在"),
		/**
		 * 同意类型无效
		 */
		agreeTypeNullity(-512,"agreeTypeNullity","同意类型无效，只能是1同意或2不同意"),
		
		/**
		 * 文件路径没有设置
		 */
		filePathNotExist(-600,"filePathNotExist","文件路径不存在"),
		/**
		 * 文件类型参数值无效
		 */
		fileTypeNullity(-601,"fileTypeNullity","文件类型参数值无效"),
		/**
		 * 文件上传配置项没有配置
		 */
		fileUploadConfigNoExist(-602,"fileUploadConfigNoExist","文件上传配置项没有配置"),
		/**
		 * 该好友已添加
		 */
		freindsIsAlreadyAdd(-603,"freindsIsAlreadyAdd","该好友已添加"),
		/**
		 * 数量无效
		 */
		numNullity(-604,"numNullity","数量无效"),
		/**
		 * 好友id无效
		 */
		freindsIdNullity(-605,"freindsIdNullity","好友id无效"),
		/**
		 * 未找到您参与的抢购
		 */
		myJoinedProjectNotExist(-605,"myJoinedProjectNotExist","未找到您参与的抢购"),
		/**
		 * 您的猪仔数量不足
		 */
		pigNumNotEnought(-606,"pigNumNotEnought","您的猪仔数量不足，请重新填写数量"),
		
		/**
		 * 不存在该好友
		 */
		freindsNotExist(-607,"freindsNotExist","不存在该好友"),
		/**
		 * 该用户不是您的好友
		 */
		userIsNotYourFreinds(-607,"userIsNotYourFreinds","该用户不是您的好友"),
		/**
		 * 已超过时限，不能赠送好友猪仔
		 */
		cannotSendPigOverTime(-608,"cannotSendPigOverTime","已超过时限，不能赠送好友猪仔"),
		/**
		 * 券id无效
		 */
		couponIdNullity(-609,"couponIdNullity","券id无效"),
		/**
		 * 券不存在
		 */
		couponNotExist(-610,"couponNotExist","券不存在"),
		/**
		 * 券已过期
		 */
		couponIsOverTime(-611,"couponIsOverTime","券已过期"),
		/**
		 * 券的余额不足
		 */
		couponLeftMoneyNotEnought(-612,"couponLeftMoneyNotEnought","券的余额不足"),
		/**
		 * 已超过时限，不能修改回报方式
		 */
		cannotModifyRepayType(-613,"cannotModifyRepayType","已超过时限，不能修改回报方式"),
		/**
		 * 回报已处理，不能再修改
		 */
		repayAlreadyDealed(-614,"repayAlreadyDealed","回报已处理，不能再修改"),
		/**
		 * 已存在屠宰生成的订单，请手动取消订单后再修改回报方式
		 */
		cannotModifyRepayTypeBeforeCancelOrder(-615,"cannotModifyRepayTypeBeforeCancelOrder","已存在由屠宰配送/领活猪生成的订单，请手动取消订单后再修改回报方式"),
		
		/**
		 * 收货地址id无效
		 */
		addressIdNullity(-616,"addressIdNullity","收货地址id无效"),
		/**
		 * 收货地址不存在
		 */
		addressNotExist(-617,"addressNotExist","收货地址不存在"),
		/**
		 * 设置类型无效
		 */
		settingTypeNullity(-618,"settingTypeNullity","设置类型无效"),
		
		/**
		 * 回报已处理，不能再赠送猪仔
		 */
		cannotSendPigDealed(-619,"cannotSendPigDealed","回报已处理，不能再赠送猪仔"),
		
		/**
		 * 当前期剩余1头猪不能赠送
		 */
		pigNumNotSendOnlyOne(-620,"pigNumNotSendOnlyOne","当前期剩余1头猪不能赠送"),
		/**
		 * 邀请码无效
		 */
		inviteCodeNullity(-700,"inviteCodeNullity","邀请码无效"),
		/**
		 * 不能抢购，请现将已生成的屠宰配送/领活猪的订单取消掉之后再抢购
		 */
		cannotBuyPleaseCancelOrder(-701,"cannotBuyPleaseCancelOrder","不能抢购，请现将已生成的屠宰配送/领活猪的订单取消掉之后再抢购"),
		
		/**
		 * 用户/好友赠送猪仔的当期已生成了订单，不能赠送
		 */
		cannotSendPigCauseCreateOrder(-702,"cannotSendPigCauseCreateOrder","不能赠送，您或您的好友该期已生成屠宰订单或领活猪订单，请先取消后再赠送"),
		/**
		 * 请求微信授权access_token异常
		 */
		getAccessTokenFail(-1000,"getAccessTokenFail","请求微信授权access_token异常，请重新进入"),
		/**
		 * 请求微信获取当前用户资料信息异常
		 */
		getUserByWxFail(-1001,"getUserByWxFail","请求微信获取当前用户资料信息异常，请重新进入"),
		/**
		 * 请求微信access_token和openid同时未能获取到
		 */
		getAccessTokenAndOpenIdByWxFail(-1002,"getAccessTokenAndOpenIdByWxFail","请求微信access_token和openid同时未能获取到，请重新进入"),
		/**
		 * 统一支付接口获取预支付订单失败
		 */
		getWxPreOrderCodeFail(-2000,"getWxPreOrderCodeFail","统一支付接口获取预支付订单失败，请重新请求支付"),
		
		/**
		 * 请求微信支付失败
		 */
		requestWxPayFail(-2001,"requestWxPayFail","请求微信支付失败，请重新请求"),
		/**
		 * 请求微信支付失败
		 */
		requestAlipayPayFail(-2002,"requestWxPayFail","请求支付宝支付失败，请重新请求"),
		/**
		 * 请求萤石服务器获取时间戳失败
		 */
		requestYSGetTimeFail(-3000,"requestYSGetTimeFail","请求萤石服务器获取时间戳失败，请重新请求"),
		/**
		 * 请求萤石服务器获取视频列表失败
		 */
		requestYSVedioListFail(-3001,"requestYSVedioListFail","请求萤石服务器获取视频列表失败，请重新请求"),
		/**
		 * 
		 */
		addressCountOver(-3002,"addressCountOver","保存失败,最多只能保存10个地址"),
		;
		
		//状态码
		private int status;
		//状态描述文本
		private String code;
		//状态中文提示
		private String msg;
		
		public int getStatus()
		{
			return status;
		}

		public String getCode()
		{
			return code;
		}
		public String getMsg()
		{
			return msg;
		}
		public void setMsg(String msg)
		{
			this.msg = msg;
		}

		Status(int status,String code,String msg)
		{
			this.status=status;
			this.code=code;
			this.msg=msg;
		}
		
		//获取msg
        public static String getMsg(int index) {
            for (Status s : Status.values()) {
                if (s.getStatus() == index) {
                    return s.getMsg();
                }
            }
            return null;
        }
        //获取status
        public static Status getStatus(int index) {
        	for (Status s : Status.values()) {
        		if (s.getStatus() == index) {
        			return s;
        		}
        	}
        	return null;
        }
	}
	
	/* 失败全是非正数 */

}
