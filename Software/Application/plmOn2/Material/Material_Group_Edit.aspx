<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Group_Edit.aspx.vb" Inherits="plmOnApp.Material_Group_Edit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
		<title>Material Group</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">	
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>		
	    <script language="javascript" src="../System/Jscript/Custom.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
					    id="btnSave" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_save.gif" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 					
					    id="btnAddMaterial" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_addMaterial.gif"></cc1:confirmedimagebutton><cc1:BWImageButton 
					    id="btnMaterialColorAdd" Visible="true" runat="server" Message="" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_addcolor.gif"></cc1:BWImageButton><cc1:bwimagebutton 
					    id="btnCopy" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_copy.gif" Visible="False"></cc1:bwimagebutton><cc1:bwimagebutton 
					    id="btnGoTo" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_goto.gif"></cc1:bwimagebutton><cc1:BWImageButton
					    id="btnMaterialDelete" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_delete.gif" Message='<%#GetSystemText("Are you sure you want to delete this folder?")%>'></cc1:BWImageButton><cc1:BWImageButton 
					    id="btnColorRemove" Visible="false" runat="server" Message="" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_removecolor.gif"></cc1:BWImageButton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                        <cc1:confirmedimagebutton id="btnClose" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_close.gif"></cc1:confirmedimagebutton></td>					
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material Group</asp:label></td>
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
		    var frm = document.form1 ;
		    function CheckAll( checkAllBox ){
		        var actVar = checkAllBox.checked ;
		        for(i=0;i< frm.length;i++) {
			        e=frm.elements[i];
			        if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			        e.checked= actVar ;
		        }
		    }
   		
		    </script>			
	</body>
</html>
