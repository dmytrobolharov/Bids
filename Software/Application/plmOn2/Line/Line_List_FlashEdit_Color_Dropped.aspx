<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Line_List_FlashEdit_Color_Dropped.aspx.vb" Inherits="plmOnApp.Line_List_FlashEdit_Color_Dropped" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/BOMColorway.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.8.0.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null; if (window.radWindow)
                oWindow = window.radWindow; else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow; return oWindow;
        }

        function closeWindow() {
            GetRadWindow().close();
            return false;
        }

        function refreshAndCloseWindow() {
            GetRadWindow().BrowserWindow.location.href = GetRadWindow().BrowserWindow.location.href;
            GetRadWindow().close();
        }
    </script>
    <style type="text/css">
        .color-label {
            display: block;
            width: 80;
            height: 80;
            outline: none;
        }        
    </style>
</head>
<body style="background-color: #ffffff;">
    <form id="Form1" method="post" runat="server">    
    <div id="divStyleColors" style="overflow: auto; height: 200px; border-bottom: 1px solid gainsboro;">
        <asp:DataList ID="dtlColorways" runat="server" DataKeyField="StyleColorID" RepeatDirection="Horizontal" RepeatLayout="Flow">
            <ItemStyle BorderWidth="1" BorderStyle="Solid" BorderColor="Gainsboro" CssClass="BOMColorChip" />
            <ItemTemplate>
                <table>
                    <tr>
                        <td style="height: 80px; width: 80px; vertical-align: top; text-align: left;">                            
                            <asp:Label ID="colorLabel" runat="server" AssociatedControlID="chkSelect" CssClass="color-label">
                                <asp:CheckBox ID="chkSelect" runat="server" />                                
                            </asp:Label>
                            <asp:HiddenField ID="hdnColorPaletteID" runat="server" Value='<% Eval("ColorPaletteID") %>' />
                            <asp:HiddenField ID="hdnColorName" runat="server" Value='<% Eval("ColorName") %>' />
                        </td>
                        <td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblColorCode" runat="server" CssClass="font" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblColorName" runat="server" CssClass="font" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
    </div>
    <div style="width: 100%; text-align: right;">
        <cc1:ConfirmedButton ID="btnSave" runat="server" />
        <asp:Button ID="btnCancel" runat="server" OnClientClick="return closeWindow();" />
    </div>
    </form>
    <script type="text/javascript">
        $("#btnSave, #btnCancel").button().css("color", "#000000");       
    </script>
</body>
</html>