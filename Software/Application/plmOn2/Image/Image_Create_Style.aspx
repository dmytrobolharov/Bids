<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Create_Style.aspx.vb" Inherits="plmOnApp.Image_Create_Style" EnableEventValidation="false"  %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Style New</title>
		
		
		
		
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
					<asp:imagebutton id="btnSaveStyle" runat="server" ></asp:imagebutton>
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
									<div align="right"><asp:label id="lblStyleHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
											ForeColor="#E0E0E0">New Style...</asp:label></div>
								</td>
							</tr>
						</table>
						<asp:panel id="pnlStyle" runat="server">
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
					<td vAlign="top" width="10%" bgColor="#f5f5f5"><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
				</tr>
			</table>
		</form>
        <script  language="javascript" type="text/javascript">
            function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
                    }
        </script>
	</body>
</HTML>
