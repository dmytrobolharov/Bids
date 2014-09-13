<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmitTempSelect.aspx.vb" Inherits="plmOnApp.Material_RequestSubmitTempSelect" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Select Template</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
        <table cellspacing="0" cellpadding="0" width="100%" border="0" class="TableHeader">
            <tr>                
                <td>
                    <asp:ImageButton ID="btnSave" runat="server"></asp:ImageButton>
                    <asp:ImageButton ID="btnClose" runat="server"></asp:ImageButton>
                </td>                
            </tr>
        </table>
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
            <cc1:ScrollingGrid ID="sgMaterialTemplate" runat="server" Height="475px" 
            Width="580px">
                <asp:datagrid id="dgMaterialSubmitTemplate" runat="server" BorderStyle="NotSet" AllowSorting="false"
                 AutoGenerateColumns="false"  DataKeyField="MaterialRequestWorkflowGroupID" 
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
    <asp:HiddenField ID="hdnXmlFiles" runat="server" />
    </form>
</body>
</html>
