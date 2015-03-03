<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_Option3D.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_Option3D" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />

    <input id="hidBOMDimensionId" type="hidden" name="hidBOMDimensionId" width="20" runat="server" />
    <asp:Panel runat="server">
        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10px"><img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                <td>                    
                    <cc1:ConfirmedImageButton ID="btnSave" Message="NONE" runat="server"></cc1:ConfirmedImageButton>&nbsp;       
                    <cc1:BWImageButton ID="btnChangeLog" runat="server" Visible="false" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:BWImageButton>&nbsp;
                    <cc1:ConfirmedImageButton ID="btnClose" Message="NONE" runat="server" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>&nbsp;&nbsp;                    
                </td>
            </tr>
        </table>
    </asp:Panel>

    <asp:DataGrid id="DataGrid1" runat="server" AllowSorting="false" DataKeyField="ItemDim1Id" >
	    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
	    <PagerStyle Visible="False"></PagerStyle>
        <Columns><asp:TemplateColumn Visible="false"></asp:TemplateColumn></Columns>
    </asp:DataGrid>

    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
