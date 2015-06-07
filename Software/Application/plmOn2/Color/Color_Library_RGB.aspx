<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_Library_RGB.aspx.vb" Inherits="plmOnApp.Color_Library_RGB" %>

<%@ Register Assembly="YSWebControls" Namespace="Yunique.WebControls" TagPrefix="cc1" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server" id="PageTitle">Set RGB Color</title>
    <script type="text/javascript" src="../System/Jscript/prototype.js"></script>
    <script type="text/javascript" src="../System/Jscript/colormethods.js"></script>
    <script type="text/javascript" src="../System/Jscript/colorvaluepicker.js"></script>
    <script type="text/javascript" src="../System/Jscript/slider.js"></script>
    <script type="text/javascript" src="../System/Jscript/colorpicker.js"></script>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <div id="fixed_icons">
        <a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help"
            target="_blank" id="yHelp"></a>
    </div>
    <form id="form1" runat="server">
    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" CausesValidation="false"></cc1:ConfirmedImageButton>
                <asp:ImageButton ID="btnClose" runat="server" CausesValidation="false" OnClientClick="return btnClose_Click();"/>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="35" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td width="20">
                &nbsp;
            </td>
            <td width="20">
                <img src="../System/Icons/icon_colorwheel.gif" />
            </td>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Medium"
                    ForeColor="Gray">Set RGB Value...</asp:Label>
            </td>
        </tr>
    </table>
    <table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="White">
        <tr>
            <td valign="top" width="400" height="600" style="border: 1px solid #F0F0F0; margin: auto;
                padding: inherit;">
                <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25"
                    border="0">
                    <tr>
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                        </td>
                        <td>
                            <cc1:ConfirmedImageButton ID="btnSelectRGB" runat="server" Message="NONE" CausesValidation="false"/>
                            <cc1:BWImageButton ID="btnCreateImage" runat="server" Message="NONE" CausesValidation="false"/>
                            <cc1:BWImageButton ID="btnSelectImage" runat="server" Message="NONE" CausesValidation="false"/>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="pnlRGB" runat="server">
                    <table bgcolor="White" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td valign="top" width="256">
                                <div style="width: 256px" id="cp1_ColorMap">
                                </div>
                            </td>
                            <td valign="top" width="50">
                                <div id="cp1_ColorBar">
                                </div>
                            </td>
                            <td valign="top" width="100">
                                <table>
                                    <tr>
                                        <td colspan="2">
                                            <div style="border-bottom: #000 1px solid; border-left: #000 1px solid; padding-bottom: 0px;
                                                background-color: #fff; margin: 0px; padding-left: 0px; width: 60px; padding-right: 0px;
                                                height: 60px; border-top: #000 1px solid; border-right: #000 1px solid; padding-top: 0px"
                                                id="cp1_Preview">
                                                <br>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label for="cp1_RedRadio">
                                                <asp:Label ID="lblRed" runat="server">R:</asp:Label></label>
                                        </td>
                                        <td>
                                            <input style="width: 40px" id="cp1_Red" name="cp1_Red" value="255" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label for="cp1_GreenRadio">
                                                <asp:Label ID="lblGreen" runat="server">G:</asp:Label></label>
                                        </td>
                                        <td>
                                            <input style="width: 40px" id="cp1_Green" name="cp1_Green" value="0" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label for="cp1_BlueRadio">
                                                <asp:Label ID="lblBlue" runat="server">B:</asp:Label></label>
                                        </td>
                                        <td>
                                            <input style="width: 40px" id="cp1_Blue" name="cp1_Blue" value="0" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            #:
                                        </td>
                                        <td>
                                            <input style="width: 60px" id="cp1_Hex" name="cp1_Hex" runat="server" value='<%# Request.Querystring("HEX") %>'>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <div visible="false" style="visibility: hidden">
                        <table>
                            <tr>
                                <td>
                                    <input id="cp1_RedRadio" value="r" type="radio" name="cp1_Mode">
                                </td>
                                <td>
                                    <input id="cp1_GreenRadio" value="g" type="radio" name="cp1_Mode">
                                </td>
                                <td>
                                    <input id="cp1_BlueRadio" value="b" type="radio" name="cp1_Mode">
                                </td>
                                <td>
                                    <input id="cp1_HueRadio" value="0" type="radio" name="cp1_Mode" runat="server">
                                </td>
                                <td>
                                    <input style="width: 40px" id="cp1_Hue" value="0" runat="server">
                                </td>
                                <td>
                                    <input id="cp1_SaturationRadio" value="1" type="radio" name="cp1_Mode" runat="server">
                                </td>
                                <td>
                                    <input style="width: 40px" id="cp1_Saturation" value="100" runat="server">
                                </td>
                                <td>
                                    <input id="cp1_BrightnessRadio" value="2" type="radio" name="cp1_Mode" runat="server">
                                </td>
                                <td>
                                    <input style="width: 40px" id="cp1_Brightness" value="100" runat="server">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="display: none">
                        <img src="../System/Images/rangearrows.gif" />
                        <img src="../System/Images/mappoint.gif" />
                        <img src="../System/Images/bar-saturation.png" />
                        <img src="../System/Images/bar-brightness.png" />
                        <img src="../System/Images/bar-blue-tl.png" />
                        <img src="../System/Images/bar-blue-tr.png" />
                        <img src="../System/Images/bar-blue-bl.png" />
                        <img src="../System/Images/bar-blue-br.png" />
                        <img src="../System/Images/bar-red-tl.png" />
                        <img src="../System/Images/bar-red-tr.png" />
                        <img src="../System/Images/bar-red-bl.png" />
                        <img src="../System/Images/bar-red-br.png" />
                        <img src="../System/Images/bar-green-tl.png" />
                        <img src="../System/Images/bar-green-tr.png" />
                        <img src="../System/Images/bar-green-bl.png" />
                        <img src="../System/Images/bar-green-br.png" />
                        <img src="../System/Images/map-red-max.png" />
                        <img src="../System/Images/map-red-min.png" />
                        <img src="../System/Images/map-green-max.png" />
                        <img src="../System/Images/map-green-min.png" />
                        <img src="../System/Images/map-blue-max.png" />
                        <img src="../System/Images/map-blue-min.png" />
                        <img src="../System/Images/map-saturation.png" />
                        <img src="../System/Images/map-saturation-overlay.png" />
                        <img src="../System/Images/map-brightness.png" />
                        <img src="../System/Images/map-hue.png" />
                    </div>
                    <script type="text/javascript">
                        Event.observe(window, 'load', function () {
                            var sHex = '<% = Request.QueryString("HEX") %>';
                            cp1 = new Refresh.Web.ColorPicker('cp1', { startHex: '' + sHex + '', startMode: 's' });
                        });
                    </script>
                </asp:Panel>
            </td>
            <td valign="top" style="border: 1px solid #F0F0F0; margin: auto; padding: inherit;">
                <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25"
                    border="0">
                    <tr>
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                        </td>
                        <td>
                            <asp:Label ID="lblColorProperties" runat="server" CssClass="fontHead">Color Properties</asp:Label>
                        </td>
                        <td valign="top">
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <table cellspacing="1" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td class="fontHead">
                            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                            <asp:DataGrid ID="DataGrid1" runat="server" EnableViewState="False" DataKeyField="ColorPaletteID">
                                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                                <PagerStyle Visible="False"></PagerStyle>
                            </asp:DataGrid>
                        </td>
                    </tr>
                </table>
                <br>
            </td>
        </tr>
    </table>
     <script type="text/javascript" >
        function navigate(obj) {
             var minRow = 3;
             var maxRow = obj.parentNode.parentNode.parentNode.rows.length + 1;

             var dataGridId = obj.id.split("_")[0];
             var rowId = obj.id.split("_")[1];
             var objId = obj.id.split("_")[2]

             var rowCount = rowId.slice(-2);
             var rowName = rowId.split(rowCount)[0];

             rowCount *= 1;

             var objects = [];
             var inputs = document.getElementById(dataGridId).getElementsByTagName("input");
             
             for (var i = 0; i < inputs.length; i++) {
                 if (inputs[i].id.indexOf([dataGridId, rowId, "txt"].join("_")) == 0) {
                     objects.push(inputs[i].id.split("_")[2]);
                 }
             }

             var objCount = 0;
             for (var i = 0; i < objects.length; i++) {
                 if (objects[i] === objId) {
                     objCount = i;
                     break;
                 }
             }

             //down
             if (event.keyCode == 40) {
                 rowCount = (rowCount + 1 > maxRow) ? minRow : rowCount + 1;
             }
             //up
             else if (event.keyCode == 38) {
                 rowCount = (rowCount - 1 < minRow) ? maxRow : rowCount - 1;
             }
             //right
             else if (event.keyCode == 39) {
                 objCount = (objCount + 1 >= objects.length) ? 0 : objCount + 1;
             }
             //left
             else if (event.keyCode == 37) {
                 objCount = (objCount - 1 >= 0) ? objCount - 1 : objects.length - 1;
             }

             rowCount = (rowCount < 10) ? "0" + rowCount : rowCount
             rowId = rowName + rowCount;

             objId = objects[objCount];

             var targetObj = [dataGridId, rowId, objId].join("_");
             document.getElementById(targetObj).focus();
         }
     
                function btnClose_Click() {
                    <%= strExitScript %>
                    return false;
                }
     
     </script>
    </form>

     <script type="text/javascript">
         try {
             for (var i = 0, len = Page_Validators.length; i < len; i++) {
                 Page_Validators[i].display = "Dynamic";
                 Page_Validators[i].style.visibility = "visible";
             }

             Page_ClientValidate();

             Page_BlockSubmit = false;
             }
            catch (e) {};
     </script>

</body>
</html>
