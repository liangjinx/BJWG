//滚动图片构造函数
function ScrollPic(scrollContId,arrLeftId,arrRightId,dotListId,listType){
  
  this.scrollContId = scrollContId; //内容容器ID
  this.arrLeftId = arrLeftId; //左箭头ID
  this.arrRightId = arrRightId; //右箭头ID
  this.dotListId = dotListId; //点列表ID
  this.listType = listType; //列表类型

  this.dotClassName   = "dotItem";//点className
  this.dotOnClassName   = "dotItemOn";//当前点className
  this.dotObjArr = [];
  this.listEvent = "onclick";
  this.circularly = true; //循环滚动（无缝循环）
  
  this.pageWidth = 0; //翻页宽度
  this.frameWidth = 0; //显示框宽度
  this.speed = 10; //移动速度(单位毫秒，越小越快)
  this.space = 10; //每次移动像素(单位px，越大越快)
  this.scrollWidth = 5; //横向滚动宽度
  
  this.upright = false; //垂直的滚动
  
  this.pageIndex = 0;
  
  this.autoPlay = true;
  this.autoPlayTime = 3; //秒
  
  this._autoTimeObj;
  this._scrollTimeObj;
  this._state = "ready"; // ready | floating | stoping
  
  
  this.stripDiv = document.createElement("DIV");
  
  
  this.lDiv01 = document.createElement("DIV");
  this.lDiv02 = document.createElement("DIV");
};
ScrollPic.prototype = {
  version : "1.41",
  author : "mengjia",
  pageLength : 0,
  touch : true,
  initialize : function(){ //初始化
    var thisTemp = this;
    if(!this.scrollContId){
      throw new Error("必须指定scrollContId.");
      return;
    };
    this.scDiv = this.$(this.scrollContId);
    if(!this.scDiv){
      throw new Error("scrollContId不是正确的对象.(scrollContId = \""+ this.scrollContId +"\")");
      return;
    };
    
    this.scDiv.style[this.upright?'height':'width'] = this.frameWidth + "px";
    this.scDiv.style.overflow = "hidden";
    
    //HTML
    this.lDiv01.innerHTML = this.scDiv.innerHTML;
    this.scDiv.innerHTML = "";
    this.scDiv.appendChild(this.stripDiv);
    this.stripDiv.appendChild(this.lDiv01);
    if(this.circularly){//无缝循环
      this.stripDiv.appendChild(this.lDiv02);
      this.lDiv02.innerHTML = this.lDiv01.innerHTML
    };
    
    
    this.stripDiv.style.overflow = "hidden";
    this.stripDiv.style.zoom = "1";
    this.stripDiv.style[this.upright?'height':'width'] = "32766px";
    
    if(!this.upright){  
      this.lDiv01.style.cssFloat = "left";
      this.lDiv01.style.styleFloat = "left";
      this.lDiv01.style.overflow = "hidden";
    };
    this.lDiv01.style.zoom = "1";
    if(this.circularly && !this.upright){ //无缝循环设置CSS
      this.lDiv02.style.cssFloat = "left";
      this.lDiv02.style.styleFloat = "left";
      this.lDiv02.style.overflow = "hidden";
    };
    this.lDiv02.style.zoom = "1";
    
    this.addEvent(this.scDiv,"mouseover",function(){thisTemp.stop()});
    this.addEvent(this.scDiv,"mouseout",function(){thisTemp.play()});
    
    //Arrowhead event
    //left
    if(this.arrLeftId){
      this.alObj = this.$(this.arrLeftId);
      if(this.alObj){
        this.addEvent(this.alObj,"mousedown",function(){thisTemp.rightMouseDown()});
        this.addEvent(this.alObj,"mouseup",function(){thisTemp.rightEnd()});
        this.addEvent(this.alObj,"mouseout",function(){thisTemp.rightEnd()});
      };
    };
    //right
    if(this.arrRightId){
      this.arObj = this.$(this.arrRightId);
      if(this.arObj){
        this.addEvent(this.arObj,"mousedown",function(){thisTemp.leftMouseDown()});
        this.addEvent(this.arObj,"mouseup",function(){thisTemp.leftEnd()});
        this.addEvent(this.arObj,"mouseout",function(){thisTemp.leftEnd()});
      };
    };
    
    var pages = Math.ceil(this.lDiv01[this.upright?'offsetHeight':'offsetWidth'] / this.frameWidth),i,tempObj;
    this.pageLength = pages;
    //dot
    if(this.dotListId){
      this.dotListObj = this.$(this.dotListId);
      this.dotListObj.innerHTML = "";
      if(this.dotListObj){
        
        for(i=0;i<pages;i++){
          tempObj = document.createElement("span");
          this.dotListObj.appendChild(tempObj);
          this.dotObjArr.push(tempObj);
          
          if(i==this.pageIndex){
            tempObj.className = this.dotOnClassName;
          }else{
            tempObj.className = this.dotClassName;
          };
          if(this.listType == 'number'){
            tempObj.innerHTML = i+1;
          }else if(typeof (this.listType) =='string' ){
            tempObj.innerHTML = this.listType;
          }else {
            tempObj.innerHTML='';
          };
          tempObj.title = "第" + (i+1) + "页";
          tempObj.num = i;
          tempObj[this.listEvent] = function(){thisTemp.pageTo(this.num)};
        };
      };
    };
    this.scDiv[this.upright?'scrollTop':'scrollLeft'] = 0;
    //autoPlay
    if(this.autoPlay){this.play()};
    
    this._scroll = this.upright?'scrollTop':'scrollLeft';
    this._sWidth = this.upright?'scrollHeight':'scrollWidth';
    
    if(typeof(this.onpagechange) === 'function'){
      this.onpagechange();
    };
    
    this.iPad();
  },
  leftMouseDown : function(){
    if(this._state != "ready"){return};
    var thisTemp = this;
    this._state = "floating";
    clearInterval(this._scrollTimeObj);
    this.moveLeft();
    this._scrollTimeObj = setInterval(function(){thisTemp.moveLeft()},this.speed);
  },
  rightMouseDown : function(){
    if(this._state != "ready"){return};
    var thisTemp = this;
    this._state = "floating";
    clearInterval(this._scrollTimeObj);
    this.moveRight();
    this._scrollTimeObj = setInterval(function(){thisTemp.moveRight()},this.speed);
  },
  moveLeft : function(){
    if(this.circularly){ //无缝循环
      if(this.scDiv[this._scroll] + this.space >= this.lDiv01[this._sWidth]){
        this.scDiv[this._scroll] = this.scDiv[this._scroll] + this.space - this.lDiv01[this._sWidth];
      }else{
        this.scDiv[this._scroll] += this.space;
      };
    }else{
      if(this.scDiv[this._scroll] + this.space >= this.lDiv01[this._sWidth] - this.frameWidth){
        this.scDiv[this._scroll] = this.lDiv01[this._sWidth] - this.frameWidth;
        //停
        this.leftEnd();
      }else{
        this.scDiv[this._scroll] += this.space;
      };
    };
    this.accountPageIndex();
  },
  moveRight : function(){
    if(this.circularly){ //无缝循环
      if(this.scDiv[this._scroll] - this.space <= 0){
        
        this.scDiv[this._scroll] = this.lDiv01[this._sWidth] + this.scDiv[this._scroll] - this.space;
      }else{
        this.scDiv[this._scroll] -= this.space;
      };
    }else{
      if(this.scDiv[this._scroll] - this.space <= 0){
        this.scDiv[this._scroll] = 0;
        //停
        this.rightEnd();
      }else{
        this.scDiv[this._scroll] -= this.space;
      };
    };
    this.accountPageIndex();
  },
  leftEnd : function(){
    if(this._state != "floating" && this._state != 'touch'){return};
    this._state = "stoping";
    clearInterval(this._scrollTimeObj);
    
    var fill = this.pageWidth - this.scDiv[this._scroll] % this.pageWidth;
    this.move(fill);
  },
  rightEnd : function(){
    if(this._state != "floating" && this._state != 'touch'){return};
    this._state = "stoping";
    clearInterval(this._scrollTimeObj);
    
    var fill = - this.scDiv[this._scroll] % this.pageWidth;
    
    this.move(fill);
  },
  move : function(num,quick){
    var thisTemp = this;
    var thisMove = num/5;
    var theEnd = false;
    if(!quick){
      if(thisMove > this.space){thisMove = this.space};
      if(thisMove < -this.space){thisMove = -this.space};
    };
    
    if(Math.abs(thisMove)<1 && thisMove!=0){
      thisMove = thisMove>=0?1:-1;
    }else{
      thisMove = Math.round(thisMove);
    };
    
    var temp = this.scDiv[this._scroll] + thisMove;
    
    if(thisMove>0){
      if(this.circularly){ //无缝循环
        if(this.scDiv[this._scroll] + thisMove >= this.lDiv01[this._sWidth]){
          this.scDiv[this._scroll] = this.scDiv[this._scroll] + thisMove - this.lDiv01[this._sWidth];
        }else{
          this.scDiv[this._scroll] += thisMove;
        };
      }else{
        if(this.scDiv[this._scroll] + thisMove >= this.lDiv01[this._sWidth] - this.frameWidth){
          this.scDiv[this._scroll] = this.lDiv01[this._sWidth] - this.frameWidth;
          this._state = "ready";
          theEnd = true;
          //return;
        }else{
          this.scDiv[this._scroll] += thisMove;
        };
      };
    }else{
      if(this.circularly){ //无缝循环
        if(this.scDiv[this._scroll] + thisMove < 0){
          this.scDiv[this._scroll] = this.lDiv01[this._sWidth] + this.scDiv[this._scroll] + thisMove;
        }else{
          this.scDiv[this._scroll] += thisMove;
        };
      }else{
        if(this.scDiv[this._scroll] - thisMove < 0){
          this.scDiv[this._scroll] = 0;
          this._state = "ready";
          theEnd = true;
          //return;
        }else{
          this.scDiv[this._scroll] += thisMove;
        };
      };
    };
    
    if(typeof(this.onpagechange) === 'function'){
      this.onpagechange();
    };
    
    if(theEnd){
      return;
    };
    
    num -= thisMove;
    if(Math.abs(num) == 0){
      this._state = "ready";
      if(this.autoPlay){this.play()};
      this.accountPageIndex();
      return;
    }else{
      this.accountPageIndex();
      this._scrollTimeObj = setTimeout(function(){thisTemp.move(num,quick)},this.speed)
    };
    
  },
  pre : function(){
    if(this._state != "ready"){return};
    this._state = "stoping";
    this.pageTo(this.pageIndex - 1);
  },
  next : function(reStar){
    if(this._state != "ready"){return};
    this._state = "stoping";
    if(this.circularly){
      this.pageTo(this.pageIndex + 1);
    }else{
      if(this.scDiv[this._scroll] >= this.lDiv01[this._sWidth] - this.frameWidth){
        this._state = "ready";
        if(reStar){this.pageTo(0)};
      }else{
        this.pageTo(this.pageIndex + 1);
      };
    };
  },
  play : function(){
    var thisTemp = this;
    if(!this.autoPlay){return};
    clearInterval(this._autoTimeObj);
    this._autoTimeObj = setInterval(function(){thisTemp.next(true)},this.autoPlayTime * 1000);
  },
  stop : function(){
    clearInterval(this._autoTimeObj);
  },
  pageTo : function(num){
    if(this.pageIndex == num){return};
    if(num < 0){num = this.pageLength - 1};
    clearTimeout(this._scrollTimeObj);
    this._state = "stoping";
    var fill = num * this.frameWidth - this.scDiv[this._scroll];
    this.move(fill,true);
  },
  accountPageIndex : function(){
    var pageIndex = Math.floor(this.scDiv[this._scroll] / this.frameWidth);
    if(pageIndex == this.pageIndex){return};
    this.pageIndex = pageIndex;
    
    if(this.pageIndex > Math.floor(this.lDiv01[this.upright?'offsetHeight':'offsetWidth'] / this.frameWidth )){this.pageIndex = 0};
	if(typeof(this.onnowpage) === 'function'){
		this.onnowpage(this.pageIndex);
	}
    var i;
	//alert(this.pageIndex);
    for(i=0;i<this.dotObjArr.length;i++){
      if(i==this.pageIndex){
		  
        this.dotObjArr[i].className = this.dotOnClassName;
      }else{
        this.dotObjArr[i].className = this.dotClassName;
      };
    };

    if(typeof(this.onpagechange) === 'function'){
      this.onpagechange();
    };
  },
  
  iPadX : 0,
  iPadLastX : 0,
  iPadStatus : 'ok',
  iPad : function(){
    if(typeof(window.ontouchstart) === 'undefined'){ //不支持触屏
      return;  
    };
    if(!this.touch){return};
    
    var tempThis = this;
    this.addEvent(this.scDiv,'touchstart',function(e){tempThis._touchstart(e)});
    this.addEvent(this.scDiv,'touchmove',function(e){tempThis._touchmove(e)});
    this.addEvent(this.scDiv,'touchend',function(e){tempThis._touchend(e)});
  },
  _touchstart : function(e){
    //if(this._state != "ready"){return};
    //this._state = 'touch';
    this.stop();
    this.iPadX = e.touches[0].pageX;
    this.iPadScrollX = window.pageXOffset;
    this.iPadScrollY = window.pageYOffset; //用于判断页面是否滚动
    this.scDivScrollLeft = this.scDiv[this._scroll];
  },
  _touchmove : function(e){
    if(e.touches.length > 1){ //多点触摸
      this.iPadStatus = 'ok';
      return;
    };
    this.iPadLastX = e.touches[0].pageX;
    var cX = this.iPadX - this.iPadLastX;
    if(this.iPadStatus == 'ok'){
      if(this.iPadScrollY == window.pageYOffset && this.iPadScrollX == window.pageXOffset && Math.abs(cX)>this.scrollWidth){ //横向触摸
        this.iPadStatus = 'touch';
      }else{
        return;
      };
    };
    this._state = 'touch';
    var scrollNum = this.scDivScrollLeft + cX;
    
    if(scrollNum >= this.lDiv01[this._sWidth]){
      scrollNum = scrollNum - this.lDiv01[this._sWidth];
    };
    if(scrollNum < 0){
      scrollNum = scrollNum + this.lDiv01[this._sWidth];
    };
    this.scDiv[this._scroll] = scrollNum;
    e.preventDefault();
  },
  _touchend : function(e){
    if(this.iPadStatus != 'touch'){return};
    this.iPadStatus = 'ok';
    //this._state = 'ready';
    var cX = this.iPadX - this.iPadLastX;
    if(cX<0){
      this.rightEnd();
    }else{
      this.leftEnd();
    };
    this.play();
  },
  $ : function(objName){if(document.getElementById){return eval('document.getElementById("'+objName+'")')}else{return eval('document.all.'+objName)}},
  isIE : navigator.appVersion.indexOf("MSIE")!=-1?true:false,
  
  //Event
  addEvent : function(obj,eventType,func){if(obj.attachEvent){obj.attachEvent("on" + eventType,func);}else{obj.addEventListener(eventType,func,false)}},
  delEvent : function(obj,eventType,func){
    if(obj.detachEvent){obj.detachEvent("on" + eventType,func)}else{obj.removeEventListener(eventType,func,false)}
  },
  //Cookie
  readCookie : function(l){var i="",I=l+"=";if(document.cookie.length>0){var offset=document.cookie.indexOf(I);if(offset!=-1){offset+=I.length;var end=document.cookie.indexOf(";",offset);if(end==-1)end=document.cookie.length;i=unescape(document.cookie.substring(offset,end))}};return i},
  
  writeCookie : function(O,o,l,I){var i="",c="";if(l!=null){i=new Date((new Date).getTime()+l*3600000);i="; expires="+i.toGMTString()};if(I!=null){c=";domain="+I};document.cookie=O+"="+escape(o)+i+c},
  //Style
  readStyle:function(i,I){if(i.style[I]){return i.style[I]}else if(i.currentStyle){return i.currentStyle[I]}else if(document.defaultView&&document.defaultView.getComputedStyle){var l=document.defaultView.getComputedStyle(i,null);return l.getPropertyValue(I)}else{return null}}
};





