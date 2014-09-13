<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_Calendars.aspx.vb" Inherits="plmOnApp.Color_Calendars" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Color_Header" Src="Color_Header.ascx" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">

<html>
	<head>
		<title>Style_Schedule</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0" >
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
                        <cc1:confirmedimagebutton id="btnSaveSet" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:bwimagebutton id="btnAddCalendar" visible="true" runat="server" ></cc1:bwimagebutton>
                        <cc1:confirmedimagebutton id="btnRemoveCalendar" runat="server"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                    </td>
				</tr>
			</table>
            <table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" 
                height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblColorCalendar" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<uc1:Color_Header id="Color_Header1" runat="server" IsCollapsible="true" IsCollapsed="true"></uc1:Color_Header>
           
            <table height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <asp:PlaceHolder ID="plhWorkflowControls" runat="server"></asp:PlaceHolder>
                    </td>                                       
                    <td valign="top" class="center">
                        <table cellspacing="0" cellpadding="0" width="75" style="border:none;">
                            <tbody></tbody>
                        </table>
                    </td>
                </tr>
            </table>
			
			<asp:panel id="Panel1" runat="server">
				<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left">&nbsp;</td>
					</tr>
				</table>
				
				<asp:datagrid id="dgWorkflowSet1" runat="server" DataKeyField="ColorFolderID" AllowSorting="False">
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				    <PagerStyle Visible="False"></PagerStyle>
				    <Columns>
				    	<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
							<ItemTemplate>
								<asp:Image id="imgStatus" runat="server"
								     ImageUrl='<%# string.Concat("../System/Icons/"  + DataBinder.Eval(Container.DataItem,"WorkflowStatusImage").tostring ) %>' 
								     ></asp:Image>
							</ItemTemplate>
						</asp:TemplateColumn>
				    </Columns>
                </asp:datagrid>
			</asp:panel>
			
			
			</form>

            <script>
                if (!$("#drlColorTACalendarID").val())
                {
                    $("#gotoCalendar").css('display', 'none')
                }

                var goToCalendar = function () {
                    var tCalReferenceId = $("#drlColorTACalendarID").val()
                    //if (tCalReferenceId)
                    var newWin = window.open("../TimeAction/TimeAction_Folder.aspx?TID=" + tCalReferenceId, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
                    newWin.focus();
                }
            </script>
	</body>
</html>
