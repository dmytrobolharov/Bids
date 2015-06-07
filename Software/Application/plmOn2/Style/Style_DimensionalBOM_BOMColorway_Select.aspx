<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DimensionalBOM_BOMColorway_Select.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_BOMColorway_Select" %>

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
        <script type="text/javascript">

            function GetRadWindow() {
                var oWindow = null; if (window.radWindow)
                    oWindow = window.radWindow; else if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow; return oWindow;
            }

            /*
            * Saving material color for current material and all colorways.
            * If we're pitching material through this pop-up, we're saving MaterialColorID, not the ColorPaletteID. Thus, we don't have to add "!" at the beginning
            * of the GUID.
            */
            function pitchWholeRow(senderID, strImageLink, strColorCode, strColorName, strMaterialColorID) {
                GetRadWindow().BrowserWindow.pitchColorHorizontally(senderID, strImageLink, strColorName + " - " + strColorCode, strMaterialColorID);
            }

            /*
            * Saving material color for current material and current colorway.
            * If we're pitching material through this pop-up, we're saving MaterialColorID, not the ColorPaletteID. Thus, we don't have to add "!" at the beginning
            * of the GUID.
            */
            function pitchSingleColorway(senderID, strImageLink, strColorCode, strColorName, strMaterialColorID) {
                var parentWindow = GetRadWindow().BrowserWindow;
                parentWindow.document.getElementById(senderID).src = strImageLink;
                parentWindow.document.getElementById(senderID.replace("imbColorChip", "txtColor")).value = strColorName + " - " + strColorCode;
                parentWindow.document.getElementById(senderID.replace("imbColorChip", "txtColor")).style.color = "red";
                parentWindow.document.getElementById(senderID.replace("imbColorChip", "hdnColor")).value = strMaterialColorID;
            }

            /*
            * Marking the selected color as Active color.
            */
            function makeColorActive(strImageLink, strColorCode, strColorName, strColorPaletteID) {
                GetRadWindow().BrowserWindow.setActiveColor(strImageLink, strColorCode, strColorName, strColorPaletteID);
            }

        </script>
	</head>
	<body style="background-color: #ffffff;">
		<form id="Form1" method="post" runat="server">
			
            <div style="margin-top: 15px; margin-left: 10px; border-bottom: 1px solid gainsboro; font-size: 15px;">
                <p> <input type="radio" id="chbSingle" name="chbPitchAll" value="0" checked="checked" /><label for="chbSingle"><%= GetSystemText("Pitch color only for colorway") & " " & strColorwayName %></label> </p>
                <p> <input type="radio" id="chbAll" name="chbPitchAll" value="1" /><label for="chbAll"><%= GetSystemText("Pitch color for all available colorways")%></label> </p>
            </div>
            <br />
            <div id="divMaterialColors" style="overflow: auto; height: 320px;">
			    <asp:DataList ID="dtlMaterialColors" runat="server" DataKeyField="MaterialColorID" RepeatDirection="Horizontal" RepeatLayout="Flow"
                    OnItemCommand="dtlMaterialColors_ItemCommand">
                    <ItemStyle CssClass="BOMColorChip" />
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td style="height: 50px; width: 50px; vertical-align: top; text-align: left;">
                                    <asp:ImageButton ID="btnMaterialColor" runat="server" CommandName="Pitch"/>
                                </td>
                                <td>
                                    <asp:Label ID="lblColorCode" runat="server" Width="120" CssClass="font" /><br />
                                    <asp:Label ID="lblColorName" runat="server" Width="120" CssClass="font" />
                                    <asp:HiddenField ID="hdnColorPaletteID" runat="server" />
                                    <asp:HiddenField ID="hdnColorFolderID" runat="server" />
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
