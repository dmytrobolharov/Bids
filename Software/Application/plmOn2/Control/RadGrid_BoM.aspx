<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RadGrid_BoM.aspx.vb" Inherits="plmOnApp.RadGrid_BoM" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/tr/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
        <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
        <meta content="JavaScript" name="vs_defaultClientScript" />
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" title="YuniquePLMStyle" />
        <link href="../System/CSS/RadGrid.YPLM.css" type="text/css" rel="stylesheet" />
    </head>

    <body style="margin:0;padding:0">

		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				<tr vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
						<asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" />
						<cc1:confirmedimagebutton id="btnEdit" runat="server" Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnImportFromLdap" runat="server"Message="NONE" Visible="False"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnLdapResync" runat="server" Message="NONE" Visible="False"></cc1:confirmedimagebutton>
					</TD>
					<td>&nbsp;</td>
				</tr>
			</table>

			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" />

            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
		</form>

    </body>
</html>