/*
 * Swiper 2.7.0
*/
	!
function() {
    "use strict";
    function e(e) {
        e.fn.swiper = function(a) {
            var t;
            return e(this).each(function() {
                var e = new Swiper(this, a);
                t || (t = e)
            }),
            t
        }
    }
    window.Swiper = function(e, t) {
        function r() {
            return "horizontal" === h.params.direction
        }
        function s() {
            h.autoplayTimeoutId = setTimeout(function() {
                h.params.loop ? (h.fixLoop(), h._slideNext()) : h.isEnd ? t.autoplayStopOnLast ? h.stopAutoplay() : h._slideTo(0) : h._slideNext()
            },
            h.params.autoplay)
        }
        function i(e, a) {
            var t = f(e.target);
            if (!t.is(a)) if ("string" == typeof a) t = t.parents(a);
            else if (a.nodeType) {
                var r;
                return t.parents().each(function(e, t) {
                    t === a && (r = a)
                }),
                r ? a: void 0
            }
            return 0 === t.length ? void 0: t[0]
        }
        function n(e, a) {
            a = a || {};
            var t = window.MutationObserver || window.WebkitMutationObserver,
            r = new t(function(e) {
                e.forEach(function(e) {
                    h.onResize(),
                    h.params.onObserverUpdate && h.params.onObserverUpdate(h, e)
                })
            });
            r.observe(e, {
                attributes: "undefined" == typeof a.attributes ? !0: a.attributes,
                childList: "undefined" == typeof a.childList ? !0: a.childList,
                characterData: "undefined" == typeof a.characterData ? !0: a.characterData
            }),
            h.observers.push(r)
        }
        function o(e) {
            e.originalEvent && (e = e.originalEvent);
            var a = e.keyCode || e.charCode;
            if (! (e.shiftKey || e.altKey || e.ctrlKey || e.metaKey || document.activeElement && document.activeElement.nodeName && ("input" === document.activeElement.nodeName.toLowerCase() || "textarea" === document.activeElement.nodeName.toLowerCase()))) {
                if (37 === a || 39 === a || 38 === a || 40 === a) {
                    var t = !1;
                    if (h.container.parents(".swiper-slide").length > 0 && 0 === h.container.parents(".swiper-slide-active").length) return;
                    for (var s = {
                        left: window.pageXOffset,
                        top: window.pageYOffset
                    },
                    i = window.innerWidth, n = window.innerHeight, o = h.container.offset(), l = [[o.left, o.top], [o.left + h.width, o.top], [o.left, o.top + h.height], [o.left + h.width, o.top + h.height]], d = 0; d < l.length; d++) {
                        var p = l[d];
                        p[0] >= s.left && p[0] <= s.left + i && p[1] >= s.top && p[1] <= s.top + n && (t = !0)
                    }
                    if (!t) return
                }
                r() ? ((37 === a || 39 === a) && (e.preventDefault ? e.preventDefault() : e.returnValue = !1), 39 === a && h.slideNext(), 37 === a && h.slidePrev()) : ((38 === a || 40 === a) && (e.preventDefault ? e.preventDefault() : e.returnValue = !1), 40 === a && h.slideNext(), 38 === a && h.slidePrev())
            }
        }
        function l(e) {
            e.originalEvent && (e = e.originalEvent);
            var a = h._wheelEvent,
            t = 0;
            if (e.detail) t = -e.detail;
            else if ("mousewheel" === a) if (h.params.mousewheelForceToAxis) if (r()) {
                if (! (Math.abs(e.wheelDeltaX) > Math.abs(e.wheelDeltaY))) return;
                t = e.wheelDeltaX
            } else {
                if (! (Math.abs(e.wheelDeltaY) > Math.abs(e.wheelDeltaX))) return;
                t = e.wheelDeltaY
            } else t = e.wheelDelta;
            else if ("DOMMouseScroll" === a) t = -e.detail;
            else if ("wheel" === a) if (h.params.mousewheelForceToAxis) if (r()) {
                if (! (Math.abs(e.deltaX) > Math.abs(e.deltaY))) return;
                t = -e.deltaX
            } else {
                if (! (Math.abs(e.deltaY) > Math.abs(e.deltaX))) return;
                t = -e.deltaY
            } else t = Math.abs(e.deltaX) > Math.abs(e.deltaY) ? -e.deltaX: -e.deltaY;
            if (h.params.freeMode) {
                var s = h.getWrapperTranslate() + t;
                if (s > 0 && (s = 0), s < h.maxTranslate() && (s = h.maxTranslate()), h.setWrapperTransition(0), h.setWrapperTranslate(s), h.updateProgress(), h.updateActiveIndex(), 0 === s || s === h.maxTranslate()) return
            } else(new Date).getTime() - h._lastWheelScrollTime > 60 && (0 > t ? h.slideNext() : h.slidePrev()),
            h._lastWheelScrollTime = (new Date).getTime();
            return h.params.autoplay && h.stopAutoplay(),
            e.preventDefault ? e.preventDefault() : e.returnValue = !1,
            !1
        }
        function d(e, a) {
            e = f(e);
            var t,
            s,
            i,
            n,
            o;
            t = e.attr("data-swiper-parallax"),
            s = e.attr("data-swiper-parallax-x"),
            i = e.attr("data-swiper-parallax-y"),
            s || i || !t ? (s = s ? s: "0", i = i ? i: "0") : r() ? (s = t, i = "0") : (i = t, s = "0"),
            s = s.indexOf("%") >= 0 ? parseInt(s, 10) * a + "%": s * a + "px",
            i = i.indexOf("%") >= 0 ? parseInt(i, 10) * a + "%": i * a + "px",
            n = s,
            o = i,
            e.transform("translate3d(" + n + ", " + o + ",0px)")
        }
        var p = {
            direction: "horizontal",
            touchEventsTarget: "container",
            initialSlide: 0,
            speed: 300,
            autoplay: !1,
            autoplayDisableOnInteraction: !0,
            freeMode: !1,
            freeModeMomentum: !0,
            freeModeMomentumRatio: 1,
            freeModeMomentumBounce: !0,
            freeModeMomentumBounceRatio: 1,
            effect: "slide",
            coverflow: {
                rotate: 50,
                stretch: 0,
                depth: 100,
                modifier: 1,
                slideShadows: !0
            },
            cube: {
                slideShadows: !0,
                shadow: !0,
                shadowOffset: 20,
                shadowScale: .94
            },
            fade: {
                crossFade: !1
            },
            parallax: !1,
            scrollbar: null,
            scrollbarHide: !0,
            keyboardControl: !1,
            mousewheelControl: !1,
            mousewheelForceToAxis: !1,
            hashnav: !1,
            spaceBetween: 0,
            slidesPerView: 1,
            slidesPerColumn: 1,
            slidesPerColumnFill: "column",
            slidesPerGroup: 1,
            centeredSlides: !1,
            touchRatio: 1,
            touchAngle: 45,
            simulateTouch: !0,
            shortSwipes: !0,
            longSwipes: !0,
            longSwipesRatio: .5,
            longSwipesMs: 300,
            followFinger: !0,
            onlyExternal: !1,
            threshold: 0,
            touchMoveStopPropagation: !0,
            pagination: null,
            paginationClickable: !1,
            paginationHide: !1,
            paginationBulletRender: null,
            resistance: !0,
            resistanceRatio: .85,
            nextButton: null,
            prevButton: null,
            watchSlidesProgress: !1,
            watchSlidesVisibility: !1,
            grabCursor: !1,
            preventClicks: !0,
            preventClicksPropagation: !0,
            slideToClickedSlide: !1,
            lazyLoading: !1,
            lazyLoadingInPrevNext: !1,
            lazyLoadingOnTransitionStart: !1,
            preloadImages: !0,
            updateOnImagesReady: !0,
            loop: !1,
            loopAdditionalSlides: 0,
            loopedSlides: null,
            control: void 0,
            controlInverse: !1,
            allowSwipeToPrev: !0,
            allowSwipeToNext: !0,
            swipeHandler: null,
            noSwiping: !0,
            noSwipingClass: "swiper-no-swiping",
            slideClass: "swiper-slide",
            slideActiveClass: "swiper-slide-active",
            slideVisibleClass: "swiper-slide-visible",
            slideDuplicateClass: "swiper-slide-duplicate",
            slideNextClass: "swiper-slide-next",
            slidePrevClass: "swiper-slide-prev",
            wrapperClass: "swiper-wrapper",
            bulletClass: "swiper-pagination-bullet",
            bulletActiveClass: "swiper-pagination-bullet-active",
            buttonDisabledClass: "swiper-button-disabled",
            paginationHiddenClass: "swiper-pagination-hidden",
            observer: !1,
            observeParents: !1,
            runCallbacksOnInit: !0
        };
        t = t || {};
        for (var u in p) if ("undefined" == typeof t[u]) t[u] = p[u];
        else if ("object" == typeof t[u]) for (var c in p[u])"undefined" == typeof t[u][c] && (t[u][c] = p[u][c]);
        var h = this;
        h.params = t;
        var f;
        if (f = "undefined" == typeof a ? window.Dom7 || window.Zepto || window.jQuery: a, f && (h.container = f(e), 0 !== h.container.length)) {
            if (h.container.length > 1) return void h.container.each(function() {
                new Swiper(this, t)
            });
            h.container[0].swiper = h,
            h.container.data("swiper", h),
            h.container.addClass("swiper-container-" + h.params.direction),
            h.params.freeMode && h.container.addClass("swiper-container-free-mode"),
            (h.params.parallax || h.params.watchSlidesVisibility) && (h.params.watchSlidesProgress = !0),
            ["cube", "coverflow"].indexOf(h.params.effect) >= 0 && (h.support.transforms3d ? (h.params.watchSlidesProgress = !0, h.container.addClass("swiper-container-3d")) : h.params.effect = "slide"),
            "slide" !== h.params.effect && h.container.addClass("swiper-container-" + h.params.effect),
            "cube" === h.params.effect && (h.params.resistanceRatio = 0, h.params.slidesPerView = 1, h.params.slidesPerColumn = 1, h.params.slidesPerGroup = 1, h.params.centeredSlides = !1, h.params.spaceBetween = 0),
            "fade" === h.params.effect && (h.params.watchSlidesProgress = !0, h.params.spaceBetween = 0),
            h.params.grabCursor && h.support.touch && (h.params.grabCursor = !1),
            h.wrapper = h.container.children("." + h.params.wrapperClass),
            h.params.pagination && (h.paginationContainer = f(h.params.pagination), h.params.paginationClickable && h.paginationContainer.addClass("swiper-pagination-clickable")),
            h.rtl = r() && ("rtl" === h.container[0].dir.toLowerCase() || "rtl" === h.container.css("direction")),
            h.rtl && h.container.addClass("swiper-container-rtl"),
            h.rtl && (h.wrongRTL = "-webkit-box" === h.wrapper.css("display")),
            h.translate = 0,
            h.progress = 0,
            h.velocity = 0,
            h.lockSwipeToNext = function() {
                h.params.allowSwipeToNext = !1
            },
            h.lockSwipeToPrev = function() {
                h.params.allowSwipeToPrev = !1
            },
            h.lockSwipes = function() {
                h.params.allowSwipeToNext = h.params.allowSwipeToPrev = !1
            },
            h.unlockSwipeToNext = function() {
                h.params.allowSwipeToNext = !0
            },
            h.unlockSwipeToPrev = function() {
                h.params.allowSwipeToPrev = !0
            },
            h.unlockSwipes = function() {
                h.params.allowSwipeToNext = h.params.allowSwipeToPrev = !0
            },
            h.params.slidesPerColumn > 1 && h.container.addClass("swiper-container-multirow"),
            h.params.grabCursor && (h.container[0].style.cursor = "move", h.container[0].style.cursor = "-webkit-grab", h.container[0].style.cursor = "-moz-grab", h.container[0].style.cursor = "grab"),
            h.imagesToLoad = [],
            h.imagesLoaded = 0,
            h.loadImage = function(e, a, t, r) {
                function s() {
                    r && r()
                }
                var i;
                e.complete && t ? s() : a ? (i = new Image, i.onload = s, i.onerror = s, i.src = a) : s()
            },
            h.preloadImages = function() {
                function e() {
                    "undefined" != typeof h && null !== h && (void 0 !== h.imagesLoaded && h.imagesLoaded++, h.imagesLoaded === h.imagesToLoad.length && (h.params.updateOnImagesReady && h.update(), h.params.onImagesReady && h.params.onImagesReady(h)))
                }
                h.imagesToLoad = h.container.find("img");
                for (var a = 0; a < h.imagesToLoad.length; a++) h.loadImage(h.imagesToLoad[a], h.imagesToLoad[a].currentSrc || h.imagesToLoad[a].getAttribute("src"), !0, e)
            },
            h.autoplayTimeoutId = void 0,
            h.autoplaying = !1,
            h.autoplayPaused = !1,
            h.startAutoplay = function() {
                return "undefined" != typeof h.autoplayTimeoutId ? !1: h.params.autoplay ? h.autoplaying ? !1: (h.autoplaying = !0, h.params.onAutoplayStart && h.params.onAutoplayStart(h), void s()) : !1
            },
            h.stopAutoplay = function() {
                h.autoplayTimeoutId && (h.autoplayTimeoutId && clearTimeout(h.autoplayTimeoutId), h.autoplaying = !1, h.autoplayTimeoutId = void 0, h.params.onAutoplayStop && h.params.onAutoplayStop(h))
            },
            h.pauseAutoplay = function(e) {
                h.autoplayPaused || (h.autoplayTimeoutId && clearTimeout(h.autoplayTimeoutId), h.autoplayPaused = !0, 0 === e ? (h.autoplayPaused = !1, s()) : h.wrapper.transitionEnd(function() {
                    h.autoplayPaused = !1,
                    h.autoplaying ? s() : h.stopAutoplay()
                }))
            },
            h.minTranslate = function() {
                return - h.snapGrid[0]
            },
            h.maxTranslate = function() {
                return - h.snapGrid[h.snapGrid.length - 1]
            },
            h.updateContainerSize = function() {
                h.width = h.container[0].clientWidth,
                h.height = h.container[0].clientHeight,
                h.size = r() ? h.width: h.height
            },
            h.updateSlidesSize = function() {
                h.slides = h.wrapper.children("." + h.params.slideClass),
                h.snapGrid = [],
                h.slidesGrid = [],
                h.slidesSizesGrid = [];
                var e,
                a = h.params.spaceBetween,
                t = 0,
                s = 0,
                i = 0;
                "string" == typeof a && a.indexOf("%") >= 0 && (a = parseFloat(a.replace("%", "")) / 100 * h.size),
                h.virtualWidth = -a,
                h.slides.css(h.rtl ? {
                    marginLeft: "",
                    marginTop: ""
                }: {
                    marginRight: "",
                    marginBottom: ""
                });
                var n;
                h.params.slidesPerColumn > 1 && (n = Math.floor(h.slides.length / h.params.slidesPerColumn) === h.slides.length / h.params.slidesPerColumn ? h.slides.length: Math.ceil(h.slides.length / h.params.slidesPerColumn) * h.params.slidesPerColumn);
                var o;
                for (e = 0; e < h.slides.length; e++) {
                    o = 0;
                    var l = h.slides.eq(e);
                    if (h.params.slidesPerColumn > 1) {
                        var d,
                        p,
                        u,
                        c,
                        f = h.params.slidesPerColumn;
                        "column" === h.params.slidesPerColumnFill ? (p = Math.floor(e / f), u = e - p * f, d = p + u * n / f, l.css({
                            "-webkit-box-ordinal-group": d,
                            "-moz-box-ordinal-group": d,
                            "-ms-flex-order": d,
                            "-webkit-order": d,
                            order: d
                        })) : (c = n / f, u = Math.floor(e / c), p = e - u * c),
                        l.css({
                            "margin-top": 0 !== u && h.params.spaceBetween && h.params.spaceBetween + "px"
                        }).attr("data-swiper-column", p).attr("data-swiper-row", u)
                    }
                    "none" !== l.css("display") && ("auto" === h.params.slidesPerView ? o = r() ? l.outerWidth(!0) : l.outerHeight(!0) : (o = (h.size - (h.params.slidesPerView - 1) * a) / h.params.slidesPerView, r() ? h.slides[e].style.width = o + "px": h.slides[e].style.height = o + "px"), h.slides[e].swiperSlideSize = o, h.slidesSizesGrid.push(o), h.params.centeredSlides ? (t = t + o / 2 + s / 2 + a, 0 === e && (t = t - h.size / 2 - a), Math.abs(t) < .001 && (t = 0), i % h.params.slidesPerGroup === 0 && h.snapGrid.push(t), h.slidesGrid.push(t)) : (i % h.params.slidesPerGroup === 0 && h.snapGrid.push(t), h.slidesGrid.push(t), t = t + o + a), h.virtualWidth += o + a, s = o, i++)
                }
                h.virtualWidth = Math.max(h.virtualWidth, h.size);
                var m;
                if (h.rtl && h.wrongRTL && ("slide" === h.params.effect || "coverflow" === h.params.effect) && h.wrapper.css({
                    width: h.virtualWidth + h.params.spaceBetween + "px"
                }), h.params.slidesPerColumn > 1 && (h.virtualWidth = (o + h.params.spaceBetween) * n, h.virtualWidth = Math.ceil(h.virtualWidth / h.params.slidesPerColumn) - h.params.spaceBetween, h.wrapper.css({
                    width: h.virtualWidth + h.params.spaceBetween + "px"
                }), h.params.centeredSlides)) {
                    for (m = [], e = 0; e < h.snapGrid.length; e++) h.snapGrid[e] < h.virtualWidth + h.snapGrid[0] && m.push(h.snapGrid[e]);
                    h.snapGrid = m
                }
                if (!h.params.centeredSlides) {
                    for (m = [], e = 0; e < h.snapGrid.length; e++) h.snapGrid[e] <= h.virtualWidth - h.size && m.push(h.snapGrid[e]);
                    h.snapGrid = m,
                    Math.floor(h.virtualWidth - h.size) > Math.floor(h.snapGrid[h.snapGrid.length - 1]) && h.snapGrid.push(h.virtualWidth - h.size)
                }
                0 === h.snapGrid.length && (h.snapGrid = [0]),
                0 !== h.params.spaceBetween && h.slides.css(r() ? h.rtl ? {
                    marginLeft: a + "px"
                }: {
                    marginRight: a + "px"
                }: {
                    marginBottom: a + "px"
                }),
                h.params.watchSlidesProgress && h.updateSlidesOffset()
            },
            h.updateSlidesOffset = function() {
                for (var e = 0; e < h.slides.length; e++) h.slides[e].swiperSlideOffset = r() ? h.slides[e].offsetLeft: h.slides[e].offsetTop
            },
            h.updateSlidesProgress = function(e) {
                if ("undefined" == typeof e && (e = h.translate || 0), 0 !== h.slides.length) {
                    "undefined" == typeof h.slides[0].swiperSlideOffset && h.updateSlidesOffset();
                    var a = h.params.centeredSlides ? -e + h.size / 2: -e;
                    h.rtl && (a = h.params.centeredSlides ? e - h.size / 2: e); {
                        h.container[0].getBoundingClientRect(),
                        r() ? "left": "top",
                        r() ? "right": "bottom"
                    }
                    h.slides.removeClass(h.params.slideVisibleClass);
                    for (var t = 0; t < h.slides.length; t++) {
                        var s = h.slides[t],
                        i = h.params.centeredSlides === !0 ? s.swiperSlideSize / 2: 0,
                        n = (a - s.swiperSlideOffset - i) / (s.swiperSlideSize + h.params.spaceBetween);
                        if (h.params.watchSlidesVisibility) {
                            var o = -(a - s.swiperSlideOffset - i),
                            l = o + h.slidesSizesGrid[t],
                            d = o >= 0 && o < h.size || l > 0 && l <= h.size || 0 >= o && l >= h.size;
                            d && h.slides.eq(t).addClass(h.params.slideVisibleClass)
                        }
                        s.progress = h.rtl ? -n: n
                    }
                }
            },
            h.updateProgress = function(e) {
                "undefined" == typeof e && (e = h.translate || 0);
                var a = h.maxTranslate() - h.minTranslate();
                0 === a ? (h.progress = 0, h.isBeginning = h.isEnd = !0) : (h.progress = (e - h.minTranslate()) / a, h.isBeginning = h.progress <= 0, h.isEnd = h.progress >= 1),
                h.isBeginning && h.params.onReachBeginning && h.params.onReachBeginning(h),
                h.isEnd && h.params.onReachEnd && h.params.onReachEnd(h),
                h.params.watchSlidesProgress && h.updateSlidesProgress(e),
                h.params.onProgress && h.params.onProgress(h, h.progress)
            },
            h.updateActiveIndex = function() {
                var e,
                a,
                t,
                r = h.rtl ? h.translate: -h.translate;
                for (a = 0; a < h.slidesGrid.length; a++)"undefined" != typeof h.slidesGrid[a + 1] ? r >= h.slidesGrid[a] && r < h.slidesGrid[a + 1] - (h.slidesGrid[a + 1] - h.slidesGrid[a]) / 2 ? e = a: r >= h.slidesGrid[a] && r < h.slidesGrid[a + 1] && (e = a + 1) : r >= h.slidesGrid[a] && (e = a); (0 > e || "undefined" == typeof e) && (e = 0),
                t = Math.floor(e / h.params.slidesPerGroup),
                t >= h.snapGrid.length && (t = h.snapGrid.length - 1),
                e !== h.activeIndex && (h.snapIndex = t, h.previousIndex = h.activeIndex, h.activeIndex = e, h.updateClasses())
            },
            h.updateClasses = function() {
                h.slides.removeClass(h.params.slideActiveClass + " " + h.params.slideNextClass + " " + h.params.slidePrevClass);
                var e = h.slides.eq(h.activeIndex);
                if (e.addClass(h.params.slideActiveClass), e.next("." + h.params.slideClass).addClass(h.params.slideNextClass), e.prev("." + h.params.slideClass).addClass(h.params.slidePrevClass), h.bullets && h.bullets.length > 0) {
                    h.bullets.removeClass(h.params.bulletActiveClass);
                    var a;
                    h.params.loop ? (a = h.activeIndex - h.loopedSlides, a > h.slides.length - 1 - 2 * h.loopedSlides && (a -= h.slides.length - 2 * h.loopedSlides)) : a = "undefined" != typeof h.snapIndex ? h.snapIndex: h.activeIndex || 0,
                    h.bullets.eq(a).addClass(h.params.bulletActiveClass)
                }
                h.params.loop || (h.params.prevButton && (h.isBeginning ? f(h.params.prevButton).addClass(h.params.buttonDisabledClass) : f(h.params.prevButton).removeClass(h.params.buttonDisabledClass)), h.params.nextButton && (h.isEnd ? f(h.params.nextButton).addClass(h.params.buttonDisabledClass) : f(h.params.nextButton).removeClass(h.params.buttonDisabledClass)))
            },
            h.updatePagination = function() {
                if (h.params.pagination && h.paginationContainer && h.paginationContainer.length > 0) {
                    for (var e = "", a = h.params.loop ? h.slides.length - 2 * h.loopedSlides: h.snapGrid.length, t = 0; a > t; t++) e += h.params.paginationBulletRender ? h.params.paginationBulletRender(t, h.params.bulletClass) : '<span class="' + h.params.bulletClass + '"></span>';
                    h.paginationContainer.html(e),
                    h.bullets = h.paginationContainer.find("." + h.params.bulletClass)
                }
            },
            h.update = function(e) {
                function a() {
                    r = Math.min(Math.max(h.translate, h.maxTranslate()), h.minTranslate()),
                    h.setWrapperTranslate(r),
                    h.updateActiveIndex(),
                    h.updateClasses()
                }
                if (h.updateContainerSize(), h.updateSlidesSize(), h.updateProgress(), h.updatePagination(), h.updateClasses(), h.params.scrollbar && h.scrollbar && h.scrollbar.set(), e) {
                    var t,
                    r;
                    h.params.freeMode ? a() : (t = "auto" === h.params.slidesPerView && h.isEnd && !h.params.centeredSlides ? h.slideTo(h.slides.length - 1, 0, !1, !0) : h.slideTo(h.activeIndex, 0, !1, !0), t || a())
                }
            },
            h.onResize = function() {
                if (h.updateContainerSize(), h.updateSlidesSize(), h.updateProgress(), ("auto" === h.params.slidesPerView || h.params.freeMode) && h.updatePagination(), h.params.scrollbar && h.scrollbar && h.scrollbar.set(), h.params.freeMode) {
                    var e = Math.min(Math.max(h.translate, h.maxTranslate()), h.minTranslate());
                    h.setWrapperTranslate(e),
                    h.updateActiveIndex(),
                    h.updateClasses()
                } else h.updateClasses(),
                "auto" === h.params.slidesPerView && h.isEnd && !h.params.centeredSlides ? h.slideTo(h.slides.length - 1, 0, !1, !0) : h.slideTo(h.activeIndex, 0, !1, !0)
            };
            var m = ["mousedown", "mousemove", "mouseup"];
            window.navigator.pointerEnabled ? m = ["pointerdown", "pointermove", "pointerup"] : window.navigator.msPointerEnabled && (m = ["MSPointerDown", "MSPointerMove", "MSPointerUp"]),
            h.touchEvents = {
                start: h.support.touch || !h.params.simulateTouch ? "touchstart": m[0],
                move: h.support.touch || !h.params.simulateTouch ? "touchmove": m[1],
                end: h.support.touch || !h.params.simulateTouch ? "touchend": m[2]
            },
            (window.navigator.pointerEnabled || window.navigator.msPointerEnabled) && ("container" === h.params.touchEventsTarget ? h.container: h.wrapper).addClass("swiper-wp8-" + h.params.direction),
            h.events = function(e) {
                var a = e ? "off": "on",
                r = e ? "removeEventListener": "addEventListener",
                s = "container" === h.params.touchEventsTarget ? h.container[0] : h.wrapper[0],
                i = h.support.touch ? s: document,
                n = h.params.nested ? !0: !1;
                h.browser.ie ? (s[r](h.touchEvents.start, h.onTouchStart, !1), i[r](h.touchEvents.move, h.onTouchMove, n), i[r](h.touchEvents.end, h.onTouchEnd, !1)) : (h.support.touch && (s[r](h.touchEvents.start, h.onTouchStart, !1), s[r](h.touchEvents.move, h.onTouchMove, n), s[r](h.touchEvents.end, h.onTouchEnd, !1)), !t.simulateTouch || h.device.ios || h.device.android || (s[r]("mousedown", h.onTouchStart, !1), i[r]("mousemove", h.onTouchMove, n), i[r]("mouseup", h.onTouchEnd, !1))),
                window[r]("resize", h.onResize),
                h.params.nextButton && f(h.params.nextButton)[a]("click", h.onClickNext),
                h.params.prevButton && f(h.params.prevButton)[a]("click", h.onClickPrev),
                h.params.pagination && h.params.paginationClickable && f(h.paginationContainer)[a]("click", "." + h.params.bulletClass, h.onClickIndex),
                (h.params.preventClicks || h.params.preventClicksPropagation) && s[r]("click", h.preventClicks, !0)
            },
            h.attachEvents = function() {
                h.events()
            },
            h.detachEvents = function() {
                h.events(!0)
            },
            h.allowClick = !0,
            h.preventClicks = function(e) {
                h.allowClick || (h.params.preventClicks && e.preventDefault(), h.params.preventClicksPropagation && (e.stopPropagation(), e.stopImmediatePropagation()))
            },
            h.onClickNext = function(e) {
                e.preventDefault(),
                h.slideNext()
            },
            h.onClickPrev = function(e) {
                e.preventDefault(),
                h.slidePrev()
            },
            h.onClickIndex = function(e) {
                e.preventDefault();
                var a = f(this).index() * h.params.slidesPerGroup;
                h.params.loop && (a += h.loopedSlides),
                h.slideTo(a)
            },
            h.updateClickedSlide = function(e) {
                var a = i(e, "." + h.params.slideClass);
                if (!a) return h.clickedSlide = void 0,
                void(h.clickedIndex = void 0);
                if (h.clickedSlide = a, h.clickedIndex = f(a).index(), h.params.slideToClickedSlide && void 0 !== h.clickedIndex && h.clickedIndex !== h.activeIndex) {
                    var t,
                    r = h.clickedIndex;
                    if (h.params.loop) if (t = f(h.clickedSlide).attr("data-swiper-slide-index"), r > h.slides.length - h.params.slidesPerView) h.fixLoop(),
                    r = h.wrapper.children("." + h.params.slideClass + '[data-swiper-slide-index="' + t + '"]').eq(0).index(),
                    setTimeout(function() {
                        h.slideTo(r)
                    },
                    0);
                    else if (r < h.params.slidesPerView - 1) {
                        h.fixLoop();
                        var s = h.wrapper.children("." + h.params.slideClass + '[data-swiper-slide-index="' + t + '"]');
                        r = s.eq(s.length - 1).index(),
                        setTimeout(function() {
                            h.slideTo(r)
                        },
                        0)
                    } else h.slideTo(r);
                    else h.slideTo(r)
                }
            };
            var g,
            v,
            w,
            T,
            b,
            x,
            y,
            S,
            C,
            M = "input, select, textarea, button",
            E = Date.now(),
            P = [];
            h.animating = !1,
            h.touches = {
                startX: 0,
                startY: 0,
                currentX: 0,
                currentY: 0,
                diff: 0
            };
            var z;
            if (h.onTouchStart = function(e) {
                if (e.originalEvent && (e = e.originalEvent), z = "touchstart" === e.type, z || !("which" in e) || 3 !== e.which) {
                    if (h.params.noSwiping && i(e, "." + h.params.noSwipingClass)) return void(h.allowClick = !0);
                    if (!h.params.swipeHandler || i(e, h.params.swipeHandler)) {
                        if (g = !0, v = !1, T = void 0, h.touches.startX = h.touches.currentX = "touchstart" === e.type ? e.targetTouches[0].pageX: e.pageX, h.touches.startY = h.touches.currentY = "touchstart" === e.type ? e.targetTouches[0].pageY: e.pageY, w = Date.now(), h.allowClick = !0, h.updateContainerSize(), h.swipeDirection = void 0, h.params.threshold > 0 && (y = !1), "touchstart" !== e.type) {
                            var a = !0;
                            f(e.target).is(M) && (a = !1),
                            document.activeElement && f(document.activeElement).is(M) && document.activeElement.blur(),
                            a && e.preventDefault()
                        }
                        h.params.onTouchStart && h.params.onTouchStart(h, e)
                    }
                }
            },
            h.onTouchMove = function(e) {
                if (e.originalEvent && (e = e.originalEvent), !(z && "mousemove" === e.type || e.preventedByNestedSwiper)) {
                    if (h.params.onlyExternal) return v = !0,
                    void(h.allowClick = !1);
                    if (z && document.activeElement && e.target === document.activeElement && f(e.target).is(M)) return v = !0,
                    void(h.allowClick = !1);
                    if (h.params.onTouchMove && h.params.onTouchMove(h, e), h.allowClick = !1, !(e.targetTouches && e.targetTouches.length > 1)) {
                        if (h.touches.currentX = "touchmove" === e.type ? e.targetTouches[0].pageX: e.pageX, h.touches.currentY = "touchmove" === e.type ? e.targetTouches[0].pageY: e.pageY, "undefined" == typeof T) {
                            var a = 180 * Math.atan2(Math.abs(h.touches.currentY - h.touches.startY), Math.abs(h.touches.currentX - h.touches.startX)) / Math.PI;
                            T = r() ? a > h.params.touchAngle: 90 - a > h.params.touchAngle
                        }
                        if (T && h.params.onTouchMoveOpposite && h.params.onTouchMoveOpposite(h, e), g) {
                            if (T) return void(g = !1);
                            h.params.onSliderMove && h.params.onSliderMove(h, e),
                            e.preventDefault(),
                            h.params.touchMoveStopPropagation && !h.params.nested && e.stopPropagation(),
                            v || (t.loop && h.fixLoop(), x = "cube" === h.params.effect ? (h.rtl ? -h.translate: h.translate) || 0: h.getWrapperTranslate(), h.setWrapperTransition(0), h.animating && h.wrapper.trigger("webkitTransitionEnd transitionend oTransitionEnd MSTransitionEnd msTransitionEnd"), h.params.autoplay && h.autoplaying && (h.params.autoplayDisableOnInteraction ? h.stopAutoplay() : h.pauseAutoplay()), C = !1, h.params.grabCursor && (h.container[0].style.cursor = "move", h.container[0].style.cursor = "-webkit-grabbing", h.container[0].style.cursor = "-moz-grabbin", h.container[0].style.cursor = "grabbing")),
                            v = !0;
                            var s = h.touches.diff = r() ? h.touches.currentX - h.touches.startX: h.touches.currentY - h.touches.startY;
                            s *= h.params.touchRatio,
                            h.rtl && (s = -s),
                            h.swipeDirection = s > 0 ? "prev": "next",
                            b = s + x;
                            var i = !0;
                            if (s > 0 && b > h.minTranslate() ? (i = !1, h.params.resistance && (b = h.minTranslate() - 1 + Math.pow( - h.minTranslate() + x + s, h.params.resistanceRatio))) : 0 > s && b < h.maxTranslate() && (i = !1, h.params.resistance && (b = h.maxTranslate() + 1 - Math.pow(h.maxTranslate() - x - s, h.params.resistanceRatio))), i && (e.preventedByNestedSwiper = !0), !h.params.allowSwipeToNext && "next" === h.swipeDirection && x > b && (b = x), !h.params.allowSwipeToPrev && "prev" === h.swipeDirection && b > x && (b = x), h.params.followFinger) {
                                if (h.params.threshold > 0) {
                                    if (! (Math.abs(s) > h.params.threshold || y)) return void(b = x);
                                    if (!y) return y = !0,
                                    h.touches.startX = h.touches.currentX,
                                    h.touches.startY = h.touches.currentY,
                                    b = x,
                                    void(h.touches.diff = r() ? h.touches.currentX - h.touches.startX: h.touches.currentY - h.touches.startY)
                                } (h.params.freeMode || h.params.watchSlidesProgress) && h.updateActiveIndex(),
                                h.params.freeMode && (0 === P.length && P.push({
                                    position: h.touches[r() ? "startX": "startY"],
                                    time: w
                                }), P.push({
                                    position: h.touches[r() ? "currentX": "currentY"],
                                    time: (new Date).getTime()
                                })),
                                h.updateProgress(b),
                                h.setWrapperTranslate(b)
                            }
                        }
                    }
                }
            },
            h.onTouchEnd = function(e) {
                if (e.originalEvent && (e = e.originalEvent), h.params.onTouchEnd && h.params.onTouchEnd(h, e), g) {
                    h.params.grabCursor && v && g && (h.container[0].style.cursor = "move", h.container[0].style.cursor = "-webkit-grab", h.container[0].style.cursor = "-moz-grab", h.container[0].style.cursor = "grab");
                    var a = Date.now(),
                    t = a - w;
                    if (h.allowClick && (h.updateClickedSlide(e), h.params.onTap && h.params.onTap(h, e), 300 > t && a - E > 300 && (S && clearTimeout(S), S = setTimeout(function() {
                        h && (h.params.paginationHide && h.paginationContainer.length > 0 && !f(e.target).hasClass(h.params.bulletClass) && h.paginationContainer.toggleClass(h.params.paginationHiddenClass), h.params.onClick && h.params.onClick(h, e))
                    },
                    300)), 300 > t && 300 > a - E && (S && clearTimeout(S), h.params.onDoubleTap && h.params.onDoubleTap(h, e))), E = Date.now(), setTimeout(function() {
                        h && h.allowClick && (h.allowClick = !0)
                    },
                    0), !g || !v || !h.swipeDirection || 0 === h.touches.diff || b === x) return void(g = v = !1);
                    g = v = !1;
                    var r;
                    if (r = h.params.followFinger ? h.rtl ? h.translate: -h.translate: -b, h.params.freeMode) {
                        if (r < -h.minTranslate()) return void h.slideTo(h.activeIndex);
                        if (r > -h.maxTranslate()) return void h.slideTo(h.slides.length - 1);
                        if (h.params.freeModeMomentum) {
                            if (P.length > 1) {
                                var s = P.pop(),
                                i = P.pop(),
                                n = s.position - i.position,
                                o = s.time - i.time;
                                h.velocity = n / o,
                                h.velocity = h.velocity / 2,
                                Math.abs(h.velocity) < .02 && (h.velocity = 0),
                                (o > 150 || (new Date).getTime() - s.time > 300) && (h.velocity = 0)
                            } else h.velocity = 0;
                            P.length = 0;
                            var l = 1e3 * h.params.freeModeMomentumRatio,
                            d = h.velocity * l,
                            p = h.translate + d;
                            h.rtl && (p = -p);
                            var u,
                            c = !1,
                            m = 20 * Math.abs(h.velocity) * h.params.freeModeMomentumBounceRatio;
                            p < h.maxTranslate() && (h.params.freeModeMomentumBounce ? (p + h.maxTranslate() < -m && (p = h.maxTranslate() - m), u = h.maxTranslate(), c = !0, C = !0) : p = h.maxTranslate()),
                            p > h.minTranslate() && (h.params.freeModeMomentumBounce ? (p - h.minTranslate() > m && (p = h.minTranslate() + m), u = h.minTranslate(), c = !0, C = !0) : p = h.minTranslate()),
                            0 !== h.velocity && (l = Math.abs(h.rtl ? ( - p - h.translate) / h.velocity: (p - h.translate) / h.velocity)),
                            h.params.freeModeMomentumBounce && c ? (h.updateProgress(u), h.setWrapperTransition(l), h.setWrapperTranslate(p), h.onTransitionStart(), h.animating = !0, h.wrapper.transitionEnd(function() {
                                C && (h.params.onMomentumBounce && h.params.onMomentumBounce(h), h.setWrapperTransition(h.params.speed), h.setWrapperTranslate(u), h.wrapper.transitionEnd(function() {
                                    h.onTransitionEnd()
                                }))
                            })) : h.velocity ? (h.updateProgress(p), h.setWrapperTransition(l), h.setWrapperTranslate(p), h.onTransitionStart(), h.animating || (h.animating = !0, h.wrapper.transitionEnd(function() {
                                h.onTransitionEnd()
                            }))) : h.updateProgress(p),
                            h.updateActiveIndex()
                        }
                        return void((!h.params.freeModeMomentum || t >= h.params.longSwipesMs) && (h.updateProgress(), h.updateActiveIndex()))
                    }
                    var T,
                    y = 0,
                    M = h.slidesSizesGrid[0];
                    for (T = 0; T < h.slidesGrid.length; T += h.params.slidesPerGroup)"undefined" != typeof h.slidesGrid[T + h.params.slidesPerGroup] ? r >= h.slidesGrid[T] && r < h.slidesGrid[T + h.params.slidesPerGroup] && (y = T, M = h.slidesGrid[T + h.params.slidesPerGroup] - h.slidesGrid[T]) : r >= h.slidesGrid[T] && (y = T, M = h.slidesGrid[h.slidesGrid.length - 1] - h.slidesGrid[h.slidesGrid.length - 2]);
                    var z = (r - h.slidesGrid[y]) / M;
                    if (t > h.params.longSwipesMs) {
                        if (!h.params.longSwipes) return void h.slideTo(h.activeIndex);
                        "next" === h.swipeDirection && h.slideTo(z >= h.params.longSwipesRatio ? y + h.params.slidesPerGroup: y),
                        "prev" === h.swipeDirection && h.slideTo(z > 1 - h.params.longSwipesRatio ? y + h.params.slidesPerGroup: y)
                    } else {
                        if (!h.params.shortSwipes) return void h.slideTo(h.activeIndex);
                        "next" === h.swipeDirection && h.slideTo(y + h.params.slidesPerGroup),
                        "prev" === h.swipeDirection && h.slideTo(y)
                    }
                }
            },
            h._slideTo = function(e, a) {
                return h.slideTo(e, a, !0, !0)
            },
            h.slideTo = function(e, a, t, s) {
                "undefined" == typeof t && (t = !0),
                "undefined" == typeof e && (e = 0),
                0 > e && (e = 0),
                h.snapIndex = Math.floor(e / h.params.slidesPerGroup),
                h.snapIndex >= h.snapGrid.length && (h.snapIndex = h.snapGrid.length - 1);
                var i = -h.snapGrid[h.snapIndex];
                h.params.autoplay && h.autoplaying && (s || !h.params.autoplayDisableOnInteraction ? h.pauseAutoplay(a) : h.stopAutoplay()),
                h.updateProgress(i);
                for (var n = 0; n < h.slidesGrid.length; n++) - i >= h.slidesGrid[n] && (e = n);
                if ("undefined" == typeof a && (a = h.params.speed), h.previousIndex = h.activeIndex || 0, h.activeIndex = e, i === h.translate) return h.updateClasses(),
                !1;
                h.onTransitionStart(t);
                r() ? i: 0,
                r() ? 0: i;
                return 0 === a ? (h.setWrapperTransition(0), h.setWrapperTranslate(i), h.onTransitionEnd(t)) : (h.setWrapperTransition(a), h.setWrapperTranslate(i), h.animating || (h.animating = !0, h.wrapper.transitionEnd(function() {
                    h.onTransitionEnd(t)
                }))),
                h.updateClasses(),
                !0
            },
            h.onTransitionStart = function(e) {
                "undefined" == typeof e && (e = !0),
                h.lazy && h.lazy.onTransitionStart(),
                e && (h.params.onTransitionStart && h.params.onTransitionStart(h), h.params.onSlideChangeStart && h.activeIndex !== h.previousIndex && h.params.onSlideChangeStart(h))
            },
            h.onTransitionEnd = function(e) {
                h.animating = !1,
                h.setWrapperTransition(0),
                "undefined" == typeof e && (e = !0),
                h.lazy && h.lazy.onTransitionEnd(),
                e && (h.params.onTransitionEnd && h.params.onTransitionEnd(h), h.params.onSlideChangeEnd && h.activeIndex !== h.previousIndex && h.params.onSlideChangeEnd(h))
            },
            h.slideNext = function(e, a, t) {
                if (h.params.loop) {
                    if (h.animating) return ! 1;
                    h.fixLoop(); {
                        h.container[0].clientLeft
                    }
                    return h.slideTo(h.activeIndex + h.params.slidesPerGroup, a, e, t)
                }
                return h.slideTo(h.activeIndex + h.params.slidesPerGroup, a, e, t)
            },
            h._slideNext = function(e) {
                return h.slideNext(!0, e, !0)
            },
            h.slidePrev = function(e, a, t) {
                if (h.params.loop) {
                    if (h.animating) return ! 1;
                    h.fixLoop(); {
                        h.container[0].clientLeft
                    }
                    return h.slideTo(h.activeIndex - 1, a, e, t)
                }
                return h.slideTo(h.activeIndex - 1, a, e, t)
            },
            h._slidePrev = function(e) {
                return h.slidePrev(!0, e, !0)
            },
            h.slideReset = function(e, a) {
                return h.slideTo(h.activeIndex, a, e)
            },
            h.setWrapperTransition = function(e, a) {
                h.wrapper.transition(e),
                h.params.onSetTransition && h.params.onSetTransition(h, e),
                "slide" !== h.params.effect && h.effects[h.params.effect] && h.effects[h.params.effect].setTransition(e),
                h.params.parallax && h.parallax && h.parallax.setTransition(e),
                h.params.scrollbar && h.scrollbar && h.scrollbar.setTransition(e),
                h.params.control && h.controller && h.controller.setTransition(e, a)
            },
            h.setWrapperTranslate = function(e, a, t) {
                var s = 0,
                i = 0,
                n = 0;
                r() ? s = h.rtl ? -e: e: i = e,
                h.wrapper.transform(h.support.transforms3d ? "translate3d(" + s + "px, " + i + "px, " + n + "px)": "translate(" + s + "px, " + i + "px)"),
                h.translate = r() ? s: i,
                a && h.updateActiveIndex(),
                "slide" !== h.params.effect && h.effects[h.params.effect] && h.effects[h.params.effect].setTranslate(h.translate),
                h.params.parallax && h.parallax && h.parallax.setTranslate(h.translate),
                h.params.scrollbar && h.scrollbar && h.scrollbar.setTranslate(h.translate),
                h.params.control && h.controller && h.controller.setTranslate(h.translate, t),
                h.params.hashnav && h.hashnav && h.hashnav.setHash(),
                h.params.onSetTranslate && h.params.onSetTranslate(h, h.translate)
            },
            h.getTranslate = function(e, a) {
                var t,
                r,
                s,
                i;
                return "undefined" == typeof a && (a = "x"),
                s = window.getComputedStyle(e, null),
                window.WebKitCSSMatrix ? i = new WebKitCSSMatrix("none" === s.webkitTransform ? "": s.webkitTransform) : (i = s.MozTransform || s.OTransform || s.MsTransform || s.msTransform || s.transform || s.getPropertyValue("transform").replace("translate(", "matrix(1, 0, 0, 1,"), t = i.toString().split(",")),
                "x" === a && (r = window.WebKitCSSMatrix ? i.m41: parseFloat(16 === t.length ? t[12] : t[4])),
                "y" === a && (r = window.WebKitCSSMatrix ? i.m42: parseFloat(16 === t.length ? t[13] : t[5])),
                h.rtl && r && (r = -r),
                r || 0
            },
            h.getWrapperTranslate = function(e) {
                return "undefined" == typeof e && (e = r() ? "x": "y"),
                h.getTranslate(h.wrapper[0], e)
            },
            h.observers = [], h.initObservers = function() {
                if (h.params.observeParents) for (var e = h.container.parents(), a = 0; a < e.length; a++) n(e[a]);
                n(h.container[0], {
                    childList: !1
                }),
                n(h.wrapper[0], {
                    attributes: !1
                })
            },
            h.disconnectObservers = function() {
                for (var e = 0; e < h.observers.length; e++) h.observers[e].disconnect();
                h.observers = []
            },
            h.createLoop = function() {
                h.wrapper.children("." + h.params.slideClass + "." + h.params.slideDuplicateClass).remove();
                var e = h.wrapper.children("." + h.params.slideClass);
                h.loopedSlides = parseInt(h.params.loopedSlides || h.params.slidesPerView, 10),
                h.loopedSlides = h.loopedSlides + h.params.loopAdditionalSlides,
                h.loopedSlides > e.length && (h.loopedSlides = e.length);
                var a,
                t = [],
                r = [];
                for (e.each(function(a, s) {
                    var i = f(this);
                    a < h.loopedSlides && r.push(s),
                    a < e.length && a >= e.length - h.loopedSlides && t.push(s),
                    i.attr("data-swiper-slide-index", a)
                }), a = 0; a < r.length; a++) h.wrapper.append(f(r[a].cloneNode(!0)).addClass(h.params.slideDuplicateClass));
                for (a = t.length - 1; a >= 0; a--) h.wrapper.prepend(f(t[a].cloneNode(!0)).addClass(h.params.slideDuplicateClass))
            },
            h.destroyLoop = function() {
                h.wrapper.children("." + h.params.slideClass + "." + h.params.slideDuplicateClass).remove()
            },
            h.fixLoop = function() {
                var e;
                h.activeIndex < h.loopedSlides ? (e = h.slides.length - 3 * h.loopedSlides + h.activeIndex, e += h.loopedSlides, h.slideTo(e, 0, !1, !0)) : ("auto" === h.params.slidesPerView && h.activeIndex >= 2 * h.loopedSlides || h.activeIndex > h.slides.length - 2 * h.params.slidesPerView) && (e = -h.slides.length + h.activeIndex + h.loopedSlides, e += h.loopedSlides, h.slideTo(e, 0, !1, !0))
            },
            h.appendSlide = function(e) {
                if (h.params.loop && h.destroyLoop(), "object" == typeof e && e.length) for (var a = 0; a < e.length; a++) e[a] && h.wrapper.append(e[a]);
                else h.wrapper.append(e);
                h.params.loop && h.createLoop(),
                h.params.observer && h.support.observer || h.update(!0)
            },
            h.prependSlide = function(e) {
                h.params.loop && h.destroyLoop();
                var a = h.activeIndex + 1;
                if ("object" == typeof e && e.length) {
                    for (var t = 0; t < e.length; t++) e[t] && h.wrapper.prepend(e[t]);
                    a = h.activeIndex + e.length
                } else h.wrapper.prepend(e);
                h.params.loop && h.createLoop(),
                h.params.observer && h.support.observer || h.update(!0),
                h.slideTo(a, 0, !1)
            },
            h.removeSlide = function(e) {
                h.params.loop && h.destroyLoop();
                var a,
                t = h.activeIndex;
                if ("object" == typeof e && e.length) {
                    for (var r = 0; r < e.length; r++) a = e[r],
                    h.slides[a] && h.slides.eq(a).remove(),
                    t > a && t--;
                    t = Math.max(t, 0)
                } else a = e,
                h.slides[a] && h.slides.eq(a).remove(),
                t > a && t--,
                t = Math.max(t, 0);
                h.params.observer && h.support.observer || h.update(!0),
                h.slideTo(t, 0, !1)
            },
            h.removeAllSlides = function() {
                for (var e = [], a = 0; a < h.slides.length; a++) e.push(a);
                h.removeSlide(e)
            },
            h.effects = {
                fade: {
                    setTranslate: function() {
                        for (var e = 0; e < h.slides.length; e++) {
                            var a = h.slides.eq(e),
                            t = a[0].swiperSlideOffset,
                            s = -t - h.translate,
                            i = 0;
                            r() || (i = s, s = 0);
                            var n = h.params.fade.crossFade ? Math.max(1 - Math.abs(a[0].progress), 0) : 1 + Math.min(Math.max(a[0].progress, -1), 0);
                            a.css({
                                opacity: n
                            }).transform("translate3d(" + s + "px, " + i + "px, 0px)")
                        }
                    },
                    setTransition: function(e) {
                        h.slides.transition(e)
                    }
                },
                cube: {
                    setTranslate: function() {
                        var e,
                        a = 0;
                        h.params.cube.shadow && (r() ? (e = h.wrapper.find(".swiper-cube-shadow"), 0 === e.length && (e = f('<div class="swiper-cube-shadow"></div>'), h.wrapper.append(e)), e.css({
                            height: h.width + "px"
                        })) : (e = h.container.find(".swiper-cube-shadow"), 0 === e.length && (e = f('<div class="swiper-cube-shadow"></div>'), h.container.append(e))));
                        for (var t = 0; t < h.slides.length; t++) {
                            var s = h.slides.eq(t),
                            i = 90 * t,
                            n = Math.floor(i / 360);
                            h.rtl && (i = -i, n = Math.floor( - i / 360));
                            var o = Math.max(Math.min(s[0].progress, 1), -1),
                            l = 0,
                            d = 0,
                            p = 0;
                            t % 4 === 0 ? (l = 4 * -n * h.size, p = 0) : (t - 1) % 4 === 0 ? (l = 0, p = 4 * -n * h.size) : (t - 2) % 4 === 0 ? (l = h.size + 4 * n * h.size, p = h.size) : (t - 3) % 4 === 0 && (l = -h.size, p = 3 * h.size + 4 * h.size * n),
                            h.rtl && (l = -l),
                            r() || (d = l, l = 0);
                            var u = "rotateX(" + (r() ? 0: -i) + "deg) rotateY(" + (r() ? i: 0) + "deg) translate3d(" + l + "px, " + d + "px, " + p + "px)";
                            if (1 >= o && o > -1 && (a = 90 * t + 90 * o, h.rtl && (a = 90 * -t - 90 * o)), s.transform(u), h.params.cube.slideShadows) {
                                var c = s.find(r() ? ".swiper-slide-shadow-left": ".swiper-slide-shadow-top"),
                                m = s.find(r() ? ".swiper-slide-shadow-right": ".swiper-slide-shadow-bottom");
                                0 === c.length && (c = f('<div class="swiper-slide-shadow-' + (r() ? "left": "top") + '"></div>'), s.append(c)),
                                0 === m.length && (m = f('<div class="swiper-slide-shadow-' + (r() ? "right": "bottom") + '"></div>'), s.append(m)); {
                                    s[0].progress
                                }
                                c.length && (c[0].style.opacity = -s[0].progress),
                                m.length && (m[0].style.opacity = s[0].progress)
                            }
                        }
                        if (h.wrapper.css({
                            "-webkit-transform-origin": "50% 50% -" + h.size / 2 + "px",
                            "-moz-transform-origin": "50% 50% -" + h.size / 2 + "px",
                            "-ms-transform-origin": "50% 50% -" + h.size / 2 + "px",
                            "transform-origin": "50% 50% -" + h.size / 2 + "px"
                        }), h.params.cube.shadow) if (r()) e.transform("translate3d(0px, " + (h.width / 2 + h.params.cube.shadowOffset) + "px, " + -h.width / 2 + "px) rotateX(90deg) rotateZ(0deg) scale(" + h.params.cube.shadowScale + ")");
                        else {
                            var g = Math.abs(a) - 90 * Math.floor(Math.abs(a) / 90),
                            v = 1.5 - (Math.sin(2 * g * Math.PI / 360) / 2 + Math.cos(2 * g * Math.PI / 360) / 2),
                            w = h.params.cube.shadowScale,
                            T = h.params.cube.shadowScale / v,
                            b = h.params.cube.shadowOffset;
                            e.transform("scale3d(" + w + ", 1, " + T + ") translate3d(0px, " + (h.height / 2 + b) + "px, " + -h.height / 2 / T + "px) rotateX(-90deg)")
                        }
                        var x = h.isSafari || h.isUiWebView ? -h.size / 2: 0;
                        h.wrapper.transform("translate3d(0px,0," + x + "px) rotateX(" + (r() ? 0: a) + "deg) rotateY(" + (r() ? -a: 0) + "deg)")
                    },
                    setTransition: function(e) {
                        h.slides.transition(e).find(".swiper-slide-shadow-top, .swiper-slide-shadow-right, .swiper-slide-shadow-bottom, .swiper-slide-shadow-left").transition(e),
                        h.params.cube.shadow && !r() && h.container.find(".swiper-cube-shadow").transition(e)
                    }
                },
                coverflow: {
                    setTranslate: function() {
                        for (var e = h.translate, a = r() ? -e + h.width / 2: -e + h.height / 2, t = r() ? h.params.coverflow.rotate: -h.params.coverflow.rotate, s = h.params.coverflow.depth, i = 0, n = h.slides.length; n > i; i++) {
                            var o = h.slides.eq(i),
                            l = h.slidesSizesGrid[i],
                            d = o[0].swiperSlideOffset,
                            p = (a - d - l / 2) / l * h.params.coverflow.modifier,
                            u = r() ? t * p: 0,
                            c = r() ? 0: t * p,
                            m = -s * Math.abs(p),
                            g = r() ? 0: h.params.coverflow.stretch * p,
                            v = r() ? h.params.coverflow.stretch * p: 0;
                            Math.abs(v) < .001 && (v = 0),
                            Math.abs(g) < .001 && (g = 0),
                            Math.abs(m) < .001 && (m = 0),
                            Math.abs(u) < .001 && (u = 0),
                            Math.abs(c) < .001 && (c = 0);
                            var w = "translate3d(" + v + "px," + g + "px," + m + "px)  rotateX(" + c + "deg) rotateY(" + u + "deg)";
                            if (o.transform(w), o[0].style.zIndex = -Math.abs(Math.round(p)) + 1, h.params.coverflow.slideShadows) {
                                var T = o.find(r() ? ".swiper-slide-shadow-left": ".swiper-slide-shadow-top"),
                                b = o.find(r() ? ".swiper-slide-shadow-right": ".swiper-slide-shadow-bottom");
                                0 === T.length && (T = f('<div class="swiper-slide-shadow-' + (r() ? "left": "top") + '"></div>'), o.append(T)),
                                0 === b.length && (b = f('<div class="swiper-slide-shadow-' + (r() ? "right": "bottom") + '"></div>'), o.append(b)),
                                T.length && (T[0].style.opacity = p > 0 ? p: 0),
                                b.length && (b[0].style.opacity = -p > 0 ? -p: 0)
                            }
                        }
                        if (window.navigator.pointerEnabled || window.navigator.msPointerEnabled) {
                            var x = h.wrapper.style;
                            x.perspectiveOrigin = a + "px 50%"
                        }
                    },
                    setTransition: function(e) {
                        h.slides.transition(e).find(".swiper-slide-shadow-top, .swiper-slide-shadow-right, .swiper-slide-shadow-bottom, .swiper-slide-shadow-left").transition(e)
                    }
                }
            },
            h.lazy = {
                initialImageLoaded: !1,
                loadImageInSlide: function(e) {
                    if ("undefined" != typeof e && 0 !== h.slides.length) {
                        var a = h.slides.eq(e),
                        t = a.find("img.swiper-lazy:not(.swiper-lazy-loaded):not(.swiper-lazy-loading)");
                        0 !== t.length && t.each(function() {
                            var e = f(this);
                            e.addClass("swiper-lazy-loading");
                            var t = e.attr("data-src");
                            h.loadImage(e[0], t, !1, 
                            function() {
                                e.attr("src", t),
                                e.removeAttr("data-src"),
                                e.addClass("swiper-lazy-loaded").removeClass("swiper-lazy-loading"),
                                a.find(".swiper-lazy-preloader, .preloader").remove(),
                                h.params.onLazyImageLoaded && h.params.onLazyImageLoaded(h, a[0], e[0])
                            }),
                            h.params.onLazyImageLoad && h.params.onLazyImageLoad(h, a[0], e[0])
                        })
                    }
                },
                load: function() {
                    if (h.params.watchSlidesVisibility) h.wrapper.children("." + h.params.slideVisibleClass).each(function() {
                        h.lazy.loadImageInSlide(f(this).index())
                    });
                    else if (h.params.slidesPerView > 1) for (var e = h.activeIndex; e < h.activeIndex + h.params.slidesPerView; e++) h.slides[e] && h.lazy.loadImageInSlide(e);
                    else h.lazy.loadImageInSlide(h.activeIndex);
                    if (h.params.lazyLoadingInPrevNext) {
                        var a = h.wrapper.children("." + h.params.slideNextClass);
                        a.length > 0 && h.lazy.loadImageInSlide(a.index());
                        var t = h.wrapper.children("." + h.params.slidePrevClass);
                        t.length > 0 && h.loadImageInSlide(t.index())
                    }
                },
                onTransitionStart: function() {
                    h.params.lazyLoading && (h.params.lazyLoadingOnTransitionStart || !h.params.lazyLoadingOnTransitionStart && !h.lazy.initialImageLoaded) && (h.lazy.initialImageLoaded = !0, h.lazy.load())
                },
                onTransitionEnd: function() {
                    h.params.lazyLoading && !h.params.lazyLoadingOnTransitionStart && h.lazy.load()
                }
            },
            h.scrollbar = {
                set: function() {
                    if (h.params.scrollbar) {
                        var e = h.scrollbar;
                        e.track = f(h.params.scrollbar),
                        e.drag = e.track.find(".swiper-scrollbar-drag"),
                        0 === e.drag.length && (e.drag = f('<div class="swiper-scrollbar-drag"></div>'), e.track.append(e.drag)),
                        e.drag[0].style.width = "",
                        e.drag[0].style.height = "",
                        e.trackSize = r() ? e.track[0].offsetWidth: e.track[0].offsetHeight,
                        e.divider = h.size / h.virtualWidth,
                        e.moveDivider = e.divider * (e.trackSize / h.size),
                        e.dragSize = e.trackSize * e.divider,
                        r() ? e.drag[0].style.width = e.dragSize + "px": e.drag[0].style.height = e.dragSize + "px",
                        e.track[0].style.display = e.divider >= 1 ? "none": "",
                        h.params.scrollbarHide && (e.track[0].style.opacity = 0)
                    }
                },
                setTranslate: function() {
                    if (h.params.scrollbar) {
                        var e,
                        a = h.scrollbar,
                        t = (h.translate || 0, a.dragSize);
                        e = (a.trackSize - a.dragSize) * h.progress,
                        h.rtl && r() ? (e = -e, e > 0 ? (t = a.dragSize - e, e = 0) : -e + a.dragSize > a.trackSize && (t = a.trackSize + e)) : 0 > e ? (t = a.dragSize + e, e = 0) : e + a.dragSize > a.trackSize && (t = a.trackSize - e),
                        r() ? (a.drag.transform("translate3d(" + e + "px, 0, 0)"), a.drag[0].style.width = t + "px") : (a.drag.transform("translate3d(0px, " + e + "px, 0)"), a.drag[0].style.height = t + "px"),
                        h.params.scrollbarHide && (clearTimeout(a.timeout), a.track[0].style.opacity = 1, a.timeout = setTimeout(function() {
                            a.track[0].style.opacity = 0,
                            a.track.transition(400)
                        },
                        1e3))
                    }
                },
                setTransition: function(e) {
                    h.params.scrollbar && h.scrollbar.drag.transition(e)
                }
            },
            h.controller = {
                setTranslate: function(e, a) {
                    var t,
                    r,
                    s = h.params.control;
                    if (h.isArray(s)) for (var i = 0; i < s.length; i++) s[i] !== a && s[i] instanceof Swiper && (e = s[i].rtl && "horizontal" === s[i].params.direction ? -h.translate: h.translate, t = (s[i].maxTranslate() - s[i].minTranslate()) / (h.maxTranslate() - h.minTranslate()), r = (e - h.minTranslate()) * t + s[i].minTranslate(), h.params.controlInverse && (r = s[i].maxTranslate() - r), s[i].updateProgress(r), s[i].setWrapperTranslate(r, !1, h), s[i].updateActiveIndex());
                    else s instanceof Swiper && a !== s && (e = s.rtl && "horizontal" === s.params.direction ? -h.translate: h.translate, t = (s.maxTranslate() - s.minTranslate()) / (h.maxTranslate() - h.minTranslate()), r = (e - h.minTranslate()) * t + s.minTranslate(), h.params.controlInverse && (r = s.maxTranslate() - r), s.updateProgress(r), s.setWrapperTranslate(r, !1, h), s.updateActiveIndex())
                },
                setTransition: function(e, a) {
                    var t = h.params.control;
                    if (h.isArray(t)) for (var r = 0; r < t.length; r++) t[r] !== a && t[r] instanceof Swiper && t[r].setWrapperTransition(e, h);
                    else t instanceof Swiper && a !== t && t.setWrapperTransition(e, h)
                }
            },
            h.hashnav = {
                init: function() {
                    if (h.params.hashnav) {
                        h.hashnav.initialized = !0;
                        var e = document.location.hash.replace("#", "");
                        if (e) for (var a = 0, t = 0, r = h.slides.length; r > t; t++) {
                            var s = h.slides.eq(t),
                            i = s.attr("data-hash");
                            if (i === e && !s.hasClass(h.params.slideDuplicateClass)) {
                                var n = s.index();
                                h.slideTo(n, a, h.params.runCallbacksOnInit, !0)
                            }
                        }
                    }
                },
                setHash: function() {
                    h.hashnav.initialized && h.params.hashnav && (document.location.hash = h.slides.eq(h.activeIndex).attr("data-hash") || "")
                }
            },
            h.disableKeyboardControl = function() {
                f(document).off("keydown", o)
            },
            h.enableKeyboardControl = function() {
                f(document).on("keydown", o)
            },
            h._wheelEvent = !1, h._lastWheelScrollTime = (new Date).getTime(), h.params.mousewheelControl) {
                if (void 0 !== document.onmousewheel && (h._wheelEvent = "mousewheel"), !h._wheelEvent) try {
                    new WheelEvent("wheel"),
                    h._wheelEvent = "wheel"
                } catch(I) {}
                h._wheelEvent || (h._wheelEvent = "DOMMouseScroll")
            }
            return h.disableMousewheelControl = function() {
                return h._wheelEvent ? (h.container.off(h._wheelEvent, l), !0) : !1
            },
            h.enableMousewheelControl = function() {
                return h._wheelEvent ? (h.container.on(h._wheelEvent, l), !0) : !1
            },
            h.parallax = {
                setTranslate: function() {
                    h.container.children("[data-swiper-parallax], [data-swiper-parallax-x], [data-swiper-parallax-y]").each(function() {
                        d(this, h.progress)
                    }),
                    h.slides.each(function() {
                        var e = f(this);
                        e.find("[data-swiper-parallax], [data-swiper-parallax-x], [data-swiper-parallax-y]").each(function() {
                            var a = Math.min(Math.max(e[0].progress, -1), 1);
                            d(this, a)
                        })
                    })
                },
                setTransition: function(e) {
                    "undefined" == typeof e && (e = h.params.speed),
                    h.container.find("[data-swiper-parallax], [data-swiper-parallax-x], [data-swiper-parallax-y]").each(function() {
                        var a = f(this),
                        t = parseInt(a.attr("data-swiper-parallax-duration"), 10) || e;
                        0 === e && (t = 0),
                        a.transition(t)
                    })
                }
            },
            h.init = function() {
                h.params.loop && h.createLoop(),
                h.updateContainerSize(),
                h.updateSlidesSize(),
                h.updatePagination(),
                h.params.scrollbar && h.scrollbar && h.scrollbar.set(),
                "slide" !== h.params.effect && h.effects[h.params.effect] && (h.params.loop || h.updateProgress(), h.effects[h.params.effect].setTranslate()),
                h.params.loop ? h.slideTo(h.params.initialSlide + h.loopedSlides, 0, h.params.runCallbacksOnInit) : (h.slideTo(h.params.initialSlide, 0, h.params.runCallbacksOnInit), 0 === h.params.initialSlide && (h.parallax && h.params.parallax && h.parallax.setTranslate(), h.lazy && h.params.lazyLoading && h.lazy.load())),
                h.attachEvents(),
                h.params.observer && h.support.observer && h.initObservers(),
                h.params.preloadImages && !h.params.lazyLoading && h.preloadImages(),
                h.params.autoplay && h.startAutoplay(),
                h.params.keyboardControl && h.enableKeyboardControl && h.enableKeyboardControl(),
                h.params.mousewheelControl && h.enableMousewheelControl && h.enableMousewheelControl(),
                h.params.hashnav && h.hashnav && h.hashnav.init(),
                h.params.onInit && h.params.onInit(h)
            },
            h.destroy = function(e) {
                h.detachEvents(),
                h.disconnectObservers(),
                h.params.keyboardControl && h.disableKeyboardControl && h.disableKeyboardControl(),
                h.params.mousewheelControl && h.disableMousewheelControl && h.disableMousewheelControl(),
                h.params.onDestroy && h.params.onDestroy(),
                e !== !1 && (h = null)
            },
            h.init(),
            h
        }
    },
    Swiper.prototype = {
        isSafari: function() {
            var e = navigator.userAgent.toLowerCase();
            return e.indexOf("safari") >= 0 && e.indexOf("chrome") < 0 && e.indexOf("android") < 0
        } (),
        isUiWebView: /(iPhone|iPod|iPad).*AppleWebKit(?!.*Safari)/i.test(navigator.userAgent),
        isArray: function(e) {
            return "[object Array]" === Object.prototype.toString.apply(e)
        },
        browser: {
            ie: window.navigator.pointerEnabled || window.navigator.msPointerEnabled
        },
        device: function() {
            var e = navigator.userAgent,
            a = e.match(/(Android);?[\s\/]+([\d.]+)?/),
            t = e.match(/(iPad).*OS\s([\d_]+)/),
            r = (e.match(/(iPod)(.*OS\s([\d_]+))?/), !t && e.match(/(iPhone\sOS)\s([\d_]+)/));
            return {
                ios: t || r || t,
                android: a
            }
        } (),
        support: {
            touch: window.Modernizr && Modernizr.touch === !0 || 
            function() {
                return !! ("ontouchstart" in window || window.DocumentTouch && document instanceof DocumentTouch)
            } (),
            transforms3d: window.Modernizr && Modernizr.csstransforms3d === !0 || 
            function() {
                var e = document.createElement("div").style;
                return "webkitPerspective" in e || "MozPerspective" in e || "OPerspective" in e || "MsPerspective" in e || "perspective" in e
            } (),
            flexbox: function() {
                for (var e = document.createElement("div").style, a = "WebkitBox msFlexbox MsFlexbox WebkitFlex MozBox flex".split(" "), t = 0; t < a.length; t++) if (a[t] in e) return ! 0
            } (),
            observer: function() {
                return "MutationObserver" in window || "WebkitMutationObserver" in window
            } ()
        }
    };
    for (var a = (function() {
        var e = function(e) {
            var a = this,
            t = 0;
            for (t = 0; t < e.length; t++) a[t] = e[t];
            return a.length = e.length,
            this
        },
        a = function(a, t) {
            var r = [],
            s = 0;
            if (a && !t && a instanceof e) return a;
            if (a) if ("string" == typeof a) {
                var i,
                n,
                o = a.trim();
                if (o.indexOf("<") >= 0 && o.indexOf(">") >= 0) {
                    var l = "div";
                    for (0 === o.indexOf("<li") && (l = "ul"), 0 === o.indexOf("<tr") && (l = "tbody"), (0 === o.indexOf("<td") || 0 === o.indexOf("<th")) && (l = "tr"), 0 === o.indexOf("<tbody") && (l = "table"), 0 === o.indexOf("<option") && (l = "select"), n = document.createElement(l), n.innerHTML = a, s = 0; s < n.childNodes.length; s++) r.push(n.childNodes[s])
                } else for (i = t || "#" !== a[0] || a.match(/[ .<>:~]/) ? (t || document).querySelectorAll(a) : [document.getElementById(a.split("#")[1])], s = 0; s < i.length; s++) i[s] && r.push(i[s])
            } else if (a.nodeType || a === window || a === document) r.push(a);
            else if (a.length > 0 && a[0].nodeType) for (s = 0; s < a.length; s++) r.push(a[s]);
            return new e(r)
        };
        return e.prototype = {
            addClass: function(e) {
                if ("undefined" == typeof e) return this;
                for (var a = e.split(" "), t = 0; t < a.length; t++) for (var r = 0; r < this.length; r++) this[r].classList.add(a[t]);
                return this
            },
            removeClass: function(e) {
                for (var a = e.split(" "), t = 0; t < a.length; t++) for (var r = 0; r < this.length; r++) this[r].classList.remove(a[t]);
                return this
            },
            hasClass: function(e) {
                return this[0] ? this[0].classList.contains(e) : !1
            },
            toggleClass: function(e) {
                for (var a = e.split(" "), t = 0; t < a.length; t++) for (var r = 0; r < this.length; r++) this[r].classList.toggle(a[t]);
                return this
            },
            attr: function(e, a) {
                if (1 === arguments.length && "string" == typeof e) return this[0] ? this[0].getAttribute(e) : void 0;
                for (var t = 0; t < this.length; t++) if (2 === arguments.length) this[t].setAttribute(e, a);
                else for (var r in e) this[t][r] = e[r],
                this[t].setAttribute(r, e[r]);
                return this
            },
            removeAttr: function(e) {
                for (var a = 0; a < this.length; a++) this[a].removeAttribute(e)
            },
            data: function(e, a) {
                if ("undefined" == typeof a) {
                    if (this[0]) {
                        var t = this[0].getAttribute("data-" + e);
                        return t ? t: this[0].dom7ElementDataStorage && e in this[0].dom7ElementDataStorage ? this[0].dom7ElementDataStorage[e] : void 0
                    }
                    return void 0
                }
                for (var r = 0; r < this.length; r++) {
                    var s = this[r];
                    s.dom7ElementDataStorage || (s.dom7ElementDataStorage = {}),
                    s.dom7ElementDataStorage[e] = a
                }
                return this
            },
            transform: function(e) {
                for (var a = 0; a < this.length; a++) {
                    var t = this[a].style;
                    t.webkitTransform = t.MsTransform = t.msTransform = t.MozTransform = t.OTransform = t.transform = e
                }
                return this
            },
            transition: function(e) {
                "string" != typeof e && (e += "ms");
                for (var a = 0; a < this.length; a++) {
                    var t = this[a].style;
                    t.webkitTransitionDuration = t.MsTransitionDuration = t.msTransitionDuration = t.MozTransitionDuration = t.OTransitionDuration = t.transitionDuration = e
                }
                return this
            },
            on: function(e, t, r, s) {
                function i(e) {
                    var s = e.target;
                    if (a(s).is(t)) r.call(s, e);
                    else for (var i = a(s).parents(), n = 0; n < i.length; n++) a(i[n]).is(t) && r.call(i[n], e)
                }
                var n,
                o,
                l = e.split(" ");
                for (n = 0; n < this.length; n++) if ("function" == typeof t || t === !1) for ("function" == typeof t && (r = arguments[1], s = arguments[2] || !1), o = 0; o < l.length; o++) this[n].addEventListener(l[o], r, s);
                else for (o = 0; o < l.length; o++) this[n].dom7LiveListeners || (this[n].dom7LiveListeners = []),
                this[n].dom7LiveListeners.push({
                    listener: r,
                    liveListener: i
                }),
                this[n].addEventListener(l[o], i, s);
                return this
            },
            off: function(e, a, t, r) {
                for (var s = e.split(" "), i = 0; i < s.length; i++) for (var n = 0; n < this.length; n++) if ("function" == typeof a || a === !1)"function" == typeof a && (t = arguments[1], r = arguments[2] || !1),
                this[n].removeEventListener(s[i], t, r);
                else if (this[n].dom7LiveListeners) for (var o = 0; o < this[n].dom7LiveListeners.length; o++) this[n].dom7LiveListeners[o].listener === t && this[n].removeEventListener(s[i], this[n].dom7LiveListeners[o].liveListener, r);
                return this
            },
            once: function(e, a, t, r) {
                function s(n) {
                    t(n),
                    i.off(e, a, s, r)
                }
                var i = this;
                "function" == typeof a && (a = !1, t = arguments[1], r = arguments[2]),
                i.on(e, a, s, r)
            },
            trigger: function(e, a) {
                for (var t = 0; t < this.length; t++) {
                    var r;
                    try {
                        r = new CustomEvent(e, {
                            detail: a,
                            bubbles: !0,
                            cancelable: !0
                        })
                    } catch(s) {
                        r = document.createEvent("Event"),
                        r.initEvent(e, !0, !0),
                        r.detail = a
                    }
                    this[t].dispatchEvent(r)
                }
                return this
            },
            transitionEnd: function(e) {
                function a(i) {
                    if (i.target === this) for (e.call(this, i), t = 0; t < r.length; t++) s.off(r[t], a)
                }
                var t,
                r = ["webkitTransitionEnd", "transitionend", "oTransitionEnd", "MSTransitionEnd", "msTransitionEnd"],
                s = this;
                if (e) for (t = 0; t < r.length; t++) s.on(r[t], a);
                return this
            },
            width: function() {
                return this[0] === window ? window.innerWidth: this.length > 0 ? parseFloat(this.css("width")) : null
            },
            outerWidth: function(e) {
                return this.length > 0 ? e ? this[0].offsetWidth + parseFloat(this.css("margin-right")) + parseFloat(this.css("margin-left")) : this[0].offsetWidth: null
            },
            height: function() {
                return this[0] === window ? window.innerHeight: this.length > 0 ? parseFloat(this.css("height")) : null
            },
            outerHeight: function(e) {
                return this.length > 0 ? e ? this[0].offsetHeight + parseFloat(this.css("margin-top")) + parseFloat(this.css("margin-bottom")) : this[0].offsetHeight: null
            },
            offset: function() {
                if (this.length > 0) {
                    var e = this[0],
                    a = e.getBoundingClientRect(),
                    t = document.body,
                    r = e.clientTop || t.clientTop || 0,
                    s = e.clientLeft || t.clientLeft || 0,
                    i = window.pageYOffset || e.scrollTop,
                    n = window.pageXOffset || e.scrollLeft;
                    return {
                        top: a.top + i - r,
                        left: a.left + n - s
                    }
                }
                return null
            },
            css: function(e, a) {
                var t;
                if (1 === arguments.length) {
                    if ("string" != typeof e) {
                        for (t = 0; t < this.length; t++) for (var r in e) this[t].style[r] = e[r];
                        return this
                    }
                    if (this[0]) return window.getComputedStyle(this[0], null).getPropertyValue(e)
                }
                if (2 === arguments.length && "string" == typeof e) {
                    for (t = 0; t < this.length; t++) this[t].style[e] = a;
                    return this
                }
                return this
            },
            each: function(e) {
                for (var a = 0; a < this.length; a++) e.call(this[a], a, this[a]);
                return this
            },
            html: function(e) {
                if ("undefined" == typeof e) return this[0] ? this[0].innerHTML: void 0;
                for (var a = 0; a < this.length; a++) this[a].innerHTML = e;
                return this
            },
            is: function(t) {
                if (!this[0]) return ! 1;
                var r,
                s;
                if ("string" == typeof t) {
                    var i = this[0];
                    if (i === document) return t === document;
                    if (i === window) return t === window;
                    if (i.matches) return i.matches(t);
                    if (i.webkitMatchesSelector) return i.webkitMatchesSelector(t);
                    if (i.mozMatchesSelector) return i.mozMatchesSelector(t);
                    if (i.msMatchesSelector) return i.msMatchesSelector(t);
                    for (r = a(t), s = 0; s < r.length; s++) if (r[s] === this[0]) return ! 0;
                    return ! 1
                }
                if (t === document) return this[0] === document;
                if (t === window) return this[0] === window;
                if (t.nodeType || t instanceof e) {
                    for (r = t.nodeType ? [t] : t, s = 0; s < r.length; s++) if (r[s] === this[0]) return ! 0;
                    return ! 1
                }
                return ! 1
            },
            index: function() {
                if (this[0]) {
                    for (var e = this[0], a = 0; null !== (e = e.previousSibling);) 1 === e.nodeType && a++;
                    return a
                }
                return void 0
            },
            eq: function(a) {
                if ("undefined" == typeof a) return this;
                var t,
                r = this.length;
                return a > r - 1 ? new e([]) : 0 > a ? (t = r + a, new e(0 > t ? [] : [this[t]])) : new e([this[a]])
            },
            append: function(a) {
                var t,
                r;
                for (t = 0; t < this.length; t++) if ("string" == typeof a) {
                    var s = document.createElement("div");
                    for (s.innerHTML = a; s.firstChild;) this[t].appendChild(s.firstChild)
                } else if (a instanceof e) for (r = 0; r < a.length; r++) this[t].appendChild(a[r]);
                else this[t].appendChild(a);
                return this
            },
            prepend: function(a) {
                var t,
                r;
                for (t = 0; t < this.length; t++) if ("string" == typeof a) {
                    var s = document.createElement("div");
                    for (s.innerHTML = a, r = s.childNodes.length - 1; r >= 0; r--) this[t].insertBefore(s.childNodes[r], this[t].childNodes[0])
                } else if (a instanceof e) for (r = 0; r < a.length; r++) this[t].insertBefore(a[r], this[t].childNodes[0]);
                else this[t].insertBefore(a, this[t].childNodes[0]);
                return this
            },
            insertBefore: function(e) {
                for (var t = a(e), r = 0; r < this.length; r++) if (1 === t.length) t[0].parentNode.insertBefore(this[r], t[0]);
                else if (t.length > 1) for (var s = 0; s < t.length; s++) t[s].parentNode.insertBefore(this[r].cloneNode(!0), t[s])
            },
            insertAfter: function(e) {
                for (var t = a(e), r = 0; r < this.length; r++) if (1 === t.length) t[0].parentNode.insertBefore(this[r], t[0].nextSibling);
                else if (t.length > 1) for (var s = 0; s < t.length; s++) t[s].parentNode.insertBefore(this[r].cloneNode(!0), t[s].nextSibling)
            },
            next: function(t) {
                return new e(this.length > 0 ? t ? this[0].nextElementSibling && a(this[0].nextElementSibling).is(t) ? [this[0].nextElementSibling] : [] : this[0].nextElementSibling ? [this[0].nextElementSibling] : [] : [])
            },
            nextAll: function(t) {
                var r = [],
                s = this[0];
                if (!s) return new e([]);
                for (; s.nextElementSibling;) {
                    var i = s.nextElementSibling;
                    t ? a(i).is(t) && r.push(i) : r.push(i),
                    s = i
                }
                return new e(r)
            },
            prev: function(t) {
                return new e(this.length > 0 ? t ? this[0].previousElementSibling && a(this[0].previousElementSibling).is(t) ? [this[0].previousElementSibling] : [] : this[0].previousElementSibling ? [this[0].previousElementSibling] : [] : [])
            },
            prevAll: function(t) {
                var r = [],
                s = this[0];
                if (!s) return new e([]);
                for (; s.previousElementSibling;) {
                    var i = s.previousElementSibling;
                    t ? a(i).is(t) && r.push(i) : r.push(i),
                    s = i
                }
                return new e(r)
            },
            parent: function(e) {
                for (var t = [], r = 0; r < this.length; r++) e ? a(this[r].parentNode).is(e) && t.push(this[r].parentNode) : t.push(this[r].parentNode);
                return a(a.unique(t))
            },
            parents: function(e) {
                for (var t = [], r = 0; r < this.length; r++) for (var s = this[r].parentNode; s;) e ? a(s).is(e) && t.push(s) : t.push(s),
                s = s.parentNode;
                return a(a.unique(t))
            },
            find: function(a) {
                for (var t = [], r = 0; r < this.length; r++) for (var s = this[r].querySelectorAll(a), i = 0; i < s.length; i++) t.push(s[i]);
                return new e(t)
            },
            children: function(t) {
                for (var r = [], s = 0; s < this.length; s++) for (var i = this[s].childNodes, n = 0; n < i.length; n++) t ? 1 === i[n].nodeType && a(i[n]).is(t) && r.push(i[n]) : 1 === i[n].nodeType && r.push(i[n]);
                return new e(a.unique(r))
            },
            remove: function() {
                for (var e = 0; e < this.length; e++) this[e].parentNode && this[e].parentNode.removeChild(this[e]);
                return this
            },
            add: function() {
                var e,
                t,
                r = this;
                for (e = 0; e < arguments.length; e++) {
                    var s = a(arguments[e]);
                    for (t = 0; t < s.length; t++) r[r.length] = s[t],
                    r.length++
                }
                return r
            }
        },
        a.fn = e.prototype,
        a.unique = function(e) {
            for (var a = [], t = 0; t < e.length; t++) - 1 === a.indexOf(e[t]) && a.push(e[t]);
            return a
        },
        a
    } ()), t = ["jQuery", "Zepto", "Dom7"], r = 0; r < t.length; r++) window[t[r]] && e(window[t[r]]);
    var s;
    s = "undefined" == typeof a ? window.Dom7 || window.Zepto || window.jQuery: a,
    s && ("transitionEnd" in s.fn || (s.fn.transitionEnd = function(e) {
        function a(i) {
            if (i.target === this) for (e.call(this, i), t = 0; t < r.length; t++) s.off(r[t], a)
        }
        var t,
        r = ["webkitTransitionEnd", "transitionend", "oTransitionEnd", "MSTransitionEnd", "msTransitionEnd"],
        s = this;
        if (e) for (t = 0; t < r.length; t++) s.on(r[t], a);
        return this
    }), "transform" in s.fn || (s.fn.transform = function(e) {
        for (var a = 0; a < this.length; a++) {
            var t = this[a].style;
            t.webkitTransform = t.MsTransform = t.msTransform = t.MozTransform = t.OTransform = t.transform = e
        }
        return this
    }), "transition" in s.fn || (s.fn.transition = function(e) {
        "string" != typeof e && (e += "ms");
        for (var a = 0; a < this.length; a++) {
            var t = this[a].style;
            t.webkitTransitionDuration = t.MsTransitionDuration = t.msTransitionDuration = t.MozTransitionDuration = t.OTransitionDuration = t.transitionDuration = e
        }
        return this
    }))
} (),
"undefined" != typeof module ? module.exports = Swiper: "function" == typeof define && define.amd && define([], 
function() {
    "use strict";
    return Swiper
});

