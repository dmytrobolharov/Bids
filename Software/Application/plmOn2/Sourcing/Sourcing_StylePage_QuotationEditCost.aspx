<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_QuotationEditCost.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_QuotationEditCost" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Sourcing_Style_Header" Src="Sourcing_Style_Header.ascx" %>
<%@ Register TagPrefix="uc2" TagName="QuotationEdit_CommentsAttachments" Src="Sourcing_StylePage_QuotationEdit_CommentsAttachments.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Sourcing_Partner_Header" Src="Sourcing_Partner_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Sourcing_WorkflowStatus" Src="~/Sourcing/Sourcing_WorkflowStatus.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server" id="pgTitle">Quotation View</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
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

        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc1:confirmedimagebutton id="btnCommit" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnShare" runat="server" Message="NONE" Visible="false"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>  
                <cc1:bwimagebutton id="btnGoToStyle" runat="server" ></cc1:bwimagebutton>
                <cc1:BWImageButton ID="btnCopyQuote" runat="server"></cc1:BWImageButton>
                <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click();"></cc1:confirmedimagebutton>
                
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
        <uc1:Sourcing_WorkflowStatus ID="Sourcing_Workflow_Status1" runat="server" />
        <uc1:Sourcing_Partner_Header ID="Sourcing_Partner_Header1" runat="server"></uc1:Sourcing_Partner_Header>
       <asp:Panel Visible="false" runat="server">
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table cellspacing="0" cellpadding="0" width="100%"  border="0">
                    <tr>
                        <td valign="middle" align="left">
                            <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr height="25">
                                    <td valign="middle" align="center" width="10">
                                        <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                                    </td>
                                    <td class="fontHead" align="left" width="100%">
                                        <asp:ImageButton ID="imgBtnToggleQuotDetail" OnClientClick="return toggleQuotationDetailVisibility(this);" runat="server"
                                            ImageUrl="../System/Icons/icon_Down.gif"></asp:ImageButton>
                                       <asp:Label id="lblCostDetail" runat="server">Quotation Detail</asp:Label>
                                    </td>
                                </tr>
                                <tr id="trQuotationDetail">
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
            <td width="100%" valign="top">
               <asp:Label id="lblBOM" runat="server">BOM Dimensions</asp:Label>&nbsp;&nbsp;
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
    

      
        </asp:Panel>

        <asp:Panel ID="hideBOMs" runat="server">
        <asp:Panel ID="pnlBOMOptions" runat="server">
            <table class="TableHeader CollapsibleHeader" height="30" cellspacing="0" cellpadding="0" width="100%" border="0">
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
                                    <asp:ImageButton ID="btnOptionAdd" runat="server" visible="false"/>
                                    <asp:ImageButton ID="btnOptionSave" runat="server" visible="false"/>
                                </td>
                                <td valign="middle" style="padding: 0 10px;">
                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

             <div id="divBOMOptionContent" class="Collapsible" style="">
                <asp:Panel ID="CostDetail" runat="server">
                <cc3:YSTabView id="YSTabView2" runat="server" />

                  
                    <asp:PlaceHolder ID="plhOptionEdit" runat="server"></asp:PlaceHolder>
                    <div style="max-height:274px;  overflow-y:auto; overflow-x:hidden; float:left">
                <asp:DataGrid ID="DataGrid3" runat="server" DataKeyField="SourcingCostOptionDetailID"
                        AllowSorting="False" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                        AutoGenerateColumns="False" >
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                   
                <asp:PlaceHolder ID="PlaceHolderSummary" runat="server"></asp:PlaceHolder>
                </div>
                 </asp:Panel>
             </div>
           
           <div style="clear:both;"></div>
        </asp:Panel>
        </asp:Panel>
         

         <uc2:QuotationEdit_CommentsAttachments ID="QuotationEdit_CommentsAttachments" runat="server"></uc2:QuotationEdit_CommentsAttachments>

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
            <td valign="top" width="220" id="tblFlashQuantity" runat="server">
            <table cellspacing="0" cellpadding="0">
            <tr>
             <td>  <asp:Label id="lblQNT" runat="server"><%= GetSystemText("Quantity") %></asp:Label>:&nbsp;&nbsp;</td>
             <td>  <asp:TextBox ID="txtQNT" runat="server" Width="40"></asp:TextBox>&nbsp;&nbsp;</td>
            <td>   <asp:RegularExpressionValidator ID="QNTvalid" ControlToValidate="txtQNT" runat="server" Display="Dynamic" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>" EnableClientScript="True" ValidationExpression="[0-9]*"></asp:RegularExpressionValidator></td>
             <td>  <cc1:confirmedimagebutton id="btnQNT" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
               </tr>
               </table>
            </td>

            <td valign="top">
            <table cellspacing="0" cellpadding="0" id="tblFlashCost" runat="server">
            <tr>
              <td>  <asp:Label id="lblCost" runat="server"><%= GetSystemText("Cost") %></asp:Label>:&nbsp;&nbsp;</td>
               <td> <asp:TextBox ID="txtCost" runat="server" Width="40"></asp:TextBox>&nbsp;&nbsp;</td>
               <td> <cc1:confirmedimagebutton id="btnCost" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
               </tr>
               </table>
            </td>
        </tr>
        </table>

        
        <asp:datagrid id="DataGrid2" runat="server" DataKeyField="SourcingQuotationBOMDetailsID" AllowSorting="False" BorderColor="Silver" 
        BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="False" CssClass="Collapsible">
			<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
			<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
			<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
					        
		</asp:datagrid>	

        <telerik:RadScriptBlock runat="server" ID="scriptblock">
            <script type="text/javascript">
                $(document).ready(function () {
                    parent.menu.showImage("<%= getStyleImageID() %>", "<%= getStyleName() %>");
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
           
           <asp:HiddenField ID="isSummary" runat="server"/>
           <asp:HiddenField ID="DetailOpened" runat="server" Value="open" />
           <asp:HiddenField ID="optionCount" runat="server"/>
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

            function refresh() {
                <%= ClientScript.GetPostBackEventReference(New PostBackOptions(imgBtnTechPackAdd) With {.PerformValidation = False}) %>;                
            }

            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }

        </script>
</html>
