<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Style.aspx.vb"
    Inherits="srmOnApp.SampleRequest_Workflow_Style" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title runat="server" id="PageTitle">Sample Workflow</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td width="80">
                <cc1:ConfirmedImageButton ID="btnSaveMaterial" runat="server" Message="Are you sure you want to add to quotation folder?">
                </cc1:ConfirmedImageButton>
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="Do you want to close this window?" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnGoToStyle" runat="server"></cc1:BWImageButton>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td width="900">
                <uc1:Style_Header ID="Style_Header1" runat="server"></uc1:Style_Header>
            </td>
            <td>
                <cc1:BWImageButton ID="imgDesign" runat="server"></cc1:BWImageButton>
            </td>
        </tr>
    </table>
    <asp:DataGrid ID="dgSampleWorkflow" runat="server" Width="300px" AutoGenerateColumns="False"
        PageSize="100" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
        <Columns>
            <asp:TemplateColumn>
                <ItemTemplate>
                    <asp:PlaceHolder ID="phc" runat="server"></asp:PlaceHolder>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid></form>
</body>
	<script type="text/javascript">
		function btnClose_Click() {
			<%= strExitScript %>
			return false;
		}
	</script>

</html>
