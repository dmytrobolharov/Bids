<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_Folder_History_List.aspx.vb" Inherits="plmOnApp.Vendor_Folder_History_List" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Color History</title>
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<form id="Form2" method="post" runat="server">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
        <asp:Panel runat="server" ID="pnlPerm" Visible=false>
				<table style="height:50;" cellspacing="0" cellpadding="0" width="100%"  bgColor="#990000" border="1" borderColor="red">
					<tr>
						<td>
                            <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                    <td><asp:Label ID="lblPerm" runat="server" 
                                        Text="You might not have permission to access agent using your credentials." 
                                        CssClass="fontHead" ForeColor="White"></asp:Label></td>
                                </tr>
                            </table>
                          </td>
                      </tr>
                  </table>			
			</asp:Panel>
              <asp:Panel runat="server" ID="pnlMain">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnClear" runat="server"  ></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
            <asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="TradePartnerID" AutoGenerateColumns="False" BorderWidth="1">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                            <asp:TemplateColumn>
                            <HeaderTemplate>
                               <asp:Label ID="Label1" runat="server" ><%# GetSystemText("Partner Code")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                            <asp:label runat="server" ID="lblColorTypeDescription"><%# Container.DataItem("TradePartnerCode")%></asp:label>
                            </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                            <HeaderTemplate>
                               <asp:Label ID="Label1" runat="server" ><%# GetSystemText("Partner Name")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                            <asp:label runat="server" ID="lblColorFolderDescription"><%# Container.DataItem("TradePartnerName")%></asp:label>
                            </ItemTemplate>
                            </asp:TemplateColumn>
                            </Columns>
						</asp:datagrid>
                        </asp:Panel>
			</form>
	</body>
</html>

