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
                <cc1:BWImageButton ID="btnCreateModel" runat="server" Message="NONE"></cc1:BWImageButton>           	
                <cc1:BWImageButton ID="btnAdd1" runat="server" Message="NONE" runat="server"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnRemove1" runat="server" Message="NONE" runat="server"></cc1:BWImageButton>
                &nbsp;&nbsp;&nbsp;
                <asp:CheckBox valign="top" align="center" ID="chbImperial" autopostback="true"  runat="server" Text="Imperial" CssClass="fontHead" />
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
    </form>
</body>
</html>
