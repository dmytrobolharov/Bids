<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_QuotationMain.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_QuotationMain" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server" id="pgTitle">Quotation Palette</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui-1.10.3.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery.tablescroll.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../System/Jscript/System.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="Form1" runat="server" defaultbutton="imgBtnSearch">
     <wc1:Color_Wait ID="Color_Wait" runat="server" />
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
<table id="mainTable" border="0" cellpadding="0" cellspacing="0" width="99.9%">
<tr>
<td style="width:75%;" align="left" valign="top">
      <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc1:confirmedimagebutton id="btnGenerate" runat="server" Message="NONE" OnClientClick="TotalSummValidate();"></cc1:confirmedimagebutton>
                <cc1:ConfirmedImageButton ID="btnShare" runat="server" Message="NONE" CausesValidation="true" OnClientClick="TotalSummValidate(); var y = ShareValidate(); return y;"
                    ValidationGroup="TechPack"></cc1:ConfirmedImageButton>
                <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="if(ConfirmClose()){return btnClose_Click();}else{return false;};"></cc1:confirmedimagebutton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        </table>
        <div id="FloatDG" runat="server" style="z-index:500; width:520px; position: absolute; left:0px; background-color:White;" >
            <div id="FloatDGMain" style="float:left; width:500px; height:100%;">
            		<table id="tLabel" style="background-color:#6699FF;" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
			            <tr>
				            <td class="fontHead" style="color:White; padding-left:10px;">
						            <asp:Label id="lblstyle" runat="server">Style</asp:Label>
				            </td>
			            </tr>
		            </table>
		            <table id="tSearch" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
			            <tr>
				            <td><asp:placeholder id="plhStyleSearch" runat="server" EnableViewState="False"></asp:placeholder></td>
				            <td vAlign="middle" width="100%">
					            <table height="45">
						            <tr>
							            <td><asp:imagebutton id="imgBtnSearch" runat="server" CausesValidation="false"></asp:imagebutton></td>
						            </tr>
					            </table>
				            </td>
			            </tr>
		            </table>
		            <asp:datagrid id="dgStyleList" runat="server" AllowSorting="false" width="100%">
			            <AlternatingItemStyle Height="20px" CssClass="ItemTemplate"></AlternatingItemStyle>
			            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
			            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
			            <PagerStyle Visible="False"></PagerStyle>
		            </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>

            </div>
            <div id="FloatDGControl" style="float:right; width:20px; cursor:pointer; background-color:#6699FF; height:100%;"><span id="SliderHead" runat="server" style="-moz-transform: rotate(90deg); -webkit-transform: rotate(90deg); -o-transform: rotate(90deg); writing-mode: tb-rl; white-space:nowrap; padding: 4px 4px 0px 3px; font-size:12px; font-family:Arial; font-weight:bold; color:White; display:block;"></span></div>
        </div>
        <div id="SamplePalette" style="overflow-y: auto; overflow-x:hidden; padding-left: 20px;">
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top" colspan="2" height="30">
                            <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                                ForeColor="#E0E0E0"></asp:Label>&nbsp;
                        </td>
                        <td valign="top" height="30">
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        </table>
        <asp:PlaceHolder ID="Style_Header" runat="server"></asp:PlaceHolder>        
        <asp:Panel ID="divMain" runat="server">

        <table cellspacing="0" cellpadding="0" width="100%"  border="0">
            <tr>
                <td valign="middle" align="left" width="400px">
                    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr height="25">
                            <td valign="middle" align="center" width="10">
                                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                            </td>
                            <td class="fontHead" align="left" width="100%">
                                <asp:Label id="lblCostDetail" runat="server">Quotation Detail</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" valign="top" width="100%">
                                    <table id="Table2" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td>
                                            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr height="25">
                            <td valign="middle" align="center" width="5px"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                            <td class="fontHead"  align="left" width="100%">
                            <asp:Label id="lblAdditionalCost" runat="server">Additional Cost</asp:Label>
                            </td>
                        </tr>
                        <tr>

                            <td colspan="2" valign="top" width="100%">
                                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td>
                                            
                                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
							                    <tr>
								                    <td>
									                    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
										                    <tr>
											                    <td align="center" width="3"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
											                    <td class="fontHead" width="100"><asp:label id="lblMaterialSizeType" runat="server"></asp:label></td>
											                    <td height="30">
												                    <table id="TbTrim" cellspacing="0" cellpadding="0" width="250" border="0" runat="server">
													                    <tr class="fontHead">
														                    <td>&nbsp;</td>
														                    <td noWrap width="85"><asp:Label ID="lblNoofRow" runat="server" Text="No. of Row(s):"></asp:Label></td>
														                    <td width="35"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
																                    <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
																                    <asp:ListItem Value="2">2</asp:ListItem>
																                    <asp:ListItem Value="3">3</asp:ListItem>
																                    <asp:ListItem Value="4">4</asp:ListItem>
																                    <asp:ListItem Value="5">5</asp:ListItem>
																                    <asp:ListItem Value="10">10</asp:ListItem>
																                    <asp:ListItem Value="15">15</asp:ListItem>
																                    <asp:ListItem Value="20">20</asp:ListItem>
															                    </asp:dropdownlist></td>
														                    <td><cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
													                    </tr>
												                    </table>
												                    </td>
										                    </tr>
									                    </table>
								                    </td>
							                    </tr>
							                    <tr>
								                    <td>
									                    <table id="TD_ImgFolder" cellspacing="1" cellpadding="0" border="0" runat="server">
										                    <tr bgcolor="#ffffff">
											                    <td><cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
											                            
										                    </tr>
									                    </table>
								                    </td>
							                    </tr>
							                    <tr>
								                    <td>
									                    <asp:datagrid id="Datagrid1" runat="server" OnItemDataBound="Datagrid1_ItemEventHandler" DataKeyField="SourcingAdditionalCostID" Width="250" AutoGenerateColumns="False" PageSize="1000"
										                    BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
										                    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
										                    <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
										                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
										                    <FooterStyle></FooterStyle>
										                    <Columns>
											                    <asp:TemplateColumn>
												                    <HeaderTemplate>
													                    <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" NAME="checkAll">
												                    </HeaderTemplate>
												                    <ItemTemplate>
													                    <asp:CheckBox id="chkDelete" runat="server"></asp:CheckBox>
												                    </ItemTemplate>
											                    </asp:TemplateColumn>
											                    <asp:TemplateColumn>
												                    <HeaderTemplate>
													                    <asp:Label id="lblDescription" runat="server"></asp:Label>
												                    </HeaderTemplate>
												                    <ItemTemplate>
													                    <asp:TextBox id="txtDescription" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														                    MaxLength="100" Columns="30"></asp:TextBox>
												                        <asp:HiddenField ID="hdnDescription" runat="server" />
												                    </ItemTemplate>
											                    </asp:TemplateColumn>
											                    <asp:TemplateColumn>
												                    <HeaderTemplate>
													                    <div align="center">
														                    <asp:Label id="lblAmount" runat="server"></asp:Label>													                           
													                    </div>
												                    </HeaderTemplate>
												                    <ItemTemplate>
													                    <asp:TextBox id="txtAmount" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0" maxlength="8" columns="5"></asp:TextBox>
												                        <asp:HiddenField ID="hdnAmount" runat="server" />
												                    </ItemTemplate>
											                    </asp:TemplateColumn>
										                    </Columns>
									                    </asp:datagrid>
								                    </td>
							                    </tr>
						                    </table>


                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
        </table>

        <input id="hidBOMDimensionId" type="hidden" name="hidBOMDimensionId" width="20" runat="server" />
        <asp:Panel ID="pnlDimType" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr >
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100px">
               <asp:Label id="lblBOM" runat="server">BOM Dimensions</asp:Label>&nbsp;&nbsp;
               </td>
               <td >
                <cc1:confirmedimagebutton id="btnFilter" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
            </td>

        </tr>
        </table>
        <asp:Panel id="tblDim1" runat="server">
         <table  cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:CheckBox runat="server" ID="chbSelectAllDim1" Visible="false" checked="false" onclick="SelectAllDimension(this, 'DataGridDim1')"/>
                    <asp:Label runat="server" ID="lblDim1Name" class="fontHead"></asp:Label>&nbsp;
                    <asp:ImageButton ID="btnImageDim1" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DataGrid ID="DataGridDim1" runat="server" Datakeys="DimID" BorderColor="Silver"
                        BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="false"
                        AllowPaging="true" PagerStyle-Visible="false">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
        </asp:Panel>
        <asp:Panel id="tblDim2" runat="server">
        <table  cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:CheckBox runat="server" ID="chbSelectAllDim2" Visible="false" checked="false" onclick="SelectAllDimension(this, 'DataGridDim2')"/>
                    <asp:Label runat="server" ID="lblDim2Name" class="fontHead"></asp:Label>&nbsp;
                    <asp:ImageButton ID="btnImageDim2" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DataGrid ID="DataGridDim2" runat="server" Datakeys="DimID" BorderColor="Silver"
                        BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="false"
                        AllowPaging="true" PagerStyle-Visible="false">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
        </asp:Panel>
        <asp:Panel id="tblDim3" runat="server">
        <table  cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:CheckBox runat="server" ID="chbSelectAllDim3" Visible="false" checked="false" onclick="SelectAllDimension(this, 'DataGridDim3')"/>
                    <asp:Label runat="server" ID="lblDim3Name" class="fontHead"></asp:Label>&nbsp;
                    <asp:ImageButton ID="btnImageDim3" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DataGrid ID="DataGridDim3" runat="server" Datakeys="DimID" BorderColor="Silver"
                        BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="false"
                        AllowPaging="true" PagerStyle-Visible="false">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
        </asp:Panel>
    </asp:Panel>
    

        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="280">
             <table cellspacing="0" cellpadding="0" >
            <tr>
              <td> <asp:Label id="lblQuotationDetails" runat="server">Dimensional Detail</asp:Label> &nbsp;&nbsp;</td>
               </tr>
               </table>
            </td>

            <td valign="top" width="150">
            <table cellspacing="0" cellpadding="0">
            <tr>
             <td>  <asp:Label id="lblQNT" runat="server">Quantity</asp:Label>:&nbsp;&nbsp;</td>
             <td>  <asp:TextBox ID="txtQNT" runat="server" Width="40"></asp:TextBox>&nbsp;&nbsp;</td>
            <td>   <asp:RegularExpressionValidator ID="QNTvalid" ControlToValidate="txtQNT" runat="server" Display="Dynamic" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>" EnableClientScript="True" ValidationExpression="[0-9]*"></asp:RegularExpressionValidator></td>
               </tr>
               </table>
            </td>

            <td valign="top">
            <table cellspacing="0" cellpadding="0" >
            <tr>
              <td>  <asp:Label id="lblCost" runat="server">Cost</asp:Label>:&nbsp;&nbsp;</td>
               <td> <asp:TextBox ID="txtCost" runat="server" Width="40"></asp:TextBox>&nbsp;&nbsp;</td>
               <td> <cc1:confirmedimagebutton id="btnCostQnt" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
               </tr>
               </table>
            </td>

        </tr>
        </table>


        <asp:datagrid id="DataGrid2" runat="server" DataKeyField="SourcingQuotationBOMDetailsID" AllowSorting="False" BorderColor="Silver" 
        BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="False" >
			<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
			<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
			<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
            <Columns>
                <asp:TemplateColumn>
                    <HeaderTemplate>
                        <input type="checkbox" id="chbSelectAllBomDetail" onclick="SelectAllBomDetails(this);"/>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chbSelectBOMDetail" runat="server" />
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
		</asp:datagrid>	
        </asp:Panel>
        </div>
