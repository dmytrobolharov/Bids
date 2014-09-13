<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Image_Schedule.aspx.vb" Inherits="plmOnApp.Image_Schedule" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Image_Header" Src="Image_Header.ascx" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Material Workflow</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />	
</head>
<body>
    <form id="form1" runat="server">
      <wc1:Color_Wait ID="Color_Wait" runat="server" />
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:confirmedimagebutton id="btnSave" runat="server" message="NONE"></cc1:confirmedimagebutton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false" />
                <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>             
            </td>
        </tr>
    </table>
    <asp:PlaceHolder ID="plhWorkflowControls" runat="server" ></asp:PlaceHolder>
    <uc1:Image_Header runat="server" ID="Image_Header1" IsCollapsible="true" IsCollapsed="true" />
    <asp:DataGrid ID="dgWorkflow" runat="server" DataKeyField="ImageWorkflowPageID" AllowSorting="False">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
        <Columns>
            <asp:TemplateColumn Visible="false">
                <%-- Do not delete this column --%>
                <ItemTemplate>
                    <asp:Label runat="server" ID="ChangeLogHeaderName" Text='<%# Eval("ImageWorkflowTemplateItemName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    </form>
</body>
</html>