/*
*
*Unslider+jQuery.event.swipe+jQuery.event.move
*
*/
//Unslider
(function($, f) {
	var Unslider = function() {
		//  Object clone
		var _ = this;

		//  Set some options
		_.o = {
			speed: 500,     // animation speed, false for no transition (integer or boolean)
			delay: 3000,    // delay between slides, false for no autoplay (integer or boolean)
			init: 0,        // init delay, false for no delay (integer or boolean)
			pause: !f,      // pause on hover (boolean)
			loop: !f,       // infinitely looping (boolean)
			keys: f,        // keyboard shortcuts (boolean)
			dots: f,        // display dots pagination (boolean)
			arrows: f,      // display prev/next arrows (boolean)
			prev: '&larr;', // text or html inside prev button (string)
			next: '&rarr;', // same as for prev option
			fluid: f,       // is it a percentage width? (boolean)
			starting: f,    // invoke before animation (function with argument)
			complete: f,    // invoke after animation (function with argument)
			items: '>ul',   // slides container selector
			item: '>li',    // slidable items selector
			easing: 'swing',// easing function to use for animation
			autoplay: true  // enable autoplay on initialisation
		};

		_.init = function(el, o) {
			//  Check whether we're passing any options in to Unslider
			_.o = $.extend(_.o, o);

			_.el = el;
			_.ul = el.find(_.o.items);
			_.max = [el.outerWidth() | 0, el.outerHeight() | 0];
			_.li = _.ul.find(_.o.item).each(function(index) {
				var me = $(this),
					width = me.outerWidth(),
					height = me.outerHeight();

				//  Set the max values
				if (width > _.max[0]) _.max[0] = width;
				if (height > _.max[1]) _.max[1] = height;
			});


			//  Cached vars
			var o = _.o,
				ul = _.ul,
				li = _.li,
				len = li.length;

			//  Current indeed
			_.i = 0;

			//  Set the main element
			el.css({width: _.max[0], height: li.first().outerHeight(), overflow: 'hidden'});

			//  Set the relative widths
			ul.css({position: 'relative', left: 0, width: (len * 100) + '%'});
			if(o.fluid) {
				li.css({'float': 'left', width: (100 / len) + '%'});
			} else {
				li.css({'float': 'left', width: (_.max[0]) + 'px'});
			}

			//  Autoslide
			o.autoplay && setTimeout(function() {
				if (o.delay | 0) {
					_.play();

					if (o.pause) {
						el.on('mouseover mouseout', function(e) {
							_.stop();
							e.type === 'mouseout' && _.play();
						});
					};
				};
			}, o.init | 0);

			//  Keypresses
			if (o.keys) {
				$(document).keydown(function(e) {
					switch(e.which) {
						case 37:
							_.prev(); // Left
							break;
						case 39:
							_.next(); // Right
							break;
						case 27:
							_.stop(); // Esc
							break;
					};
				});
			};

			//  Dot pagination
			o.dots && nav('dot');

			//  Arrows support
			o.arrows && nav('arrow');

			//  Patch for fluid-width sliders. Screw those guys.
			o.fluid && $(window).resize(function() {
				_.r && clearTimeout(_.r);

				_.r = setTimeout(function() {
					var styl = {height: li.eq(_.i).outerHeight()},
						width = el.outerWidth();

					ul.css(styl);
					styl['width'] = Math.min(Math.round((width / el.parent().width()) * 100), 100) + '%';
					el.css(styl);
					li.css({ width: width + 'px' });
				}, 50);
			}).resize();

			//  Move support
			if ($.event.special['move'] || $.Event('move')) {
				el.on('movestart', function(e) {
					if ((e.distX > e.distY && e.distX < -e.distY) || (e.distX < e.distY && e.distX > -e.distY)) {
						e.preventDefault();
					}else{
						el.data("left", _.ul.offset().left / el.width() * 100);
					}
				}).on('move', function(e) {
					var left = 100 * e.distX / el.width();
				        var leftDelta = 100 * e.deltaX / el.width();
					_.ul[0].style.left = parseInt(_.ul[0].style.left.replace("%", ""))+leftDelta+"%";

					_.ul.data("left", left);
				}).on('moveend', function(e) {
					var left = _.ul.data("left");
					if (Math.abs(left) > 30){
						var i = left > 0 ? _.i-1 : _.i+1;
						if (i < 0 || i >= len) i = _.i;
						_.to(i);
					}else{
						_.to(_.i);
					}
				});
			};

			return _;
		};

		//  Move Unslider to a slide index
		_.to = function(index, callback) {
			if (_.t) {
				_.stop();
				_.play();
	                }
			var o = _.o,
				el = _.el,
				ul = _.ul,
				li = _.li,
				current = _.i,
				target = li.eq(index);

			$.isFunction(o.starting) && !callback && o.starting(el, li.eq(current));

			//  To slide or not to slide
			if ((!target.length || index < 0) && o.loop === f) return;

			//  Check if it's out of bounds
			if (!target.length) index = 0;
			if (index < 0) index = li.length - 1;
			target = li.eq(index);

			var speed = callback ? 5 : o.speed | 0,
				easing = o.easing,
				obj = {height: target.outerHeight()};

			if (!ul.queue('fx').length) {
				//  Handle those pesky dots
				el.find('.dot').eq(index).addClass('active').siblings().removeClass('active');

				el.animate(obj, speed, easing) && ul.animate($.extend({left: '-' + index + '00%'}, obj), speed, easing, function(data) {
					_.i = index;

					$.isFunction(o.complete) && !callback && o.complete(el, target);
				});
			};
		};

		//  Autoplay functionality
		_.play = function() {
			_.t = setInterval(function() {
				_.to(_.i + 1);
			}, _.o.delay | 0);
		};

		//  Stop autoplay
		_.stop = function() {
			_.t = clearInterval(_.t);
			return _;
		};

		//  Move to previous/next slide
		_.next = function() {
			return _.stop().to(_.i + 1);
		};

		_.prev = function() {
			return _.stop().to(_.i - 1);
		};

		//  Create dots and arrows
		function nav(name, html) {
			if (name == 'dot') {
				html = '<ol class="dots">';
					$.each(_.li, function(index) {
						html += '<li class="' + (index === _.i ? name + ' active' : name) + '">' + ++index + '</li>';
					});
				html += '</ol>';
			} else {
				html = '<div class="';
				html = html + name + 's">' + html + name + ' prev">' + _.o.prev + '</div>' + html + name + ' next">' + _.o.next + '</div></div>';
			};

			_.el.addClass('has-' + name + 's').append(html).find('.' + name).click(function() {
				var me = $(this);
				me.hasClass('dot') ? _.stop().to(me.index()) : me.hasClass('prev') ? _.prev() : _.next();
			});
		};
	};

	//  Create a jQuery plugin
	$.fn.unslider = function(o) {
		var len = this.length;

		//  Enable multiple-slider support
		return this.each(function(index) {
			//  Cache a copy of $(this), so it
			var me = $(this),
				key = 'unslider' + (len > 1 ? '-' + ++index : ''),
				instance = (new Unslider).init(me, o);

			//  Invoke an Unslider instance
			me.data(key, instance).data('key', key);
		});
	};

	Unslider.version = "1.0.0";
})(jQuery, false);

