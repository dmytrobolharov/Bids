<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlanItemMultiCloth2_MainMaterial.aspx.vb" Inherits="plmOnApp.LinePlanItemMultiCloth2_MainMaterial" %>
<%@ Register src="LinePlanItemMultiCloth2_MainMaterial.ascx" tagname="ctrLinePlanItemMultiCloth2_MainMaterial" tagprefix="uc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
    <html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
		<title>Multi-Cloth</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">	
	    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>	 	
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
					    id="btnSave" runat="server" Message="NONE" CausesValidation="False" ></cc1:confirmedimagebutton><cc1:bwImageButton 
					    id="btnGoTo" runat="server"  ToolTip="Go to the Material Folder..." CausesValidation="False" ></cc1:bwImageButton><cc1:confirmedimagebutton 
					    id="btnRemove" runat="server" Message="NONE" CausesValidation="False" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					    id="btnClose" runat="server" Message="NONE" CausesValidation="False" ></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:label id="lblHeader" runat="server" ForeColor="Gray" 
                            Font-Size="X-Large" Font-Names="Tahoma,Verdana">Multi Cloth</asp:label></td>
				</tr>
				
			</table>
			<table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="FontHead" width="200">Main Material</td>
					<td></td>
				</tr>
			</table>
			<table height="100" cellSpacing="0" cellPadding="0" border="0" width="100%" bgcolor="White">
				<tr vAlign="top">
				    <td width="10">&nbsp;</td>
					<td width="900">
                        <uc1:ctrLinePlanItemMultiCloth2_MainMaterial ID="ctrLinePlanItemMultiCloth2_MainMaterial1" 
                            runat="server" />
                        <asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False" Visible="False"></asp:placeholder>
                    </td>
					<td>&nbsp;</td>
				</tr>
			</table>			
        	<asp:datagrid id="dgColorway" runat="server"
                DataKeyField="LinePlanMultiCloth2ColorTempID" AutoGenerateColumns="False" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                Visible="true" PageSize="100" EnableViewState="False">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px"></HeaderStyle>
			</asp:datagrid>		
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" height="5"></td>
				</tr>
			</table>					
        	<asp:datagrid id="dgMaterialGroup" runat="server" DataKeyField="MaterialCoreItemID" AutoGenerateColumns="False" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                Visible="true">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			</asp:datagrid>				
        </form>
			
		 <script language="javascript" type="text/javascript">
		     var frm = document.Form1;
		     function CheckAll(checkAllBox, id) {
		         var actVar = checkAllBox.checked;  
		         for (i = 0; i < frm.length; i++) {
		             e = frm.elements[i];
		             if (e.type == 'checkbox' && e.name.indexOf(id) != -1)
		                 e.checked = actVar;
		         }
		     }


		     function DelCheckAll(checkAllBox, id, grp) {

		         var actVar = checkAllBox.checked;
		         for (i = 0; i < frm.length; i++) {
		             e = frm.elements[i];

		             if (e.type == 'radio' && e.id.indexOf(id) != -1) {
		                 e.checked = actVar;
		                 //e.disabled = !actVar ;
		             }

		             if (e.type == 'checkbox' && e.name.indexOf(grp) != -1 && e.name != checkAllBox.name) {
		                 e.checked = false;
		             }


		         }
		     }
		    
		</script>			
	</body>
</html>
