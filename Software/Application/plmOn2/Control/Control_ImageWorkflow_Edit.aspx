<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_ImageWorkflow_Edit.aspx.vb" Inherits="plmOnApp.Control_ImageWorkflow_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title runat="server" id="PageTitle">Template</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td width="650">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="imgAdd" runat="server"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnDelete" Message="NONE" CausesValidation="false" runat="server"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table cellspacing="2" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
    </table>
    <br>
    <table cellspacing="0" width="100%" cellpadding="0" border="0">
        <tr>
            <td valign="top">
                <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" DataKeyField="ImageWorkflowTemplateEntryID">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
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