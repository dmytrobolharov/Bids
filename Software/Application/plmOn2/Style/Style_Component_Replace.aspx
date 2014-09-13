<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Component_Replace.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Replace" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">    
</head>
<body>
    <form id="form1" runat="server">

	    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
		    <tr valign="middle">
			    <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
				    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
    		    </td>
		    </tr>
	    </table>

		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Select material to be replaced</asp:label></td>
			</tr>
		</table>
        <asp:datagrid id="dgMaterial" runat="server" DataKeyField="StyleMaterialID" AutoGenerateColumns="False" 
            BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" >
            <PagerStyle />
            <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
            <ItemStyle Height="20px" CssClass="font"></ItemStyle>
            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
            <Columns>
                <asp:TemplateColumn>
                    <ItemTemplate>
                        <asp:CheckBox runat="server"  ID="chkSelect" />
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>				
        </asp:datagrid>	
		
    </form>
    
</body>
</html>
