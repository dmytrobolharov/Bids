<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_CostSheetItem.aspx.vb" Inherits="plmOnApp.Style.CostingEnhanced.Style_CostSheetItem" ResponseEncoding="UTF-8" %>
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
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/CostingScripts.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <!-- Once upon a time here was a great pile of styles. Now it lies in CostingStyles.css -->
	</head>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10" style="height: 28px"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="600" style="height: 28px">
                            <cc1:confirmedimagebutton id="btnEdit" runat="server" Message="NONE" disabled="disabled" />		
                            <cc1:bwimagebutton id="btnPreview" runat="server" Message="NONE" disabled="disabled" />					
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" disabled="disabled" />
                            <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;" disabled="disabled"></cc1:bwimagebutton>					
					</td>					
				</tr>
			</table>
            <uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>	
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>	

                <!-- Header grid -- info about costing scenarios and others. Must always have the same width and cellwidth as the grids below. -->
                <table id="ImportHeader" style="border-bottom: #e0e0e0 1px solid; border-left: #e0e0e0 1px solid; border-collapse: collapse; 
                    border-top: #e0e0e0 1px solid; border-right: #e0e0e0 1px solid; width:1100px;" border="1" rules="all" 
                    cellspacing="0">
                    <tr>
                        <td style="text-align:center;border-left:0px; border-right:0px;">
                        </td>
                        <td style="text-align:center;border-left:0px; border-right:0px;">
                            <input type="checkbox" id="chkTriggerRFQ" name="chkTriggerRFQ" disabled="disabled" style="display:none"/>
                            <label for="chkTriggerRFQ" class="fontHead" style="display:none">TRIGGER RFQ</label>
                        </td>
                        <td style="text-align:center;border-left:0px; border-right:0px;">
                            <input type="radio" id="rdbSystemCost1" name="rdbSystemCost" runat="server" disabled="disabled" />
                        </td>
                        <td style="text-align:center;border-left:0px; border-right:0px;">
                            <input type="radio" id="rdbSystemCost2" name="rdbSystemCost" runat="server" disabled="disabled" />
                        </td>
                        <td style="text-align:center;border-left:0px; border-right:0px;">
                            <input type="radio" id="rdbSystemCost3" name="rdbSystemCost" runat="server" disabled="disabled" />
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
                            <asp:Label runat="server" ID="lblHeaderCost1" Width="99%" style="text-align:center"></asp:Label>
                        </td>
                        <td class="CostsheetHeader">
                            <asp:Label runat="server" ID="lblHeaderCost2" Width="99%" style="text-align:center"></asp:Label>
                        </td>
                        <td class="CostsheetHeader">
                            <asp:Label runat="server" ID="lblHeaderCost3" Width="99%" style="text-align:center"></asp:Label>
                        </td>
                    </tr>
                    <tr class="TableHeaderGreen">
                        <td class="AttributesItem">
                            <asp:Label runat="server" ID="lblCurrencyType"></asp:Label>
                        </td>
                        <td class="SystemCostsheetHeader" align="center">
                            <asp:Label runat="server" ID="lblCurrencyTypeSystem"></asp:Label>
                        </td>
                        <td class="CostsheetHeader" align="center">
                            <asp:Label runat="server" ID="lblCurrencyType1"></asp:Label>
                        </td>
                        <td class="CostsheetHeader" align="center">
                            <asp:Label runat="server" ID="lblCurrencyType2"></asp:Label>
                        </td>
                        <td class="CostsheetHeader" align="center">
                            <asp:Label runat="server" ID="lblCurrencyType3"></asp:Label>
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
                            <asp:TemplateColumn HeaderStyle-CssClass="AttributesItem" ItemStyle-CssClass="AttributesItem">
                                <HeaderTemplate>
                                    <img id="imgCollapseBOM" runat="server" alt="Collapse" src="../System/Icons/icon_Down.gif" onclick="collapseTable(this);" style="cursor:pointer;"/>
                                    <img id="imgExpandBOM" runat="server" alt="Expand" src="../System/Icons/icon_Next.gif" onclick="expandTable(this);" style="display: none;cursor:pointer;"/>
                                    <asp:Label ID="lblBOMHeader" runat="server"><%# GetSystemText("Bill of Materials") & " (" & strBOMName & ")"%></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblGroupName"></asp:Label>
                                    <table width="95%" runat="server" id="descrTable" style="height:100%;">
                                        <tr>
                                            <td style="width:10%;border-right:1px solid #E0E0E0;">
                                                <asp:Label runat="server" ID="lblRowIndex"></asp:Label>
                                            </td>
                                            <td style="width:30%;border-right:1px solid #E0E0E0;">
                                                <asp:Label runat="server" ID="lblCode" Width="95%"></asp:Label>
                                            </td>
                                            <td style="width:60%;">
                                                <asp:Label runat="server" ID="lblDescription" Width="95%"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCostSystem" Width="95%" style="text-align:right;"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCost1" Width="95%" style="text-align:right;"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCost2" Width="95%" style="text-align:right;"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCost3" Width="95%" style="text-align:right;"></asp:Label>
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
                            <asp:TemplateColumn HeaderStyle-CssClass="AttributesItem" ItemStyle-CssClass="AttributesItem">
                                <HeaderTemplate>
                                    <img id="imgCollapseBOL" runat="server" alt="Collapse" src="../System/Icons/icon_Down.gif" onclick="collapseTable(this);" style="cursor:pointer;"/>
                                    <img id="imgExpandBOL" runat="server" alt="Expand" src="../System/Icons/icon_Next.gif" onclick="expandTable(this);" style="display: none;cursor:pointer;"/>
                                    <asp:Label ID="lblBOLHeader" runat="server"><%# GetSystemText("Bill of Labor") & " (" & strBOLName & ")"%></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblGroupName"></asp:Label>
                                    <table width="95%" runat="server" id="descrTable" style="height:100%;">
                                        <tr>
                                            <td style="width:10%;border-right:1px solid #E0E0E0;">
                                                <asp:Label runat="server" ID="lblRowIndex"></asp:Label>
                                            </td>
                                            <td style="width:30%;border-right:1px solid #E0E0E0;">
                                                <asp:Label runat="server" ID="lblCode" Width="95%"></asp:Label>
                                            </td>
                                            <td style="width:60%;">
                                                <asp:Label runat="server" ID="lblDescription" Width="95%"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCostSystem" Width="95%" style="text-align:right;"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCost1" Width="95%" style="text-align:right;"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCost2" Width="95%" style="text-align:right;"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCost3" Width="95%" style="text-align:right;"></asp:Label>
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
                            <asp:TemplateColumn HeaderStyle-CssClass="AttributesItem" ItemStyle-CssClass="AttributesItem">
                                <HeaderTemplate>
                                    <img id="imgCollapseAdditional" runat="server" alt="Collapse" src="../System/Icons/icon_Down.gif" onclick="collapseTable(this);" style="cursor:pointer;"/>
                                    <img id="imgExpandAdditional" runat="server" alt="Expand" src="../System/Icons/icon_Next.gif" onclick="expandTable(this);" style="display: none;cursor:pointer;"/>
                                    <asp:Label ID="lblAdditionalHeader" runat="server"><%# GetSystemText("Additional Cost") %></asp:Label>                                   
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table width="95%" runat="server" id="descrTable" style="height:100%;">
                                        <tr>
                                            <td style="width:10%;border-right:1px solid #E0E0E0;">
                                                <asp:Label runat="server" ID="lblRowIndex"></asp:Label>
                                            </td>
                                            <td style="width:30%;border-right:1px solid #E0E0E0;">
                                                <asp:Label runat="server" ID="lblCode" Width="95%"></asp:Label>
                                            </td>
                                            <td style="width:60%;">
                                                <asp:Label runat="server" ID="lblDescription" Width="95%"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCostSystem" Width="95%" style="text-align:right;"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCost1" Width="95%" style="text-align:right;"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCost2" Width="95%" style="text-align:right;"></asp:Label>
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
                                    <asp:Label runat="server" ID="lblCost3" Width="95%" style="text-align:right;"></asp:Label>
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
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            
                            <asp:TemplateColumn HeaderStyle-CssClass="SystemCostsheetItem" ItemStyle-CssClass="SystemCostsheetItem">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCostSystem" Width="95%" style="padding-left: 3%;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost1" Width="95%" style="padding-left: 3%;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost2" Width="95%" style="padding-left: 3%;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-CssClass="CostsheetItem" ItemStyle-CssClass="CostsheetItem">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost3" Width="95%" style="padding-left: 3%;"></asp:Label>
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

            // Insert empty row after every row, marked as GridGroupEnd, for creating visual spaces
            var blankRow = '<TR style="HEIGHT: 10px" class="UnitDelimiter"><TD class="AttributesItem" style="border-right-style:none;">&nbsp;</TD> ' +
                            '<TD class="SystemCostsheetItem">&nbsp;</TD>' +
                            '<TD class="CostsheetItem">&nbsp;</TD>' +
                            '<TD class="CostsheetItem">&nbsp;</TD>' +
                            '<TD class="CostsheetItem">&nbsp;</TD></TR>';
            $(".GridGroupEnd").after(blankRow);

            insertCollapsibleClassHeaderRow("Benchmarks", "BENCHMARKS");
            insertCollapsibleClassHeaderRow("TotalCost", "TOTAL COST");
            insertCollapsibleClassHeaderRow("Sandbox", "SANDBOX")

            /*** Processing the scroll area for grids -- fitting it's height ***/
            resizeGridScrollArea();
            $(window).resize(function () { resizeGridScrollArea(); });

            jQuery(document).ready(function ($) {
                // Add "disable" function
                jQuery.fn.extend({
                    disable: function (state) {
                        return this.each(function () {
                            if (this) {
                                this.disabled = state;
                            }
                        });
                    }
                });

                // Enable all disabled buttons which are disabled from the start
                $("#toolbar input").disable(false);
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
