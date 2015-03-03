<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_Request_Workflow_Wizard_Final.aspx.vb" Inherits="plmOnApp.Material_Request_Workflow_Wizard_Final" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title></title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />    
	<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">

			<TABLE class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr>
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td><asp:imagebutton id="btnSave" runat="server"  />
					<asp:imagebutton id="btnCancel" runat="server" /></td>
				</tr>
			</TABLE>

			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Material Request</asp:label></td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" 
                            ImageUrl="../System/Icons/icon_Next.gif" ToolTip="Show Material Header..." 
                            style="width: 16px"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" ToolTip="Hide Material Header..." Visible="false"></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:label id="lblMaterialDetail" runat="server"></asp:label></td>
				</tr>
			</table>
			<br />

			<asp:panel id="Panel1" runat="server" CssClass="font" BorderWidth="0" BackColor="#ffffff" Width="100%" Visible="false">
				<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc2:Material_Header id="Material_Header1" runat="server"></uc2:Material_Header></td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</asp:panel>




            <asp:datagrid id="DataGrid1" runat="server" PageSize="50" AllowSorting="True" DataKeyField="MaterialColorSeasonYearID">
	            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
	            <PagerStyle Visible="False"></PagerStyle>
                <Columns > 
                    <asp:TemplateColumn>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chkSelect" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
            
    
            <br /><br />
			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
                <tr>
                    <td class="fontHead"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
                </tr>
            </table>


			<br /><br />
            <asp:datagrid id="DataGrid2" runat="server" PageSize="50" AllowSorting="True" DataKeyField="TradePartnerVendorId">
	            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
	            <PagerStyle Visible="False"></PagerStyle>
                <Columns > 
                    <asp:TemplateColumn>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chkSelect" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:datagrid><asp:label id="Label1" runat="server" Visible="False"></asp:label>

    
    </form>
</body>
</html>
