<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_Edit.aspx.vb" Inherits="plmOnApp.Body_Edit" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Body</title>
    	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
		<script language="javascript" src="../System/Jscript/System.js"></script>
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    
    
        <cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
        <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<TD>
					<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:bwimagebutton id="btnSet" runat="server" Message="NONE" Visible="false" ToolTip="Edit Style Set..."></cc1:bwimagebutton>
					<cc1:bwimagebutton id="btnDelete" runat="server" Message="NONE"  CausesValidation="False"></cc1:bwimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></TD>
			</TR>
		</table> 
		<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<TR vAlign="top">
				<TD width="10">&nbsp;</TD>
				<TD>
					<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
			</TR>
		</TABLE>
		<BR>
		<asp:placeholder id="pnlStyleComments1" runat="server"></asp:placeholder>		   
    
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
