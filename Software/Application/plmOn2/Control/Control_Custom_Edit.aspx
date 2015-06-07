<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Custom_Edit.aspx.vb" Inherits="plmOnApp.Control_Custom_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Control Panel</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnSaveNew" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnDelete" runat="server"  CausesValidation="false" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
                    <table cellspacing="0" cellpadding="0" width="100%" border="0" style="background-color:White">
                        <tr>
                            <td colspan="2">
                                <table cellspacing="0" cellpadding="0" runat="server" id="tblUpload">
                                    <tr>
                                        <td class="fontHead" valign="top">
                                            <asp:Label ID="lblImageFile" runat="server"></asp:Label>
                                        </td>
                                        <td class="font">
                                            <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <br />
                                <asp:Panel ID="pnlFileLocked" runat="server" Visible="False">
                                    <table cellspacing="0" cellpadding="1" width="100%" bgcolor="#ea0000" border="0">
                                        <tr>
                                            <td width="10">
                                                &nbsp;
                                            </td>
                                            <td width="20">
                                                <img height="16" src="../System/Icons/icon_lock.gif" width="16">
                                            </td>
                                            <td>
                                                &nbsp;
                                                <asp:Label ID="lblFileLocked" runat="server" ForeColor="White"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <br />
                                <cc1:ConfirmedImageButton ID="btnImageRemove" runat="server" ToolTip="Delete Image File..." />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"  class="font" width="50">
                            <br />
                                <asp:Image id="imgFeature" runat="server"/>
                            </td>
                        </tr>
                    </table></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"></td>
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
</HTML>
