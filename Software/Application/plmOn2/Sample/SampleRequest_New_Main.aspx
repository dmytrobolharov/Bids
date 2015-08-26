<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_New_Main.aspx.vb" Inherits="plmOnApp.SampleRequest_New_Main" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server" id="pgTitle">New Sample Request</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../System/Jscript/System.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
        .compliance-failed {
        	color: #f00;
        	font-weight: bold;
        }
    </style>
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
<table border="0" cellpadding="0" cellspacing="0">
<tr>
<td style="width:90%; height:100%;" align="left" valign="top" style="background-color:White">
      <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc1:confirmedimagebutton id="btnGenerate" runat="server" Message="NONE" CausesValidation="true"></cc1:confirmedimagebutton>
                <cc1:ConfirmedImageButton ID="btnShare" runat="server" Message="NONE" CausesValidation="true"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" CausesValidation="true"></cc1:ConfirmedImageButton>
                <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        </table>

        <div id="SamplePalette" style="overflow-y: auto; overflow-x:hidden;">
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
                <td valign="middle" align="left" >
                    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr height="25">
                            <td valign="middle" align="center" width="10">
                                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                            </td>
                            <td class="fontHead" align="left" width="100%">
                                <asp:Label id="lblCostDetail" runat="server"><%= GetSystemText("Sample Detail") %></asp:Label>
                            </td>
                        </tr>
                       
                    </table>
                </td>
                
            </tr>
        </table>

        <table cellSpacing="1" cellPadding="1" width="" border="0">
			<tr>
                <td><asp:label id="lblCalendar" runat="server" CssClass="fontHead"></asp:label>  &nbsp; &nbsp; &nbsp;</td>
                <td>
                    <asp:dropdownlist id="drlCalendar" runat="server" AutoPostBack="True" Width="180"></asp:dropdownlist>
                </td>
                <td></td>
                <td></td>
            </tr>

			<tr>
                <td><asp:label id="lblTemplate" runat="server" CssClass="fontHead"></asp:label>  &nbsp; &nbsp; &nbsp;</td>
                <td>
                    <asp:dropdownlist id="dplTemplate" runat="server" AutoPostBack="True" Width="180"></asp:dropdownlist>
                    <asp:RequiredFieldValidator runat="server" ID="valTemplate" ControlToValidate="dplTemplate" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>" ToolTip="Template is required!"></asp:RequiredFieldValidator>
                </td>
                <td><asp:label id="lblStartdate" runat="server" CssClass="fontHead"></asp:label></td>
                <td>
                    <asp:textbox id="txtStartDate" runat="server" Width="75px"></asp:textbox><a id="aStartDate" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0" /></a>
                    <asp:RequiredFieldValidator runat="server" ID="valStartDate" ControlToValidate="txtStartDate" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>" ToolTip="Start Date is required!"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td width=""><asp:label id="lblTechPack" runat="server" CssClass="fontHead"></asp:label></td>
                <td width="220px"><asp:dropdownlist id="drlTechPack" runat="server" AutoPostBack="False" Width="180"></asp:dropdownlist><cc1:BWImageButton id="imgBtnTechPackAdd" runat="server"/></td>
                <td><asp:label id="lblEndDate" runat="server" CssClass="fontHead"></asp:label></td>
                <td>
                    <asp:textbox id="txtEndDate" runat="server" Width="75px"></asp:textbox><a id="aEndDate" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0" /></a>
                    <asp:RequiredFieldValidator runat="server" ID="valEndDate" ControlToValidate="txtEndDate" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>" ToolTip="End Date is required!"></asp:RequiredFieldValidator>
                </td>
            </tr>
            
            <tr>
                <td><asp:label id="lblStyleColorID" runat="server" CssClass="fontHead"></asp:label></td>
                <td>
                    <asp:dropdownlist id="drlStyleColorID" runat="server" AutoPostBack="True" Width="180"></asp:dropdownlist>
