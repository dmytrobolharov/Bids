<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DimensionalBOM_BOMColorway_Add.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_BOMColorway_Add" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head runat="server">
		<title></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/BOMColorway.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script type="text/javascript">

            function GetRadWindow() {
                var oWindow = null; if (window.radWindow)
                    oWindow = window.radWindow; else if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow; return oWindow;
            }

            function closeAndRebind() {
                GetRadWindow().BrowserWindow.refreshTempColorsList();
                GetRadWindow().close();
            }

        </script>
	</head>
	<body style="background-color: #ffffff;">
		<form id="Form1" method="post" runat="server">
			
            <div style="margin-top: 10px; margin-left: 10px; border-bottom: 1px solid gainsboro; padding-bottom: 15px;">
                <div style="width: 100%; font-size: 15px;">
                    <asp:Label ID="lblDescription" runat="server"></asp:Label> 
                </div>
                <br />
                <div style="width: 100%; text-align: right;">
                    <asp:Button id="btnAdd" runat="server" />
                    <asp:Button ID="btnAddAll" runat="server" />
                </div>
            </div>
            <br />
            <div id="divMaterialColors" style="overflow: auto; height: 330px;">
			    <asp:DataList ID="dtlMaterialColors" runat="server" DataKeyField="MaterialColorID" RepeatDirection="Horizontal" RepeatLayout="Flow">
                    <ItemStyle CssClass="BOMColorChip" />
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td id="tdMaterialColor" runat="server" style="height: 60px; width: 60px; vertical-align: top; text-align: left; ">
                                    <label style="width:100%; height:100%; display:block;">
                                        <asp:CheckBox ID="chbSelectColor" runat="server" />
                                    </label>
                                </td>
                                <td>
                                    <asp:Label ID="lblColorCode" runat="server" Width="110" CssClass="font" /><br />
                                    <asp:Label ID="lblColorName" runat="server" Width="110" CssClass="font" />
                                    <asp:HiddenField ID="hdnColorPaletteID" runat="server" />
                                </td>
                            </tr>
                        </table>
				    </ItemTemplate>
                </asp:DataList>
			</div>
        </form>

        <script type="text/javascript">
            $("#btnAdd, #btnAddAll").button().css("color", "#000000");
        </script>
	</body>
</html>
