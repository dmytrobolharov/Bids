<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOMMaterial_SizeEdit.aspx.vb"
    Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOMMaterial_SizeEdit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Material Size Edit</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td align="center" width="3">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                        </td>
                        <td height="30">
                            <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                            <cc1:bwimagebutton id="btnAddTreatment" runat="server"></cc1:bwimagebutton>
                            <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return CloseWindow()"></cc1:confirmedimagebutton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr><td style="padding:10px 2px"><asp:Label ID="lblMaterialSizeType" runat="server" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label></td></tr>
        <tr>
            <td>
                <table id="TD_ImgFolder" cellspacing="1" cellpadding="0" border="0" runat="server">
                    <tr bgcolor="#ffffff">
                        <td>
                            <cc1:confirmedimagebutton id="btnDelete" runat="server" message="NONE"></cc1:confirmedimagebutton>
                        </td>
                        <td>
                            <asp:Label ID="lblSortBy" CssClass="font" runat="server"><b>&nbsp;Sort by:</b></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSortBy" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <cc1:confirmedimagebutton id="btnSort" runat="server" message="NONE"></cc1:confirmedimagebutton>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:DataGrid ID="dgSize" runat="server"
                    DataKeyField="MaterialSizeID" Width="250" AutoGenerateColumns="False" PageSize="1000"
                    BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
                    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <FooterStyle></FooterStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
                                <asp:TextBox ID="txtMaterialSizeVersion" runat="server" Visible="false" />
                                <asp:HiddenField ID="hdnMaterialSizeVersion" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label ID="lblMaterialSize" runat="server" Text='<%#GetSystemText(MaterialSizeHeaderName)%>'></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtMaterialSize" runat="server" BorderWidth="1px" BorderStyle="Solid"
                                    BorderColor="#E0E0E0" MaxLength="100" Columns="30"></asp:TextBox>
                                <asp:HiddenField ID="hdnMaterialSize" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblMaterialPrice" runat="server" Text='<%#GetSystemText("Price")%>'></asp:Label>
                                    <asp:HiddenField ID="hdnMaterialPrice" runat="server" />
                                </div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtMaterialPrice" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                    BorderColor="#E0E0E0" MaxLength="5" Columns="5"></asp:TextBox>
                                <asp:HiddenField ID="hdnMaterialPrice" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="Label1" runat="server"><%=GetSystemText("Sort")%></asp:Label></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtSort" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
                                    MaxLength="5" Columns="5"></asp:TextBox>
                                <asp:HiddenField ID="hdnSort" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </td>
        </tr>
    </table>
    </form>
    
    <script type="text/javascript">            
		    var frm = document.form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked, e, i;
		        
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1 && !e.disabled) {
		                e.checked = actVar;
		            }
		        }
		    }

		    function CloseWindow() {		        
		        var boxes, len;
		        
		        try {
		            boxes = window.opener.Telerik.Web.UI.RadComboBox.ComboBoxes;
		        } catch (e) {
		            boxes = [];
		        }

		        for (i = 0, len = boxes.length; i < len; i++) {
		            boxes[i].clearItems();
		        }

		        window.close();
		    }
	</script>
</body>
</html>