//jQuery.event.swipe
(function (module) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define(['jquery'], module);
    } else {
        // Browser globals
        module(jQuery);
    }
})(function(jQuery, undefined){
    var add = jQuery.event.add,
        
        remove = jQuery.event.remove,
 
        // Just sugar, so we can have arguments in the same order as
        // add and remove.
        trigger = function(node, type, data) {
            jQuery.event.trigger(type, data, node);
        },
 
        settings = {
            // Ratio of distance over target finger must travel to be
            // considered a swipe.
            threshold: 0.4,
            // Faster fingers can travel shorter distances to be considered
            // swipes. 'sensitivity' controls how much. Bigger is shorter.
            sensitivity: 6
        };
 
    function moveend(e) {
        var w, h, event;
 
        w = e.currentTarget.offsetWidth;
        h = e.currentTarget.offsetHeight;
 
        // Copy over some useful properties from the move event
        event = {
            distX: e.distX,
            distY: e.distY,
            velocityX: e.velocityX,
            velocityY: e.velocityY,
            finger: e.finger
        };
 
        // Find out which of the four directions was swiped
        if (e.distX > e.distY) {
            if (e.distX > -e.distY) {
                if (e.distX/w > settings.threshold || e.velocityX * e.distX/w * settings.sensitivity > 1) {
                    event.type = 'swiperight';
                    trigger(e.currentTarget, event);
                }
            }
            else {
                if (-e.distY/h > settings.threshold || e.velocityY * e.distY/w * settings.sensitivity > 1) {
                    event.type = 'swipeup';
                    trigger(e.currentTarget, event);
                }
            }
        }
        else {
            if (e.distX > -e.distY) {
                if (e.distY/h > settings.threshold || e.velocityY * e.distY/w * settings.sensitivity > 1) {
                    event.type = 'swipedown';
                    trigger(e.currentTarget, event);
                }
            }
            else {
                if (-e.distX/w > settings.threshold || e.velocityX * e.distX/w * settings.sensitivity > 1) {
                    event.type = 'swipeleft';
                    trigger(e.currentTarget, event);
                }
            }
        }
    }
 
    function getData(node) {
        var data = jQuery.data(node, 'event_swipe');
         
        if (!data) {
            data = { count: 0 };
            jQuery.data(node, 'event_swipe', data);
        }
         
        return data;
    }
 
    jQuery.event.special.swipe =
    jQuery.event.special.swipeleft =
    jQuery.event.special.swiperight =
    jQuery.event.special.swipeup =
    jQuery.event.special.swipedown = {
        setup: function( data, namespaces, eventHandle ) {
            var data = getData(this);
 
            // If another swipe event is already setup, don't setup again.
            if (data.count++ > 0) { return; }
 
            add(this, 'moveend', moveend);
 
            return true;
        },
 
        teardown: function() {
            var data = getData(this);
 
            // If another swipe event is still setup, don't teardown.
            if (--data.count > 0) { return; }
 
            remove(this, 'moveend', moveend);
 
            return true;
        },
 
        settings: settings
    };
});

