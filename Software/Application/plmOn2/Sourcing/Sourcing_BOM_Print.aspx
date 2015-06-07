<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_BOM_Print.aspx.vb" Inherits="plmOnApp.Sourcing_BOM_Print" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
			<asp:datagrid id="DataGrid1" runat="server" BorderColor="#999999" 
                    BorderStyle="Solid" BorderWidth="0px"
				PageSize="100" AutoGenerateColumns="False" DataKeyField="ComponentTypeID" 
                    ShowHeader="false" CellPadding="1" CellSpacing="1" >
				<ItemStyle Height="20px" BackColor="White"></ItemStyle>
				<Columns>
				    <asp:TemplateColumn>
					    <ItemTemplate>
					    <table style="border-style: inherit; border-width: thin; border-color: #C0C0C0;" width="100%">
					    <tr>
					    <td> <TABLE cellSpacing="0" cellPadding="0" border="0"  runat="server" id ="tbHeader">
							    <TR>
								    <TD width="10" bgColor="white"></TD>
								    <TD bgColor="white"><asp:Label ID="lblCompDescription"  runat ="server" Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt"></asp:Label></TD>
							    </TR>
						    </TABLE></td>
					    </tr>
					    </table>
						   
						    <asp:DataGrid runat="server" ID="dgComponenType" BorderColor="#999999" 
                                BorderStyle="Solid" BorderWidth="1px" CellPadding="0">
	                            <AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderStyle="Solid" BorderColor="Black"></AlternatingItemStyle>
                                <ItemStyle Font-Size="6pt" Font-Names="Tahoma" ></ItemStyle>
                                <HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black"  BackColor="WhiteSmoke"></HeaderStyle>
						        <Columns>
						            <asp:TemplateColumn>
						                <ItemTemplate>
						                    <asp:Image runat="server" ID="imgDesign" />
						                </ItemTemplate>
						            </asp:TemplateColumn>
    						            
						            <asp:TemplateColumn>
						                <ItemTemplate>
						                    <asp:PlaceHolder runat="server" ID="phlComponents"></asp:PlaceHolder>
						                </ItemTemplate>
						            </asp:TemplateColumn>
    					        </Columns>
    					    </asp:DataGrid>
					    </ItemTemplate>
				    </asp:TemplateColumn>
				</Columns>
            </asp:datagrid>
    </form>
</body>
</html>
