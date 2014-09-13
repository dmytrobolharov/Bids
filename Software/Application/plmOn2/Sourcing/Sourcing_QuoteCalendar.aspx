<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Sourcing_QuoteCalendar.aspx.vb" Inherits="plmOnApp.Sourcing_QuoteCalendar" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Sourcing_Header" Src="Sourcing_Header.ascx" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">

<style type="text/css">
     .tracked-pages-title
      {
       text-align: center;
      }
      .tracked-pages-header {
        font-family: Tahoma, Geneva, Arial, Helvetica, sans-serif;
        font-size: 11px;
        font-weight: bold;
        padding: 2px;
        }
</style>


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
                        <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:bwimagebutton id="btnAddCalendar" visible="true" runat="server" ></cc1:bwimagebutton>
                        <cc1:confirmedimagebutton id="btnRemoveCalendar" runat="server"></cc1:confirmedimagebutton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                    </td>
				</tr>
			</table>
			<br>
			<asp:panel id="Panel1" runat="server">
                <table cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="TableHeaderRed" height="25">
                            <%= GetSystemText("Calendar")%>
                        </td>
                    </tr>
                    <tr>
                        <td height="25">
                            <asp:TextBox ID="txtCalendar" runat="server" Width="150" ReadOnly="true"></asp:TextBox>
                            <cc1:BWImageButton ID="btnCalendarGoTo" runat="server" />
                        </td>
                    </tr>
                </table>
				<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left">&nbsp;
							<asp:Label id="Label1" runat="server"></asp:Label>&nbsp;<asp:Label ID="lblSch1" runat="server" Text=""></asp:Label></td>
					</tr>
				</table>
				
				<asp:datagrid id="dgWorkflowSet1" runat="server" DataKeyField="StyleQuoteItemID" AllowSorting="False">
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
                if (!$("#drlStyleTACalendarID").val())
                {
                    $("#gotoCalendar").css('display', 'none')
                    $("#pnlTrackedPages").css('display','none')
                }

                var goToCalendar = function () {
                    var tCalReferenceId = $("#drlStyleTACalendarID").val()
                    //if (tCalReferenceId)
                    var newWin = window.open("../TimeAction/TimeAction_Folder.aspx?TID=" + tCalReferenceId, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
                    newWin.focus();
                }
            </script>
	</body>
</html>
