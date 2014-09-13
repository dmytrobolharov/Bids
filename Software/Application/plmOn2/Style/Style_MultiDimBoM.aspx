<!-- 
Style_Material_Summary.xml
spx_StyleMaterialSummary_SELECT
spx_StyleMaterialRollup_SELECT
spx_StyleMaterialLogic_Linked_UPDATE
-->

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_MultiDimBoM.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_MultiDimBoM" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<title>Material</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
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
    <form id="form1" runat="server">
    
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnCopy" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnRemove" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnReplace" runat="server" Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						</td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Material Summary</asp:label></td>
				</tr>
			</table>
			<table cellspacing="2" cellpadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top"></td>
				</tr>
			</table>
            <table>
                <tr class="TableHeader">
                    <td width="20" height="25">&nbsp; </td>
                    <td class="fontHead" width="150">
                        <asp:Label ID="lbStyleColorway" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="fontHead" width="150">
                        <asp:Label ID="lbSizeRange" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td>&nbsp;</td>

                </tr>
                <tr>
                    <td height="25">&nbsp;</td>
                    <td><asp:DropDownList ID="drStyleColorway" runat="server" CssClass="fontHead"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="drSizeRange" runat="server" CssClass="fontHead"></asp:DropDownList></td>
                    <td>&nbsp;</td>
                </tr>
            </table>
			<table>
			<tr>
			<td>
        	<asp:datagrid id="dgMaterial" runat="server"
                DataKeyField="StyleMaterialID" AutoGenerateColumns="False" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" EnableViewState="False">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
				    <asp:TemplateColumn>
				        <ItemTemplate>
				            <asp:label ID="lblGroupName" runat="server" ></asp:label>
				            <input type="hidden" runat="server"  id="hdnMatCode" />
				            <input type="hidden" runat="server"  id="hdnMatName" />
				        </ItemTemplate>
				    </asp:TemplateColumn>
				</Columns>				
			</asp:datagrid>				
			
			</td>
			</tr>
			<tr>
			<td align="right">
			
        	<asp:datagrid id="dgMaterialCost" runat="server" BorderStyle="NotSet" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                cellspacing="0" ShowHeader="False">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="fontHead"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="fontHead"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeaderGreen"></HeaderStyle>
			</asp:datagrid>			
			</td>
			</tr>
			</table>

    
					


    
					
    </form>
</body>
</html>
