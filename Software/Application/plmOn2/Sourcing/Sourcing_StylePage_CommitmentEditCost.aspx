<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_CommitmentEditCost.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_CommitmentEditCost" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%--<%@ Register TagPrefix="uc1" TagName="Sourcing_Style_Header" Src="Sourcing_Style_Header.ascx" %>--%>
<%@ Register TagPrefix="uc2" TagName="CommitmentEdit_CommentsAttachments" Src="Sourcing_StylePage_CommitmentEdit_CommentsAttachments.ascx" %>
<%--<%@ Register TagPrefix="uc1" TagName="Sourcing_Partner_Header" Src="Sourcing_Partner_Header.ascx" %>--%>
<%@ Register TagPrefix="uc1" TagName="Sourcing_WorkflowStatus_Commitment" Src="~/Sourcing/Sourcing_WorkflowStatus_Commitment.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title runat="server" id="pgTitle">Quotation View</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="Form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
        </StyleSheets>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadStyleSheetManager>
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />
    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc1:ConfirmedImageButton ID="btnCommit" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <%--<cc1:ConfirmedImageButton ID="btnShare" runat="server" Message="NONE" Visible="false"></cc1:ConfirmedImageButton>--%>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:confirmedimagebutton id="btnDrop" runat="server" Message="NONE" Visible="false"></cc1:confirmedimagebutton>  
                <cc1:confirmedimagebutton id="btnEdit" runat="server" Message="NONE" Visible="false"></cc1:confirmedimagebutton>  
                <cc1:BWImageButton ID="btnGoToStyle" runat="server"></cc1:BWImageButton>                
                <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;">
                </cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="window.parent.close();"></cc1:ConfirmedImageButton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" height="25">
                <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Large" ForeColor="#E0E0E0"></asp:Label>
            </td>
        </tr>
    </table>
    <uc1:Sourcing_WorkflowStatus_Commitment ID="Sourcing_WorkflowStatus_Commitment1" runat="server" />
    <asp:Panel ID="hideBOMs" runat="server">
        <asp:Panel ID="pnlBOMOptions" runat="server">
            <table class="TableHeader CollapsibleHeader" height="30" cellspacing="0" cellpadding="0" width="100%"
                border="0">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="middle" align="center" width="10">
                                    <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                                </td>
                                <td width="20">
                                    <asp:ImageButton ID="imgBtnToggleOption" OnClientClick="return toggleSectionVisibility(this);" runat="server"
                                        ImageUrl="../System/Icons/icon_Down.gif"></asp:ImageButton>
                                </td>
                                <td valign="middle" align="center" style="padding: 0 10px;">
                                    <asp:Label ID="lblBOMOptions" runat="server" Text="Cost by Quantuty Options"></asp:Label>
                                </td>
                                <td>
                                    <asp:ImageButton ID="btnOptionAdd" runat="server" Visible="false" />
                                    <asp:ImageButton ID="btnOptionSave" runat="server" Visible="false" />
                                </td>
                                <td valign="middle" style="padding: 0 10px;">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div id="divBOMOptionContent" class="Collapsible">
                <asp:Panel ID="CostDetail" runat="server">
                    <cc3:YSTabView ID="YSTabView2" runat="server" />
                    <asp:PlaceHolder ID="plhOptionEdit" runat="server"></asp:PlaceHolder>
                     <div style="max-height:274px;  overflow-y:auto; overflow-x:hidden; float:left">
                    <asp:DataGrid ID="DataGrid3" runat="server" DataKeyField="SourcingCommitmentCostOptionDetailID" AllowSorting="False"
                        BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="False">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                    <asp:PlaceHolder ID="PlaceHolderSummary" runat="server"></asp:PlaceHolder>
                    </div>
                </asp:Panel>
            </div>
        </asp:Panel>
    </asp:Panel>
    <br />
    <br />
    <uc2:CommitmentEdit_CommentsAttachments ID="CommitmentEdit_CommentsAttachments" runat="server"></uc2:CommitmentEdit_CommentsAttachments>
    <table class="TableHeader CollapsibleHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="20">
                <asp:ImageButton ID="imgBtnToggleDimDetail" OnClientClick="return toggleSectionVisibility(this);" runat="server"
                    ImageUrl="../System/Icons/icon_Down.gif"></asp:ImageButton>
                <input type="hidden" id="hdnIsExpanded" value="false" />
            </td>
            <td width="280">
                <table cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <asp:Label ID="lblQuotationDetails" runat="server"><%= GetSystemText("Dimensional Detail") %></asp:Label>
                            &nbsp;&nbsp;
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top" width="220">
                <table cellspacing="0" cellpadding="0" id="flash1" runat="server">
                    <tr>
                        <td>
                            <asp:Label ID="lblQNT" runat="server"><%= GetSystemText("Quantity") %></asp:Label>:&nbsp;&nbsp;
                        </td>
                        <td>
                            <asp:TextBox ID="txtQNT" runat="server" Width="40"></asp:TextBox>&nbsp;&nbsp;
                        </td>
                        <td>
                            <asp:RegularExpressionValidator ID="QNTvalid" ControlToValidate="txtQNT" runat="server" Display="Dynamic"
                                Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>" EnableClientScript="True"
                                ValidationExpression="[0-9]*"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <cc1:ConfirmedImageButton ID="btnQNT" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top">
                <table cellspacing="0" cellpadding="0" id="flash2" runat="server">
                    <tr>
                        <td>
                            <asp:Label ID="lblCost" runat="server"><%= GetSystemText("Cost") %></asp:Label>:&nbsp;&nbsp;
                        </td>
                        <td>
                            <asp:TextBox ID="txtCost" runat="server" Width="40"></asp:TextBox>&nbsp;&nbsp;
                        </td>
                        <td>
                            <cc1:ConfirmedImageButton ID="btnCost" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:DataGrid ID="DataGrid2" runat="server" DataKeyField="SourcingCommitmentBOMDetailsID" AllowSorting="False"
        BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="False" CssClass="Collapsible">
        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
    </asp:DataGrid>
    <telerik:RadScriptBlock runat="server" ID="scriptblock">
        <script type="text/javascript">
            $(document).ready(function () {
                
                $("#CostDetail input").each(function () {
                    $(this).attr('disabled', 'disabled');
                });
                $("#CostDetail select").each(function () {
                    $(this).attr('disabled', 'disabled');
                });

                $("#CostDetail td.TableCellYellow a").each(function () {
                    $(this).hide();
                });

                if ($('#DetailOpened').val() != 'open') {
                    $('#imgBtnToggleDimDetail').click();
                }
                $('#DetailOpened').val('');

                //rowspan for summary tab

                if ($("#isSummary").val() == "1") {
                    var i = 0
                    var count = 0;
                    var options = parseInt($("#optionCount").val());

                    var width1 = $("#DataGrid3 tbody tr:first td:nth-child(1)").css("width");
                    var width2 = $("#DataGrid3 tbody tr:first td:nth-child(2)").css("width");
                    var width3 = $("#DataGrid3 tbody tr:first td:nth-child(3)").css("width");

                    $("#DataGrid3 tbody tr:not(.TableHeader)").each(function () {

                        if (i == 0) {
                            count++;
                            $(this).find("td:nth-child(1)").attr("rowspan", $("#optionCount").val());
                            $(this).find("td:nth-child(2)").attr("rowspan", $("#optionCount").val());
                            $(this).find("td:nth-child(3)").attr("rowspan", $("#optionCount").val());

                            // $(this).find("td:nth-child(2)").html("");
                            // $(this).find("td:nth-child(3)").html("");

                            if (count % 2 == 0) {
                                $(this).find("td:nth-child(1)").css("background-color", "aliceblue");  // Alternating item style
                                $(this).find("td:nth-child(2)").css("background-color", "aliceblue");  // Alternating item style
                                $(this).find("td:nth-child(3)").css("background-color", "aliceblue");  // Alternating item style
                            } else {
                                $(this).find("td:nth-child(1)").css("background-color", "white");  // Item style
                                $(this).find("td:nth-child(2)").css("background-color", "white");  // Item style
                                $(this).find("td:nth-child(3)").css("background-color", "white");  // Item style
                            }

                        } else {
                            $(this).find("td:nth-child(1)").remove("");
                            $(this).find("td:nth-child(1)").remove("");
                            $(this).find("td:nth-child(1)").remove("");
                        }
                        i++;
                        if (i == options) {
                            i = 0;
                        }

                    });

                    $("#DataGrid3 tbody tr:first td:nth-child(1)").css("width", width1);
                    $("#DataGrid3 tbody tr:first td:nth-child(2)").css("width", width2);
                    $("#DataGrid3 tbody tr:first td:nth-child(3)").css("width", width3);



                    $("#DataGrid3 tbody tr:not(.TableHeader):first td:nth-child(1)").attr("colspan", "3");
                    $("#DataGrid3 tbody tr:not(.TableHeader):first td:nth-child(1)").css("text-align", "center");
                    $("#DataGrid3 tbody tr:not(.TableHeader):first td:nth-child(2)").remove();
                    $("#DataGrid3 tbody tr:not(.TableHeader):first td:nth-child(2)").remove();

                    //repaintRows($("#DataGrid3").get(0));
                }

            });



            $(window).bind('beforeunload', function () { parent.menu.hideImage(); });
        </script>
    </telerik:RadScriptBlock>
    <asp:HiddenField ID="isSummary" runat="server" />
    <asp:HiddenField ID="DetailOpened" runat="server" />
    <asp:HiddenField ID="optionCount" runat="server" />
    </form>
