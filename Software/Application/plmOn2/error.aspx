<%@ Page Language="vb" AutoEventWireup="false" Codebehind="error.aspx.vb" Inherits="plmOnApp.PageError" %>

<%@ Register Assembly="YSWebControls" Namespace="Yunique.WebControls" TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>error</title>
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<link href="System/CSS/Style.css" rel="stylesheet" type="text/css">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
	    <table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" height="50" 
            width="100%">
            <tr>
                <td width="10">
                    &nbsp;</td>
                <td width="50">
                    <div align="center">
                        <img border="0" src="System/Icons/icon_critical32.gif" /></div>
                </td>
                <td class="fontHead">
                    &nbsp;
                    plmOn has encountered a problem. We are sorry for the inconvenience.</td>
            </tr>
        </table>
	<table width="900">
        <tr>
            <td width="50">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                Error #:</td>
            <td>
                <asp:Label ID="lbl_ErrorID" runat="server" CssClass="font"></asp:Label>
                        </td>
        </tr>
        
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                Error Message:</td>
            <td>
                <asp:Label ID="lbl_ErrorMsg" runat="server" CssClass="font"></asp:Label>
                        </td>
        </tr>
                
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                Error Page:</td>
            <td>
                <asp:Label ID="lbl_ErrorPage" runat="server" CssClass="font"></asp:Label>
                        </td>
        </tr>
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                Error Type:</td>
            <td>
                <asp:Label ID="lbl_ErrorExType" runat="server" CssClass="font"></asp:Label>
                        </td>
        </tr>
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                Error Trace:</td>
            <td>
                <asp:Label ID="lbl_ErrorTrace" runat="server" CssClass="font"></asp:Label>
                        </td>
        </tr>
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                &nbsp;</td>
            <td>
                <cc1:BWHyperLink ID="lnk_SendError" runat="server" CssClass="fontHead" 
                    Font-Underline="True" ForeColor="Blue" Location="False" MenuBar="False" 
                    Status="False" ToolBar="False" WindowHeight="400px" WindowName="ErrorWindow" 
                    WindowWidth="600px">Click here to report this error...</cc1:BWHyperLink>
                    </td>
        </tr>
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
</table>
		</form>
	    </body>
</HTML>
