<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DetailGrid_Custom_Delete.aspx.vb" Inherits="plmOnApp.Style.DetailGrid.Style_DetailGrid_Custom_Delete" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Delete</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
			<table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left" width="400">
                            <cc1:confirmedimagebutton id="btnDelete" runat="server"  Message="NONE"></cc1:confirmedmagebutton>
                            <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                        </td>
						<td></td>
					</tr>
				</TBODY>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Delete Item...</asp:label></td>
				</tr>
			</table>
			
			
			<asp:datagrid id="DataGrid1" runat="server" Width="300px" BorderColor="#E0E0E0" BorderStyle="Solid"
				 AllowSorting="true" BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" DataKeyField="StyleDetailGridID">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle CssClass="TableHeaderRed" Width="20"></HeaderStyle>
						<ItemStyle BackColor="Pink"></ItemStyle>
						<HeaderTemplate>
							<input id="checkAll" onclick="CheckAll(this);" type="checkbox" >
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkDelete" runat="server"></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			
		    <script language="javascript">
		        var frm = document.form1 ;
		        function CheckAll( checkAllBox ) 	{
			        var actVar = checkAllBox.checked ;
			        for(i=0;i< frm.length;i++)	{
				        e=frm.elements[i];
				        if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
					        e.checked= actVar ;
			        }
		        }
		    </script>

    </form>
</body>
</html>
