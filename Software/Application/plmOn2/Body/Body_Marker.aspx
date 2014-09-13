<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_Marker.aspx.vb" Inherits="plmOnApp.Body_Marker" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Body - Marker</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <!-- Toolbar -->
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" 
            border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/>
                </td>
                <td>
                <cc1:ConfirmedImageButton ID="btnCreateMarker" runat="server" Message="NONE" >
                </cc1:ConfirmedImageButton> 
                <cc1:ConfirmedImageButton ID="btnAdd1" runat="server" Message="NONE" runat="server" >
                </cc1:ConfirmedImageButton>
                                 <cc1:ConfirmedImageButton ID="btnRemove1" runat="server" Message="NONE" runat="server" >
                </cc1:ConfirmedImageButton>
                &nbsp;&nbsp;&nbsp;
                <asp:CheckBox valign="top" align="center" ID="chbImperial" autopostback="true"  runat="server" Text="Imperial" CssClass="fontHead" />
               
                </td>
            </tr>
        </table>
        <br />
        <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Body-Marker</asp:label></td>
				</tr>
		</table>
	    
	    <!-- List View -->
	  
        <asp:datagrid id="dgListView" runat="server" AllowSorting="True"  width="1800px"
        DataKeyField="ID" AutoGenerateColumns="false">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
        </AlternatingItemStyle>
        <ItemStyle Height="20px"  CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader" BorderColor="Gainsboro" BorderWidth="1px"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
			<Columns>
		        <asp:TemplateColumn>
                   <ItemStyle Height="20px" CssClass="ItemTemplate" BorderWidth="1pt" BorderColor="Gainsboro" BorderStyle="Solid"></ItemStyle>
                    <HeaderStyle CssClass="TableHeader" BorderColor="Gainsboro"  />
                    <HeaderTemplate>
                          <DIV align="center">
							<asp:Label id="lblLink" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></DIV>					       
                    </HeaderTemplate>
                    <ItemTemplate>                 
                        <asp:Image id="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" Visible='<%# DisplayLinkedVisible(Container.DataItem("IsLinked")) %>' ToolTip='<%#GetsystemText("Marker Linked")%>'/>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>    
	    </asp:datagrid>
	    <asp:label id="dgListViewSortOrder" runat="server" Visible="False"></asp:label>  
	    
	    <br />
	    
	 
      <br />
        <br />
 
    <asp:Label ID="lblSummary"  runat="server" Font-Names="Tahoma,Verdana" 
            Font-Size="Large" ForeColor="#666666">Marker Spreadsheet</asp:Label>
    <br />
    <br />
          <asp:datagrid id="Datagrid1" runat="server" AllowSorting="false" 
         AutoGenerateColumns="true" BorderColor="Gainsboro" BorderStyle="None" 
            BorderWidth="1px">
        <AlternatingItemStyle Height="20px" Width="50px" CssClass="AlternateItemTemplate">
        </AlternatingItemStyle>
        <ItemStyle Height="20px" Width="50px" CssClass="ItemTemplate" BorderColor="Gainsboro" 
                  BorderWidth="1px"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader" BorderColor="Gainsboro" 
                  BorderWidth="1px"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
					
	    </asp:datagrid> 
          
    </form>
</body>
</html>
