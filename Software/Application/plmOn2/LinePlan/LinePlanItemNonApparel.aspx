<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlanItemNonApparel.aspx.vb" Inherits="plmOnApp.LinePlanItemNonApparel" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
		<title>Non-Apparel</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">	
	    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>	
		<script language="JavaScript">
		<!--
		    if (window.screen) {
		        var aw = screen.availWidth;
		        var ah = screen.availHeight;
		        window.moveTo(0, 0);
		        window.resizeTo(aw, ah);
		    }

		    if (self != top) top.location.replace(self.location);				
			
		//-->
		</script>  	
	</head>
	<body>
		<form id="form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
					    id="btnSave" runat="server" Message="NONE" CausesValidation="False" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					    id="btnColor" runat="server" Message="NONE" CausesValidation="False"  ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					    id="btnMaterial" runat="server" Message="NONE" CausesValidation="False"  ></cc1:confirmedimagebutton><cc1:BWImageButton  
                        id="btnAddMaterial" runat="server"   CausesValidation="False" /><cc1:BWImageButton  
						id="btnAddColor" runat="server"  CausesValidation="False" /><cc1:BWImageButton  
						id="btnSummary" runat="server" CausesValidation="False" /><cc1:confirmedimagebutton 
						id="btnClose" runat="server" Message="NONE" CausesValidation="False"  ></cc1:confirmedimagebutton></td>
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
			<table cellSpacing="2" cellPadding="0" width="100%" border="0" bgcolor="White">
				<tr>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="White">
				<tr>
					<td vAlign="middle" align="center" width="10" height="20"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="100" class="TableHeader"><asp:Label ID="lblHeaderBody" runat="server" Text="Body"></asp:Label></td>
					<td width="100" class="TableHeaderBlue"><asp:Label ID="lblHeaderAttribute" runat="server" Text="Attribute"></asp:Label></td>
                    <td width="120" class="TableHeaderGreen"><asp:Label ID="lblHeaderMaterialGroup" runat="server" Text="Material Group"></asp:Label></td>
                    <td width="75" class="TableHeaderRed"><asp:Label ID="lblHeaderAttributeAvailable" runat="server" Text="# of Styles"></asp:Label></td>
                    <td>&nbsp;</td>
				</tr>
				<tr>
				    <td bgcolor="White" height="20"></td>
					<td width="100" bgcolor="White" ><asp:DropDownList ID="drlBody" runat="server"></asp:DropDownList></td>
                    <td width="100" bgcolor="White"><asp:Label ID="lblAttribute" runat="server" Text="Attribute" /></td>
                    <td width="120" bgcolor="White" ><asp:DropDownList ID="drlMaterialGroup" runat="server" AutoPostBack="True"></asp:DropDownList></td>
                    <td width="75" bgcolor="White" >&nbsp;<asp:DropDownList ID="drlAtrributeAvailable" runat="server" Width="70"></asp:DropDownList></td>
                    <td bgcolor="White" height="20">&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" height="5"></td>
				</tr>
			</table>
        	<asp:datagrid id="dgMaterial" runat="server" DataKeyField="ColorPaletteID" AutoGenerateColumns="False" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="fontHead"></HeaderStyle>
			</asp:datagrid>				
        </form>
			
		 <script language="javascript" type="text/javascript">
		     var frm = document.form1;
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
