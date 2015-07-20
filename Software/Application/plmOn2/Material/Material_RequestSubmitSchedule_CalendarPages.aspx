<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_RequestSubmitSchedule_CalendarPages.aspx.vb" Inherits="plmOnApp.Material_RequestSubmitSchedule_CalendarPages" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Material Request Schedule</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/tree.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body alink="xml">
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" >
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td width="500">
					    <cc1:confirmedimagebutton ID="btnSaveSet" runat="server" Message="NONE"/>
					    <cc1:BWImageButton ID="btnAdd" runat="server"  />
                        <cc1:BWImageButton ID="btnRemove" runat="server"  />
                        <cc1:BWImageButton id="btnAddCalendar" runat="server"  Message="NONE"></cc1:BWImageButton>
                        <cc1:ConfirmedImageButton id="btnRemoveCalendar" runat="server"  Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
					</td>
						<td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
						<td valign="middle" align="left" width="125"><asp:Label ID="lblSelectColor" runat="server" Text="Select Color / Size"></asp:Label></td>
					    <td>
                            <asp:DropDownList ID="ddlMaterialTradeColor" runat="server" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                        <td align="left" valign="middle">
                            &nbsp;</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="Gray">Material Request Workflow</asp:label></td>
				</tr>
			</table>		
			<asp:PlaceHolder ID="plhWorkflowControls" runat="server" 
                EnableViewState="False" ></asp:PlaceHolder>
			<table cellspacing="1" cellpadding="0" height="45" border="0">
                <tr>
                    <td class="fontHead">
                        <asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder>
                    </td>
                    <td align="center" width="100" style="background-color:White;" id="tdOnlyTracked">
                        <asp:Label ID="lblOnlyTracked" runat="server" CssClass="fontHead" Text="Tracked Pages"></asp:Label><br/>
                        <asp:CheckBox runat="server" ID="chbOnlyTracked" AutoPostBack="true" />
                    </td>
                    <td></td>
                </tr>
            </table>
			
			<asp:panel id="Panel1" runat="server">

			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
                <tr>
                    <td class="fontHead" height="10"></td>
                </tr>
            </table>
				<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
				<asp:datagrid id="dgWorkflowSet1" runat="server" DataKeyField="MaterialRequestSubmitWorkflowID" AllowSorting="true">
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				    <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
				    <PagerStyle Visible="False"></PagerStyle>
				    <Columns>
				    	<asp:TemplateColumn ItemStyle-BorderColor="Gainsboro" ItemStyle-BorderWidth="1">
							<headerStyle Height="20px" Width="20px" CssClass="TableHeader"></headerStyle>
							<ItemTemplate>
								<%# string.Concat(DataBinder.Eval(Container.DataItem,"StatusUrl").tostring) %>
                                <asp:HiddenField ID="hdnTACalRefTaskId" Value='<%#Eval("TACalRefTaskId")%>' runat="server"/>
							</ItemTemplate>
						</asp:TemplateColumn>
				    </Columns>
                </asp:datagrid>
			</asp:panel>
            <asp:HiddenField ID="hdnXmlFiles" runat="server" />
			</form>

        <script type="text/javascript" language="javascript">
            if (!$("#drlMaterialRequestTACalendarID").val()) {
                $("#gotoCalendar").css('display', 'none')
                $("#tdOnlyTracked").css('display', 'none')
            }
            var goToCalendar = function () {
                var strTACalTemplateId = $("#drlMaterialRequestTACalendarID").val()
                var newWin = window.open("../TimeAction/TimeAction_Frame.aspx?TID=" + strTACalTemplateId, "dp", "toolbar=yes,location=yes,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,left=375,top=200");
                newWin.focus();
            }
        </script>

	</body>
</html>
