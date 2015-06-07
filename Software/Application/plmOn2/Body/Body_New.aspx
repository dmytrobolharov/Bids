﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_New.aspx.vb" Inherits="plmOnApp.Body_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title id="titleBodyNew" runat="server">Body New</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>	
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	<script language="JavaScript">
		<!--

		if (window.screen) {
			var aw = screen.availWidth;
			var ah = screen.availHeight;
			window.moveTo(0, 0);
			window.resizeTo(aw, ah);
		}

		//if (self != top) top.location.replace(self.location);	

		self.focus();

		//-->
	</script>
</head>
<body>
    <form id="form1" runat="server">

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
						<asp:ImageButton id="btnSave" runat="server" ></asp:ImageButton>
						<cc1:confirmedimagebutton id="imgBtnNext" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"  CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
                    </TD>
				</TR>
			</TABLE>
			
			<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<TR>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</TR>
			</TABLE>


			<table height="90%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td>
									<div align="right"><asp:label id="lblHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
											ForeColor="#E0E0E0">New Body...</asp:label></div>
								</td>
							</tr>
						</table>
						<asp:panel id="pnlBody" runat="server">
							<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="top">
									<TD width="10">&nbsp;</TD>
									<TD>
										<asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></TD>
								</TR>
							</TABLE>
						</asp:panel>
						<table height="100" cellSpacing="0" cellPadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
							border="0">
							<tr vAlign="top">
								<td width="33%"></td>
								<td width="33%"></td>
								<td width="33%"></td>
							</tr>
						</table>
					</td>
					<td width="10%" bgColor="#f5f5f5">&nbsp;</td>
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
