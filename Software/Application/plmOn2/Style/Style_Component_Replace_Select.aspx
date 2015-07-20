<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Component_Replace_Select.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Replace_Select" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td> 
                <td>
                    <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                    <asp:ImageButton ID="btnClose"  runat ="server" OnClientClick="return btnClose_Click()"  />
                </td>
            </tr>
        </table>
        <table id="tbHeader" runat="server" style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
            cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr><td>&nbsp;<asp:Label ID="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label></td></tr>
        </table>
		<table width="100%" height="15" cellspacing="0" cellpadding="0" bgcolor="white" border="0">
			<tr>
				<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
				<td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
                <td width="100%">&nbsp;</td>
			</tr>
		</table>
		<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr valign="middle">
				<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                <td nowrap width="120"><asp:checkbox id="cbThumbnail" AutoPostBack="True" runat="server"></asp:checkbox></td>
				<td width="10">&nbsp;</td>
				<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
				<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
				<td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
				<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
				<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
				<td width="10">&nbsp;</td>
				<td nowrap width="100%" height="25"><asp:label id="lblRecordCount" runat="server" CssClass="fontHead"></asp:label></td>
                <td nowrap width="110" align="right"><asp:label id="lblRecordsperPage" runat="server" CssClass="fontHead"></asp:label></td>
				<td width="25">
                    <asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
                        <asp:ListItem Value="5">5</asp:ListItem>
						<asp:ListItem Value="10">10</asp:ListItem>
						<asp:ListItem Value="15">15</asp:ListItem>
						<asp:ListItem Value="20">20</asp:ListItem>
						<asp:ListItem Value="25">25</asp:ListItem>
						<asp:ListItem Value="30">30</asp:ListItem>
						<asp:ListItem Value="40">40</asp:ListItem>
						<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
					</asp:dropdownlist>
                </td>
				<td width="10"><asp:button id="Button1" runat="server" CssClass="fontHead" CausesValidation="false"></asp:button></td>
			</tr>
		</table>
        <asp:datagrid id="DataGrid1" runat="server"  EnableViewState="true" DataKeyField="MaterialID">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
			<ItemStyle CssClass="ItemTemplate"></ItemStyle>
			<HeaderStyle Height="25px" Width="25px" CssClass="TableHeader"></HeaderStyle>
            <PagerStyle Visible="False"></PagerStyle>
            <Columns>
                <asp:TemplateColumn>
                    <ItemTemplate><asp:Label runat="server"  ID="lblSelect" ></asp:Label></ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderTemplate><%# GetSystemText("Picture")%></HeaderTemplate>
					<ItemTemplate><cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton></ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:datagrid>
        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
    </form>
    <script type="text/javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
