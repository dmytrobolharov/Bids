<!-- 
Style_Material_Summary.xml
spx_StyleMaterialSummary_SELECT
spx_StyleMaterialRollup_SELECT
spx_StyleMaterialLogic_Linked_UPDATE
-->

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Component_Colorway.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Colorway" %>
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
			
			if (self != top) top.location.replace(self.location);				
			
		//-->
		</script>				
</head>
<body>
    <form id="form1" runat="server">
    
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnCopy" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnRemove" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnReplace" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
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
			<asp:Panel ID="pnlSeasonYear"  runat="server"  >		
			<table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                    <td width="125" align="right" nowrap="nowrap">
                        <asp:Label runat="server" ID="lblStyleSeasonYear" class="fontHead" >Select Season / Year:</asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                    </td>
                </tr>
            </table>
            </asp:Panel>
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