</td>

<td style="width:25%;" align="left" valign="top">
<div id="SamplePartner" style="overflow-y: auto; overflow-x:hidden;">
   <table cellspacing="0" cellpadding="0" width="100%" class="TableHeader" height="30px">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td>
                <asp:Label ID="lblSelectPartner" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" width="100%">    
    <tr>        
        <td>
            <asp:PlaceHolder ID="plhSearchControl" runat="server"></asp:PlaceHolder>
        </td>
        <td>
            <cc1:ConfirmedImageButton ID="btnSearch" runat="server" Message="NONE" CausesValidation="false" />
        </td>
    </tr>
</table>
<asp:PlaceHolder ID="plhData" runat="server"></asp:PlaceHolder>
    <telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">
        <script type="text/javascript">
            var flag = false; // to prevent child records selecting when parent chain is being selected
             $(document).ready(function () {
                    ValidateUnitsSumm();
                });

            function RowSelected(sender, e) {
                if (flag) return;
                flag = true;
                var parentRow = e.get_tableView().get_parentRow();

                // select parent records
                while (parentRow != null) {
                    var gdi = $find(parentRow.id);
                    gdi.set_selected(true);
                    parentRow = gdi.get_parent().get_parentRow();
                }

                flag = false;

                // select child records
                $.each(e.get_gridDataItem().get_nestedViews(), function (index, view) {
                    view.selectAllItems();
                });
            }

            function RowDeselected(sender, e) {
                // deselect child records
                $.each(e.get_gridDataItem().get_nestedViews(), function (index, view) {
                    view.clearSelectedItems();
                });
            }

            function refresh(teckPackId) {
                <%= ClientScript.GetPostBackEventReference(New PostBackOptions(imgBtnTechPackAdd) With {.PerformValidation = False, .Argument = "teckPackId"}).Replace("'teckPackId'", "teckPackId") %>;                
            }

            function ShareValidate() {
                if (Page_ClientValidate("TechPack")) {
                    return Page_ClientValidate();
                }

                return false;
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

		    function ValidateUnitsSumm() {
                
                var imgValidatorImages = $(".valUnitsSumm");
                if (imgValidatorImages.length == 0 || ($("#drlStyleCostingType").val() == "9")) {
                    return true;
                }

                var strWholesaleUnits = $("#txtStyleQuoteItemCustomField2").val();
                var strRetailUnits =  $("#txtStyleQuoteItemCustomField6").val();
                var strEcomUnits =  $("#txtStyleQuoteItem_EcomUnits").val();
                var strTotalUnits =  $("#txtStyleQuoteItemCustomField16").val();

                var iTotalBOMUnits = 0;
                var txtQty = $("input[id*='txtQuantity']");

                if (strTotalUnits == "" || strTotalUnits == null) {
                    if (txtQty.length > 0) {
                        txtQty.each(function(){iTotalBOMUnits = iTotalBOMUnits + parseInt(this.value,10);})
                    }
                    else {
                        return true;
                    }
                }

                if (strWholesaleUnits == "" || strWholesaleUnits == null) {
                    strWholesaleUnits = "0";
                }
                if (strRetailUnits == "" || strRetailUnits == null) {
                    strRetailUnits = "0";
                }
                if (strEcomUnits == "" || strEcomUnits == null) {
                    strEcomUnits = "0";
                }
                if (strTotalUnits == "" || strTotalUnits == null) {
                    if (txtQty.length > 0) {
                        strTotalUnits = iTotalBOMUnits;
                    }
                    else {
                        strTotalUnits = "0";
                    }
                }

                var iWholesaleUnits = parseInt(strWholesaleUnits, 10);
                var iRetailUnits = parseInt(strRetailUnits, 10);
                var iEcomUnits = parseInt(strEcomUnits, 10);
                var iTotalUnits = parseInt(strTotalUnits, 10);

		        if ((iWholesaleUnits + iRetailUnits + iEcomUnits) == iTotalUnits) {
                    imgValidatorImages.hide();
                    return true;
                } else {
                    imgValidatorImages.show();
                    return false;
                }

		    }

            function TotalSummValidate() {
                
                if (!ValidateUnitsSumm()) {
                    alert('<%= GetSystemText("The wholesale and retail units don\'t add up to the total units for the quote") %>');
                }
            }

            function ConfirmClose() {

                if (!ValidateUnitsSumm()) {
                    return confirm('<%= GetSystemText("The wholesale and retail units don\'t add up to the total units for the quote. Do you really want to close the window?")  %>');
                } else {
                    return true;
                }
            }

            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }

            function SelectAllBomDetails(sender)
            {
                $("#DataGrid2").find("input[id$='chbSelectBOMDetail']").each(
                    function() {
                        this.checked = sender.checked;
                    }
                 );
            }

        </script>
    </telerik:RadScriptBlock>  
