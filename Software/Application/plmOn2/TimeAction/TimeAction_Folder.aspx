<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TimeAction_Folder.aspx.vb"
   Inherits="plmOnApp.TimeAction_Folder" %>

<%@ Register Src="../System/Control/WaitControl.ascx" TagName="Color_Wait" TagPrefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head runat="server">
   <title id="title" runat="server"></title>
   <meta http-equiv="x-ua-compatible" content="IE=Edge"/> 
   <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
   <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
   <meta content="JavaScript" name="vs_defaultClientScript">
   <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
   <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
   
   <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
   <!-- -->
   <link rel="stylesheet" href="../System/CSS/kendoUI/default/kendo.common.min.css" type="text/css">
   <link rel="stylesheet" href="../System/CSS/kendoUI/default/kendo.default.min.css" type="text/css">
   <link rel="stylesheet" type="text/css" href="../System/CSS/taCalendar/notifIt.css"> 
   <link rel="stylesheet" type="text/css" href="../System/CSS/taCalendar/taCalMain.css"> 
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />

</head>
<body ms_positioning="GridLayout" style="background-color: #fff;">
    <form id="Form1" method="post" runat="server" onkeydown = "return (event.keyCode!=13)" >
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
     <table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
runat="server">
<tr valign="middle">
<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
<td>
<wc1:Color_Wait ID="cwColorWait" runat="server" />
<asp:ImageButton id="btnSave" runat="server" CssClass="inputYu"></asp:ImageButton>
                   <cc1:confirmedimagebutton id="btnDelete" runat="server" CausesValidation="False" CssClass="inputYu" ></cc1:confirmedimagebutton>
                     <cc1:bwimagebutton id="btnCopy" runat="server" CausesValidation="False" CssClass="inputYu"></cc1:bwimagebutton>
                   <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false" CssClass="inputYu"
                       ></cc1:confirmedimagebutton>
                                              </td>
                       <td>&nbsp;</td>
</tr>
</table>

    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" >
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
            </Scripts>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadScriptManager>
        <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
            <StyleSheets>
                <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
            </StyleSheets>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadStyleSheetManager>
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
            <Windows>
                <telerik:RadWindow ID="MaterialColorsMenu" runat="server" Title="Colors" Height="600px"
                    Width="1010px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                    NavigateUrl="TimeAction_TemplateTask_Detail.aspx"
                    Behaviors="Close"
                    IconUrl="../System/Icons/icon_table.gif"
                    KeepInScreenBounds="true" Modal="true" />
                
            </Windows>
        </telerik:RadWindowManager>      
<script>
    show_wait_text();
    busyBox.Animate();
    function showTaskDetails(strTACalTemplateTaskID) {
        window.radopen("TimeAction_TemplateTask_Detail.aspx?TTID=" + strTACalTemplateTaskID,"MaterialColorsMenu");
    }
</script>
       <table id="Table1" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
<tr>
<td>&nbsp;
						<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Development Calendar</asp:label></td>
</tr>
</table>

       <table cellSpacing="0" cellPadding="0" width="100%" border="0" height="25">
   <tr class="TableHeader">
<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
<td width="20"></td>
<td class="fontHead">&nbsp;
<asp:Label id="lblComment" runat="server"></asp:Label></td>
</tr>
   </table>

   <table class="fontHead YuContainer" cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0" >
<tr>
<td width="900">

   <asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder>
 
</td>
<td>&nbsp;</td>
</tr>
</table>

   <table cellSpacing="0" cellPadding="0" width="100%" border="0" height="25">
   <tr class="TableHeader">
<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
<td width="20"></td>
<td class="fontHead">&nbsp;
<asp:Label id="Label1" runat="server"></asp:Label></td>
</tr>
   </table>


<div id="workSpace" style="padding:0px; overflow-y:auto; overflow-x:hidden;border:1px solid #e5e5e5;position:relative;"></div>


<style>
    .inputYu
    {
        padding:0;
    }
    .YuContainer input,
    .YuContainer select
    {
        padding:0;
        font-size: 11px;
    }
    .calendarYU input
    {
    	font-size: 11px;
    }
    .deleteTemplate{
        width: 189px;
    }
    .resEdit {
        padding: 15px;
    }
    span.k-dropdown{
        width: 100%;
    }
    span.typeYunique.k-dropdown{
        width: 90px;
    }

    .resLine {
        width: 95%;
        padding: 3px;
        margin: 5px;
        border: 1px solid #d0d0d0;
    }

    body {
         overflow-y: scroll;
    }

    .ganttButtonBar h1{
        color: #000000;
        font-weight: bold;
        font-size: 28px;
        margin-left: 10px;
    }

</style>
<div id="gantEditorTemplates" style="display:none">
    <script src="../System/Jscript/jquery-1.8.0.js"></script>
    <script src="../System/Jscript/jqueryUI1_8.js"></script>
    <script src="../System/Jscript/hmac-md5.js"></script>
    <script src="../System/Jscript/enc-base64-min.js"></script>
    <script src="../System/Jscript/YuniquePLM.JS.SDK.js"></script>
    <script src="../System/Jscript/kendo.all.min.js"></script>
    <script src="../System/Jscript/taCalendar/cultures.js"></script>

    <script src="../System/Jscript/taCalendar/taCaljs.min.js"></script>

    <script src="../System/Jscript/jquery.svg.min.js"></script>
    <script src="../System/Jscript/jquery.svgdom.1.8.js"></script>
    <script src="../System/Jscript/taCalendar/ganttFiles.js"></script>

<script>
    $('#gantEditorTemplates').tacalendar({
 //calendarHeight:'600'
});
</script>
</div>

   </form>
   <script type="text/javascript">
       $(document).ready(function () {
           $(".calendarYU input").kendoDatePicker().css("font-size", "14px");
       });
    </script>
</body>
</html>
