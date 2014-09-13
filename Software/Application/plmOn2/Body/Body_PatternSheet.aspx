<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_PatternSheet.aspx.vb"
    Inherits="plmOnApp.Body_PatternSheet" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Body - Model</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <!-- Toolbar -->
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/>
            </td>
            <td>
            	<cc1:ConfirmedImageButton ID="btnCreateModel" runat="server" Message="NONE">
                </cc1:ConfirmedImageButton>           	
                 <cc1:ConfirmedImageButton ID="btnAdd1" runat="server" Message="NONE" runat="server"  >
                </cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnRemove1" runat="server" Message="NONE" runat="server"  >
                </cc1:ConfirmedImageButton>
                &nbsp;&nbsp;&nbsp;
                <asp:CheckBox valign="top" align="center" ID="chbImperial" autopostback="true"  runat="server" Text="Imperial" CssClass="fontHead" />
               <%--<cc1:bwimagebutton ID="btnAdd" runat="server" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_add.gif" WindowName="ModelAdd">
                </cc1:bwimagebutton>--%>
                <%--<cc1:BWImageButton ID="btnRemove" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_remove.gif">
                </cc1:BWImageButton>--%>
               <%--<cc1:ConfirmedImageButton ID="btnRefresh" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_refresh.gif">
                </cc1:ConfirmedImageButton>--%>
            </td>
        </tr>
    </table>
    <br />
            <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Large">Body - Model</asp:label></td>
				</tr>
			</table>
    <!-- HEADER -->
    <!-- Model List View -->
               
   <asp:DataGrid ID="Datagrid2" runat="server" AllowSorting="True" 
        DataKeyField="ID" AutoGenerateColumns="false">
        <AlternatingItemStyle Height="20px" Width="50px" CssClass="AlternateItemTemplate">
        </AlternatingItemStyle>
        <ItemStyle Height="20px" Width="50px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle> 
        <Columns>
		       <asp:TemplateColumn >
                   <ItemStyle Height="20px" Width="50px" CssClass="ItemTemplate" BorderWidth="1pt" BorderColor="Gainsboro" BorderStyle="Solid"></ItemStyle>
                    <HeaderStyle CssClass="TableHeader" BorderColor="Gainsboro"  />
                    <HeaderTemplate>
                        <DIV align="center">
									<asp:Label id="lblLink" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></DIV>
					</HeaderTemplate>
                    <ItemTemplate>                 
                        <asp:Image id="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" Visible='<%# DisplayLinkedVisible(Container.DataItem("IsLinked")) %>' ToolTip='<%#GetSystemText("Linked")%>'/>
                    </ItemTemplate>
                 </asp:TemplateColumn>
	    </Columns>     			
    </asp:DataGrid>

     <asp:Label ID="SortOrder2" runat="server" Visible="False"></asp:Label>
    <br />
    <br />
 <%--   <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr>
            <td>
                <cc1:ConfirmedImageButton ID="btnEdit" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_edit.gif">
                </cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_save.gif">
                </cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_cancel.gif">
                </cc1:ConfirmedImageButton>
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
            </td>
        </tr>
        <tr>
            <td>
                <%-- <asp:PlaceHolder  runat ="server"  ID="plhControlsHolderEdit" ></asp:PlaceHolder>
                <asp:PlaceHolder runat="server" ID="plhControlsHolder"></asp:PlaceHolder>
            </td>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        <!-- Piece Views -->
        <tr>
            <td>
                <cc2:YSTabView ID="YSTabView2" runat="server"></cc2:YSTabView>
            </td>
        </tr>
        <tr>
            <td>
                <!-- Piece List View -->
           
                			<asp:datagrid id="DataGrid1" runat="server" AllowSorting="False" 
                    DataKeyField="ID">
							<AlternatingItemStyle Height="25px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="25px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid>
                <asp:Label ID="SortOrder1" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
    </table>--%>
<%--    <!-- Thumbnail View -->
    <table bordercolor="gainsboro" cellspacing="1" cellpadding="0" border="0">
        <tr>
            <td valign="top">
                <asp:DataList ID="Datalist2" runat="server" EnableViewState="false" RepeatDirection="Horizontal"
                    RepeatColumns="1" RepeatLayout="Table" DataKeyField="ImageId">
                    <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
                        VerticalAlign="Top" BackColor="White"></ItemStyle>
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    <ItemTemplate>
                        <table id="tbItem" runat="server" bordercolor='#CCCCCC' border="1" cellpadding="0"
                            width="100%" cellspacing="0">
                            <tr>
                                <td>
                                    <table class="TableHeader" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblEdit" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr height='<%#ImageWidth%>'>
                                <td>
                                    <asp:Image ID="imgDesign" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:PlaceHolder ID="pnlHeader" runat="server"></asp:PlaceHolder>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="txtImageVersion" runat="server" />
                        <input type="hidden" id="txtImageFileName" runat="server" /><br />
                    </ItemTemplate>
                </asp:DataList>
            </td>
        </tr>
    </table>
    <input id="imageSize" type="hidden" runat="server" />--%>
    </form>
</body>
</html>
