
function AnchorPositionLeft(el) {
   var ol = el.offsetLeft; 
   while((el = el.offsetParent) != null) {
      ol += el.offsetLeft; 
      }
   return ol; 
   }

function AnchorPositionTop(el) {
   var ot = el.offsetTop; 
   while((el = el.offsetParent) != null) {
      ot += el.offsetTop; 
      }
   return ot; 
   }

function calendar(sTxtBoxName) {
    calendarPostBack(sTxtBoxName, 0);
    /*var anchorname = "a" + sTxtBoxName;
    var coordinates = 0;  
    var useWindow = false; 
    var coordinates = new Object(); 
    var x = 0; 
    var y = 0;

    var o = document.getElementById(anchorname);
    if (o == null) {
        var strID = sTxtBoxName.replace("$", "_");
        o = document.getElementById(strID);
    }
   
   x = AnchorPositionLeft(o); 
   y = AnchorPositionTop(o); 

   coordinates.x = x;
   coordinates.y = y;

   if (isNaN(window.screenX)) {
     coordinates.x = coordinates.x - document.body.scrollLeft + window.screenLeft; 
     coordinates.y = y = coordinates.y - document.body.scrollTop + window.screenTop; 
   }
   else {
     coordinates.x = coordinates.x + window.screenX + (window.outerWidth - window.innerWidth) - window.pageXOffset; 
     coordinates.y = y = coordinates.y + window.screenY + (window.outerHeight - 24 - window.innerHeight) - window.pageYOffset; 
   }

   this.x = coordinates.x; 
   this.y = coordinates.y; 
 
   windowDatePicker = window.open("../System/Control/CalendarPopup.aspx?txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=170px,height=170px,screenX=" + this.x + ",left=" + this.x + ",screenY=" + this.y + ",top=" + this.y + ""); 
   windowDatePicker.focus();*/

}

function calendarPostBack(sTxtBoxName, sForceParentPostBack) {

    var anchorname = "a" + sTxtBoxName;
    var coordinates = 0;
    var useWindow = false;
    var coordinates = new Object();
    var x = 0;
    var y = 0;

    var o = document.getElementById(anchorname);
    if (o == null) {
        var strID = sTxtBoxName.replace("$", "_");
        o = document.getElementById(strID);
    }

    x = AnchorPositionLeft(o);
    y = AnchorPositionTop(o);

    coordinates.x = x;
    coordinates.y = y;

    if (isNaN(window.screenX)) {
        coordinates.x = coordinates.x - (document.body.scrollLeft | document.documentElement.scrollLeft) + window.screenLeft;
        coordinates.y = y = coordinates.y - (document.body.scrollTop | document.documentElement.scrollTop) + window.screenTop;
    }
    else {
        coordinates.x = coordinates.x + window.screenX + (window.outerWidth - window.innerWidth) - window.pageXOffset;
        coordinates.y = y = coordinates.y + window.screenY + (window.outerHeight - 24 - window.innerHeight) - window.pageYOffset;
    }

    this.x = coordinates.x;
    this.y = coordinates.y;

    if (sForceParentPostBack) {
        windowDatePicker = window.open("../System/Control/CalendarPopup.aspx?txtbox=" + sTxtBoxName + "&forceParentPostback=1", "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=170px,height=170px,screenX=" + this.x + ",left=" + this.x + ",screenY=" + this.y + ",top=" + this.y + "");
    }
    else {
        windowDatePicker = window.open("../System/Control/CalendarPopup.aspx?txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=170px,height=170px,screenX=" + this.x + ",left=" + this.x + ",screenY=" + this.y + ",top=" + this.y + "");
    }
    windowDatePicker.focus();
}

function calendarGrid(sTxtBoxName, sTxtData) {

    var anchorname = sTxtBoxName
    var coordinates = 0;
    var useWindow = false;
    var coordinates = new Object();
    var x = 0;
    var y = 0;

    var o = document.getElementById(anchorname);
    x = AnchorPositionLeft(o);
    y = AnchorPositionTop(o);

    coordinates.x = x;
    coordinates.y = y;

    if (isNaN(window.screenX)) {
        coordinates.x = coordinates.x - document.body.scrollLeft + window.screenLeft;
        coordinates.y = y = coordinates.y - document.body.scrollTop + window.screenTop;
    }
    else {
        coordinates.x = coordinates.x + window.screenX + (window.outerWidth - window.innerWidth) - window.pageXOffset;
        coordinates.y = y = coordinates.y + window.screenY + (window.outerHeight - 24 - window.innerHeight) - window.pageYOffset;
    }

    this.x = coordinates.x;
    this.y = coordinates.y;


    windowDatePicker = window.open("../System/Control/CalendarPopup.aspx?txtdata=" + sTxtData + "&txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=170,height=170,screenX=" + this.x + ",left=" + this.x + ",screenY=" + this.y + ",top=" + this.y + "");
    windowDatePicker.focus();
}

