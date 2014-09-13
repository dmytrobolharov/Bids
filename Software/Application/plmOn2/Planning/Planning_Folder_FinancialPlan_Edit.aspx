<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
    <%@ Register Src="../System/Control/WaitControl.ascx" TagName="Color_Wait" TagPrefix="wc1" %>
        <%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_FinancialPlan_Edit.aspx.vb" Inherits="plmOnApp.Planning_Folder_FinancialPlan_Edit" %>
            <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
                <html>
                    <head id="Head1" runat="server">
                        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
                        <title>Line Planning Values</title>
                        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
                        <link href="../System/CSS/jquery-ui-1.10.3.css" rel="stylesheet" type="text/css" />
                        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
                        <script type="text/javascript" src="../System/Jscript/Custom.js"></script>
                        <style type="text/css">
                        #divListPlanningDivisions .PlanningValuesGrid {
                            margin-bottom: 10px;
                            border: none;
                            }

                        #divListPlanningDivisions .PlanningValuesGrid td {
                            /*border: 1px solid #bbb;*/
                            }

                        #divListPlanningDivisions .PlanningValuesGrid input {
                            color: #0000ff;
                            background-color: #FFFACD;
                            display: inline-block;
                            }

                        #divListPlanningDivisions .PlanningValuesGrid input, .numeric {
                            text-align: right;
                            }

                        #divListPlanningDivisions .names {
                            padding: 2px;
                            vertical-align: top;
                            }

                        #divListPlanningDivisions .names img {
                            display: inline-block;
                            }

                        .rgHeader .font, .rgHeader .fontRed {
                            font-weight: bold;
                            }

                        th.rgHeaderYPLME, th.rgHeader {
                            padding: 0 1px !important;
                            font-weight: bold !important;
                            }

                        .TableFooter td {
                            background-image: url(../System/Images/table_header.gif) !important;
                            background-repeat: repeat-x;
                            font-weight: bold;
                            }

                        .rgMasterTable {
                            border-collapse: collapse !important;
                            }

                        .sub-category-menu {
                            float: right;
                            }

                        .fontRed {
                            color: Red !important;
                            }
                            
                         #fixed_icons {
                            padding-bottom: 80px;
                            }
                            
                         .RadGrid_YPLM .rgHeader td, #FinancialPlanGrid .rgFooter td {
                         	border-color: #ccc;
                         }
                         
                         #FinancialPlanGrid .rgFooter td {
                         	padding: 2px;
                         }
                        </style>
                    </head>
                    <body onload="$('#frameset', window.parent.document).attr('cols', '0,*');">
                        <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
                        <form id="form1" runat="server">
                            <wc1:Color_Wait ID="Color_Wait" runat="server" />
                            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true">
                                <Scripts>
                                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
                                </Scripts>
                                <CdnSettings TelerikCdn="Disabled" />
                            </telerik:RadScriptManager>
                            <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
                                <StyleSheets>
                                    <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                                    <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                                    <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                                    <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
                                </StyleSheets>
                                <CdnSettings TelerikCdn="Disabled" />
                            </telerik:RadStyleSheetManager>
                            <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />
                            <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
                                <Windows>
                                    <telerik:RadWindow ID="ConfigSubCategories" runat="server" Title="Configure Sub categories" Height="300px"
                                    Width="250px" ReloadOnShow="true" ShowContentDuringLoad="false"
                                    NavigateUrl="Planning_Folder_FinancialPlan_SubCategory_Popup.aspx"
                                    Behaviors="Close"
                                    IconUrl="../System/Icons/icon_table.gif"
                                    KeepInScreenBounds="true" Modal="true" />
                                </Windows>
                            </telerik:RadWindowManager>

                            <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                                <tr valign="middle">
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                                    </td>
                                    <td>
                                        <cc1:ConfirmedImageButton ID="btnImport" runat="server" Message="NONE" OnClientClick="return ShowSelectionDialog()"></cc1:ConfirmedImageButton>
                                        <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                                        <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE" OnClientClick="$('#frameset', window.parent.document).attr('cols', '250,*');"></cc1:ConfirmedImageButton>
                                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="$('#frameset', window.parent.document).attr('cols', '250,*');">
                                        </cc1:ConfirmedImageButton>
                                        <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" Visible="false" OnClientClick="javascript:Page_ValidationActive = false;">
                                        </cc1:BWImageButton>
                                    </td>
                                </tr>
                            </table>
                            <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
                            cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                                <tr>
                                    <td>
                                    &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr class="TableHeader">
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                                    </td>
                                    <td width="20">
                                        <img id="imgBtnExp" onclick="return ShowPlanningHeaderContent(this)" style="cursor: pointer;" src="../System/Icons/icon_Next.gif" alt="" />
                                        <img id="imgBtnCol" onclick="return HidePlanningHeaderContent(this)" style="cursor: pointer; display: none;"
                                            src="../System/Icons/icon_Down.gif" alt="" />
                                    </td>
                                    <td class="fontHead">
                                        <asp:Label ID="lblHeaderDetail" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <div id="divHeaderContent" style="display: none;">
                            <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                                <tr>
                                    <td width="900">
                                        <asp:PlaceHolder ID="plhHeaderControlsHolder" runat="server"></asp:PlaceHolder>
                                    </td>
                                    <td>
                                    &nbsp;
                                    </td>
                                </tr>
                            </table>
                            </div>
                            <table>
                                <tr>
                                    <td>
                                        <asp:PlaceHolder runat="server" ID="plhSearchControl"></asp:PlaceHolder>
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                                    </td>
                                </tr>
                            </table>
                            <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" height="30" border="0" runat="server">
                                <tr valign="middle">
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                                    </td>
                                    <td width="300">
                                        <asp:Label ID="lblFinancialEdit" runat="server"></asp:Label>
                                    </td>
                                    <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                                    <td width="125" align="left" nowrap="nowrap" style="padding-left:5px;">
                                        <asp:Label runat="server" ID="lblSeasonYear" class="fontHead" >Compare Season:</asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true"></asp:DropDownList>
                                    </td>
                                </tr>
                            </table>

                            <div id="divListPlanningDivisions">
                                <asp:PlaceHolder runat="server" ID="plhPlanningGrid"></asp:PlaceHolder>
                                <asp:HiddenField ID="hdnHiddenColumns" runat="server" />
                                <asp:ListView ID="lstPlanningDivisions" runat="server" DataKeyNames="PlanningDivisionID">
                                    <ItemTemplate>
                                        <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr class="TableHeader">
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                                                </td>
                                                <td width="20">
                                                    <img id="imgBtnExp" onclick="return ShowGridContent(this)" style="cursor: pointer; display:none;" src="../System/Icons/icon_Next.gif" alt="" />
                                                    <img id="imgBtnCol" onclick="return HideGridContent(this)" style="cursor: pointer" src="../System/Icons/icon_Down.gif" alt="" />
                                                </td>
                                                <td class="fontHead">
                                                    <asp:Label ID="lblHeaderDetail" runat="server" Text='<%# Eval("PlanningDivision") %>'></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:DataGrid ID="dgPlanningValues" CssClass="PlanningValuesGrid" runat="server" AllowSorting="True" DataKeyField="PlanningStyleCategoryID" AutoGenerateColumns="false" OnItemDataBound="dgPlanningValues_DataBound">
                                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                                            <PagerStyle Visible="False"></PagerStyle>
                                            <Columns>
                                                <asp:TemplateColumn ItemStyle-Width="125">
                                                    <ItemStyle CssClass="names" />
                                                    <ItemTemplate>
                                                        <div style="width:125px;">
                                                            <img runat="server" id="imgToggler" onclick='<%# String.Format("toggleRows(this, &#39;{0}&#39;)", Eval("PlanningStyleTypeID").ToString)%>'
                                                            style="cursor: pointer" src="../System/Icons/icon_Down.gif" alt="" />
                                                            <asp:Label runat="server" ID="lblName" CssClass="font" Text='<%# Eval("Name") %>'></asp:Label>
                                                            <asp:HiddenField runat="server" ID="hdnPlanningDivisionID" Value='<%# Eval("PlanningDivisionID") %>' />
                                                            <asp:HiddenField runat="server" ID="hdnPlanningStyleTypeID" Value='<%# Eval("PlanningStyleTypeID") %>' />
                                                            <asp:HiddenField runat="server" ID="hdnPlanningStyleCategoryID" Value='<%# Eval("PlanningStyleCategoryID") %>' />
                                                            <asp:HiddenField runat="server" ID="hdnPlanningSubCategoryID" Value='<%# Eval("PlanningSubCategoryID") %>' />
                                                            <asp:HiddenField runat="server" ID="hdnRowName" Value='<%# Convert.ToString(Eval("PlanningDivision")) & "/" & Convert.ToString(Eval("PlanningStyleTypeDescription")) & "/" & Convert.ToString(Eval("PlanningStyleCategory")) %>'/>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                            <Columns>
                                                <asp:TemplateColumn ItemStyle-Width="100">
                                                    <ItemStyle VerticalAlign="Middle"/>
                                                    <ItemTemplate>
                                                        <div style="width:100px;">
                                                            <asp:Label ID="lblSubCategory" runat="server" Text='<%# Eval("PlanningSubCategory") %>' style="padding:3px; float:left;"></asp:Label>
                                                            <asp:ImageButton runat="server" id="btnSubCategoryMenu" Width="25" style="cursor: pointer; float:right;" alt=""  />
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
                                    </ItemTemplate>
                                </asp:ListView>
                            </div>

                            <div id="dialog" style="display: none;">
                                <asp:RadioButtonList runat="server" ID="rblSeasonYears" DataTextField="SeasonYear" DataValueField="SeasonYearID">
                                </asp:RadioButtonList>
                            </div>
                            <script type="text/javascript" src="../System/Jscript/jquery-1.8.0.js"></script>
                            <script type="text/javascript" src="../System/Jscript/underscore-min.js"></script>
                            <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
                            <script type="text/javascript" src="../System/Jscript/jquery.format-1.3.min.js"></script>
                            <script type="text/javascript">

                            (function ($) {

                                window.ShowSelectionDialog = function () {
                                    $("#dialog").dialog({
                                        modal: true,
                                        resizable: false,
                                        draggable: false,
                                        appendTo: "#form1",
                                        title: '<%= GetSystemText("Import values...") %>',
                                        buttons: {
                                            '<%= GetSystemText("Yes") %>': function() { <%= Page.ClientScript.GetPostBackEventReference(btnImport, "", False) %>; },
                            '<%= GetSystemText("No") %>': function () { $(this).dialog("close"); }
                }
            });

            return false;
        };

    })(jQuery)
    </script>
            
    </form>
    <script type="text/javascript">
        try {

            function ShowGridContent(obj) {
                obj.style.display = 'none';
                $(obj).siblings().show()
                $(obj).closest('table').next().show();
                return false;
            }

            function HideGridContent(obj) {
                obj.style.display = 'none';
                $(obj).siblings().show()
                $(obj).closest('table').next().hide();
                return false;
            }
        } catch (e) { }


        //$(".PlanningValuesGrid tr:first-child td:first-child").css({ border: 'none', visibility: 'hidden' });
        //$(".PlanningValuesGrid tr:first-child td:nth-child(1)").css({ border: 'none', visibility: 'hidden' });
        //$(".PlanningValuesGrid tr:first-child td:nth-child(2)").css({ border: 'none', visibility: 'hidden' });

        function toggleRows(img, style_category) {
            if ($(img).closest("tr").nextUntil(".TableHeader").toggle().is(":visible")) {
                img.src = "../System/Icons/icon_Down.gif";
            } else {
                img.src = "../System/Icons/icon_Next.gif";
            }
        }

        var CurrencyDecimalSymbol = "<%= GetFormatInfo.CurrencyDecimalSymbol %>";
        var CurrencyDigitGroupingSymbol = "<%= GetFormatInfo.CurrencyDigitGroupingSymbol %>";

        var $findCached = _.memoize($find);
        var $closestCached = _.memoize(function (elem, sel) {
            return elem.closest(sel);
        }, function (elem, sel) {
            return elem[0].id + sel
        });

        var getData = _.memoize(function (elem) {
            var row = $closestCached(elem, "tr");
            if (typeof row[0] !== typeof undefined && row[0] !== false) {
                var dataItem = $findCached(row[0].id);

                return {
                    DivisionID: dataItem.getDataKeyValue('PlanningDivisionID'), //row.find("input[id$=hdnPlanningDivisionID]").val(),
                    StyleTypeID: dataItem.getDataKeyValue('PlanningStyleTypeID'), //row.find("input[id$=hdnPlanningStyleTypeID]").val(),
                    StyleCategoryID: dataItem.getDataKeyValue('PlanningStyleCategoryID'), //row.find("input[id$=hdnPlanningStyleCategoryID]").val(),
                    FinancialID: elem[0].id.slice(-36)
                }
            };
        }, function (elem) { return elem[0].id });

        var itemInfoHashFunction = function (info) {
            return info.DivisionID + info.StyleTypeID + info.StyleCategoryID + info.FinancialID;
        };

        var financialBoxesCache = {}; // is filled upon loading
        var getBoxesByFinancialID = _.memoize(function (financialID) {
            return $(financialBoxesCache[financialID]); //$("#FinancialPlanGrid_GridData").find(":text[id$='" + financialID + "']");
        });

        var findBoxes = _.memoize(function (info) {
            return getBoxesByFinancialID(info["FinancialID"]).filter(function () {
                var elemInfo = getData($(this));
                return elemInfo.DivisionID != "" && elemInfo.StyleTypeID != "" && elemInfo.StyleCategoryID != "";
            });
        }, itemInfoHashFunction);

        var $header = $(".PlanningValuesGrid .sum-header");
        var findTotal = _.memoize(function (info) {
            return $header.find(":text[id$='txt" + info["FinancialID"] + "']");
        }, function (info) { return info["FinancialID"]; });

        function recalculatePercent(total) {
            return function () {
                // check totalValue for 0 so we don't get infinity
                this.value = percentFormat(getFloatValue(total.value) != 0 ? (getFloatValue($(this).siblings(":text").val()) / getFloatValue(total.value)) * 100 : 0);
            }
        }

        function recalculateValue(total) {
            return function () {
                var info = getData($(this));
                var resultValue = (getFloatValue($(this).siblings(":text").val()) / 100) * getFloatValue(total.value);
                this.value = isNaN(resultValue) ? 0 : formatValue(resultValue, info);
            }
        }

        function formatValue(value, info) {
            var format = FinancialData[info["FinancialID"]]["PlanningFinancialDataFormat"].toString();
            return $.format.number(value, format);
        }

        function percentFormat(val) {
            var value = getFloatValue(val).toFixed(4),
                        fixedFactor = /\.0000$/.test(value) ? 0 : 4; // do not show trailing zeros after decimal point

            return getFloatValue(val).toFixed(fixedFactor) + " %";
        }

        function getFloatValue(value) {
            var result = 0;
            if (typeof value !== typeof undefined && value !== false) {
                result = parseFloat(value.toString().split(CurrencyDecimalSymbol).join(".").split(CurrencyDigitGroupingSymbol).join(""))
            }
            return (isNaN(result) ? 0 : result);
        }

        function getSum(boxes) {
            var total = 0;
            boxes.each(function () { total += getFloatValue(this.value); })

            return total;
        }
        function checkIfvalueIsInt(value) {
            var er = /^-?[0-9]+$/;
            return er.test(value);
        }
        var recomputeExtended = function ($this) {
            //this function created for recomputation extended fields and gross margin's group of fields
            //get all data for computation
            var $AverageCost = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000006']"),
        $EcomPrice = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000023']"),
        EcomPrice = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000021']").val(),
        $wholeSale = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000007']"),
        wholeSale = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000004']").val(),
        $retailPrice = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000008']"),
        retailPrice = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000005']").val(),
        $extendedCost = $this.parent().closest("tr").find("[id*='lbl10000000-0000-0000-0000-000000000011']"),
        $extendedWholeSale = $this.parent().closest("tr").find("[id*='lbl10000000-0000-0000-0000-000000000009']"),
        $extendedRetail = $this.parent().closest("tr").find("[id*='lbl10000000-0000-0000-0000-000000000010']"),
        $extendedEcom = $this.parent().closest("tr").find("[id*='lbl10000000-0000-0000-0000-000000000025']"),
        $grossProfit = $this.parent().closest("tr").find("[id*='lbl10000000-0000-0000-0000-000000000026']"),
        $wholeSailGrossMargin = $this.parent().closest("tr").find("[id*='lbl10000000-0000-0000-0000-000000000012']"),
        $retailGrossMargin = $this.parent().closest("tr").find("[id*='lbl10000000-0000-0000-0000-000000000013']"),
        $ecomGrossMargin = $this.parent().closest("tr").find("[id*='lbl10000000-0000-0000-0000-000000000027']"),
        $grossMargin = $this.parent().closest("tr").find("[id*='lbl10000000-0000-0000-0000-000000000028']"),
        totalProjectUnit = getFloatValue($this.closest("tr").find("[id*='10000000-0000-0000-0000-000000000022']").html());
            //Update Extended fields with recomputed values
            var extendedCostValue = (totalProjectUnit * getFloatValue($AverageCost.val())).toFixed(2),
        extendedWholeSaleValue = (getFloatValue(wholeSale) * getFloatValue($wholeSale.val())).toFixed(2),
        extendedRetailValue = (getFloatValue(retailPrice) * getFloatValue($retailPrice.val())).toFixed(2),
        extendedEcomValue = (getFloatValue(EcomPrice) * getFloatValue($EcomPrice.val())).toFixed(2);

            //compute Extended cost and recompute associated sum fields
            $extendedCost.text(getCurrencyValues(extendedCostValue));
            recomputeTopAndBottomValue($extendedCost, $extendedCost.parent().index(), 2);

            //compute extended WholeSale and recompute associated sum fields
            $extendedWholeSale.text(getCurrencyValues(extendedWholeSaleValue));
            recomputeTopAndBottomValue($extendedWholeSale, $extendedWholeSale.parent().index(), 2);

            //compute extended Retail and recompute associated sum fields
            $extendedRetail.text(getCurrencyValues(extendedRetailValue));
            recomputeTopAndBottomValue($extendedRetail, $extendedRetail.parent().index(), 2);

            //compute extended Ecom and recompute associated sum fields
            $extendedEcom.text(extendedEcomValue.toFixed(4));
            recomputeTopAndBottomValue($extendedEcom, $extendedEcom.parent().index(), 2);

            //  update gross values
            var grossProfit = ((extendedWholeSaleValue + extendedRetailValue + extendedEcomValue) - extendedCostValue).toFixed(2),
        wholeSaleGrossMargin = ((extendedWholeSaleValue - getFloatValue(wholeSale) * getFloatValue($AverageCost.val())) / extendedWholeSaleValue) * 100,
        retailGrossMargin = ((extendedRetailValue - getFloatValue(retailPrice) * getFloatValue($AverageCost.val())) / extendedRetailValue) * 100,
        ecomGrossMargin = ((extendedEcomValue - getFloatValue(EcomPrice) * getFloatValue($AverageCost.val())) / extendedEcomValue) * 100,
        grossMargin = (grossProfit / (extendedWholeSaleValue + extendedRetailValue + extendedEcomValue)) * 100;

            //compute gross profit and recompute associated sum fields
            $grossProfit.text(grossProfit);
            recomputeTopAndBottomValue($grossProfit, $grossProfit.parent().index(), 2);

            //compute wholesail gross margin and recompute associated sum fields
            $wholeSailGrossMargin.text(recomputePercentage(wholeSaleGrossMargin));
            recomputeTopAndBottomValue($wholeSailGrossMargin, $wholeSailGrossMargin.parent().index(), 4, true);

            //compute retail gross margin and recompute associated sum fields
            $retailGrossMargin.text(recomputePercentage(retailGrossMargin));
            recomputeTopAndBottomValue($retailGrossMargin, $retailGrossMargin.parent().index(), 4, true);

            //compute Ecom gross margin and recompute associated sum fields
            $ecomGrossMargin.text(recomputePercentage(ecomGrossMargin));
            recomputeTopAndBottomValue($ecomGrossMargin, $ecomGrossMargin.parent().index(), 4, true);

            //compute gross margin % and recompute associated sum fields
            $grossMargin.text(recomputePercentage(grossMargin));
            recomputeTopAndBottomValue($grossMargin, $grossMargin.parent().index(), 4, true);
        };
        function recomputePercentage(value) {
            if (!isFinite(value)) {
                return '0%'
            } else {
                return value.toFixed(4) + '%'
            }
        };


        $(".PlanningValuesGrid input").not('.value').change(function () {
            var $this = $(this),
                info = getData($(this)),
                total = 0,
                position = $(this).parent().index();
                    //if user update averageCost||EconPrice||WholeSale||retail fields
            if (this.id.indexOf("10000000-0000-0000-0000-000000000006") != -1
                || this.id.indexOf("10000000-0000-0000-0000-000000000023") != -1
                || this.id.indexOf("txt10000000-0000-0000-0000-000000000007") != -1
                || this.id.indexOf("txt10000000-0000-0000-0000-000000000008") != -1) {
                        recomputeExtended($this);
            }
            //Update header for numeric fields
            var numberOfDigits = checkIfvalueIsInt(this.value) ? 0 : 2;
            recomputeTopAndBottomValue($this, $this.parent().index(), numberOfDigits);
        });
        $(".PlanningValuesGrid input.value").change(function () {
            var $this = $(this),
                info = getData($(this)),
                position = $(this).parent().index();
            if (info["StyleCategoryID"] == "" && info["StyleTypeID"] == "") {
                if ($this.is(".percentbox")) {
                    var total = $this.siblings(":text")[0];
                    total.value = formatValue(getFloatValue(total.value) * getFloatValue(this.value) / 100, info);
                    findBoxes(info).filter(".value:not(.percentbox)").each(recalculateValue(total));
                    this.value = percentFormat(100);
                } else {
                    if ($(this).val() == '') { $(this).val(formatValue(0, info)); }
                    findBoxes(info).filter(".value:not(.percentbox)").each(recalculateValue(this));
                }
            } else if (this.id.indexOf("10000000-0000-0000-0000-000000000020") != -1) {
                if ($this.is(".percentbox")) {
                    var $NoOfStyles = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000000']"),
                        NoOfStyles = getFloatValue($NoOfStyles.val(), getData($NoOfStyles)),
                        $OverDevStyles = $this.siblings(":text");

                    $OverDevStyles.val(formatValue(getFloatValue(this.value) / 100 * NoOfStyles, getData($OverDevStyles)));
                    this.value = percentFormat(getFloatValue(this.value));
                } else {
                    var $NoOfStyles = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000000']"),
                        NoOfStyles = getFloatValue($NoOfStyles.val(), getData($NoOfStyles)),
                        $OverDevStyles = $this.siblings(":text");

                    $OverDevStyles.val(percentFormat(NoOfStyles == 0 ? 0 : getFloatValue(this.value, info) / NoOfStyles * 100));
                }
                recomputeTopAndBottomValue($this, $this.parent().index(), 0, false, true)
            } else if (this.id.indexOf("10000000-0000-0000-0000-000000000000") != -1) {
                //total mess, i know
                //1st check if it's percentbox
                if ($this.is(".percentbox")) {
                    //compute percent values
                    //update all #overDev Styles
                    var $NoOfStyles = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000000']"),
                        NoOfStyles = getFloatValue($NoOfStyles.val(), getData($NoOfStyles)),
                        $OverDevStyles = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000020']"),
                        $OverDevStylesParent = $OverDevStyles.siblings(":text");
                    $OverDevStyles.val(getCurrencyValues(((getFloatValue($OverDevStylesParent.val())) * NoOfStyles) / 100));
                } else {
                    var $NoOfStyles = $this,
                        NoOfStyles = getFloatValue($NoOfStyles.val(), getData($NoOfStyles)),
                        $OverDevStyles = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000020']"),
                        $OverDevStylesParent = $OverDevStyles.siblings(":text");
                    $OverDevStyles.val(getCurrencyValues(((getFloatValue($OverDevStylesParent.val())) * NoOfStyles) / 100));
                    //
                    var total = findTotal(info)[0];
                    total.value = getSum(findBoxes(info).filter(":not(.percentbox)"));
                    findBoxes(info).filter(".percentbox").each(recalculatePercent(total));
                }
                recomputeTopAndBottomValue($this, $this.parent().index());
                recomputeTopAndBottomValue($OverDevStyles, $OverDevStyles.parent().index(), 0, false, false)
            }
            else if ($this.is(".percentbox")) {
                var sum = getSum(findBoxes(info).filter('.percentbox')),
                    total = findTotal(info);

                total.siblings(".percentbox").val(percentFormat(sum));
                recalculateValue(findTotal(info)[0]).call($(this).siblings(":text")[0]);
                this.value = percentFormat(this.value);
                var all = findTotal(info)[0];
                $('#FinancialPlanGrid_GridFooter table tbody tr').find('td').eq($(findTotal(info)[0]).parent().index()).text('Sum: ' + all.value)
            } else {
                try {
                    //if this field we can get with find total function
                    var total = findTotal(info)[0];
                    total.value = getSum(findBoxes(info).filter(":not(.percentbox)"));
                    findBoxes(info).filter(".percentbox").each(recalculatePercent(total));
                    $('#FinancialPlanGrid_GridFooter table tbody tr').find('td').eq($(findTotal(info)[0]).parent().index()).text('Sum: ' + getCurrencyValues(getSum(findBoxes(info).filter(":not(.percentbox)"))))
                }
                catch (err) {
                    //otherwise recompute manually
                    recomputeTopAndBottomValue(this, position, 2)
                }
            }
            if (this.id.indexOf("10000000-0000-0000-0000-000000000004") != -1 || this.id.indexOf("10000000-0000-0000-0000-000000000005") != -1 || this.id.indexOf("10000000-0000-0000-0000-000000000021") != -1) {
                var retailUnits = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000005']").val(),
            ecomUnits = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000021']").val(),
            wholeSale = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000004']").val(),
            $totalProjectUnitsTxt = $this.closest("tr").find("[id*='10000000-0000-0000-0000-000000000022']");
                var totalProjectUnits = getFloatValue(wholeSale) + getFloatValue(ecomUnits) + getFloatValue(retailUnits);

                $totalProjectUnitsTxt.text(getCurrencyValues(totalProjectUnits));
                recomputeTopAndBottomValue($totalProjectUnitsTxt, $totalProjectUnitsTxt.parent().index());
                recomputeExtended($this);
            }
        });

        var recomputeTopAndBottomValue = function (elem, position, digits, isPercent, dontUpdate) {
            var total = 0,
    info = getData($(elem));
            if (!$(elem).is('.percentbox')) {
                //check if this field isn't a text field
                if ($(elem).is('.font')) {
                    //loop all td to get values and get sum of all fields
                    $('#FinancialPlanGrid_GridData table tbody tr').each(function () {
                        total += getFloatValue($(this).find('td').eq(position).find('span').html())
                    });
                    //find header and then find proper column, then update it
                } else {
                    $('#FinancialPlanGrid_GridData table tbody tr').each(function () {
                        total += getFloatValue($(this).find('td').eq(position).find('input').not('.percentbox').val())
                    });
                }
                //find bottom row, then find column and update sum
                if ($(elem).is('input.value')) {
                    $('.rgHeader ').find('td').eq(position).val(getCurrencyValues(total, digits, isPercent));
                } else {
                    $('.rgHeader ').find('td').eq(position).text(getCurrencyValues(total, digits, isPercent));
                }
                if (dontUpdate) {
                    $('.rgHeader ').find('td').eq(position).text(getCurrencyValues(total, digits, isPercent));
                }
                $('#FinancialPlanGrid_GridFooter table tbody tr').find('td').eq(position).text('Sum: ' + getCurrencyValues(total, digits, isPercent))
            } else {
                if (!dontUpdate) {
                    var sum = getSum(findBoxes(info).filter('.percentbox')),
            total = findTotal(info);
                    total.siblings(".percentbox").val(percentFormat(sum));
                    recalculateValue(findTotal(info)[0]).call(elem.siblings(":text")[0]);
                    $(elem)[0].value = percentFormat($(elem)[0].value);
                }
                try {
                    $('#FinancialPlanGrid_GridFooter table tbody tr').find('td').eq(position).text('Sum: ' + findTotal(info)[0].value)

                }
                catch (err) {
                    $('.rgHeader ').find('td').eq(position).text(getCurrencyValues(getSum(findBoxes(info).filter(":not(.percentbox)"))));
                    $('#FinancialPlanGrid_GridFooter table tbody tr').find('td').eq(position).text('Sum: ' + getCurrencyValues(getSum(findBoxes(info).filter(":not(.percentbox)"))))

                }
            }
        };


        var getCurrencyValues = function (i, n, p) {
            // @ i = value what will be transformed to proper value
            // @ n = number of digits after currency symbol
            // @ p = if value is percent - return it as a %
            if (!p) {
                var numberOfDigits = n ? n : 2;
                if (i < 0) {
                    i = i * -1;
                    return '-' + i.toFixed(n).replace(/./g, function (c, i, a) {
                        return i && c !== CurrencyDecimalSymbol && !((a.length - i) % 3) ? CurrencyDigitGroupingSymbol + c : c;
                    });
                } else {
                    return i.toFixed(n).replace(/./g, function (c, i, a) {
                        return i && c !== CurrencyDecimalSymbol && !((a.length - i) % 3) ? CurrencyDigitGroupingSymbol + c : c;
                    });
                }

            } else {
                return percentFormat(i)
            }
        };

        Sys.Application.add_load(function () {
            //console.profile();
            $find('FinancialPlanGrid').get_masterTableView().get_dataItems();
            $("[id*='lblPlanningSubCategory']").css({ 'width': 'auto', 'float': 'left' });
            $("tr.sum-header").appendTo($("#FinancialPlanGrid_GridHeader thead"));
            financialBoxesCache = _.groupBy($("#FinancialPlanGrid_GridData").find("input.value"), function (elem) {
                return elem.id.slice(-36);
            });

            $("#FinancialPlanGrid").find(":text.value").each(function () {
                var $this = $(this),
                    info = getData($this);

                //if (info.DivisionID != "" && info.StyleTypeID != "" && info.StyleCategoryID == "") {
                if (info["StyleCategoryID"] == "" && info["StyleTypeID"] == "") {
                    if ($this.is(".percentbox")) {
                        $this.val(percentFormat(100));
                    } else {
                        findBoxes(info).filter(".percentbox").each(recalculatePercent(this));
                    }
                } else if (this.id.indexOf("10000000-0000-0000-0000-000000000020") != -1) {
                    if ($this.is(".percentbox")) {
                        var $NoOfStyles = $this.closest("tr").find("[id*='txt10000000-0000-0000-0000-000000000000']"),
                            NoOfStyles = getFloatValue($NoOfStyles.val(), getData($NoOfStyles));

                        this.value = percentFormat(NoOfStyles == 0 ? 0 : getFloatValue($this.siblings(":text").val(), info) / NoOfStyles * 100);
                    }
                } else if ($this.is(".percentbox")) {
                    recalculateValue(findTotal(info)[0]).call($this.siblings(":text")[0]);
                    this.value = percentFormat(this.value);
                } else {
                    recalculatePercent(findTotal(info)[0]).call($this.siblings(":text")[0]);
                }
                //}
            });
            function getCaretPosForInput(control, way) {
                var movement;
                if (way == 'left') { movement = -1; } else { movement = 1; }
                if (control.createTextRange) {
                    //if it's IE<9
                    control.caretPos = document.selection.createRange().duplicate();
                    if (control.caretPos.move('character', movement) != '') { return false; } else { return true; }
                } else {
                    //welcome to light side, padawan
                    control.focus();
                    if ((control.selectionStart + movement) <= control.value.length && (control.selectionStart + movement) >= 0) {
                        //            control.setSelectionRange(control.selectionStart+movement, control.selectionStart+movement);
                        return false;
                    } else {
                        return true;
                    }
                }
            }


            $("#FinancialPlanGrid_GridHeader > table").each(function () {
                var id = this.id, $this = $(this);

                $this.on("keydown", ":text", function (e) {
                    //alert('txt');
                    if (e.keyCode == 39) {
                        if (getCaretPosForInput(this, 'right')) $(this).next().focus();

                        return false;
                    } else if (e.keyCode == 37) {
                        if (getCaretPosForInput(this, 'left')) $(this).closest('td').prev().find(':text:eq(1)').focus();
                        return false;

                    } else if (e.keyCode == 13) {

                        $(this).blur();
                        return false;

                    }
                });
            });

            $("#FinancialPlanGrid_GridData > table").each(function () {
                var id = this.id, $this = $(this);

                $this.on("keydown", "tr.rgHeader :text", function (e) {

                    if (e.keyCode == 40 || e.keyCode == 13) {
                        var $tr = $(this).closest('tr');
                        var $td = $(this).closest('td');
                        $tr.next().find('td').eq($td.index()).find(':text').last().focus();

                        return false;
                    }
                    return arrowkeyPressed(this.id, id, e.originalEvent);
                });
                $this.on("keydown", "input[type=text]", function (e) {
                    if ($(this).is('.percentbox')) {
                        if (e.keyCode == 39) {
                            if (getCaretPosForInput(this, 'right')) $(this).next().focus();
                        } else if (e.keyCode == 37) {
                            if (getCaretPosForInput(this, 'left')) {
                                if ($(this).closest('td').prev().find(':text:eq(1)')[0]) {
                                    $(this).closest('td').prev().find(':text:eq(1)').focus()
                                } else {
                                    if ($(this).closest('td').prev().prev().find(':text:eq(1)')[0]) {
                                        $(this).closest('td').prev().prev().find(':text:eq(1)').focus()
                                    } else {
                                        $(this).closest('td').prev().prev().find(':text:eq(0)').focus()
                                    }
                                }
                            };
                        } else if (e.keyCode == 40 || e.keyCode == 13) {
                            var $tr = $(this).closest('tr');
                            var $td = $(this).closest('td');
                            $tr.next().find('td').eq($td.index()).find(':text').first().focus();
                            return false;
                        } else {
                            return arrowkeyPressed(this.id, id, e.originalEvent);
                        }
                    } else {

                        if (e.keyCode == 39) {
                            if (getCaretPosForInput(this, 'right')) {
                                if ($(this).closest('td').next().find(':text:eq(0)')[0]) {
                                    $(this).closest('td').next().find(':text:eq(0)').focus()
                                } else {
                                    $(this).closest('td').next().next().find(':text:eq(0)').focus()
                                };
                            }
                        } else if (e.keyCode == 37) {
                            if (getCaretPosForInput(this, 'left')) {
                                if ($(this).prev()[0]) {
                                    $(this).prev().focus();
                                }
                                else {
                                    $(this).closest('td').prev().find(':text:eq(1)').focus()
                                }
                            }
                        } else if (e.keyCode == 38) {
                            var $tr = $(this).closest('tr');
                            var $td = $(this).closest('td');
                            $tr.prev().find('td').eq($td.index()).find(':text').last().focus();
                        } else if (e.keyCode == 40 || e.keyCode == 13) {
                            var $tr = $(this).closest('tr');
                            var $td = $(this).closest('td');
                            $tr.next().find('td').eq($td.index()).find(':text').last().focus();
                            return false;
                        }
                    }
                });
            });
        });

        $("input[type=text]").focus(function () {
            var elem = $(this);
            setTimeout(function () {
                elem.select(); 
            }, 0);
        })
        ;
        
        /** Resizing Grid to take all the free height on the screen **/
        (function resizeGrid() {

            var changeGrid = $("#FinancialPlanGrid");
            var windowHeight = $(window).height();
            var formHeight = $("#form1").height();
            var minHeight = 100;

            // Calculating, how much free space we have on the window for grid area
            var diff = windowHeight - (formHeight - changeGrid.height());

            if (diff > minHeight) {
                changeGrid.height(diff - 40); // leave space for footer
            } else {
                changeGrid.height(minHeight);
            }
        })();

        function showConfigureSubCategories(strPlanningID, strSeasonYearID, strBrandID, strDivisionID, strStyleTypeID, strStyleCategoryID) {
            window.radopen("Planning_Folder_FinancialPlan_SubCategory_Popup.aspx?PLID=" + strPlanningID + "&SYID=" + strSeasonYearID + "&BID=" + strBrandID + "&DVID=" + strDivisionID + "&STID=" + strStyleTypeID + "&SCID=" + strStyleCategoryID, "ConfigSubCategories");
        }
        $(window).load(function () {
            $(".PlanningValuesGrid input:not(.value)[id*=10000000-0000-0000-0000-000000000006]").change();
        });
  
        function ColumnHidden(sender, eventArgs) {
            var tableColumns = $find("FinancialPlanGrid").get_masterTableView().get_columns();
            var arrHiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    arrHiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = arrHiddenColumns.join();
            PageMethods.SaveHiddenColumns('FinancialPlanGrid', '<%= aspxPageName & "?PLID=" & strPlanningId %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

        function ColumnShown(sender, eventArgs) {
            var tableColumns = $find("FinancialPlanGrid").get_masterTableView().get_columns();
            var arrHiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    arrHiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = arrHiddenColumns.join();
            PageMethods.SaveHiddenColumns('FinancialPlanGrid', '<%= aspxPageName & "?PLID=" & strPlanningId %>', strHiddenColumns, '<%= UserProperties.Username %>');

        }


        
    function ShowPlanningHeaderContent(obj) {
        obj.style.display = 'none';
        document.getElementById('imgBtnCol').style.display = 'block';
        document.getElementById('divHeaderContent').style.display = 'block';
        return false;
    }

    function HidePlanningHeaderContent(obj) {
        obj.style.display = 'none';
        document.getElementById('imgBtnExp').style.display = 'block';
        document.getElementById('divHeaderContent').style.display = 'none';
        return false;
    }


    </script>
                    </body>
                </html>
