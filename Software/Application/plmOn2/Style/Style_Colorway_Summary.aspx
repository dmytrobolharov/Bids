<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Colorway_Summary.aspx.vb" Inherits="plmOnApp.Style.Colorway.Style_Colorway_Summary" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title runat="server" id="PageTitle"></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet"/>
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet"/>
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<script language="javascript">
		    function SelectColor(sColor, sTxtBox) {
		        opener.document.Form1[sTxtBox].value = sColor;
		        self.close();
		    }
		</script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<br></br>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:panel id="pnlStyleCombo" runat="server">
				<table class="TableHeader" height="30" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr class="font">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<asp:Panel ID="pnlColorCombo" runat="server"> 
						<td class="fontHead" width="125">
							<div align="right"><asp:label ID="lblNoCombo" runat="server" >No. of Style Combo(s):</asp:label></div>
						</td>                                             
						<td width="35">
							<asp:dropdownlist id="dpNewRow" runat="server" EnableViewState="false" CssClass="fontHead">
								<asp:ListItem Value="0" Selected="True">0</asp:ListItem>
								<asp:ListItem Value="1">1</asp:ListItem>
								<asp:ListItem Value="2">2</asp:ListItem>
								<asp:ListItem Value="3">3</asp:ListItem>
								<asp:ListItem Value="4">4</asp:ListItem>
								<asp:ListItem Value="5">5</asp:ListItem>
								<asp:ListItem Value="10">10</asp:ListItem>
								<asp:ListItem Value="15">15</asp:ListItem>
								<asp:ListItem Value="20">20</asp:ListItem>
							</asp:dropdownlist>
						</td>
						</asp:Panel>	
						<td><cc1:confirmedimagebutton 
						    id="BtnColor" runat="server" ToolTip="Add Color Combo"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
						    id="btnSaveCombo" runat="server" ToolTip="Save..."  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
						    id="btnDeleteCombo" runat="server" ToolTip="Remove..."  Message="Do you want to remove Style Combo?"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
						    id="btnCloseCombo" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>		
						<td>&nbsp;</td>
					</tr>
				</table>
				<asp:panel id="pnlChange1" runat="server">
			        <uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			     </asp:panel>
				<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td>&nbsp;
							<asp:label id="lblStyleCombo" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
								ForeColor="#E0E0E0">Style Color Combo</asp:label></td>
					</tr>
				</table>
				
				<asp:datagrid id="dgStyleColors" runat="server" DataKeyField="StyleColorID" AutoGenerateColumns="false">
					<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
					<Columns>
					    <asp:TemplateColumn >
					        <ItemTemplate>
					            <asp:CheckBox runat="server" ID= "chbStyleColorID" />
					        </ItemTemplate>
					    </asp:TemplateColumn>
					</Columns>
				</asp:datagrid>
				
			</asp:panel><asp:panel id="pnlMaterialColorway" runat="server">
				<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
					runat="server">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td>
							<asp:ImageButton id="btnSave" runat="server" ></asp:ImageButton>
							<asp:ImageButton id="btnClose" runat="server" ></asp:ImageButton></td>
					</tr>
				</table>
				<asp:panel id="pnlChange2" runat="server">
			        <uc1:Style_Change_Alert id="Style_Change_Alert2" runat="server"></uc1:Style_Change_Alert>
			     </asp:panel>
				<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td>&nbsp;
							<asp:label id="lblMaterialHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
								ForeColor="#E0E0E0"></asp:label></td>
					</tr>
				</table>
				
			
        	<asp:datagrid id="dgMaterial" runat="server"
                DataKeyField="StyleMaterialID" AutoGenerateColumns="False" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" >
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			</asp:datagrid>				

				
			</asp:panel></form>
		<script language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("cbColorway") != -1)
		                e.checked = actVar;
		        }
		    }			
		</script>
	</body>
</html>
