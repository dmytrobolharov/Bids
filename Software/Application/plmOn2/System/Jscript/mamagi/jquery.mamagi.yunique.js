/*
 * jQuery mamagi
 *
 * Copyright (c) 2011 FlexBricks.com
 */
jQuery.fn.mamagi = function(options){
	var options = jQuery.extend({
		previewHeight:300,
		previewWidth:300
	},options);
	
	var isTouchDevice = !!('ontouchstart' in window);
	
	document.ondragstart = function() { return false }

	function fixEvent(e) {
		e = e || window.event
		if ( e.pageX == null && e.clientX != null ) {
			var html = document.documentElement
			var body = document.body
			e.pageX = e.clientX + (html && html.scrollLeft || body && body.scrollLeft || 0) - (html.clientLeft || 0)
			e.pageY = e.clientY + (html && html.scrollTop || body && body.scrollTop || 0) - (html.clientTop || 0)
		}
		if (!e.which && e.button) {
			e.which =e.button & 1 ? 1 : ( e.button & 2 ? 3 : ( e.button & 4 ? 2 : 0 ) )
		}
		if (isTouchDevice){
			e=window.event.targetTouches[0]
			e.which=1;
		}
		return e
	}
		
	return this.each(function() {
		var Mamagi=jQuery(this)
		Mamagi.css("position","relative")
				.height(options.previewHeight)
				.width(options.previewWidth)
		Mamagi.append("<img class='mamagiPreview'  style='position:absolute; cursor:pointer;' />")
		var Preview=Mamagi.find('img.mamagiPreview')
		var img=new Image();
			img.onload = function(){
				if (img.height > options.previewHeight) ky=options.previewHeight/img.height
					else ky=1;
				if (img.width > options.previewWidth) kx=options.previewWidth/img.width
					else kx=1;
				k=Math.min(kx,ky)
				var x2=img.width*k
				var y2=img.height*k
				
				Preview.attr("src",img.src)
						.height(y2+"px")
						.width(x2+"px")
						.css('left',(options.previewWidth-x2).toFixed(2)/2)
						.css('top',(options.previewHeight-y2).toFixed(2)/2)
						.data('thumb',{"width":img.width,"height":img.height});
				Preview.data("image",Mamagi.data())
				rotate(Preview)
				delete img;
			}
			img.src=Mamagi.data().path+"s_1.jpg";
	});
	/*************************************************************************************/
	function rotate(obj){
		if (obj.data("currFrame")){
			var currFrame=obj.data("currFrame")
			obj.bind((isTouchDevice ? "touchstart" : "mousedown"), function(e) {
						mouseDown(e)
						e.preventDefault();
					});
		}
		else 
		{
			var currFrame=1
			var progressWidth=obj.width();
			var progressStep=progressWidth/obj.data("image").framecount;
			var progressPossition=obj.position()
			
			obj.parent().append("<div id='mamagiProgress' style='height:"+obj.height()+"px;width:"+obj.width()+"px; position:absolute;cursor:progress; overflow: hidden;top:"+progressPossition.top+"px; right:"+progressPossition.left+"px;'>"+
									"<img src='"+obj.data('image').path+"s_1.jpg' id='mamagiProgressBW' style='height:"+obj.height()+"px; width:"+obj.width()+"px; float: right;' />"+
								"</div>")
			
			/*desaturate*/
			var imgObj = document.getElementById('mamagiProgressBW');
			imgObj=obj.parent().find("img#mamagiProgressBW").get(0);
			if(jQuery.browser.msie){
					imgObj.style.filter = 'progid:DXImageTransform.Microsoft.BasicImage(grayScale=1)';
			} else {
				var canvas = document.createElement('canvas');
				var canvasContext = canvas.getContext('2d');
				
				var imgW = obj.data('thumb').width;
				var imgH = obj.data('thumb').height;

				canvas.width = imgW;
				canvas.height = imgH;
				
				canvasContext.drawImage(imgObj, 0, 0);
				var imgPixels = canvasContext.getImageData(0, 0, imgW, imgH);
				
				for(var y = 0; y < imgPixels.height; y++){
					for(var x = 0; x < imgPixels.width; x++){
						var i = (y * 4) * imgPixels.width + x * 4;
						var avg = (imgPixels.data[i] + imgPixels.data[i + 1] + imgPixels.data[i + 2]) / 3;
						imgPixels.data[i] = avg; 
						imgPixels.data[i + 1] = avg; 
						imgPixels.data[i + 2] = avg;
					}
				}
				canvasContext.putImageData(imgPixels, 0, 0, 0, 0, imgPixels.width, imgPixels.height);
								
				imgObj.src=canvas.toDataURL();
			}
			/*desaturate*/
			obj.parent().append("<div class='mamagiProgressLoadingWrapper' style='left:"+((obj.parent().width())/2-50+10)+"px; top:"+((obj.parent().height()+16)/2)+"px;'><span id='mamagiProgressLoading' style=''>Loading 0%</span></div>")
			var loading=obj.parent().find('div#mamagiProgress')
			var loadPercent=obj.parent().find('span#mamagiProgressLoading')
			var loadPercentStep=(100/obj.data("image").framecount)
			var frames = []
			loadFrame(1)
		}
		var mouseDownAt=null;
		var mouseClick=null;
		function mouseUp(e) {
			jQuery(document).unbind(isTouchDevice ? "touchmove" : "mousemove")
			jQuery(document).unbind(isTouchDevice ? "touchend" : "mouseup")
			jQuery('body').css('cursor', 'default')
			if ((mouseDownAt.x==mouseClick.x)){
					location.href=obj.data("image").link	
			}
			mouseDownAt = null
			return true
		}
		
		function mouseDown(e) {
			e=fixEvent(e)
			if (e.which!=1) return
			mouseDownAt = { x: e.pageX }
			mouseClick={ x: e.pageX, y:e.pageY };
			jQuery(document).bind((isTouchDevice ? "touchmove" : "mousemove"),function(e){
																				rotateMouseMove(e); 
																				e.preventDefault();
																			}
			)
			if(obj.data("image").framecount > 1)
			    jQuery('body').css('cursor','e-resize')
			jQuery(document).bind((isTouchDevice ? "touchend" : "mouseup"),mouseUp)

		}
		function rotateMouseMove(e){
			e=fixEvent(e)
			if (mouseDownAt) {
				if ((Math.abs(mouseDownAt.x-e.pageX) < obj.data("step"))) {
					return
				}
				if (mouseDownAt.x > e.pageX) nextFrame();
				if (mouseDownAt.x < e.pageX) prevFrame();
				
				mouseDownAt = { x: e.pageX }
			}
			
			return false;
		}
		function prevFrame(){
			if (currFrame==1) {currFrame=obj.data("image").framecount}
			else {--currFrame}
			obj.data("currFrame",currFrame)
			obj.attr('src',obj.data("frames")[currFrame].src);
		}
		function nextFrame()
		{
			if (currFrame==obj.data("image").framecount){currFrame=1}
			else {++currFrame}
			obj.data("currFrame",currFrame)
			obj.attr('src',obj.data("frames")[currFrame].src);
		}
		function loadFrame(i)
		{
			loading.width(loading.width()-progressStep);
			if (jQuery.browser.msie) loading.find('img').css("margin-left",(loading.outerWidth()-progressWidth-3))
			
			loadPercent.html("Loading "+Math.round(i*loadPercentStep)+"%")
			frames[i] = new Image();
			frames[i].onload = function(){
				if (i < obj.data("image").framecount){
					loadFrame(++i);
					return
				}
				
				if (i==obj.data("image").framecount){
					obj.attr('src',frames[currFrame].src)
					obj.data("currFrame",currFrame)
					obj.data("step", Math.round(obj.width()/obj.data("image").framecount))
					obj.data("frames", frames)
					obj.data("loaded", true)
					obj.bind((isTouchDevice ? "touchstart" : "mousedown"), function(e) {
						mouseDown(e)
					});
					loading.remove()
					loadPercent.parent().remove();
					if(obj.data("image").framecount > 1)
					    obj.css('cursor','e-resize');
					
					if (options.autoplay) autoPlay();
				}
			};
			setTimeout(function(){frames[i].src = obj.data("image").path+"s_"+i+".jpg"}, 0)
		}
	}
};