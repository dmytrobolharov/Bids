<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Folder.aspx.vb" Inherits="plmOnApp.Control_Folder" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>

            <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>

<script type="text/javascript" language="javascript">
    var busyBox;
    var once_disable_wait_text = false;
    var wait_text_is_shown = false;

    function show_wait_text() {
        var e;
        var width = 0;
        var height = 0;
        var x = 0;
        var y = 0;

        if (once_disable_wait_text) {
            once_disable_wait_text = false;
            return;
        }

        wait_text_is_shown = true;

        e = document.getElementById("mainF").contentWindow.document.getElementById("div_wait");

        if (self.innerWidth)
            width = self.innerWidth;
        else if (document.getElementById("mainF").contentWindow.document.documentElement && document.getElementById("mainF").contentWindow.document.documentElement.clientWidth)
            width = document.getElementById("mainF").contentWindow.document.documentElement.clientWidth;
        else if (document.getElementById("mainF").contentWindow.document.body)
            width = document.getElementById("mainF").contentWindow.document.body.clientWidth;

        //if (document.body.scrollWidth > width)
        //    width = document.body.scrollWidth;

        if (self.innerHeight)
            height = self.innerHeight;
        else if (document.getElementById("mainF").contentWindow.document.documentElement && document.getElementById("mainF").contentWindow.document.documentElement.clientHeight)
            height = document.getElementById("mainF").contentWindow.document.documentElement.clientHeight;
        else if (document.getElementById("mainF").contentWindow.document.body)
            height = document.getElementById("mainF").contentWindow.document.body.clientHeight;

        //if (document.body.scrollHeight > height)
        //    height = document.body.scrollHeight;

        x = self.pageXOffset || (document.getElementById("mainF").contentWindow.document.documentElement && document.getElementById("mainF").contentWindow.document.documentElement.scrollLeft) || (document.getElementById("mainF").contentWindow.document.body && document.getElementById("mainF").contentWindow.document.body.scrollLeft);
        y = self.pageYOffset || (document.getElementById("mainF").contentWindow.document.documentElement && document.getElementById("mainF").contentWindow.document.documentElement.scrollTop) || (document.getElementById("mainF").contentWindow.document.body && document.getElementById("mainF").contentWindow.document.body.scrollTop);

        if (e) {
            e.style.width = width + 'px';
            e.style.height = height + 'px';
            e.style.left = x;
            e.style.top = y;
            e.style.display = 'block';
        }

        e = document.getElementById("mainF").contentWindow.document.getElementById("div_wait_text");
        if (e) {
            e.style.width = width + 'px';
            e.style.height = height + 'px';
            e.style.left = x;
            e.style.top = y;
            e.style.display = 'block';
        }
    }

    function hide_wait_text() {

        wait_text_is_shown = false;

        e = document.getElementById("mainF").contentWindow.document.getElementById("div_wait");
        if (e) {
            e.style.display = 'none';
        }

        e = document.getElementById("div_wait_text");
        if (e)
            e.style.display = 'none';
    }

    function dont_show_wait_next_time() {
        once_disable_wait_text = true;
    }

    function disable_waittext_for_calendar() {
        var i;
        var allelements = Array();

        allelements = document.getElementById("mainF").contentWindow.document.getElementsByTagName('a');

        for (i = 0; i < allelements.length; i++)
            if (allelements[i].href.substr(0, 19) == 'javascript:calendar' || allelements[i].href.substr(0, 23) == 'javascript:customwindow')
                allelements[i].attachEvent('onclick', dont_show_wait_next_time);

    }

    function wait_text_resize() {
        if (wait_text_is_shown) {
            e = document.getElementById("mainF").contentWindow.document.getElementById("div_wait");

            if (self.innerWidth)
                width = self.innerWidth;
            else if (document.getElementById("mainF").contentWindow.document.documentElement && document.getElementById("mainF").contentWindow.document.documentElement.clientWidth)
                width = document.getElementById("mainF").contentWindow.document.documentElement.clientWidth;
            else if (document.getElementById("mainF").contentWindow.document.body)
                width = document.getElementById("mainF").contentWindow.document.body.clientWidth;

            //if (document.body.scrollWidth > width)
            //    width = document.body.scrollWidth;

            if (self.innerHeight)
                height = self.innerHeight;
            else if (document.getElementById("mainF").contentWindow.document.documentElement && document.getElementById("mainF").contentWindow.document.documentElement.clientHeight)
                height = document.getElementById("mainF").contentWindow.document.documentElement.clientHeight;
            else if (document.getElementById("mainF").contentWindow.document.body)
                height = document.getElementById("mainF").contentWindow.document.body.clientHeight;

            //if (document.body.scrollHeight > height)
            //    height = document.body.scrollHeight;

            x = self.pageXOffset || (document.getElementById("mainF").contentWindow.document.documentElement && document.getElementById("mainF").contentWindow.document.documentElement.scrollLeft) || (document.getElementById("mainF").contentWindow.document.body && document.getElementById("mainF").contentWindow.document.body.scrollLeft);
            y = self.pageYOffset || (document.getElementById("mainF").contentWindow.document.documentElement && document.getElementById("mainF").contentWindow.document.documentElement.scrollTop) || (document.getElementById("mainF").contentWindow.document.body && document.getElementById("mainF").contentWindow.document.body.scrollTop);

            if (e) {
                e.style.width = width + 'px';
                e.style.height = height + 'px';
                e.style.left = x;
                e.style.top = y;
            }

            e = document.getElementById("mainF").contentWindow.document.getElementById("div_wait_text");
            if (e) {
                e.style.width = width + 'px';
                e.style.height = height + 'px';
                e.style.left = x;
                e.style.top = y;
            }
        }
    }

    function wait_text_onscroll() {
        var e;
        var x = 0;
        var y = 0;

        x = self.pageXOffset || (document.getElementById("mainF").contentWindow.document.documentElement && document.getElementById("mainF").contentWindow.document.documentElement.scrollLeft) || (document.getElementById("mainF").contentWindow.document.body && document.getElementById("mainF").contentWindow.document.body.scrollLeft);
        y = self.pageYOffset || (document.getElementById("mainF").contentWindow.document.documentElement && document.getElementById("mainF").contentWindow.document.documentElement.scrollTop) || (document.getElementById("mainF").contentWindow.document.body && document.getElementById("mainF").contentWindow.document.body.scrollTop);

        e = document.getElementById("mainF").contentWindow.document.getElementById("div_wait");
        if (e) {
            e.style.left = x;
            e.style.top = y;
        }

        e = document.getElementById("mainF").contentWindow.document.getElementById("div_wait_text");
        if (e) {
            e.style.left = x;
            e.style.top = y;
        }

    }


    // $(window).load(function () { disable_waittext_for_calendar(); });
    // $(window).resize(function () { wait_text_resize(); });
    //  $(window).scroll(function () { wait_text_onscroll(); });




    function BusyBox(varName, imageCount, imageNamePrefix, imageNameSuffix, imageDelay) {
        // Initialize object
        this.VarName = varName;
        this.ImageCount = imageCount;
        this.ImageNamePrefix = imageNamePrefix;
        this.ImageNameSuffix = imageNameSuffix;
        this.ImageDelay = imageDelay;

        // Allows us to stop the animation with clearTimeout(), should we ever want t
        this.timeout_id = null;

        // Cache (pre-load) imageso
        this.CurrentImageIndex = 0;
        this.CacheImages();

        // Get reference to the IFrame object
        // this.div = document.getElementById("BusyBoxDiv");
        this.img = document.getElementById("mainF").contentWindow.document.getElementById("BusyBoxImg");

        // Hide the busy box
        this.Hide();
    }

    BusyBox.prototype.CacheImages = function () {
        // Instantiate the array to store the image references
        this.Images = new Array(this.ImageCount);

        // Load all the images to cache into the aniframes array
        for (var i = 0; i < this.ImageCount; i++) {
            this.Images[i] = new Image();
            this.Images[i].src = '../System/Images/' + this.ImageNamePrefix + i + this.ImageNameSuffix;
            // alert(this.Images[i].src);
        }
    }
    // IsAnimating:
    // Returns a boolean value representing the state of the animation.
    BusyBox.prototype.IsAnimating = function () {
        return this.timeout_id != null;
    }


    // IsVisible:
    // Returns a boolean value representing the visibility state for the busy box.
    BusyBox.prototype.IsVisible = function () {
        return false;
    }


    // Animate:
    // Performs the animation process.  This is accomplished by showing the "current"
    // image in the animation sequence process; and then submitting a timed statement
    // to execute in x number of milliseconds.
    BusyBox.prototype.Animate = function () {
     try{
        this.img.src = this.Images[this.CurrentImageIndex].src;
    } catch (e) {

    }

        // Increment the current image index
        this.CurrentImageIndex = (this.CurrentImageIndex + 1) % this.ImageCount;

        // Display the next image in (imageDelay value) milliseconds (i.e. 125)
        this.timeout_id = setTimeout(this.VarName + ".Animate();", this.ImageDelay);
    }


    // StartAnimation:
    // Starts the animation process.
    BusyBox.prototype.StartAnimate = function () {
        if (this.IsAnimating())
            return;

        this.Animate();
    }


    // StopAnimation:
    // Stops the animation process.
    BusyBox.prototype.StopAnimate = function () {
        clearTimeout(this.timeout_id);
        this.timeout_id = null;
    }


    // Hide:
    // Hides the busy box making it invisible to the user.
    BusyBox.prototype.Hide = function () {
        this.StopAnimate();


    }


    // Show:
    // This function displays the busy box to the user.  This function centers the
    // busy dialog box, makes it visible, and starts the animation.  This function
    // will typically be called by the body event.
    //
    // Example:
    //    <body onbeforeunload="busyBox.Show();" >
    BusyBox.prototype.Show = function () {
        if (this.IsAnimating() || this.IsVisible())
            return;

        // Start the animation
        this.StartAnimate();
    }


    // $(window).bind('beforeunload', function () { show_wait_text(); busyBox.Show(); });
