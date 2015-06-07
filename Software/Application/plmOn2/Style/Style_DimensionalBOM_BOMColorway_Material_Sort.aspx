<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DimensionalBOM_BOMColorway_Material_Sort.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_BOMColorway_Material_Sort" %>
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
            #dtlMaterials .ui-sortable-helper {
            	background-color: #fff;
            	box-shadow: 2px 2px 5px #000;
            }
        </style>
        <script type="text/javascript">
            function sortRows2(txtSort) {
                var draggingRow = $(txtSort).closest('span');
                var hdnOldSort = draggingRow.find("input[id$='hdnSort']");
                var strNewSort = $(txtSort).val();
                var strOldSort = hdnOldSort.val();

                if (parseInt(strNewSort, 10) == parseInt(strOldSort, 10)) {
                    $(txtSort).val(strOldSort);
                    return;
                }
                var newSort = parseInt(strNewSort, 10);
                var currentTable = $('#dtlMaterials')
                if (isNaN(newSort)) {
                    newSort = 0;
                };
                var currentTable = $(txtSort).closest('#dtlMaterials');
                var wasInserted = false;

                var lastRowVal = parseInt(currentTable.find('span.BOMColorChip:last').find("input[id$='hdnSort']").val(), 10);
                var lastRow = currentTable.find('span.BOMColorChip:last');

                if (newSort == lastRowVal && draggingRow.html() != lastRow.html()) {
                    draggingRow.insertAfter(currentTable.find('span.BOMColorChip:last')); // And inserting our row before it
                    wasInserted = true;

                }
                if (newSort > lastRowVal && draggingRow.html() != lastRow.html()) {
                    draggingRow.insertAfter(currentTable.find('span.BOMColorChip:last')); // And inserting our row before it
                    wasInserted = true;
                }
                $('span.BOMColorChip').each(function () {
                    if (!wasInserted) {
                        var txtCurrentSort = $(this).find("input[id$='tbSortNo']");
                        var currentSort = parseInt($(txtCurrentSort).val(), 10);
                        if (isNaN(currentSort)) {
                            currentSort = 0;
                        }

                        if (currentSort == newSort && newSort == parseInt($(this).find("input[id$='hdnSort']").val(), 10)) {
                            if (newSort > parseInt(strOldSort, 10)) {
                                draggingRow.insertAfter($(this));
                            }

                            if (newSort < parseInt(strOldSort, 10)) {
                                draggingRow.insertBefore($(this));
                            }
                            wasInserted = true;

                        }

                        if (currentSort > newSort) {
                            draggingRow.insertBefore($(this)); // And inserting our row before it
                            wasInserted = true;

                        }
                    }

                })
                recalculateSorts()
            }
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
                var sortNo = $("input[id$='tbSortNo']");
                for (var i = 0; i < sortNo.length; i++) {
                    if (i > 9) {
                        sortNo[i].value = '00' + i.toString();
                    } else {
                        sortNo[i].value = '000' + i.toString();
                    }
                    
                }
            }

            $(function () {
                recalculateSorts()
                $('#dtlMaterials').sortable({
                    tolerance: 'pointer',
                    iframeFix: true,
                    cursorAt: { top: 80 },
                    refreshPositions: true,
                    update: function () { recalculateSorts(); },
                    start: function (e, ui) {
                        ui.placeholder.css('visibility', 'visible')
                            .height($.support.cssFloat ? ui.item.height() : ui.item.outerHeight());
                    }
                });
            });
            function changeSortNo(item) {
                if (isNumeric(item.value)) {
                    var hdnSortId = item.id.replace('tbSortNo', 'hdnSort');
                    var hdn = document.getElementById(hdnSortId);
                    hdn.value = item.value;
                    var items = $("input[id$='hdnSort']");
                    var length = items.length;
                    for (var i = 0; i < length; i++) {
                        if (hdn.value == items[i].value) {
                            
                        }
                    }
                } else {
                    var hdnSortId = item.id.replace('tbSortNo', 'hdnSort');
                    var hdn = document.getElementById(hdnSortId);
                    item.value = hdn.value;
                    if (item.value > 9) {
                        item.value = "00" + item.value;
                    } else {
                    item.value = "000" + item.value;
                    }
                }
            }
            function isNumeric(n) {
                  return !isNaN(parseFloat(n)) && isFinite(n);
              }
        </script>
	</head>
	<body style="background-color: #ffffff;">
		<form id="Form1" method="post" runat="server">
			
            <div style="margin-top: 10px; margin-left: 10px; border-bottom: 1px solid gainsboro; padding-bottom: 15px; font-size: 15px;">
                <asp:Label ID="lblDescription" runat="server"></asp:Label> 
            </div>
            <br />
            <div id="divStyleColors" style="overflow: auto; height: 430px; border-bottom: 1px solid gainsboro;">
			    <asp:DataList ID="dtlMaterials" runat="server" DataKeyField="StyleMaterialID" RepeatDirection="Horizontal" RepeatLayout="Flow">
                <ItemStyle BorderWidth="1" BorderStyle="Solid" BorderColor="Gainsboro" CssClass="draggable droppable BOMColorChip" />
                    <ItemTemplate>
                        <table style="height: 60px;">
                            <tr>
                                <td style="height: 50px; width: 50px; vertical-align: top; text-align: left;">
                                    <asp:Image ID="imgMaterial" runat="server" />
                                    <asp:HiddenField ID="hdnSort" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="lblMaterialNo" runat="server" Width="120" CssClass="font" /><br />
                                    <asp:Label ID="lblMaterialName" runat="server" Width="120" CssClass="font" /><br />
                                    <asp:TextBox ID="tbSortNo" runat="server" width="35" onchange="javascript:sortRows2(this);" ></asp:TextBox>
                                </td>
                            </tr>
                        </table>
				    </ItemTemplate>
                </asp:DataList>
			</div>
            <div style="width: 100%; text-align: right;">
                    <asp:Button id="btnSave" runat="server" confirmationmessage="NONE"/>
                    <asp:Button ID="btnCancel" runat="server" OnClientClick="return refreshAndCloseWindow();"/>
            </div>
        </form>

        <script type="text/javascript">
            $("#btnSave, #btnCancel").button().css("color", "#000000");
        </script>
	</body>
</html>
