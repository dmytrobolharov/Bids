<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Image_Schedule.aspx.vb" Inherits="srmOnApp.Image_Schedule" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Material Workflow</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />	
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:confirmedimagebutton id="btnSave" runat="server" message="NONE"></cc1:confirmedimagebutton>                
            </td>
        </tr>
    </table>
    <asp:PlaceHolder ID="plhWorkflowControls" runat="server" ></asp:PlaceHolder>
    <asp:DataGrid ID="dgWorkflow" runat="server" DataKeyField="ImageWorkflowTemplateEntryID" AllowSorting="False">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
        <%--<Columns>
            <asp:TemplateColumn>
                <HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
                <ItemTemplate>
                    <asp:Image ID="imgStatus" runat="server" ImageUrl='<%# string.Concat("../System/Icons/"  + DataBinder.Eval(Container.DataItem,"WorkflowStatusImage").tostring ) %>'>
                    </asp:Image>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>--%>
    </asp:DataGrid>
    </form>
</body>
</html>