<%--                    <asp:RequiredFieldValidator runat="server" ID="valStyleColorID" ControlToValidate="drlStyleColorID" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>" ToolTip="BOM is required!"></asp:RequiredFieldValidator>--%>
                </td>
                <td></td>
                <td></td>
            </tr>

            <tr>
                <td>
                    <asp:Label ID="lblStyleMeasHdrID" runat="server" CssClass="fontHead"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="drlStyleMeasHdrID" runat="server" AutoPostBack="True" Width="180"></asp:DropDownList>
                </td>
                <td></td>
                <td></td>
            </tr>

            <tr>
                <td>
                    <asp:Label ID="lblMeasSampleSize" runat="server" CssClass="fontHead"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="drlMeasSampleSize" runat="server" Width="180"></asp:DropDownList>
                </td>
                <td></td>
                <td></td>
            </tr>
            
		</table>


        <TABLE cellSpacing="1" cellPadding="1" width="500" border="0" style="background-color:White">
			<TR>
				<TD class="fontHead" width="100">
                    <asp:Label ID="lblScheduleBy" runat="server" ></asp:Label>
				</TD>
				<TD align="left">
                    <asp:radiobuttonlist id="rbSubmitType" runat="server" CssClass="fontHead" RepeatDirection="Horizontal">
				    </asp:radiobuttonlist>
                </TD>
			</TR>
		</TABLE>

        <asp:datagrid id="DataGrid1" runat="server" Width="650" BorderStyle="Solid" AutoGenerateColumns="False"
							PageSize="100" BorderWidth="1px" BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<Columns>
							    <asp:TemplateColumn> 
                                    <HeaderStyle Height="20px" Width="25px" />
							        <ItemTemplate>
							            <asp:CheckBox runat="server" ID="chkSelect"  />
                                        <asp:HiddenField runat="server" ID="hdnTACalTemplateTaskExists" Value='<%#Eval("TACalTemplateTaskExists") %>' />
                                        <asp:HiddenField runat="server" ID="hdnTACalTaskPlanStart" Value='<%#Eval("TaskPlanStart")%>' />
									</ItemTemplate>
							    </asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblProcessH" runat="server"><%#If(strEnableSampleRequestPages.ToUpper = "TRUE", GetSystemText("Pages"), GetSystemText("Process"))%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflow" runat="server">
											<INPUT id="Hidden1" type="hidden" runat="server" NAME="txtWorkflow"></asp:Label><INPUT id="txtWorkflow" type="hidden" runat="server" NAME="txtWorkflow">
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="50px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblSubmitH" runat="server"><%#GetSystemText("Submit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtSubmitDays" runat="server" Width="50px" MaxLength="5"></asp:TextBox>
										<asp:RequiredFieldValidator id="rvSubmitDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtSubmitDays"
											ToolTip='<%#GetSystemText("Enter Submit Days")%>...' Display="Dynamic">*</asp:RequiredFieldValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="50px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblResubmitH" runat="server"><%#GetSystemText("Resubmit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtResubmitDays" runat="server" Width="50px" MaxLength="5"></asp:TextBox>
										<asp:RequiredFieldValidator id="rvResubmitDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtResubmitDays"
											ToolTip='<%#GetSystemText("Enter Resubmit Days")%>...' Display="Dynamic">*</asp:RequiredFieldValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="175px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblAssignedToHL" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:DropDownList id="dlAssignedTo" runat="server" Width="175"></asp:DropDownList>
									</ItemTemplate>
								</asp:TemplateColumn>

								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblDueDateHL" runat="server"><%#GetSystemText("Due Date")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtDueDate" runat="server" Width="75px" MaxLength="10" Enabled="true" ReadOnly="true"></asp:TextBox>
                                        <asp:Label ID="lblDueDateLink" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								

								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate><asp:Label ID="lblFinalDateH" runat="server"><%#GetSystemText("Final Date")%></asp:Label></HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtFinalDate" runat="server" Width="75px" MaxLength="10" Enabled="true" ReadOnly="true"></asp:TextBox><asp:Label ID="lblLink" runat="server" 
										></asp:Label><input type="hidden" runat="server" id="hdnFinalDate" />
									</ItemTemplate>
								</asp:TemplateColumn>

							</Columns>
						</asp:datagrid>


        <asp:HiddenField id="hdnBOMDimensionId" runat="server" />
        <asp:Panel ID="pnlDimType" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr >
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100px">
               <asp:Label id="lblBOM" runat="server"><%= GetSystemText("BOM Dimensions") %></asp:Label>&nbsp;&nbsp;
               </td>
               <td >
                <cc1:confirmedimagebutton id="btnFilter" runat="server"  Message="NONE" Visible="false"></cc1:confirmedimagebutton>
            </td>

        </tr>
        </table>
        <asp:Panel id="tblDim1" runat="server">
        <asp:HiddenField id="hdnDim1" runat="server" />
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
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
        </asp:Panel>
        <asp:Panel id="tblDim2" runat="server">
        <asp:HiddenField id="hdnDim2" runat="server" />
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
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
        </asp:Panel>
        <asp:Panel id="tblDim3" runat="server">
        <asp:HiddenField id="hdnDim3" runat="server" />
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
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
        </asp:Panel>
    </asp:Panel>
    

        


      
        </asp:Panel>
        </div>

</td>
<td style="width: 2px;" valign="top">&nbsp;</td>
<td style="width:10%;" align="left" valign="top">
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
    <tr>
        <TD><asp:checkbox id="cbStyleQuote" runat="server" CssClass="fontHead" ForeColor="Red"></asp:checkbox></TD>
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
                var strWholesaleUnits = $("#txtStyleQuoteItemCustomField2").val();
                var strRetailUnits =  $("#txtStyleQuoteItemCustomField6").val();
                var strTotalUnits =  $("#txtStyleQuoteItemCustomField16").val();

                if (strWholesaleUnits == "" || strWholesaleUnits == null) {
                    strWholesaleUnits = "0"
                }
                if (strRetailUnits == "" || strRetailUnits == null) {
                    strRetailUnits = "0"
                }
                if (strTotalUnits == "" || strTotalUnits == null) {
                    strTotalUnits = "0"
                }

                var iWholesaleUnits = parseInt(strWholesaleUnits, 10);
                var iRetailUnits = parseInt(strRetailUnits, 10);
                var iTotalUnits = parseInt(strTotalUnits, 10);

		        if ((iWholesaleUnits + iRetailUnits) == iTotalUnits) {
                    imgValidatorImages.hide();
                    return true;
                } else {
                    imgValidatorImages.show();
                    return false;
                }
		    }


        </script>
    </telerik:RadScriptBlock>  

</div>

</td>
</tr>


</table>
  

    </form>
</body>

<script type="text/javascript">
    function CheckAll(checkAllBox) { $("[name*=chkDelete]").attr("checked", checkAllBox.checked) }

    $("#SamplePalette").height($(window).height() - 30);
    $("#SamplePartner").height($(window).height() - 30);

</script>
<script language="javascript">
	function btnClose_Click() {
		<%= strExitScript %>
        return false;
    }
</script>
</html>
