<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BatchQ_ImageNew.aspx.vb" Inherits="plmOnApp.BatchQ_ImageNew" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>New Image</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		    <asp:imagebutton id="Imagebutton1" runat="server" Width="0px" Height="0px" />
		    <asp:placeholder id="phNav" runat="server"></asp:placeholder>   
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					</td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">New Image...</asp:label></td>
				</tr>
			</table>
			<asp:panel id="pnlUpload" runat="server">
				<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
						<P><BR>
							<SPAN class="fontHead"><asp:Label ID="lblSelectFile" runat="server" Text="Select File to Upload..."></asp:Label></SPAN>
							
                            <br>
                                <br>
                                    <input id="File1" runat="server" name="file1" type="file">
                                    </input>
                                </br>
                            </br>
                        </P>
					</BLOCKQUOTE></BLOCKQUOTE>
			</asp:panel>
			<TABLE id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD width="900"><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
