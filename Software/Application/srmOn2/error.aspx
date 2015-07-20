<%@ Page Language="vb" AutoEventWireup="false" Codebehind="error.aspx.vb" Inherits="srmOnApp._error" %>

<%@ Register Assembly="YSWebControls" Namespace="Yunique.WebControls" TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">error</title>
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
                    &nbsp;<asp:label id="lblWarning1" runat="server">plmOn has encountered a problem.</asp:label>
                    &nbsp;<asp:label id="lblWarning2" runat="server">We are sorry for the inconvenience.</asp:label>
                </td>
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
                <asp:label id="lblErrorNo" runat="server">Error #:</asp:label>
            </td>
            <td>
                <asp:Label ID="lbl_ErrorID" runat="server" CssClass="font"></asp:Label>
                        </td>
        </tr>
        
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                <asp:label id="lblErrorMessage" runat="server">Error Message:</asp:label>
            </td>
            <td>
                <asp:Label ID="lbl_ErrorMsg" runat="server" CssClass="font"></asp:Label>
                        </td>
        </tr>
                
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                <asp:label id="lblErrorPage" runat="server">Error Page:</asp:label>
            </td>
            <td>
                <asp:Label ID="lbl_ErrorPage" runat="server" CssClass="font"></asp:Label>
                        </td>
        </tr>
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                <asp:label id="lblErrorType" runat="server">Error Type:</asp:label>
            </td>
            <td>
                <asp:Label ID="lbl_ErrorExType" runat="server" CssClass="font"></asp:Label>
                        </td>
        </tr>
        <tr>
            <td width="50">
                &nbsp;</td>
            <td width="100" class="fontHead">
                <asp:label id="lblErrorTrace" runat="server">Error Trace:</asp:label>
            </td>
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
