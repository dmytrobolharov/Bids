<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_CostSheetItem.aspx.vb" Inherits="srmOnApp.Style_CostSheetItem" ResponseEncoding="UTF-8" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Costing Scenarios</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <!--link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" /-->
        <style type="text/css">
            .Underlined td
            {
            	border-bottom-style: Solid;
            	border-bottom-width: 2px;
            	border-bottom-color: #000;
            }
            
            .Underlined td td
            {
            	border-bottom-style: hidden;
            	border-bottom-width: 0px;
            }
                       
            .UnitDelimiter
            {
            	background-color: #C2C1BA;
            }

        </style>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10" style="height: 28px"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="600" style="height: 28px">
                            <cc1:bwimagebutton id="btnPreview" runat="server" Message="NONE" />					
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" />
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

            <div id="GridArea">

                <!-- Header grid -- info about costing scenarios and others. Must always have the same width and cellwidth as the grids below. -->
                <table id="ImportHeader" style="border-bottom: #e0e0e0 1px solid; border-left: #e0e0e0 1px solid; border-collapse: collapse; 
                    border-top: #e0e0e0 1px solid; border-right: #e0e0e0 1px solid; width:700px;" border="1" rules="all" 
                    cellspacing="0">
                    <tr>
                        <td style="width:252px;text-align:center;border-left:0px; border-right:0px;">
                        </td>
                        <td style="width:110px;text-align:center;border-left:0px; border-right:0px;">
                            <input type="checkbox" id="chkTriggerRFQ" name="chkTriggerRFQ" disabled="disabled" />
                            <label for="chkTriggerRFQ" class="fontHead">TRIGGER RFQ</label>
                        </td>
                        <td style="width:110px;text-align:center;border-left:0px; border-right:0px;">
                            <input type="radio" id="rdbSystemCost1" name="rdbSystemCost" runat="server" disabled="disabled" />
                        </td>
                        <td style="width:110px;text-align:center;border-left:0px; border-right:0px;">
                            <input type="radio" id="rdbSystemCost2" name="rdbSystemCost" runat="server" disabled="disabled" />
                        </td>
                        <td style="width:110px;text-align:center;border-left:0px; border-right:0px;">
                            <input type="radio" id="rdbSystemCost3" name="rdbSystemCost" runat="server" disabled="disabled" />
                        </td>
                    </tr>
                    <tr class="TableHeaderGreen" Height="20px">
                        <td style="width:252px;">
                            <asp:Label runat="server" ID="lblHeaderName"></asp:Label>
                        </td>
                        <td style="width:110px;">
                            <asp:Label runat="server" ID="lblHeaderCostSystem" Width="99%"></asp:Label>
                        </td>
                        <td style="width:110px;">
                            <asp:Label runat="server" ID="lblHeaderCost1" Width="99%"></asp:Label>
                        </td>
                        <td style="width:110px;">
                            <asp:Label runat="server" ID="lblHeaderCost2" Width="99%"></asp:Label>
                        </td>
                        <td style="width:110px;">
                            <asp:Label runat="server" ID="lblHeaderCost3" Width="99%"></asp:Label>
                        </td>
                    </tr>
                </table>
                    <!-- Data grid for storing and editing BOM costing -->
                    <asp:DataGrid ID="BOMCosting" runat="server" BorderColor="#E0E0E0" 
                        BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="false" Width="700px">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
						<HeaderStyle Height="20px" CssClass="TableHeaderYellow"></HeaderStyle>
                        <Columns>
                            <asp:TemplateColumn HeaderStyle-Width="250px" ItemStyle-Width="250px">
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

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCostSystemSum" Width="95%" style="text-align:right;" ></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCostSystem" Width="95%" style="text-align:right;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCost1Sum" Width="95%" style="text-align:right;" ></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost1" Width="95%" style="text-align:right;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCost2Sum" Width="95%" style="text-align:right;" ></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost2" Width="95%" style="text-align:right;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCost3Sum" Width="95%" style="text-align:right;"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost3" Width="95%" style="text-align:right;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                        </Columns>
                    </asp:DataGrid>

                    <!-- Data grid for storing and editing BOL costing -->

                    <asp:DataGrid ID="BOLCosting" runat="server" BorderColor="#E0E0E0" 
                        BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="false" Width="700px">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
						<HeaderStyle Height="20px" CssClass="TableHeaderYellow"></HeaderStyle>
                        <Columns>
                            <asp:TemplateColumn HeaderStyle-Width="250px" ItemStyle-Width="250px">
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

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCostSystemSum" Width="95%" style="text-align:right;"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCostSystem" Width="95%" style="text-align:right;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCost1Sum" Width="95%" style="text-align:right;"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost1" Width="95%" style="text-align:right;"></asp:Label>
                                 </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCost2Sum" Width="95%" style="text-align:right;"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost2" Width="95%" style="text-align:right;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCost3Sum" Width="95%" style="text-align:right;"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost3" Width="95%" style="text-align:right;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                        </Columns>
                    </asp:DataGrid>

                    <!-- Table for calculating additional items costing -->
                    <asp:DataGrid ID="AdditionalCosting" runat="server" BorderColor="#E0E0E0" 
                        BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="false" Width="700px">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
						<HeaderStyle Height="20px" CssClass="TableHeaderYellow"></HeaderStyle>
                        <Columns>
                            <asp:TemplateColumn HeaderStyle-Width="250px" ItemStyle-Width="250px">
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

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCostSystemSum" Width="95%" style="text-align:right;" ></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCostSystem" Width="95%" style="text-align:right;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCost1Sum" Width="95%" style="text-align:right;" ></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost1" Width="95%" style="text-align:right;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCost2Sum" Width="95%" style="text-align:right;" ></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost2" Width="95%" style="text-align:right;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <HeaderTemplate>
                                    <asp:Label runat="server" ID="lblCost3Sum" Width="95%" style="text-align:right;"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost3" Width="95%" style="text-align:right;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                        </Columns>
                    </asp:DataGrid>

                    <!-- SQL-driven DataGrid. WARNING! DataKey for this grid is the name of the column in database -- thanks PIVOT for this -->
                    
                    <asp:DataGrid ID="UnitsCosting" runat="server" BorderColor="#E0E0E0" 
                        BorderStyle="Solid" BorderWidth="2px" AutoGenerateColumns="false" Width="700px">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
						<HeaderStyle Height="0px"></HeaderStyle>
                        <Columns>
                            <asp:TemplateColumn HeaderStyle-Width="252px" ItemStyle-Width="252px">
                                <ItemTemplate>
                                    <asp:Label id="lblRowAlias" runat="server" CssClass="fontHead"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            
                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCostSystem" Width="95%" style="padding-left: 3%;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost1" Width="95%" style="padding-left: 3%;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost2" Width="95%" style="padding-left: 3%;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                            <asp:TemplateColumn HeaderStyle-Width="110px" ItemStyle-Width="110px">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblCost3" Width="95%" style="padding-left: 3%;"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>

                        </Columns>
                    </asp:DataGrid>

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
        <script type='text/javascript'>

            // Insert empty row after every row, marked as GridGroupEnd, for creating visual spaces
            var blankRow = '<TR style="HEIGHT: 10px" class="UnitDelimiter"><TD style="WIDTH: 250px; border-right-style:none;">&nbsp;</TD> ' +
                            '<TD style="WIDTH: 110px; border-left-style:none; border-right-style:none;">&nbsp;</TD>' +
                            '<TD style="WIDTH: 110px; border-left-style:none; border-right-style:none;">&nbsp;</TD>' +
                            '<TD style="WIDTH: 110px; border-left-style:none; border-right-style:none;">&nbsp;</TD>' +
                            '<TD style="WIDTH: 110px; border-left-style:none; border-right-style:none;">&nbsp;</TD></TR>';
            $(".GridGroupEnd").after(blankRow);

            // Collapsing and expanding data grids. If there are not collapsible tables in the hierarchy use
            // the class 'nodata'. For not collapsible rows use class 'nocollapse' and table headers
            function collapseTable(sender) {
                var table = $(sender).closest("table:not([class*='nodata'])");
                var btnCollapse = table.find("img[id*='imgCollapse']");
                var btnExpand = table.find("img[id*='imgExpand']");
                btnCollapse.hide();
                btnExpand.show();
                table.find("tr:not([class*='TableHeaderYellow']):not([class*='nocollapse'])").hide();
            }

            function expandTable(sender) {
                var table = $(sender).closest("table:not([class*='nodata'])");
                var btnCollapse = table.find("img[id*='imgCollapse']");
                var btnExpand = table.find("img[id*='imgExpand']");
                btnCollapse.show();
                btnExpand.hide();
                table.find("tr:not([class*='TableHeaderYellow']):not([class*='nocollapse'])").show();
            }

            // Collapsing and expanding COST/LDP Extended (little part of 4th data grid)
            var btnCollapseClass = "<img id='imgCollapseClass' alt='Collapse' src='../System/Icons/icon_Down.gif' onclick='collapseClass(this, \"LDPExtended\");' style='cursor:pointer;' />"
            var btnExpandClass = "<img id='imgExpandClass' alt='Expand' src='../System/Icons/icon_Next.gif' onclick='expandClass(this, \"LDPExtended\");' style='display: none;cursor:pointer;'/>"
            var headerLabel = "<span class='fontHead'>BENCHMARKS</span>"
            var headerRow = $("#UnitsCosting tr[class*='ExtendedHeader'][class*='LDPExtended']");
            var LDPExpandedRow = '<TR style="HEIGHT: 25px" id="UniqueLDPHeader" class="TableHeader">' +
                            '<TD style="WIDTH: 250px; border-right-style:none;">' + btnCollapseClass + btnExpandClass + headerLabel + '</TD> ' +
                            '<TD style="WIDTH: 110px; border-left-style:none; border-right-style:none;">&nbsp;</TD>' +
                            '<TD style="WIDTH: 110px; border-left-style:none; border-right-style:none;">&nbsp;</TD>' +
                            '<TD style="WIDTH: 110px; border-left-style:none; border-right-style:none;">&nbsp;</TD>' +
                            '<TD style="WIDTH: 110px; border-left-style:none; border-right-style:none;">&nbsp;</TD></TR>';
            $(headerRow).before(LDPExpandedRow);

            function collapseClass(sender, className) {
                var hideRows = $("#UnitsCosting tr[class*='" + className + "']");
                var showBtn = $(sender).closest('td').find("#imgExpandClass");
                var hideBtn = $(sender);
                hideRows.hide();
                showBtn.show();
                hideBtn.hide();
            }

            function expandClass(sender, className) {
                var showRows = $("#UnitsCosting tr[class*='" + className + "']");
                var showBtn = $(sender)
                var hideBtn = $(sender).closest('td').find("#imgCollapseClass"); ;
                showRows.show();
                showBtn.hide();
                hideBtn.show();
            }
        </script>
	    <script type="text/javascript">
		    function btnClose_Click() {
			    <%= strExitScript %>
			    return false;
		    }
	    </script>

	</body>
</html>