</div>
</td>
</tr>


</table>
<div id="sku-confirm" style="display:none;">
    <%= GetSystemText("Are you sure you want to apply the selected Style SKU page? All existing SKU Level data will be lost.")%>
</div>
<%--<script type="text/javascript" src="../System/Jscript/jquery-1.8.3.in.js"></script>--%>
<script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript">

    var drlStyleSKUItemIDValue = $("#drlStyleSKUItemID").val();
    $("#drlStyleSKUItemID").change(function () {
        $("#sku-confirm").dialog({
            title: '<%= GetSystemText("Style SKU Page") %>',
            modal: true,
            width: 380,
            buttons: {
                '<%= GetSystemText("Yes") %>': function () { <%=If(FindControl("drlStyleSKUItemID") IsNot Nothing, ClientScript.GetPostBackEventReference(FindControl("drlStyleSKUItemID"), ""), "") %> },
                '<%= GetSystemText("No") %>': function () { $(this).dialog('close'); $("#drlStyleSKUItemID").val(drlStyleSKUItemIDValue); }
            }
        });
    });

</script>
</form>
</body>
<script language="javascript" type="text/javascript">

	var frm = document.forms['Form1'];
	function CheckAll(checkAllBox) {
		var actVar = checkAllBox.checked;
		for (i = 0; i < frm.length; i++) {
		    e = frm.elements[i];
		    if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
		        e.checked = actVar;
		}
	}