function calendarGridByControl(txtBox) {

    /*
    function calendarGridByControl(event, txtBox) {

    if ('preventDefault' in event) event.preventDefault();
    event.returnValue = false; 
    */

    var anchorname = txtBox.id;
    anchorname = anchorname.replace("$atxt", "$txt").replace("_atxt", "_txt").replace("$", "_");

    var dateControl = document.getElementById(anchorname);
    var sTxtData = dateControl.value;

    var useWindow = false;
    var coordinates = new Object();
    var x = 0;
    var y = 0;

    var o = document.getElementById(txtBox.id);

    x = AnchorPositionLeft(o);
    y = AnchorPositionTop(o);

    coordinates.x = x;
    coordinates.y = y;

    if (isNaN(window.screenX)) {
        coordinates.x = coordinates.x - document.body.scrollLeft + window.screenLeft;
        coordinates.y = y = coordinates.y - document.body.scrollTop + window.screenTop;
    }
    else {
        coordinates.x = coordinates.x + window.screenX + (window.outerWidth - window.innerWidth) - window.pageXOffset;
        coordinates.y = y = coordinates.y + window.screenY + (window.outerHeight - 24 - window.innerHeight) - window.pageYOffset;
    }

    this.x = coordinates.x;
    this.y = coordinates.y;

    windowDatePicker = window.open("../System/Control/CalendarPopup.aspx?txtdata=" + sTxtData + "&txtbox=" + anchorname, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=170,height=170,screenX=" + this.x + ",left=" + this.x + ",screenY=" + this.y + ",top=" + this.y + "");
    windowDatePicker.focus();
}

function calendarpopup(sTxtBoxName, sTxtData) {

   var anchorname = "a" + sTxtBoxName
   var coordinates = 0;  
   var useWindow = false; 
   var coordinates = new Object(); 
   var x = 0; 
   var y = 0; 

   var o = document.getElementById(anchorname); 
   x = AnchorPositionLeft(o); 
   y = AnchorPositionTop(o); 

   coordinates.x = x; 
   coordinates.y = y;    
   
  if(isNaN(window.screenX)) {
     coordinates.x = coordinates.x - (document.body.scrollLeft | document.documentElement.scrollLeft) + window.screenLeft; 
     coordinates.y = y = coordinates.y - (document.body.scrollTop | document.documentElement.scrollTop) + window.screenTop; 
     }
  else {
     coordinates.x = coordinates.x + window.screenX + (window.outerWidth - window.innerWidth) - window.pageXOffset; 
     coordinates.y = y = coordinates.y + window.screenY + (window.outerHeight - 24 - window.innerHeight) - window.pageYOffset; 
     }

   this.x = coordinates.x; 
   this.y = coordinates.y; 

   
   windowDatePicker = window.open("../System/Control/CalendarPopup.aspx?txtdata=" + sTxtData + "&txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=170,height=170,screenX=" + this.x + ",left=" + this.x + ",screenY=" + this.y + ",top=" + this.y + ""); 
   windowDatePicker.focus();
}


function calendarevent(sTxtBoxName) {

   var anchorname = "a" + sTxtBoxName
   var coordinates = 0;  
   var useWindow = false; 
   var coordinates = new Object(); 
   var x = 0; 
   var y = 0; 

   var o = document.getElementById(anchorname); 
   x = AnchorPositionLeft(o); 
   y = AnchorPositionTop(o); 

   coordinates.x = x; 
   coordinates.y = y;    
   
  if(isNaN(window.screenX)) {
     coordinates.x = coordinates.x - document.body.scrollLeft + window.screenLeft; 
     coordinates.y = y = coordinates.y - document.body.scrollTop + window.screenTop; 
     }
  else {
     coordinates.x = coordinates.x + window.screenX + (window.outerWidth - window.innerWidth) - window.pageXOffset; 
     coordinates.y = y = coordinates.y + window.screenY + (window.outerHeight - 24 - window.innerHeight) - window.pageYOffset; 
     }

   this.x = coordinates.x; 
   this.y = coordinates.y; 

   
   windowDatePicker = window.open("../System/Control/CalendarEventPopup.aspx?txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=auto,resizable=1,width=305,height=150,screenX=" + this.x + ",left=" + this.x + ",screenY=" + this.y + ",top=" + this.y + ""); 
   windowDatePicker.focus();
}


function calendarRange(oAnchor, oTextbox) {

   var anchorname = oAnchor
   var coordinates = 0;  
   var useWindow = false; 
   var coordinates = new Object(); 
   var x = 0; 
   var y = 0; 

   var o = document.getElementById(anchorname); 
   x = AnchorPositionLeft(o); 
   y = AnchorPositionTop(o); 

   coordinates.x = x; 
   coordinates.y = y;    
   
  if(isNaN(window.screenX)) {
     coordinates.x = coordinates.x - document.body.scrollLeft + window.screenLeft; 
     coordinates.y = y = coordinates.y - document.body.scrollTop + window.screenTop; 
     }
  else {
     coordinates.x = coordinates.x + window.screenX + (window.outerWidth - window.innerWidth) - window.pageXOffset; 
     coordinates.y = y = coordinates.y + window.screenY + (window.outerHeight - 24 - window.innerHeight) - window.pageYOffset; 
     }

   this.x = coordinates.x; 
   this.y = coordinates.y; 

   
   windowDatePicker = window.open("../System/Control/CalendarRangePopup.aspx?txtbox=" + oTextbox, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=300,height=200,screenX=" + this.x + ",left=" + this.x + ",screenY=" + this.y + ",top=" + this.y + ""); 
   windowDatePicker.focus();
}


function customwindow(strWindowUrl){
	windowCustom = window.open("../System/Control/" + strWindowUrl + "","Custom","toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=50,top=50");
	windowCustom.focus();
}
