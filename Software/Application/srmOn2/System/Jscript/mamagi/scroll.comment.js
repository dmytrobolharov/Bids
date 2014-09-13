 jQuery(window).load(function () {
	jQuery(".CommentsScroll").parent().parent().width(250)
	
	jQuery(".CommentsScroll").parent().each(function(n,commentSpan){
		var commentWidth = 240;
		commentSpanID = jQuery(this).attr('id');
		jQuery(this).css("display","block");
		jQuery(this).css("overflow","hidden");
		jQuery(this).css("position","relative"); // ie requires it for overflow:hidden to work properly
		jQuery(this).width(commentWidth+10);
		
		commentScrollLeft = jQuery("#" + commentSpanID + " .CommentsScrollLeft");
		commentScrollRight = jQuery("#" + commentSpanID + " .CommentsScrollRight");
		commentScrollDiv = jQuery("#" + commentSpanID + " .CommentsScroll");
		
		commentScrollDiv.css("position", "relative");
		commentScrollDiv.css("left","0");
		commentScrollLeft.css("background","#aaa url(../System/images/MAMAGI/scroll-left.png) no-repeat 50% 50%");
		commentScrollRight.css("background","#aaa url(../System/images/MAMAGI/scroll-right.png) no-repeat 50% 50%");
		commentScrollLeft.css("width","10px");
		commentScrollRight.css("width","10px");
		commentScrollLeft.css("float","left");
		commentScrollRight.css("float","left");
		commentScrollLeft.css("position","absolute");
		commentScrollRight.css("position","absolute");
		commentScrollLeft.css("z-index","1");
		commentScrollRight.css("z-index","1");
		commentScrollLeft.css("cursor","pointer");
		commentScrollRight.css("cursor","pointer");
		commentScrollRight.css("margin-left",(commentWidth)+"px");
		
		var scrollDivWidth = 0;
		var imgWidth = 0;
		var imagesCount = 0;
		jQuery("#" + commentSpanID + " .CommentsScroll *").each(function(n,element){
			jQuery(this).css('margin','0 2px');
			scrollDivWidth = scrollDivWidth + jQuery(this).width()+4;
			imgWidth = jQuery(this).width()+4;
			imagesCount = imagesCount + 1;
		});
		
		//jQuery(this).width(commentWidth);
		if(jQuery.browser.msie)
			commentScrollDiv.width(scrollDivWidth+10);
		else 
			commentScrollDiv.width(scrollDivWidth);
		//alert(scrollDivWidth);
		commentScrollDiv.css("padding-left","10px");
		commentScrollLeft.height(commentScrollDiv.height());
		commentScrollRight.height(commentScrollDiv.height());
		//alert(commentScrollRight.height());
		commentScrollRight.click(function(){
			scrollDiv = jQuery(this).parent().find(".CommentsScroll");
			if(Math.abs((parseInt(scrollDiv.css("left")) - imgWidth)) <= scrollDiv.width()-commentWidth)
				scrollDiv.animate({"left": "-="+imgWidth+"px"}, "fast");
			else if(Math.abs((parseInt(scrollDiv.css("left")) - imgWidth)) - scrollDiv.width()+commentWidth < imgWidth)
				scrollDiv.animate({"left": "-="+(imgWidth-(Math.abs((parseInt(scrollDiv.css("left")) - imgWidth)) - scrollDiv.width()+commentWidth-10))+"px"}, "fast");
		});
		
		commentScrollLeft.click(function(){
			scrollDiv = jQuery(this).parent().find(".CommentsScroll");
			if((parseInt(scrollDiv.css("left")) + imgWidth)<=0){
				scrollDiv.animate({"left": "+="+imgWidth+"px"}, "fast");
			}
			else if((parseInt(scrollDiv.css("left")) + imgWidth) < imgWidth){
				scrollDiv.animate({"left": "0px"}, "fast");
			}
		});
		
		if(imagesCount==0){
			commentScrollRight.hide();
			commentScrollLeft.hide();
		}
	});
});