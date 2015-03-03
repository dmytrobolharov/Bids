<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_CostSheetItem_Edit.aspx.vb" Inherits="plmOnApp.Style.CostingEnhanced.Style_CostSheetItem_Edit" ResponseEncoding="UTF-8" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Costing Scenarios</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/CostingStyles.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../System/Jscript/CostingScripts.js"></script>
    </head>
    <!-- Once upon a time here was a great pile of styles. Now it lies in CostingStyles.css -->
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10" style="height: 28px"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="600" style="height: 28px">	
                            <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" />	
                            <cc1:bwimagebutton id="btnPreview" runat="server" />		
                            <cc1:confirmedimagebutton id="btnDelete" runat="server" />
                            <cc1:confirmedimagebutton id="btnRemoveSelected" runat="server" />
                            <cc1:ConfirmedImageButton ID="btnClear" runat="server" OnClientClick="return CheckClearColumnSelection();" />			
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()" />
                            <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>					
					</td>					
				</tr>
			</table>
			<asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			</asp:panel><uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>	
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>	
            <!--
                Some simple rules about names:
                1. Labels are for group header rows. So txtCost1 -- user input for entering cost, and lblCost1 - header for 
                calculating cost sum by group.
                2. Total sums by grid are stored in lbl<ColumnName>Sum labels - e.g. lblCost1Sum.
                3. Columns has names CostSystem, Cost1, Cost2 and Cost3.
            -->
                <!-- Header grid -- info about costing scenarios and others. Must always have the same width and cellwidth as the grids below. -->
                <table id="ImportHeader" style="border-bottom: #e0e0e0 1px solid; border-left: #e0e0e0 1px solid; border-collapse: collapse; 
                    border-top: #e0e0e0 1px solid; border-right: #e0e0e0 1px solid; width:1100px;" border="1" rules="all" 
                    cellspacing="0">
                    <tr>
                        <td style="text-align:center;border-left:0px; border-right:0px;">
                        </td>
                        <td style="text-align:center;border-left:0px; border-right:0px;">
                            <input type="checkbox" id="chkTriggerRFQ" name="chkTriggerRFQ" style="display:none" />
                            <label for="chkTriggerRFQ" class="fontHead" style="display:none">TRIGGER RFQ</label>
                        </td>
                        <td style="text-align:center;border-left:0px; border-right:0px;">
                            <input type="radio" id="rdbSystemCost1" name="rdbSystemCost" runat="server"/>
                        </td>
                        <td style="text-align:center;border-left:0px; border-right:0px;">
                            <input type="radio" id="rdbSystemCost2" name="rdbSystemCost" runat="server"/>
                        </td>
                        <td style="text-align:center;border-left:0px; border-right:0px;">
                            <input type="radio" id="rdbSystemCost3" name="rdbSystemCost" runat="server"/>
                        </td>
                    </tr>
                    <tr class="TableHeaderGreen">
                        <td class="AttributesItem">
                            <img id="imgMasterCollapse" runat="server" alt="Collapse All" src="../System/Icons/icon_Down.gif" onclick="collapseAll();" style="cursor:pointer;"/>
                            <img id="imgMasterExpand" runat="server" alt="Expand All" src="../System/Icons/icon_Next.gif" onclick="expandAll();" style="display: none;cursor:pointer;"/>
                            <asp:Label runat="server" ID="lblHeaderName"></asp:Label>
                        </td>
                        <td class="SystemCostsheetHeader">
                            <asp:Label runat="server" ID="lblHeaderCostSystem" Width="99%" style="text-align:center"></asp:Label>
                        </td>
                        <td class="CostsheetHeader">
                            <asp:Label runat="server" ID="lblHeaderCost1" CssClass="InplaceEdit" Width="99%" style="text-align:center"></asp:Label>
                            <asp:TextBox runat="server" ID="txtHeaderCost1" Width="95%" style="display:none;"></asp:TextBox>
                            <asp:HiddenField runat="server" ID="hdnHeaderCost1" />
                        </td>
                        <td class="CostsheetHeader">
                            <asp:Label runat="server" ID="lblHeaderCost2" CssClass="InplaceEdit" Width="99%" style="text-align:center"></asp:Label>
                            <asp:TextBox runat="server" ID="txtHeaderCost2" Width="95%" style="display:none;"></asp:TextBox>
                            <asp:HiddenField runat="server" ID="hdnHeaderCost2" />
                        </td>
                        <td class="CostsheetHeader">
                            <asp:Label runat="server" ID="lblHeaderCost3" CssClass="InplaceEdit" Width="99%" style="text-align:center"></asp:Label>
                            <asp:TextBox runat="server" ID="txtHeaderCost3" Width="95%" style="display:none;"></asp:TextBox>
                            <asp:HiddenField runat="server" ID="hdnHeaderCost3" />
                        </td>
                    </tr>
                    <tr class="TableHeaderGreen">
                        <td class="AttributesItem">
                            <asp:Label runat="server" ID="lblCurrencyType"></asp:Label>
                        </td>
                        <td class="SystemCostsheetHeader">
                            <asp:DropDownList runat="server" ID="ddlCurrencyTypeSystem" Width="99%" style="text-align:center"></asp:DropDownList>
                        </td>
                        <td class="CostsheetHeader">
                            <asp:DropDownList runat="server" ID="ddlCurrencyType1" Width="99%" style="text-align:center"></asp:DropDownList>
                        </td>
                        <td class="CostsheetHeader">
                            <asp:DropDownList runat="server" ID="ddlCurrencyType2" Width="99%" style="text-align:center"></asp:DropDownList>  
                        </td>
                        <td class="CostsheetHeader">
                            <asp:DropDownList runat="server" ID="ddlCurrencyType3" Width="99%" style="text-align:center"></asp:DropDownList>
                        </td>
                    </tr>
                </table>

                <div id="GridArea">
                    <!-- Data grid for storing and editing BOM costing -->
                    <asp:DataGrid ID="BOMCosting" runat="server" BorderColor="#E0E0E0" 
                        BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="false" Width="1100px">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
						<HeaderStyle Height="20px" CssClass="TableHeaderYellow"></HeaderStyle>
                        <Columns>
                            <asp:TemplateColumn HeaderStyle-CssClass="CheckboxColumn"  ItemStyle-CssClass="CheckboxColumn">
                                <HeaderTemplate>
                                    &nbsp;
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chbRemove" />
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="AttributesItemShort" ItemStyle-CssClass="AttributesItemShort">
                                <HeaderTemplate>
                                    <table class="nodata" width="99%">
                                        <tr class="nocollapse">
                                            <td width="80%">
                                                <img id="imgCollapseBOM" runat="server" alt="Collapse" src="../System/Icons/icon_Down.gif" onclick="collapseTable(this);" style="cursor:pointer;"/>
                                                <img id="imgExpandBOM" runat="server" alt="Expand" src="../System/Icons/icon_Next.gif" onclick="expandTable(this);" style="display: none;cursor:pointer;"/>
                                                <asp:Label ID="lblBOMHeader" runat="server"><%# GetSystemText("Bill of Materials") & " (" & strBOMName & ")"%></asp:Label>
                                                <asp:HiddenField ID="hdnIsExpanded" runat="server" />
                                            </td>
                                            <td width="20%" style="text-align:right;">
                                                 <asp:ImageButton runat="server" ID="btnAddToGroup" style="float:right" ImageUrl="../System/Icons/icon_add.gif"
                                                    CommandName='AddMaterialType' ToolTip='<%# GetSystemText("Add new material type")%>' OnClientClick="expandTableAfterPostback(this);"/>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table width="99%" runat="server" id="groupingTable">
                                        <tr>
                                            <td width="80%">
                                                 <asp:Label runat="server" ID="lblGroupName" Width="95%"></asp:Label>
                                                 <asp:TextBox runat="server" ID="txtGroupName" Width="95%" style="display:none;"></asp:TextBox>
                                                 <asp:HiddenField runat="server" ID="hdnGroupName" />
                                                 <asp:HiddenField runat="server" ID="hdnMaterialType" Value='<%# Container.DataItem("MaterialType").ToString()%>' />
                                            </td>
                                            <td width="20%" style="text-align:right;">
                                                 <asp:ImageButton runat="server" ID="btnAddToGroup" style="float:right" ImageUrl="../System/Icons/icon_add.gif"
                                                    CommandName='AddMaterial' CommandArgument='<%# Container.DataItem("MaterialType").ToString()%>'
                                                    ToolTip='<%# GetSystemText("Add new material")%>' />
                                            </td>
                                        </tr>                                 
                                    </table>
                                    <table width="95%" runat="server" id="descrTable" style="height:100%;">
                                        <tr>
                                            <td style="width:10%;border-right:1px solid #E0E0E0;">
                                                <asp:Label runat="server" ID="lblRowIndex"></asp:Label>
                                            </td>
                                            <td style="width:30%;border-right:1px solid #E0E0E0;">
                                                <asp:TextBox runat="server" ID="txtCode" Width="95%"></asp:TextBox>
                                                <asp:HiddenField runat="server" ID="hdnCode" />
                                                <asp:CustomValidator runat="server" ID="valCode" Display="Dynamic"
                                                ValidateEmptyText="true"
                                                ErrorMessage="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>"
                                                ControlToValidate="txtCode" ClientValidationFunction="ValidateRequiredRowElement"></asp:CustomValidator>
                                            </td>
                                            <td style="width:60%;">
                                                <asp:TextBox runat="server" ID="txtDescription" Width="95%"></asp:TextBox>
                                                <asp:HiddenField runat="server" ID="hdnDescription" />
                                                <asp:CustomValidator runat="server" ID="valDescription" Display="Dynamic"
                                                ValidateEmptyText="true"
                                                ErrorMessage="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>"
                                                ControlToValidate="txtDescription" ClientValidationFunction="ValidateRequiredRowElement"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="SystemCostsheetItem" ItemStyle-CssClass="SystemCostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCostSystemSum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCostSystemSum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCostSystem" readonly="true" Width="95%" style="text-align:right;" CssClass='<%# Container.DataItem("MaterialType").ToString()%>' Visible="false"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtCostSystem" readonly="true" Width="85%" style="text-align:right;" CssClass='<%# Container.DataItem("MaterialType").ToString()%>'></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCostSystem" />
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost1Sum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost1Sum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost1" style="text-align:right;" Width="95%"  CssClass='<%# Container.DataItem("MaterialType").ToString()%>' Visible="false"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtCost1" Width="85%" style="text-align:right;" CssClass='<%# Container.DataItem("MaterialType").ToString()%>'></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCost1" />
                                    <asp:RegularExpressionValidator runat="server" ID="valCost1" Display="Dynamic" ControlToValidate="txtCost1"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost2Sum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost2Sum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost2" Width="95%" style="text-align:right;" Visible="false" CssClass='<%# Container.DataItem("MaterialType").ToString()%>'></asp:Label>
                                    <asp:TextBox runat="server" ID="txtCost2" Width="85%" style="text-align:right;" CssClass='<%# Container.DataItem("MaterialType").ToString()%>'></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCost2" />
                                    <asp:RegularExpressionValidator runat="server" ID="valCost2" Display="Dynamic" ControlToValidate="txtCost2"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost3Sum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost3Sum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost3" Visible="false" Width="95%" style="text-align:right;" CssClass='<%# Container.DataItem("MaterialType").ToString()%>'></asp:Label>
                                    <asp:TextBox runat="server" ID="txtCost3" Width="85%" style="text-align:right;" CssClass='<%# Container.DataItem("MaterialType").ToString()%>'></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCost3" />
                                    <asp:RegularExpressionValidator runat="server" ID="valCost3" Display="Dynamic" ControlToValidate="txtCost3"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                        </Columns>
                    </asp:DataGrid>

                    <!-- Data grid for storing and editing BOL costing -->

                    <asp:DataGrid ID="BOLCosting" runat="server" BorderColor="#E0E0E0" 
                        BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="false" Width="1100px">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
						<HeaderStyle Height="20px" CssClass="TableHeaderYellow"></HeaderStyle>
                        <Columns>
                            <asp:TemplateColumn HeaderStyle-CssClass="CheckboxColumn"  ItemStyle-CssClass="CheckboxColumn">
                                <HeaderTemplate>
                                    &nbsp;
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chbRemove" />
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="AttributesItemShort" ItemStyle-CssClass="AttributesItemShort">
                                <HeaderTemplate>
                                <table width="99%" class="nodata">
                                    <tr class="nocollapse">
                                        <td width="70%">
                                            <img id="imgCollapseBOL" runat="server"  alt="Collapse" src="../System/Icons/icon_Down.gif" onclick="collapseTable(this);" style="cursor:pointer;"/>
                                            <img id="imgExpandBOL" runat="server"  alt="Expand" src="../System/Icons/icon_Next.gif" onclick="expandTable(this);" style="display: none;cursor:pointer;"/>
                                            <asp:Label ID="lblBOLHeader" runat="server"><%# GetSystemText("Bill of Labor")& " (" & strBOLName & ")"%></asp:Label>
                                            <asp:HiddenField ID="hdnIsExpanded" runat="server" Value="True" />
                                        </td>
                                        <td width="70%" style="text-align: right;">
                                            <asp:ImageButton runat="server" ID="btnAddToBOL" style="float:right" ImageUrl="../System/Icons/icon_add.gif" 
                                            OnClientClick="expandTableAfterPostback(this);"/>
                                        </td>
                                    </tr>
                                </table>
                                    
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblGroupName"></asp:Label>
                                    <table width="95%" runat="server" id="descrTable" style="height:100%;">
                                        <tr>
                                            <td style="width:10%;border-right:1px solid #E0E0E0;">
                                                <asp:Label runat="server" ID="lblRowIndex"></asp:Label>
                                            </td>
                                            <td style="width:30%;border-right:1px solid #E0E0E0;">
                                                <asp:TextBox runat="server" ID="txtCode" Width="95%"></asp:TextBox>
                                                <asp:HiddenField runat="server" ID="hdnCode" />
                                                <asp:CustomValidator runat="server" ID="valCode" Display="Dynamic"
                                                ValidateEmptyText="true"
                                                ErrorMessage="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>"
                                                ControlToValidate="txtCode" ClientValidationFunction="ValidateRequiredRowElement"></asp:CustomValidator>
                                            </td>
                                            <td style="width:60%;">
                                                <asp:TextBox runat="server" ID="txtDescription" Width="95%"></asp:TextBox>
                                                <asp:HiddenField runat="server" ID="hdnDescription" />
                                                <asp:CustomValidator runat="server" ID="valDescription" Display="Dynamic"
                                                ValidateEmptyText="true"
                                                ErrorMessage="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>"
                                                ControlToValidate="txtDescription" ClientValidationFunction="ValidateRequiredRowElement"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="SystemCostsheetItem" ItemStyle-CssClass="SystemCostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCostSystemSum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCostSystemSum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCostSystem" Width="95%"  readonly="true" style="text-align:right;" CssClass='<%# Container.DataItem("OperationTypeID").ToString()%>' Visible="false"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtCostSystem" readonly="true" Width="85%" style="text-align:right;" CssClass='<%# Container.DataItem("OperationTypeID").ToString()%>'></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCostSystem" />
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost1Sum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost1Sum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost1" Width="95%" style="text-align:right;"  CssClass='<%# Container.DataItem("OperationTypeID").ToString()%>' Visible="false"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtCost1" Width="85%" style="text-align:right;" CssClass='<%# Container.DataItem("OperationTypeID").ToString()%>'></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCost1" />
                                    <asp:RegularExpressionValidator runat="server" ID="valCost1" Display="Dynamic" ControlToValidate="txtCost1"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost2Sum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost2Sum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost2" Width="95%" style="text-align:right;" Visible="false" CssClass='<%# Container.DataItem("OperationTypeID").ToString()%>'></asp:Label>
                                    <asp:TextBox runat="server" ID="txtCost2" Width="85%" style="text-align:right;" CssClass='<%# Container.DataItem("OperationTypeID").ToString()%>'></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCost2" />
                                    <asp:RegularExpressionValidator runat="server" ID="valCost2" Display="Dynamic" ControlToValidate="txtCost2"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost3Sum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost3Sum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost3" Visible="false" Width="95%" style="text-align:right;" CssClass='<%# Container.DataItem("OperationTypeID").ToString()%>'></asp:Label>
                                    <asp:TextBox runat="server" ID="txtCost3" Width="85%" style="text-align:right;" CssClass='<%# Container.DataItem("OperationTypeID").ToString()%>'></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCost3" />
                                    <asp:RegularExpressionValidator runat="server" ID="valCost3" Display="Dynamic" ControlToValidate="txtCost3"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                        </Columns>
                    </asp:DataGrid>

                    <!-- Table for calculating additional items costing -->
                    <asp:DataGrid ID="AdditionalCosting" runat="server" BorderColor="#E0E0E0" 
                        BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="false" Width="1100px">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
						<HeaderStyle Height="20px" CssClass="TableHeaderYellow"></HeaderStyle>
                        <Columns>
                            <asp:TemplateColumn HeaderStyle-CssClass="CheckboxColumn"  ItemStyle-CssClass="CheckboxColumn">
                                <HeaderTemplate>
                                    &nbsp;
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chbRemove" />
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="AttributesItemShort" ItemStyle-CssClass="AttributesItemShort">
                                <HeaderTemplate>
                                    <table class="nodata" width="99%">
                                        <tr class="nocollapse">
                                            <td width="80%">
                                                <img id="imgCollapseAdditional" runat="server" alt="Collapse" src="../System/Icons/icon_Down.gif" onclick="collapseTable(this);" style="cursor:pointer;"/>
                                                <img id="imgExpandAdditional" runat="server" alt="Expand" src="../System/Icons/icon_Next.gif" onclick="expandTable(this);" style="display: none;cursor:pointer;"/>
                                                <asp:Label ID="lblAdditionalHeader" runat="server"><%# GetSystemText("Additional Cost")%></asp:Label>
                                                <asp:HiddenField ID="hdnIsExpanded" runat="server" Value="True" />
                                            </td>
                                            <td width="20%" style="text-align:right;">
                                                <asp:ImageButton runat="server" ID="btnAddToAdditional" style="float:right" ImageUrl="../System/Icons/icon_add.gif" 
                                                OnClientClick="expandTableAfterPostback(this);"/>
                                            </td>
                                        </tr>
                                    </table>                                    
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table width="95%" runat="server" id="descrTable" style="height:100%;">
                                        <tr>
                                            <td style="width:10%;border-right:1px solid #E0E0E0;">
                                                <asp:Label runat="server" ID="lblRowIndex"></asp:Label>
                                            </td>
                                            <td style="width:30%;border-right:1px solid #E0E0E0;">
                                                <asp:TextBox runat="server" ID="txtCode" Width="95%"></asp:TextBox>
                                                <asp:HiddenField runat="server" ID="hdnCode" />
                                                <asp:CustomValidator runat="server" ID="valCode" Display="Dynamic"
                                                ValidateEmptyText="true"
                                                ErrorMessage="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>"
                                                ControlToValidate="txtCode" ClientValidationFunction="ValidateRequiredRowElement"></asp:CustomValidator>
                                            </td>
                                            <td style="width:60%;">
                                                <asp:TextBox runat="server" ID="txtDescription" Width="95%"></asp:TextBox>
                                                <asp:HiddenField runat="server" ID="hdnDescription" />
                                                <asp:CustomValidator runat="server" ID="valDescription" Display="Dynamic"
                                                ValidateEmptyText="true"
                                                ErrorMessage="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>"
                                                ControlToValidate="txtDescription" ClientValidationFunction="ValidateRequiredRowElement"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="SystemCostsheetItem" ItemStyle-CssClass="SystemCostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCostSystemSum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCostSystemSum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="txtCostSystem" readonly="true" Width="85%" style="text-align:right;"></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCostSystem" />
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost1Sum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost1Sum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="txtCost1" Width="85%" style="text-align:right;"></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCost1" />
                                    <asp:RegularExpressionValidator runat="server" ID="valCost1" Display="Dynamic" ControlToValidate="txtCost1"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost2Sum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost2Sum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="txtCost2" Width="85%" style="text-align:right;"></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCost2" />
                                    <asp:RegularExpressionValidator runat="server" ID="valCost2" Display="Dynamic" ControlToValidate="txtCost2"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <HeaderTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost3Sum" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                            <td style="width:50%;" nowrap>
                                                <asp:Label runat="server" ID="lblCost3Sum_Conv" Width="95%" style="text-align:left;" ></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                   <asp:TextBox runat="server" ID="txtCost3" Width="85%" style="text-align:right;"></asp:TextBox>
                                   <asp:HiddenField runat="server" ID="hdnCost3" />
                                   <asp:RegularExpressionValidator runat="server" ID="valCost3" Display="Dynamic" ControlToValidate="txtCost3"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                        </Columns>
                    </asp:DataGrid>

                    <!-- SQL-driven DataGrid. WARNING! DataKey for this grid is the name of the column in database -- thanks PIVOT for this -->
                    
                    <asp:DataGrid ID="UnitsCosting" runat="server" BorderColor="#E0E0E0" 
                        BorderStyle="Solid" BorderWidth="2px" AutoGenerateColumns="false" Width="1100px">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
						<HeaderStyle Height="0px"></HeaderStyle>
                        <Columns>
                            <asp:TemplateColumn HeaderStyle-CssClass="AttributesItem" ItemStyle-CssClass="AttributesItem">
                                <ItemTemplate>
                                    <asp:Label id="lblRowAlias" runat="server" CssClass="fontHead"></asp:Label>
                                    <asp:HiddenField ID="hdnDataType" runat="server" />
                                    <asp:HiddenField ID="hdnControlType" runat="server" />
                                    <asp:HiddenField ID="hdnIsEnabled" runat="server" />
                                    <asp:HiddenField ID="hdnIsCalculated" runat="server" />
                                    <asp:HiddenField ID="hdnDataFormat" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            
                            <asp:TemplateColumn HeaderStyle-CssClass="SystemCostsheetItem" ItemStyle-CssClass="SystemCostsheetItem">
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="drlCostSystem" Width="95%" Visible="False" readonly="true"></asp:DropDownList>
                                    <asp:TextBox runat="server" ID="txtCostSystem" readonly="true" Width="85%"></asp:TextBox>
                                    <asp:HiddenField runat="server" ID="hdnCostSystem" />
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="drlCost1" Width="95%" Visible="False"></asp:DropDownList>
                                    <table width="95%">
                                        <tr>
                                            <td width="99%">
                                                <asp:TextBox runat="server" ID="txtCost1" Width="95%"></asp:TextBox>
                                                <asp:HiddenField runat="server" ID="widCost1" Visible="false"/>
                                            </td>
                                            <td width="1%">
                                                <img src="../System/Icons/icon_windowpopup.gif" runat="server" width="17" height="17" id="imgBtnPopup1" 
                                                visible="false" style="cursor:pointer;" />
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:HiddenField runat="server" ID="hdnCost1" />
                                    <asp:RegularExpressionValidator runat="server" ID="valCost1" Display="Dynamic" ControlToValidate="txtCost1"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="drlCost2" Width="95%" Visible="False"></asp:DropDownList>
                                    <table width="95%">
                                        <tr>
                                            <td width="99%">
                                                <asp:TextBox runat="server" ID="txtCost2" Width="95%"></asp:TextBox>
                                                <asp:HiddenField runat="server" ID="widCost2" Visible="false" />
                                            </td>
                                            <td width="1%">
                                                <img src="../System/Icons/icon_windowpopup.gif" width="17" height="17" runat="server" id="imgBtnPopup2" visible="false"
                                                style="cursor:pointer;" />
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:HiddenField runat="server" ID="hdnCost2" />
                                    <asp:RegularExpressionValidator runat="server" ID="valCost2" Display="Dynamic" ControlToValidate="txtCost2"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <ItemTemplate>
                                   <asp:DropDownList runat="server" ID="drlCost3" Width="95%" Visible="False"></asp:DropDownList>
                                   <table width="95%">
                                        <tr>
                                            <td width="99%">
                                                <asp:TextBox runat="server" ID="txtCost3" Width="95%"></asp:TextBox>
                                                <asp:HiddenField runat="server" ID="widCost3" Visible="false"/>
                                            </td>
                                            <td width="1%">
                                                <img src="../System/Icons/icon_windowpopup.gif" runat="server" width="17" height="17" id="imgBtnPopup3" visible="false" 
                                                style="cursor:pointer;" />
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:HiddenField runat="server" ID="hdnCost3" />
                                   <asp:RegularExpressionValidator runat="server" ID="valCost3" Display="Dynamic" ControlToValidate="txtCost3"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                        </Columns>
                    </asp:DataGrid>

            </div>
            <!-- Here we gone.-->

			<table id="Table3" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			    <tr valign="middle">
				    <td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
				    <td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
				    <td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					    <asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				    <td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
			    </tr>
		    </table>
		</form>

        <!-- Here was a bunch of javascript, and now most of it is placed in CostingScripts.js. This was done, cause and
        awful lot of javascript is similar between View and Edit pages of new costing. -->

        <script type='text/javascript'>

            // Rough implementation of in-place editing
            $("span[class*='InplaceEdit']").bind("click", function () { showInplaceEditor(this); });

            // Insert empty row after every row, marked as GridGroupEnd, for creating visual spaces
            var blankRow = '<TR style="HEIGHT: 10px" class="UnitDelimiter"><TD style="border-right-style:none;" class="AttributesItem">&nbsp;</TD> ' +
                            '<TD class="SystemCostsheetItem">&nbsp;</TD>' +
                            '<TD class="CostsheetItem">&nbsp;</TD>' +
                            '<TD class="CostsheetItem">&nbsp;</TD>' +
                            '<TD class="CostsheetItem">&nbsp;</TD></TR>';
            $(".GridGroupEnd").after(blankRow);

            if ($("#BOMCosting input[id*='hdnIsExpanded']").val().toUpperCase() == "FALSE") {
                $("#BOMCosting img[id*='imgCollapse']").click();
            }
            if ($("#BOLCosting input[id*='hdnIsExpanded']").val().toUpperCase() == "FALSE") {
                $("#BOLCosting img[id*='imgCollapse']").click();
            }
            if ($("#AdditionalCosting input[id*='hdnIsExpanded']").val().toUpperCase() == "FALSE") {
                $("#AdditionalCosting img[id*='imgCollapse']").click();
            }

            insertCollapsibleClassHeaderRow("Benchmarks", "BENCHMARKS");
            insertCollapsibleClassHeaderRow("TotalCost", "TOTAL COST");
            insertCollapsibleClassHeaderRow("Sandbox", "SANDBOX");

            // Setting HTS boxes to ReadOnly
            $("#UnitsCosting tr[class*='DutySource'] input[name*='txtCost']").attr('readOnly','true');

            DutyPercentSetReadOnly();

            // Focusing the current window after it's opener has been reloaded
            try {
                $(window.opener).load(function () { window.focus(); })
            }
            catch (e) { // In case opener window was closed
            }


            // Select all the 'Remove' checkboxes from current group
            function selectTableClass(sender) {
                var currentTable = $(sender).closest('table');
                var currentClass = $(sender).attr('class').split(" ")[0];
                var checkboxesToSelect = $(currentTable).find(":checkbox[id*='chbRemove'][class*='" + currentClass + "']");
                for (var i = 0, currentCheckbox; currentCheckbox = checkboxesToSelect[i]; i++) {
                    if (currentCheckbox.disabled == false) {
                        currentCheckbox.checked = sender.checked;
                    }
                }
            }

            /*** Processing the scroll area for grids -- fitting it's height ***/
            resizeGridScrollArea();
            $(window).resize(function () { resizeGridScrollArea(); });

            function CheckClearColumnSelection() {
                var selectedVal = $("input:radio[name='rdbSystemCost']:checked").val();
                if (selectedVal == null) {
                    alert('<%= GetSystemText("Please, select the column which you want to clear") %>');
                    return false;
                } else {
                    return true;
                }
            }

            jQuery(document).ready(function ($) {
                // replace wrong space symbol in IE that brakes validation
                if (!$.support.cssFloat) { // check if ie
                    var a = $("#GridArea input[type=text]:enabled:not([readonly])").each(function () {
                        this.value = this.value.replace(/\xA0/g, ' ');
                    });
                }
            });

        </script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