</script>

<script type="text/javascript">

            $("#SamplePalette").height($(window).height() - 30);
            $("#SamplePartner").height($(window).height() - 30);
            $("#FloatDG").height($(window).height() - 30);

            $("#FloatDGControl").click(function () {
                if ($("#FloatDG").offset().left == 0) { $("#FloatDG").animate({ left: $("#FloatDGControl").width() - $("#FloatDG").width() }, 200); }
                else { $("#FloatDG").animate({ left: 0 }, 200); }
            })
</script>

<script type="text/javascript" src="../System/Jscript/jquery.tablescroll.js"></script>
<script type="text/javascript">

    $.fn.tableScroll.defaults =
    {
        flush: true, // makes the last thead and tbody column flush with the scrollbar
        width: null, // width of the table (head, body and foot), null defaults to the tables natural width
        height: 50, // height of the scrollable area
        containerClass: 'tablescroll' // the plugin wraps the table in a div with this css class
    };

    function addScrollToTable() {
        var table = $(<%= dgStyleList.ClientID %>);
        var head = document.createElement("thead");
        var body = table.find("tbody");
        head.appendChild(table[0].rows[0]);
        body.before(head);
        var tableHeight = $("#FloatDG").height() - $("#tLabel").height() -$("#tSearch").height() - $(head).height() - 15;
        table.tableScroll({ height: tableHeight });
        $("#FloatDG").width($(".tablescroll_head").width()+20);
        $("#FloatDGMain").width($(".tablescroll_head").width());
    };


</script>

<script language="javascript" type="text/javascript" src="../System/Jscript/colResizable-1.3.min.js"></script>
<script type="text/javascript">
    $(function () {

        $("#mainTable").colResizable({
            liveDrag: true,
            minWidth: 400
        });

    });	
</script>

</html>
