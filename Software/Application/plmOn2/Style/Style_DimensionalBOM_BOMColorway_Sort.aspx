<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DimensionalBOM_BOMColorway_Sort.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_BOMColorway_Sort" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head runat="server">
		<title></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/BOMColorway.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style type="text/css">
            #dtlColorways .ui-sortable-helper {
            	background-color: #fff;
            	box-shadow: 2px 2px 5px #000;
            }
        </style>
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

            function recalculateSorts() {
                var items = $("input[id$='hdnSort']");
                var length = items.length;
                for (var i = 0; i < length; i++) {
                    items[i].value = i.toString();
                }
            }

            $(function () {
                $('#dtlColorways').sortable({
                    tolerance: 'pointer',
                    iframeFix: true,
                    cursorAt: { top: 80 },
                    update: function () { recalculateSorts(); },
                    start: function (e, ui) {
                        ui.placeholder.css('visibility', 'visible')
                            .height($.support.cssFloat ? ui.item.height() : ui.item.outerHeight()); 
                    }
                });
            });

        </script>
	</head>
	<body style="background-color: #ffffff;">
		<form id="Form1" method="post" runat="server">
			
            <div style="margin-top: 10px; margin-left: 10px; border-bottom: 1px solid gainsboro; padding-bottom: 15px; font-size: 15px;">
                <asp:Label ID="lblDescription" runat="server"></asp:Label> 
            </div>
            <br />
            <div id="divStyleColors" style="overflow: auto; height: 430px; border-bottom: 1px solid gainsboro;">
			    <asp:DataList ID="dtlColorways" runat="server" DataKeyField="DimID" RepeatDirection="Horizontal" RepeatLayout="Flow">
                <ItemStyle BorderWidth="1" BorderStyle="Solid" BorderColor="Gainsboro" CssClass="draggable droppable BOMColorChip" />
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td style="height: 50px; width: 50px; vertical-align: top; text-align: left;">
                                    <asp:Image ID="imgColorway" runat="server" Width="50" />
                                    <asp:HiddenField ID="hdnSort" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="lblColorCode" runat="server" Width="120" CssClass="font" /><br />
                                    <asp:Label ID="lblColorName" runat="server" Width="120" CssClass="font" />
                                </td>
                            </tr>
                        </table>
				    </ItemTemplate>
                </asp:DataList>
			</div>
            <div style="width: 100%; text-align: right;">
                    <cc1:ConfirmedButton id="btnSave" runat="server" />
                    <asp:Button ID="btnCancel" runat="server" OnClientClick="return closeWindow();"/>
            </div>
        </form>

        <script type="text/javascript">
            $("#btnSave, #btnCancel").button().css("color", "#000000");
        </script>
	</body>
</html>
