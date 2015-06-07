(function () {
    window.__WaitControll = {
        init: function () {
            this.element = document.createElement('div');
            var childEl = document.createElement('div'),
				ie8fix = check_old_ie() ? ' waitBoxImgContainerIE8' : '';
            childEl.className = 'waitBoxImgContainer' + ie8fix;
            this.element.appendChild(childEl);

            this.element.onmousedown = function () {
                return false;
            };
            this.element.style.display = 'none';
            this.element.className = 'showWaitControll';
            this.once_disable_wait_text = false;
            this.twice_disable_wait_text = false;
        },
        show: function () {
            if (this.twice_disable_wait_text) {
                this.twice_disable_wait_text = false;
                return;
            }
            if (this.once_disable_wait_text) {
                this.once_disable_wait_text = false;
                return;
            }
            //block try...catch added from IE 10
            try {
                document.getElementsByTagName('body')[0].appendChild(this.element);
                this.element.style.display = 'block';
            } catch (ex) { }
        },
        hide: function () {
            this.element.style.display = 'none';
        }
    };

    if (window.addEventListener) {
        window.addEventListener("load", function (event) {
            __WaitControll.init();
            disable_waittext_for_calendar();
        });
        window.addEventListener("beforeunload", function (event) {
            __WaitControll.show();
        });
    } else {
        //for old IE
        window.attachEvent("onload", function (event) {
            __WaitControll.init();
            disable_waittext_for_calendar();
        });
        window.attachEvent("onbeforeunload", function (event) {
            __WaitControll.show();
        });
    }

} (window));

function show_wait_text() {
    __WaitControll.show();
}

function hide_wait_text() {
    __WaitControll.hide();
}

function disable_waittext_for_calendar() {
    var i;
    var allelements = Array();

    allelements = document.getElementsByTagName('a');

    for (i = 0; i < allelements.length; i++) {
        if (allelements[i].href.substr(0, 19) == 'javascript:calendar' ||
			allelements[i].href.substr(0, 23) == 'javascript:customwindow' ||
			allelements[i].href.substr(0, 27) == 'javascript:void(window.open') {
            if (!document.addEventListener) {
                //for old IE
                allelements[i].attachEvent('onclick', dont_show_wait_next_time);
            } else {
                allelements[i].addEventListener('click', dont_show_wait_next_time);
            }
        }
    }
}

function dont_show_wait_next_time() {
    __WaitControll.once_disable_wait_text = true;
}

function dont_show_wait_twice() {
    dont_show_wait_next_time();
    __WaitControll.twice_disable_wait_text = true;
}

function check_old_ie() {
    if (navigator.appVersion.indexOf("MSIE 7.") != -1) {
        return true;
    }
    return false;
}
