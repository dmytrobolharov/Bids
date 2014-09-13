<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Material_Template_Add.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Material_Template_Add" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">  
     <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />  
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    <div>

        <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	        height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	        <tr>
		        <td width="25" height="50">&nbsp;</td>
		        <td>
                    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
	                    <tr>
		                    <td width="25" height="50">&nbsp;<img src="../System/icons/icon_form_new.gif" /></td>
		                    <td><span class="fontHead">&nbsp;<asp:Label ID="lblSelTemp" runat="server" Text="Please Select Available Template..."></asp:Label></span></td>
	                    </tr>
                    </table>
		        </td>
	        </tr>
        </table>		
    
            <cc1:ScrollingGrid ID="sgMaterialTemplate" runat="server" Height="475px" Width="580px">
                <asp:datagrid id="Datagrid1" runat="server" BorderStyle="NotSet" AllowSorting="true"
                 AutoGenerateColumns="false"  
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                CellSpacing="0">
                    <PagerStyle />
                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns>
					    <asp:TemplateColumn>
					        <ItemTemplate>
                                <asp:Label ID="lblRadio" runat="server"></asp:Label>
					        </ItemTemplate>
					    </asp:TemplateColumn>
					</Columns> 
                </asp:datagrid>
            </cc1:ScrollingGrid>                
                <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
                <table style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro" height="40" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	                <tr>
		                <td align="center" width="50">&nbsp;</td>
		                <td align="center" width="500">
			                <asp:imagebutton id="btnSave" runat="server" ></asp:imagebutton>
			                <asp:imagebutton id="btnClose" runat="server" ></asp:imagebutton>
		                </td>
		                <td align="center">&nbsp;</td>
	                </tr>
                </table>
                    
    </div>
    </form>
</body>
</html>
