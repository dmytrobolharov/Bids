<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_CostSheet_Add.aspx.vb" Inherits="plmOnApp.Style.CostingEnhanced.Style_CostSheet_Add"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Add Costing</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
         <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <script language="javascript" src="../System/Jscript/AddCosting.js"></script>
        <script language="javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					</td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="30" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tbody>
					<tr>
						<td style="padding-left:50px">
							<ul class="fonthead">
								<li>
									<%=GetSystemText("Click on check box to select costing")%>
								</li>
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
			<asp:datagrid id="dgCostingType" runat="server" DataKeyField="StyleCostingTypeID" Width="400"
				AutoGenerateColumns="false">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate" BackColor="White"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll"/>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkSelect" runat="server"></asp:CheckBox>
							<asp:HiddenField id="hdnShowBOM" runat="server" />
							<asp:HiddenField id="hdnShowBOL" runat="server" />
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							&nbsp;
							<asp:Label id="lblHeaderCostingType" runat="server" CssClass="fontHead"><%#GetSystemText("Available Costing")%>...</asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblCostingType" runat="server" CssClass="font"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							&nbsp;
							<asp:Label id="lblHeaderBOMType" runat="server" CssClass="fontHead"><%#GetSystemText("BOM Type")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblBOMType" runat="server" CssClass="font"></asp:Label>
							<asp:DropDownList id="ddlBOM" runat="server" CssClass="fontHead" Width="120"></asp:DropDownList>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							&nbsp;
							<asp:Label id="lblHeaderBOLType" runat="server" CssClass="fontHead"><%#GetSystemText("BOL Type")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblBOLType" runat="server" CssClass="font"></asp:Label>
							<asp:DropDownList id="ddlBOL" runat="server" CssClass="fontHead" Width="120"></asp:DropDownList>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle Visible="False"></PagerStyle>
			</asp:datagrid>
		</form>
		<script language="javascript" type="text/javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
		                e.checked = actVar;
		        }
		    }
		</script>
	</body>
</html>
