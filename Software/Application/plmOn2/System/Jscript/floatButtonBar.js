(function($,window){
    //on document.ready
    $(function(){
        //try to find class TableFloatHeader if you want be specific on what element to apply
        var positionElem = $('table.TableFloatHeader');
        //if there is no element with class = TableHeaderPositioning => pick 1st table with class TableHeader on page.
        var element = positionElem.length>0 ? positionElem : $('table.TableHeader:first'),
            elementTop = element.offset().top,
            positionBefore = element.css('position')||'static',
            $body = $("body"),
            $elementHeight = element.height(),
            $bodyMarginTop = $('body').css('margin-top'),
            isQuirksModeOn= document.documentMode === 7 || document.compatMode == 'BackCompat';
        $(window).scroll(function () {
            //hate IE7
            var scrollTop = isQuirksModeOn ? $('body').scrollTop()||$(document).scrollTop():$(document).scrollTop();
            if (elementTop < scrollTop) {
                //we want to be sure that body wouldnt collapse after
                //before setting position Fixed to an element,
                $body.css("margin-top", $elementHeight);
                //for old browsers we will use absolute position instead of fixed
                if(isQuirksModeOn){
                    element.css({
                        'position': 'absolute',
                        'z-index': 99999,
                        'top': document.compatMode == 'BackCompat'? document.body.scrollTop + 'px':document.documentElement.scrollTop+'px'
                    });
                }else{
                    element.css({
                        'position': 'fixed',
                        'z-index': 99999,
                        'top': '0px'
                    });
                }
            }
            else {
                $body.css("margin-top", $bodyMarginTop);
                element.css({
                    'position' : positionBefore,
                    'top': elementTop
                });
            }

        });
    });
})(jQuery,window);