//jQuery.event.move
(function (module) {
	if (typeof define === 'function' && define.amd) {
		// AMD. Register as an anonymous module.
		define(['jquery'], module);
	} else {
		// Browser globals
		module(jQuery);
	}
})(function(jQuery, undefined){

	var // Number of pixels a pressed pointer travels before movestart
	    // event is fired.
	    threshold = 6,
	
	    add = jQuery.event.add,
	
	    remove = jQuery.event.remove,

	    // Just sugar, so we can have arguments in the same order as
	    // add and remove.
	    trigger = function(node, type, data) {
	    	jQuery.event.trigger(type, data, node);
	    },

	    // Shim for requestAnimationFrame, falling back to timer. See:
	    // see http://paulirish.com/2011/requestanimationframe-for-smart-animating/
	    requestFrame = (function(){
	    	return (
	    		window.requestAnimationFrame ||
	    		window.webkitRequestAnimationFrame ||
	    		window.mozRequestAnimationFrame ||
	    		window.oRequestAnimationFrame ||
	    		window.msRequestAnimationFrame ||
	    		function(fn, element){
	    			return window.setTimeout(function(){
	    				fn();
	    			}, 25);
	    		}
	    	);
	    })(),
	    
	    ignoreTags = {
	    	textarea: true,
	    	input: true,
	    	select: true,
	    	button: true
	    },
	    
	    mouseevents = {
	    	move: 'mousemove',
	    	cancel: 'mouseup dragstart',
	    	end: 'mouseup'
	    },
	    
	    touchevents = {
	    	move: 'touchmove',
	    	cancel: 'touchend',
	    	end: 'touchend'
	    };


	// Constructors
	
	function Timer(fn){
		var callback = fn,
				active = false,
				running = false;
		
		function trigger(time) {
			if (active){
				callback();
				requestFrame(trigger);
				running = true;
				active = false;
			}
			else {
				running = false;
			}
		}
		
		this.kick = function(fn) {
			active = true;
			if (!running) { trigger(); }
		};
		
		this.end = function(fn) {
			var cb = callback;
			
			if (!fn) { return; }
			
			// If the timer is not running, simply call the end callback.
			if (!running) {
				fn();
			}
			// If the timer is running, and has been kicked lately, then
			// queue up the current callback and the end callback, otherwise
			// just the end callback.
			else {
				callback = active ?
					function(){ cb(); fn(); } : 
					fn ;
				
				active = true;
			}
		};
	}


	// Functions
	
	function returnTrue() {
		return true;
	}
	
	function returnFalse() {
		return false;
	}
	
	function preventDefault(e) {
		e.preventDefault();
	}
	
	function preventIgnoreTags(e) {
		// Don't prevent interaction with form elements.
		if (ignoreTags[ e.target.tagName.toLowerCase() ]) { return; }
		
		e.preventDefault();
	}

	function isLeftButton(e) {
		// Ignore mousedowns on any button other than the left (or primary)
		// mouse button, or when a modifier key is pressed.
		return (e.which === 1 && !e.ctrlKey && !e.altKey);
	}

	function identifiedTouch(touchList, id) {
		var i, l;

		if (touchList.identifiedTouch) {
			return touchList.identifiedTouch(id);
		}
		
		// touchList.identifiedTouch() does not exist in
		// webkit yet… we must do the search ourselves...
		
		i = -1;
		l = touchList.length;
		
		while (++i < l) {
			if (touchList[i].identifier === id) {
				return touchList[i];
			}
		}
	}

	function changedTouch(e, event) {
		var touch = identifiedTouch(e.changedTouches, event.identifier);

		// This isn't the touch you're looking for.
		if (!touch) { return; }

		// Chrome Android (at least) includes touches that have not
		// changed in e.changedTouches. That's a bit annoying. Check
		// that this touch has changed.
		if (touch.pageX === event.pageX && touch.pageY === event.pageY) { return; }

		return touch;
	}


	// Handlers that decide when the first movestart is triggered
	
	function mousedown(e){
		var data;

		if (!isLeftButton(e)) { return; }

		data = {
			target: e.target,
			startX: e.pageX,
			startY: e.pageY,
			timeStamp: e.timeStamp
		};

		add(document, mouseevents.move, mousemove, data);
		add(document, mouseevents.cancel, mouseend, data);
	}

	function mousemove(e){
		var data = e.data;

		checkThreshold(e, data, e, removeMouse);
	}

	function mouseend(e) {
		removeMouse();
	}

	function removeMouse() {
		remove(document, mouseevents.move, mousemove);
		remove(document, mouseevents.cancel, mouseend);
	}

	function touchstart(e) {
		var touch, template;

		// Don't get in the way of interaction with form elements.
		if (ignoreTags[ e.target.tagName.toLowerCase() ]) { return; }

		touch = e.changedTouches[0];
		
		// iOS live updates the touch objects whereas Android gives us copies.
		// That means we can't trust the touchstart object to stay the same,
		// so we must copy the data. This object acts as a template for
		// movestart, move and moveend event objects.
		template = {
			target: touch.target,
			startX: touch.pageX,
			startY: touch.pageY,
			timeStamp: e.timeStamp,
			identifier: touch.identifier
		};

		// Use the touch identifier as a namespace, so that we can later
		// remove handlers pertaining only to this touch.
		add(document, touchevents.move + '.' + touch.identifier, touchmove, template);
		add(document, touchevents.cancel + '.' + touch.identifier, touchend, template);
	}

	function touchmove(e){
		var data = e.data,
		    touch = changedTouch(e, data);

		if (!touch) { return; }

		checkThreshold(e, data, touch, removeTouch);
	}

	function touchend(e) {
		var template = e.data,
		    touch = identifiedTouch(e.changedTouches, template.identifier);

		if (!touch) { return; }

		removeTouch(template.identifier);
	}

	function removeTouch(identifier) {
		remove(document, '.' + identifier, touchmove);
		remove(document, '.' + identifier, touchend);
	}


	// Logic for deciding when to trigger a movestart.

	function checkThreshold(e, template, touch, fn) {
		var distX = touch.pageX - template.startX,
		    distY = touch.pageY - template.startY;

		// Do nothing if the threshold has not been crossed.
		if ((distX * distX) + (distY * distY) < (threshold * threshold)) { return; }

		triggerStart(e, template, touch, distX, distY, fn);
	}

	function handled() {
		// this._handled should return false once, and after return true.
		this._handled = returnTrue;
		return false;
	}

	function flagAsHandled(e) {
		e._handled();
	}

	function triggerStart(e, template, touch, distX, distY, fn) {
		var node = template.target,
		    touches, time;

		touches = e.targetTouches;
		time = e.timeStamp - template.timeStamp;

		// Create a movestart object with some special properties that
		// are passed only to the movestart handlers.
		template.type = 'movestart';
		template.distX = distX;
		template.distY = distY;
		template.deltaX = distX;
		template.deltaY = distY;
		template.pageX = touch.pageX;
		template.pageY = touch.pageY;
		template.velocityX = distX / time;
		template.velocityY = distY / time;
		template.targetTouches = touches;
		template.finger = touches ?
			touches.length :
			1 ;

		// The _handled method is fired to tell the default movestart
		// handler that one of the move events is bound.
		template._handled = handled;
			
		// Pass the touchmove event so it can be prevented if or when
		// movestart is handled.
		template._preventTouchmoveDefault = function() {
			e.preventDefault();
		};

		// Trigger the movestart event.
		trigger(template.target, template);

		// Unbind handlers that tracked the touch or mouse up till now.
		fn(template.identifier);
	}


	// Handlers that control what happens following a movestart

	function activeMousemove(e) {
		var event = e.data.event,
		    timer = e.data.timer;

		updateEvent(event, e, e.timeStamp, timer);
	}

	function activeMouseend(e) {
		var event = e.data.event,
		    timer = e.data.timer;
		
		removeActiveMouse();

		endEvent(event, timer, function() {
			// Unbind the click suppressor, waiting until after mouseup
			// has been handled.

			setTimeout(function(){
				remove(event.target, 'click', returnFalse);
			}, 0);
		});
	}

	function removeActiveMouse(event) {
		remove(document, mouseevents.move, activeMousemove);
		remove(document, mouseevents.end, activeMouseend);
	}

	function activeTouchmove(e) {
		var event = e.data.event,
		    timer = e.data.timer,
		    touch = changedTouch(e, event);

		if (!touch) { return; }

		// Stop the interface from gesturing
		e.preventDefault();

		event.targetTouches = e.targetTouches;
		updateEvent(event, touch, e.timeStamp, timer);
	}

	function activeTouchend(e) {
		var event = e.data.event,
		    timer = e.data.timer,
		    touch = identifiedTouch(e.changedTouches, event.identifier);

		// This isn't the touch you're looking for.
		if (!touch) { return; }

		removeActiveTouch(event);
		endEvent(event, timer);
	}

	function removeActiveTouch(event) {
		remove(document, '.' + event.identifier, activeTouchmove);
		remove(document, '.' + event.identifier, activeTouchend);
	}


	// Logic for triggering move and moveend events

	function updateEvent(event, touch, timeStamp, timer) {
		var time = timeStamp - event.timeStamp;

		event.type = 'move';
		event.distX =  touch.pageX - event.startX;
		event.distY =  touch.pageY - event.startY;
		event.deltaX = touch.pageX - event.pageX;
		event.deltaY = touch.pageY - event.pageY;
		
		// Average the velocity of the last few events using a decay
		// curve to even out spurious jumps in values.
		event.velocityX = 0.3 * event.velocityX + 0.7 * event.deltaX / time;
		event.velocityY = 0.3 * event.velocityY + 0.7 * event.deltaY / time;
		event.pageX =  touch.pageX;
		event.pageY =  touch.pageY;

		timer.kick();
	}

	function endEvent(event, timer, fn) {
		timer.end(function(){
			event.type = 'moveend';

			trigger(event.target, event);
			
			return fn && fn();
		});
	}


	// jQuery special event definition

	function setup(data, namespaces, eventHandle) {
		// Stop the node from being dragged
		//add(this, 'dragstart.move drag.move', preventDefault);
		
		// Prevent text selection and touch interface scrolling
		//add(this, 'mousedown.move', preventIgnoreTags);
		
		// Tell movestart default handler that we've handled this
		add(this, 'movestart.move', flagAsHandled);

		// Don't bind to the DOM. For speed.
		return true;
	}
	
	function teardown(namespaces) {
		remove(this, 'dragstart drag', preventDefault);
		remove(this, 'mousedown touchstart', preventIgnoreTags);
		remove(this, 'movestart', flagAsHandled);
		
		// Don't bind to the DOM. For speed.
		return true;
	}
	
	function addMethod(handleObj) {
		// We're not interested in preventing defaults for handlers that
		// come from internal move or moveend bindings
		if (handleObj.namespace === "move" || handleObj.namespace === "moveend") {
			return;
		}
		
		// Stop the node from being dragged
		add(this, 'dragstart.' + handleObj.guid + ' drag.' + handleObj.guid, preventDefault, undefined, handleObj.selector);
		
		// Prevent text selection and touch interface scrolling
		add(this, 'mousedown.' + handleObj.guid, preventIgnoreTags, undefined, handleObj.selector);
	}
	
	function removeMethod(handleObj) {
		if (handleObj.namespace === "move" || handleObj.namespace === "moveend") {
			return;
		}
		
		remove(this, 'dragstart.' + handleObj.guid + ' drag.' + handleObj.guid);
		remove(this, 'mousedown.' + handleObj.guid);
	}
	
	jQuery.event.special.movestart = {
		setup: setup,
		teardown: teardown,
		add: addMethod,
		remove: removeMethod,

		_default: function(e) {
			var template, data;
			
			// If no move events were bound to any ancestors of this
			// target, high tail it out of here.
			if (!e._handled()) { return; }

			template = {
				target: e.target,
				startX: e.startX,
				startY: e.startY,
				pageX: e.pageX,
				pageY: e.pageY,
				distX: e.distX,
				distY: e.distY,
				deltaX: e.deltaX,
				deltaY: e.deltaY,
				velocityX: e.velocityX,
				velocityY: e.velocityY,

				timeStamp: e.timeStamp,
				identifier: e.identifier,
				targetTouches: e.targetTouches,
				finger: e.finger
			};

			data = {
				event: template,
				timer: new Timer(function(time){
					trigger(e.target, template);
				})
			};
			
			if (e.identifier === undefined) {
				// We're dealing with a mouse
				// Stop clicks from propagating during a move
				add(e.target, 'click', returnFalse);
				add(document, mouseevents.move, activeMousemove, data);
				add(document, mouseevents.end, activeMouseend, data);
			}
			else {
				// We're dealing with a touch. Stop touchmove doing
				// anything defaulty.
				e._preventTouchmoveDefault();
				add(document, touchevents.move + '.' + e.identifier, activeTouchmove, data);
				add(document, touchevents.end + '.' + e.identifier, activeTouchend, data);
			}
		}
	};

	jQuery.event.special.move = {
		setup: function() {
			// Bind a noop to movestart. Why? It's the movestart
			// setup that decides whether other move events are fired.
			add(this, 'movestart.move', jQuery.noop);
		},
		
		teardown: function() {
			remove(this, 'movestart.move', jQuery.noop);
		}
	};
	
	jQuery.event.special.moveend = {
		setup: function() {
			// Bind a noop to movestart. Why? It's the movestart
			// setup that decides whether other move events are fired.
			add(this, 'movestart.moveend', jQuery.noop);
		},
		
		teardown: function() {
			remove(this, 'movestart.moveend', jQuery.noop);
		}
	};

	add(document, 'mousedown.move', mousedown);
	add(document, 'touchstart.move', touchstart);

	// Make jQuery copy touch event properties over to the jQuery event
	// object, if they are not already listed. But only do the ones we
	// really need. IE7/8 do not have Array#indexOf(), but nor do they
	// have touch events, so let's assume we can ignore them.
	if (typeof Array.prototype.indexOf === 'function') {
		(function(jQuery, undefined){
			var props = ["changedTouches", "targetTouches"],
			    l = props.length;
			
			while (l--) {
				if (jQuery.event.props.indexOf(props[l]) === -1) {
					jQuery.event.props.push(props[l]);
				}
			}
		})(jQuery);
	};
});