</script>
	</HEAD>

    <script type="text/javascript">

        function addUnload() {
            $(document.getElementById("mainF").contentWindow.document.body).prepend(' <div id=\'div_wait\' style="display: none; margin: 0; padding: 0; border: 0; background-color: #f5f5f5; filter:alpha(opacity=70); opacity: 0.7; position: absolute; left: 0; top: 0;">' +

'</div>' +

'<div id=\'div_wait_text\' style="display: none; margin: 0; padding: 0; border: 0; position: absolute; left: 0; top: 0;z-index:999">' +
   ' <table width="100%" height="100%" border="0">' +
       ' <tr align="center">' +
           '<td align="center">' +
            '   <table border="0">' +
                  '  <tr align="center">' +
                    '   <td>' +
                       '     <img ID="BusyBoxImg"  src=\'../System/Images/busy_Layer_0.gif\' />' +
                     '   </td>' +
                     '   <td>' +
                         '   <label ID="LabelWait"  Font-Bold="true" Font-Size="14"></label>' +
                       ' </td>' +
                   ' </tr>' +
               ' </table>' +
         '   </td>' +
       ' </tr>' +
    '</table>' +

'</div>');
            busyBox = new BusyBox("busyBox", 12, "busy_Layer_", ".gif", 120);
            disable_waittext_for_calendar();
            // document.getElementById("mainF").contentWindow.document.body.onunload = function () { show_wait_text(); busyBox.Show(); }
            document.getElementById("mainF").contentWindow.onbeforeunload = function () { show_wait_text(); busyBox.Show(); }

        }
            
       
		</script>

	<FRAMESET cols="250,*" bordercolor="#dbd7d0">
		<frame SRC="<%=URLMenu%>" name="menuC" SCROLLING=yes marginheight=0 marginwidth=0 >
		<frame src="<%=URLMain%>" name="mainC" id="mainF" scrolling="auto" marginheight=0 marginwidth=0 onload="addUnload();">
	</FRAMESET>
</HTML>
