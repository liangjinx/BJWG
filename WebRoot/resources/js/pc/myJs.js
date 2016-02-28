/**
 * Created by Administrator on 2015/9/17.
 */

(function() {
    var lastTime = 0;
    var vendors = ['webkit', 'moz'];
    for(var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
        window.requestAnimationFrame = window[vendors[x]+'RequestAnimationFrame'];
        window.cancelAnimationFrame =
            window[vendors[x]+'CancelAnimationFrame'] || window[vendors[x]+'CancelRequestAnimationFrame'];
    }

    if (!window.requestAnimationFrame)
        window.requestAnimationFrame = function(callback, element) {
            var currTime = new Date().getTime();
            var timeToCall = Math.max(0, 16 - (currTime - lastTime));
            var id = window.setTimeout(function() { callback(currTime + timeToCall); },
                timeToCall);
            lastTime = currTime + timeToCall;
            return id;
        };

    if (!window.cancelAnimationFrame)
        window.cancelAnimationFrame = function(id) {
            clearTimeout(id);
        };
}());

$(function () {
    var
        $win = $(window),
		win_width  = $('.piggery').width(),
        win_heigth = $('.piggery').height();
        //win_width  = $win.width(),
        //win_heigth = $win.height();

    // 生成随机数
    function random (min, max) {
        if (max == null) {
            max = min;
            min = 0;
        }
        return min + Math.floor(Math.random() * (max - min + 1));
    };

    // 猪类
    var Pigkin = function (opts) {
        if (!(this instanceof Pigkin)) {
            return new Pigkin(opts);
        }

        this.options = opts;
        this.sx = (Math.random() - 0.5) > 0 ? 0.4 : -0.4;
//        this.sx = (Math.random() - 0.5) > 0 ? 1 : -1;
        this.sy = Math.random() * 0.5;
        this.sayMsg = ['不要问我什么是猪肉串儿','要么瘦，要么死，猪生好为难','育种是什么羞羞的事儿'];


        this.init();
    };

    // 猪的初始化
    Pigkin.prototype.init = function () {
        this.setup();
    };

    // 猪的设置
    Pigkin.prototype.setup = function () {
        this.build();
        this.start();
    };

    Pigkin.prototype.toggleDirection = function () {
        if (this.sx > 0) {
            this.$pig.removeClass('pig_lt').addClass('pig_rt');
        } else {
            this.$pig.removeClass('pig_rt').addClass('pig_lt');
        }
    };

    // 创建猪
    Pigkin.prototype.build = function () {
        var self = this,
            $pig = $('<div class="pig_box"><div class="pig"></div><div class="pigsay"></div></div>');

        this.$pig = $pig;
        this.toggleDirection();

        $pig.appendTo($('.piggery')); //猪活动的区域类名



        this.max_width = win_width - $pig.width(); /*获取并计算浏览器初始宽度*/
        this.max_height = win_heigth - $pig.height(); /*获取并计算浏览器初始高度*/
        this.initLeft = this._left = parseInt(Math.random() * this.max_width) + 1; /*默认left距离0-100*/
        this.initTop = this._top = parseInt(Math.random() * this.max_height) + 1; /*默认top距离0-100*/

        this.$pig.css({
            top: this._top + 'px',
            left: this._left + 'px'
        });

    };

    // 让猪动起来，才是活猪
    Pigkin.prototype.start = function () {
        this.animate();
        this.drag();
        //this.say();
    };

    // 边界检测
    Pigkin.prototype.edges = function () {
        var self = this;

        if (this._top >= this.max_height) {
            this._top = this.max_height;
			
			if (this._left >= this.max_width || this._left <= 0) {
				
				this.sy = -this.sy;
			}
			//this.sy = -this.sy;
            
        } else if (this._top <= 0) {
            this._top = 0;
			
            if (this._left >= this.max_width || this._left <= 0) {
				
				this.sy = -this.sy;
			}
			//this.sy = -this.sy;
        }

        if (this._left >= this.max_width) {
            this._left = this.max_width;
            this.sx = -this.sx;
        } else if (this._left <= 0) {
            this._left = 0;
            this.sx = -this.sx;
        }

        this._top += this.sy;
        this._left += this.sx;

        // 变换方向
        this.toggleDirection();
    };

    // 猪在走，你信吗？
    Pigkin.prototype.animate = function () {
        var self = this,
            proxy = $.proxy(this.animate, this);
		
		window.cancelAnimationFrame( self.timer );
        this.timer = window.requestAnimationFrame(proxy);
        this.edges();

        this.$pig.animate({
            left: this._left,
            top: this._top
        }, 1)

    };

    // 可爱猪,你可以摸一摸，拖一拖
    Pigkin.prototype.drag = function () {
        var x, y,
            self = this,
            $pig = self.$pig,
			_zIndex = 100;
		
		var $dragPig = $pig.draggabilly();
		
		$dragPig.on('dragStart', function () {
			window.cancelAnimationFrame( self.timer );
		})
		
		$dragPig.on('dragMove', function( event, pointer, moveVector ){
			$( this ).css({
				zIndex: _zIndex
			});
		});
		
		$dragPig.on('dragEnd', function () {
			$( this ).css({
				zIndex: 0
			});
			self.animate();
		})

    };

    // 猪在跟你说话
    Pigkin.prototype.say = function () {
        var self = this,
            total = self.sayMsg.length;

        if (!total) return;

        // 显示状态语函数
        var showSay = function (msg, callback) {
            //self.$pig.append('<div class="pigsay">' + msg + '</div>');
            self.$pig.find('.pigsay').html( msg ).addClass('visible');

            callback && callback();
        };

        // 移除状态语函数
        var hideSay = function () {
            //self.$pig.find('.pigsay').remove();
            self.$pig.find('.pigsay').html( '' ).removeClass('visible');
        };

        // 状态语处理函数
        var sayHandle = function () {
            var i = 0;

            // 切换状态语
            var changSayMsg = function () {

                if (i >= total) {
                    return say();
                }

                // 显示状态语后的回调函数
                var callbackShowSay = function () {
                    setTimeout(function () {
                        hideSay();
                        //(i < total) ? setTimeout(changSayMsg, 6 * 1000) : changSayMsg();
                        (i < total) ? setTimeout(changSayMsg, 6 * 1000) : say();
                    }, 6 * 1000);
                };

                // 显示状态语
                showSay(self.sayMsg[i++], callbackShowSay);
                //i++;

            };

            changSayMsg();

        };

        // 猪也会说话了
        var say = function () {
            setTimeout(sayHandle, random(5,20) * 1000);
        };

        say();



    };
	
	/*
    function createPig(num) {
        var num = num || 1,
			result = [];

        do {
            result.push(Pigkin());
        } while (--num)
		
		return result;
    }
	*/
	
	// 创建猪的数量
	function CreatePig(num) {
		if (!(this instanceof CreatePig)) {
			return new CreatePig(num);
		}
		
		if ((num && (typeof num !== 'number') || num < 0)) {
			console.log('Initialize an error in the number of pigs, "' + num + '" is not a number type or lt 0.');
			return
		}
		
		this.num = num || 1;
		this.result = [];

		this.init = function () {
			var num = this.num,
				result = this.result;
				
			do {
				result.push(Pigkin());
			} while (--num)
				
			this.randomPigSay();
		}
		
		this.getPig = function (i) {
			if (i && typeof i === 'number') {
				return this.result[i];
			}
			
			return this.result;
		}
		
		// 随机生成说话的猪
		this.randomPigSay = function () {
			var aPigs = this.result,
				iPigs = aPigs.length,
				i = 1;
				
			
			if (iPigs >= 10) {
				i = 3;
			} else if (iPigs >= 5) {
				i = 2;
			}
			
			do {
				aPigs[ Math.floor(Math.random() * iPigs) ].say();
			} while (--i);
			
		}
		
		this.init();
		
    }
	
    //$win[0].createPig = createPig;
    $win[0].CreatePig = CreatePig;

});