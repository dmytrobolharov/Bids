<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Costing_CopyFrom_StyleSelect.aspx.vb" Inherits="plmOnApp.Style.Costing.Style_Costing_CopyFrom_StyleSelect" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet"/>
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet"/>
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="JavaScript">
	<!--
	    if (window.screen) {
	        var aw = screen.availWidth;
	        var ah = screen.availHeight;
	        window.moveTo(0, 0);
	        window.resizeTo(aw, ah);
	    }
	    //if (self != top) top.location.replace(self.location);				
	//-->
	</script>
</head>

	<body>
		<form id="form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:imagebutton 
					    id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px"></asp:imagebutton><cc1:confirmedimagebutton 
					    id="btnClose" runat="server"  Message="NONE" Visible="False"></cc1:confirmedimagebutton></td>
				</tr>
			</TABLE>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">New Version</asp:Label></td>
				</tr>
			</table>
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" vAlign="top">
						<TABLE id="Table3" height="45">
							<TR>
								<TD>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
			<asp:PlaceHolder id="phStyle" runat="server"></asp:PlaceHolder>
			<asp:PlaceHolder id="phStyleGrid" runat="server"></asp:PlaceHolder>
		</form>
	</body>
	
</html>
