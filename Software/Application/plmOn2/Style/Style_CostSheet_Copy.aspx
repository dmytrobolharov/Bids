<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_CostSheet_Copy.aspx.vb" Inherits="plmOnApp.Style.CostingEnhanced.Style_CostSheet_Copy"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Copy Cost Sheet</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" src="../System/Jscript/AddCosting.js"></script>
        <script language="javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td>
					    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
					</td>
					<td class="fontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="30" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tbody>
					<tr>
						<td style="padding-left:50px; padding-top:20px">
							<ul class="fontHead">
								<li>
									<%= GetSystemText("Select cost sheet to copy")%>
								</li>
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
            <table>
                <tr>
                    <td style="padding-left:30px; padding-top:20px">
                        <asp:Label ID="lblCostSheets" runat="server" class="fontHead"></asp:Label>
                    </td>
                    <td style="padding-left:30px; padding-top:20px">
                        <asp:DropDownList ID="drlCostsheets" runat="server" Width="200"></asp:DropDownList>
                    </td>
                </tr>
            </table>
        </form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
