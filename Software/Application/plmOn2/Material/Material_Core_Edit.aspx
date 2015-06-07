<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Core_Edit.aspx.vb" Inherits="plmOnApp.Material_Core_Edit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Control Panel</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
					id="btnSave" runat="server" Message="NONE" 
                            style="height: 24px"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnAddMaterial" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:BWImageButton
					id="btmImgDeletePOM" runat="server"  ></cc1:BWImageButton><cc1:confirmedimagebutton 
					id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"></td>
				</tr>
			</table>



        	<asp:datagrid id="dgMaterial" runat="server" DataKeyField="MaterialCoreItemID" AutoGenerateColumns="False" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			</asp:datagrid>				
									
			
			</form>
			
		    <script language="javascript">
		    var frm = document.Form1 ;
		    function CheckAll( checkAllBox ){
		        var actVar = checkAllBox.checked ;
		        for(i=0;i< frm.length;i++) {
			        e=frm.elements[i];
			        if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			        e.checked= actVar ;
		        }
		    }
   		    function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
		    </script>			
	</body>
</HTML>
