<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Costing_CopyFrom_Selected.aspx.vb" Inherits="plmOnApp.Style.Costing.Style_Costing_CopyFrom_Selected" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet"/>
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet"/>
    <title></title>    
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
	    <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><asp:imagebutton 
			        id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px"></asp:imagebutton><cc1:confirmedimagebutton 
				    id="btnBack" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
				    id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
				    id="btnClose" runat="server"  Message="NONE" Visible="True"></cc1:confirmedimagebutton></td>
		    </tr>
	    </table>
	    
		<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
			<tr>
				<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Copy from style...</asp:Label></td>
			</tr>
		</table>	    
        
		<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td width="900"><br/><br/><asp:PlaceHolder ID="plhHeader" runat="server"></asp:PlaceHolder><br/><br/></td>
				<td></td>
			</tr>
		</table>    
		


    
    
        <asp:datagrid id="dgCostingType" runat="server" DataKeyField="StyleCostingID" Width="300"
	        AutoGenerateColumns="false">
	        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	        <ItemStyle Height="20px" CssClass="ItemTemplate" BackColor="White"></ItemStyle>
	        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
	        <Columns>
                <asp:TemplateColumn>
                    <HeaderTemplate>
                        <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chkSelected" />
                    </ItemTemplate>
                </asp:TemplateColumn>
	        </Columns>
	        
	        <PagerStyle Visible="False"></PagerStyle>
        </asp:datagrid>    

    </div>
    </form>
		<script language="javascript" type="text/javascript"  >
		var frm = document.form1 ;
		function SelectAll(checkAllBox) {
		    var actVar = checkAllBox.checked ;
		    for(i=0;i< frm.length;i++) {
			    e=frm.elements[i];
			    if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
			        e.checked= actVar ;
		    }
		}
		</script>
		    
</body>
</html>
