<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Whereused_Silho.aspx.vb"
    Inherits="plmOnApp.Style_Whereused_Silho" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Where used</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
 <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:bwimagebutton ID="btnCopy" runat="server" Message="NONE" >
                </cc1:bwimagebutton>
                <cc1:bwimagebutton ID="btnNewStyle" runat="server" 
                    Message="NONE"></cc1:bwimagebutton>
                
            </td>
            <td class="fontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td valign="middle">
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana">Where Used</asp:Label>
            </td>
        </tr>
    </table>
    
    <asp:datagrid id="dgSilhoWhereused" runat="server" BorderStyle="NotSet" AllowSorting="true"
                 AutoGenerateColumns="false" OnItemDataBound="WhereusedBinding"
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                CellSpacing="0" DataKeyField="StyleID">
		        <PagerStyle />
		        <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
		        <ItemStyle Height="20px" CssClass="font"></ItemStyle>
		        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
		        <Columns>
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <ItemTemplate>
                            <cc1:BWImageButton runat="server" ID="imgRedirect" ImageUrl="../System/icons/icon_search.gif" />
                         </ItemTemplate>
                    </asp:TemplateColumn>

		        </Columns>
	        </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
    </form>

    

</body>


</html>
