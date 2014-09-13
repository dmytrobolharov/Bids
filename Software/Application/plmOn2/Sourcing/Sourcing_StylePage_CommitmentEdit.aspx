<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_CommitmentEdit.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_CommitmentEdit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="CommitmentEdit_CommentsAttachments" Src="Sourcing_StylePage_CommitmentEdit_CommentsAttachments.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Sourcing_Partner_Header" Src="Sourcing_Partner_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Sourcing_WorkflowStatus_Commitment" Src="~/Sourcing/Sourcing_WorkflowStatus_Commitment.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server" id="pgTitle">Quotation View</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui-1.10.3.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>    
</head>
<body>
    <form id="Form1" runat="server" defaultbutton="btnSave">

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

        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" OnClientClick="TotalSummValidate();"></cc1:confirmedimagebutton>            
                <cc1:confirmedimagebutton id="btnDrop" runat="server" Message="NONE" Visible="false"></cc1:confirmedimagebutton>  
                <cc1:confirmedimagebutton id="btnEdit" runat="server" Message="NONE" Visible="false"></cc1:confirmedimagebutton>  
		        <cc1:bwimagebutton id="btnGoToStyle" runat="server"></cc1:bwimagebutton>
                <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;">
                </cc1:BWImageButton>
                <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return ConfirmClose();"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnCommit" runat="server" Message="NONE" OnClientClick="TotalSummValidate();"></cc1:confirmedimagebutton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        </table>
         <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="top" height="25">
                    <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Large"
                        ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>
        <uc1:Sourcing_WorkflowStatus_Commitment ID="Sourcing_WorkflowStatus_Commitment1" runat="server" />
        <uc1:Sourcing_Partner_Header ID="Sourcing_Partner_Header1" runat="server"></uc1:Sourcing_Partner_Header>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top" align="left" width="400px">
                            <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr class="TableHeader" height="25">
                                    <td valign="middle" align="center" width="10">
                                        <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                                    </td>
                                    <td class="fontHead" align="left" width="20">
                                        <asp:ImageButton ID="imgBtnToggleQuotDetail" OnClientClick="return toggleQuotationDetailVisibility(this);" runat="server"
                                            ImageUrl="../System/Icons/icon_Down.gif"></asp:ImageButton>
                                            </td>
                                            <td width="100%">
                                       <asp:Label id="lblCostDetail" runat="server"><%= GetSystemText("Quotation Detail") %></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trQuotationDetail">
                                    <td colspan="3" valign="top" width="100%">
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
                                    <asp:Label id="lblAdditionalCost" runat="server"><%= GetSystemText("Additional Cost")%></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trAdditionalCost">

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
														                            <td noWrap width="85"><asp:Label ID="lblNoofRow" runat="server" Text=""><%= GetSystemText("No. of Row(s)")%>:</asp:Label></td>
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
									                            <asp:datagrid id="Datagrid1" runat="server" OnItemDataBound="Datagrid1_ItemEventHandler" DataKeyField="CommitmentAdditionalCostID" Width="250" AutoGenerateColumns="False" PageSize="1000"
										                            BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
										                            <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
										                            <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
										                            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
										                            <FooterStyle></FooterStyle>
										                            <Columns>
											                            <asp:TemplateColumn>
												                            <HeaderTemplate>
													                            <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" NAME="checkAll" />
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
													                            <asp:TextBox id="txtAmount" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0" maxlength="5" columns="5"></asp:TextBox>
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

                            <uc2:CommitmentEdit_CommentsAttachments ID="CommitmentEdit_CommentsAttachments" runat="server"></uc2:CommitmentEdit_CommentsAttachments>
                        </td>
                    </tr>
                </table>


   <br />
            </td>
        </tr>
        </table>

        <table class="TableHeader CollapsibleHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="20">
                <asp:ImageButton ID="imgBtnToggleBOMs" OnClientClick="return toggleSectionVisibility(this);" runat="server"
                                        ImageUrl="../System/Icons/icon_Down.gif"></asp:ImageButton>
            </td>
            <td width="100px" >
               <asp:Label id="lblBOM" runat="server" ><%= GetSystemText("BOM Dimensions") %></asp:Label>&nbsp;&nbsp;
               </td>
               <td>
               <cc1:confirmedimagebutton id="btnFilter" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
            </td>
        </tr>
        </table>


        <input id="hidBOMDimensionId" type="hidden" name="hidBOMDimensionId" width="20" runat="server" />
        <asp:Panel ID="pnlDimType" runat="server" CssClass="Collapsible">
    
        <table cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:CheckBox runat="server" ID="chbSelectAllDim1" Visible="false" Checked="true"
                    onclick="SelectAllDimension(this, 'DataGridDim1')"/>
                    <asp:Label runat="server" ID="lblDim1Name" class="fontHead"></asp:Label>
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
        
        <table cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:CheckBox runat="server" ID="chbSelectAllDim2" Visible="false" Checked="true"
                    onclick="SelectAllDimension(this, 'DataGridDim2')"/>
                    <asp:Label runat="server" ID="lblDim2Name" class="fontHead"></asp:Label>
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
        <table cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:CheckBox runat="server" ID="chbSelectAllDim3" Visible="false" Checked="true"
                    onclick="SelectAllDimension(this, 'DataGridDim3')"/>
                    <asp:Label runat="server" ID="lblDim3Name" class="fontHead"></asp:Label>
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
    

        <table class="TableHeader CollapsibleHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="20">
                <asp:ImageButton ID="imgBtnToggleDimDetail" OnClientClick="return toggleSectionVisibility(this);" runat="server"
                                        ImageUrl="../System/Icons/icon_Down.gif"></asp:ImageButton>
            </td>
            <td width="280">
             <table cellspacing="0" cellpadding="0" >
            <tr>
              <td>
              <asp:Label id="lblQuotationDetails" runat="server"><%= GetSystemText("Dimensional Detail") %></asp:Label> &nbsp;&nbsp;</td>
               </tr>
               </table>
            </td>
            <td valign="top" width="220">
            <table cellspacing="0" cellpadding="0" runat="server" id="flash1">
            <tr>
             <td>  <asp:Label id="lblQNT" runat="server"><%= GetSystemText("Quantity") %></asp:Label>:&nbsp;&nbsp;</td>
             <td>  <asp:TextBox ID="txtQNT" runat="server" Width="40"></asp:TextBox>&nbsp;&nbsp;</td>
            <td>   <asp:RegularExpressionValidator ID="QNTvalid" ControlToValidate="txtQNT" runat="server" Display="Dynamic" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>" EnableClientScript="True" ValidationExpression="[0-9]*"></asp:RegularExpressionValidator></td>
             <td>  <cc1:confirmedimagebutton id="btnQNT" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
               </tr>
               </table>
            </td>

            <td valign="top" width="220">
            <table cellspacing="0" cellpadding="0" runat="server" id="flash2">
            <tr>
              <td>  <asp:Label id="lblCost" runat="server"><%= GetSystemText("Cost") %></asp:Label>:&nbsp;&nbsp;</td>
               <td> <asp:TextBox ID="txtCost" runat="server" Width="40"></asp:TextBox>&nbsp;&nbsp;</td>
               <td> <cc1:confirmedimagebutton id="btnCost" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
               </tr>
               </table>
            </td>

            <td valign="top">
            <table cellspacing="0" cellpadding="0" runat="server" id="flash3" >
            <tr>
              
               <td> <cc1:confirmedimagebutton id="btnRemoveDetail" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
               </tr>
               </table>
            </td>
        </tr>
        </table>

        <cc3:YSTabView id="YSTabView2" runat="server"></cc3:YSTabView>
        <asp:datagrid id="DataGrid2" runat="server" DataKeyField="SourcingCommitmentBOMDetailsID" AllowSorting="False" BorderColor="Silver" 
        BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="False" >
			<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
			<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
			<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>					        
					<Columns>
				                <asp:TemplateColumn >
				                    <HeaderTemplate>
				                        <asp:CheckBox ID="cbSelectAll" OnClick="CheckAllDetail(this);" AutoPostBack="False" runat="server"></asp:CheckBox>
				                    </HeaderTemplate> 
				                    <ItemTemplate>
				                        <asp:CheckBox ID="chkDeleteDetail" name="chkDeleteDetail" runat="server"></asp:CheckBox>				            
				                    </ItemTemplate>
				                </asp:TemplateColumn>
				            </Columns>
		</asp:datagrid>	

        <telerik:RadScriptBlock runat="server" ID="scriptblock">
            <script type="text/javascript">
                $(document).ready(function () {
                    try {
                        //parent.menu.showImage("<%= getStyleImageID()%>", "<%= getStyleName() %>");

                        ValidateUnitsSumm();
                        //hide approved option when not aproved
                        $('.statusField option[value="3"]').remove();
                    }
                    catch (ex) {
                    
                    }
                });

                $(window).bind('beforeunload', function () {
                    try {
                        parent.menu.hideImage();
                    } catch (ex) {
                    
                    }
                });
            </script>
        </telerik:RadScriptBlock>
        <div id="sku-confirm" style="display:none;">
            <%= GetSystemText("Are you sure you want to apply the selected Style SKU page? All existing SKU Level data will be lost.")%>
        </div>
        <div id="sku-sync-confirm" style="display:none;">
            <%= GetSystemText("Are you sure you want to sync quantities with the Style SKU page? Any modifications made to these quantities in the commitment will be lost.")%>
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

            $("#btnSKUWarning").click(function () {
                $("#sku-sync-confirm").dialog({
                    title: '<%= GetSystemText("Style SKU Sync") %>',
                    modal: true,
                    width: 380,
                    buttons: {
                        '<%= GetSystemText("Yes") %>': function () { <%=If(FindControl("btnSKUWarning") IsNot Nothing, ClientScript.GetPostBackEventReference(FindControl("btnSKUWarning"), ""), "") %> },
                        '<%= GetSystemText("No") %>': function () { $(this).dialog('close'); }
                    }
                });

                return false;
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
            function CheckAllDetail(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDeleteDetail") != -1)
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

		    function ToggleBOMOptionContent(trigger) {
		        var content = document.getElementById('divBOMOptionContent');

		        if (content && content.style.display == 'none') {
		            trigger.src = '../System/Icons/icon_Down.gif';
		            content.style.display = '';
		        } else {
		            trigger.src = '../System/Icons/icon_Next.gif';
		            content.style.display = 'none';
		        }

		        return false;
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

            function refresh() {
                <%= ClientScript.GetPostBackEventReference(New PostBackOptions(imgBtnTechPackAdd) With {.PerformValidation = False}) %>;                
            }
            
		    function ValidateUnitsSumm() {

		        var imgValidatorImages = $(".valUnitsSumm");
                if (imgValidatorImages.length == 0) {
                    return true;
                }

		        var strWholesaleUnits = $("#txtStyleQuoteItemCustomField2").val();
		        var strRetailUnits = $("#txtStyleQuoteItemCustomField6").val();
                var strEcomUnits =  $("#txtStyleQuoteItem_EcomUnits").val();
		        var strTotalUnits = $("#txtStyleQuoteItemCustomField16").val();

                var iTotalBOMUnits = 0;
                var txtQty = $("input[id*='txtQuantity']");
                if (txtQty.length > 0) {
                    txtQty.each(function(){iTotalBOMUnits = iTotalBOMUnits + parseInt(this.value,10);})
                    strTotalUnits = iTotalBOMUnits;
                }

		        if (strWholesaleUnits == "" || strWholesaleUnits == null) {
		            strWholesaleUnits = "0"
		        }
		        if (strRetailUnits == "" || strRetailUnits == null) {
		            strRetailUnits = "0"
		        }
                if (strEcomUnits == "" || strEcomUnits == null) {
                    strEcomUnits = "0";
                }
		        if (strTotalUnits == "" || strTotalUnits == null) {
		            strTotalUnits = "0"
		        }

		        var iWholesaleUnits = parseInt(strWholesaleUnits, 10);
		        var iRetailUnits = parseInt(strRetailUnits, 10);
                var iEcomUnits = parseInt(strEcomUnits, 10);
		        var iTotalUnits = parseInt(strTotalUnits, 10);
                var isum = parseInt(iWholesaleUnits + iRetailUnits  + iEcomUnits,10);
		        if ( isum != iTotalUnits ) {
                    imgValidatorImages.show();
                    return false;
		        } 
                else {
                     imgValidatorImages.hide();
                     return true;
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

            if ($("#drlStyleCostingType").val() == "9") {
                $("#flash2").hide();
            }
        </script>
</html>
