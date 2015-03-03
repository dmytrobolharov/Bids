<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Item_Materials_GoTo.aspx.vb" Inherits="plmOnApp.Sourcing_Item_Materials_GoTo" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" /> 
    <script>
    function btnClose_Click() {
        <%= strExitScript %>
        return false;
    }
    </script>    
</head>
<body>
    <form id="form1" runat="server">

		<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<TD><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"  OnClientClick="return btnClose_Click();"></cc1:confirmedimagebutton></TD>
			</TR>
		</TABLE>
        <asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
		    PageSize="100" AutoGenerateColumns="False" Width="100%" DataKeyField="MaterialID" >
		    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
		    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
		    <HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
		    <Columns>
			    <asp:TemplateColumn>
				    <HeaderStyle HorizontalAlign="Center" Width="20px"></HeaderStyle>
				    <ItemStyle HorizontalAlign="Center"></ItemStyle>
				    <ItemTemplate>
					    <asp:Image id="Image1" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:Image>
				    </ItemTemplate>
			    </asp:TemplateColumn>
			    <asp:TemplateColumn>
					<HeaderTemplate>
						<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Select Material")%>...</asp:Label>
					</HeaderTemplate>
				    <ItemTemplate>
				        <asp:Image id="imgMaterial" runat ="server" ></asp:Image>
				    </ItemTemplate>
			    </asp:TemplateColumn>
			    
			    <asp:TemplateColumn>
				    <ItemTemplate>
				        <asp:Label ID="lblMaterialName" runat="server" />
				    </ItemTemplate>
			    </asp:TemplateColumn>

			    <asp:TemplateColumn>
				    <ItemTemplate>
				        <asp:Label ID="lblMaterialCode" runat="server" />
				    </ItemTemplate>
			    </asp:TemplateColumn>
			    			    
		    </Columns>
		</asp:datagrid>
		
		
    </form>
</body>
</html>
