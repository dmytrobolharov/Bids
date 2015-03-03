<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_FolderPage_ImageDelete.aspx.vb" Inherits="srmOnApp.Vendor_FolderPage_ImageDelete" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title runat="server" id="PageTitle">Image</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
	<body>

		<form id="Form1" method="post" runat="server">
 
            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr>
		            <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td> 
		            <td><cc1:confirmedimagebutton id="btnDeleteImage" runat="server"></cc1:confirmedimagebutton>
		                <asp:ImageButton ID="btnClose" runat="server" OnClientClick="window.close(); return false;" />
		            </td>
	            </tr>
            </table>
            <asp:datagrid id="dgImage" runat="server" AutoGenerateColumns="False" PageSize="100" BorderWidth="1px"
	            BorderStyle="Solid" BorderColor="Silver" Width="100%" DataKeyField="TradePartnerInfrastructureImageID">
	            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
	            <Columns>
		            <asp:TemplateColumn>
			            <HeaderTemplate>
				            <asp:Image id="Image1" runat="server" ImageUrl="../System/Icons/icon_delete.gif"></asp:Image>
			            </HeaderTemplate>
			            <ItemTemplate>
				            <asp:CheckBox id="cbImageDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>'></asp:CheckBox>
                            <asp:HiddenField ID="hdnIsLinked" runat="server" Value='<%# Eval("IsLinked") %>' />
			            </ItemTemplate>
		            </asp:TemplateColumn>
	            </Columns>
            </asp:datagrid>
			
		</form>
		<script type="text/javascript" language="javascript">

		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chbLevel3ID") != -1)
		                e.checked = actVar;
		        }
		    }
		</script>
	</body>
</html>