</body>
<script language="javascript" type="text/javascript">
		    var frm = document.forms['form1'];
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
		                e.checked = actVar;
		        }
		    }
		    // Sets all the checkboxes of current dimension the same value as in 'Select All' checkbox
		    function SelectAllDimension(sender, dimensionTableId) {
		        var setChecked = sender.checked;
		        $("#" + dimensionTableId + " :input[id*='chbDim']").each(function () {
		            this.checked = setChecked;
		        });
		    }
		    /* Checking, if the 'Select All' checkbox should be selected */
		    function SetSelectAll(sender) {
		        // Getting the current dimension number
		        var indexOfDimNo = $(sender).attr('id').indexOf('chbDim') + 6;
		        var dimNo = $(sender).attr('id').substring(indexOfDimNo, indexOfDimNo + 1);
		        // Getting the 'select all' checkbox for current dimension
		        var selectAllCheckbox = $(":input[id='chbSelectAllDim" + dimNo.toString() + "']");
		        // Getting all the checkboxes and verifying, if they all are checked
		        var isAllSelected = true;
		        if (sender.checked) {
		            var dimCheckboxes = $("#DataGridDim" + dimNo.toString() + " :input[id*='chbDim']");
		            for (var i = 0, currentCheckbox; currentCheckbox = dimCheckboxes[i]; i++) {
		                if (!currentCheckbox.checked) {
		                    isAllSelected = false;
		                    break;
		                }
		            }
		        } else {
		            isAllSelected = false;
		        }
		        // Setting the 'Select All' value
		        selectAllCheckbox.get(0).checked = isAllSelected;
		    }

		    function toggleSectionVisibility(sender) {
		        var collapsibleDiv = $(sender).closest(".CollapsibleHeader").nextAll(".Collapsible")[0];
		        var hdnCollapsibleStatus = $(sender).siblings("input[id*='hdnIsExpanded']");

		        if (collapsibleDiv != null) {
                    // Saving status of collapsed section to hidden field
		            if ($(collapsibleDiv).is(":visible")) {
		                $(collapsibleDiv).hide();
		                sender.src = '../System/Icons/icon_Next.gif'
		                if ($(hdnCollapsibleStatus)[0] != null) {
		                    hdnCollapsibleStatus.val("false");
		                }
		            } else {
		                $(collapsibleDiv).show();
		                sender.src = '../System/Icons/icon_Down.gif'
		                if ($(hdnCollapsibleStatus)[0] != null) {
		                    hdnCollapsibleStatus.val("true");
		                }
		            }
		        }

		        return false;
		    }

            function toggleQuotationDetailVisibility(sender) {
                var trQuotationDetail = $("#trQuotationDetail");
                var trAdditionalCost = $("#trAdditionalCost");

		        if (trQuotationDetail.get(0) != null && trAdditionalCost.get(0) != null) {
		            if ($(trQuotationDetail).is(":visible")) {
		                $(trQuotationDetail).hide();
                        $(trAdditionalCost).hide();
		                sender.src = '../System/Icons/icon_Next.gif'
		            } else {
		                $(trQuotationDetail).show();
                        $(trAdditionalCost).show();
		                sender.src = '../System/Icons/icon_Down.gif'
		            }
		        }

		        return false;

		    }

            // For toggling the expandable items to state, in which they were before postback
		    $("input[id*='hdnIsExpanded']").each(function () {
		        var collapsibleDiv = $(this).closest(".CollapsibleHeader").nextAll(".Collapsible")[0];
		        var btnToggle = $(this).siblings("input[id*='BtnToggle']");
		        if (collapsibleDiv != null && $(btnToggle)[0] != null) {
		            if (($(this).val() == 'false' && $(collapsibleDiv).is(":visible")) ||
                        ($(this).val() == 'true' && !$(collapsibleDiv).is(":visible"))
                        ) {
		                btnToggle.click();
		            }
		        }
		    });
            
</script>
</html>
