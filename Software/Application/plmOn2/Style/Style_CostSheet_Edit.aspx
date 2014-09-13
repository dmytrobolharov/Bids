<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_CostSheet_Edit.aspx.vb" Inherits="plmOnApp.Style.CostingEnhanced.Style_CostSheet_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/jquery.tablescroll.css" type="text/css" rel="stylesheet" />
    <title>
    	
    </title>
    <style type="text/css">
        .RightAlign span
        {
        	text-align: right;
        }
        
        #divCostingHeaderContent td.font
        {
        	padding-right: 30px;
        	padding-left: 20px;
        }
        
        #divCostingHeaderContent td.font input
        {
        	text-align: right;
        }
        
        
    </style>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />
		<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td>
                    <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:bwimagebutton id="btnAddCosting" runat="server" ></cc1:bwimagebutton>
                    <cc1:bwimagebutton id="btnCopy" runat="server" ></cc1:bwimagebutton>
                    <cc1:bwimagebutton id="btnPreview" runat="server" ></cc1:bwimagebutton>
                    <cc1:confirmedimagebutton id="btnCompare" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
                    <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
				</td>
			</tr>
		</table>
        <uc1:Style_Workflow_Edit ID="Style_Workflow_Edit1" runat="server"></uc1:Style_Workflow_Edit>
		<asp:panel id="pnlChange" runat="server"></asp:panel>
        <uc2:style_header id="Style_Header1" runat="server">
		</uc2:style_header>
		<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
				<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
			</tr>
		</table>
<%--        <asp:Panel ID="pnlSeasonYear"  runat="server" >
            <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/>
                    </td>
                    <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                    <td width="125" align="right" nowrap="nowrap">
                        <asp:Label runat="server" ID="Label1" class="fontHead" >Select Season / Year:</asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                    </td>
                </tr>
            </table>
        </asp:Panel>--%>
        <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	        <tr class="TableHeader">
		        <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		        <td width="20">
		            <img id="imgBtnExp_Costing" onclick="return ShowCostingHeaderContent(this)" style="cursor:pointer"  src="../System/Icons/icon_Next.gif" />
		            <img id="imgBtnCol_Costing" onclick="return HideCostingHeaderContent(this)" style="cursor:pointer" src="../System/Icons/icon_Down.gif" />
		        </td>
		        <td class="fontHead" width="500">
			        <asp:label id="lblCostingHeader" Text="Costing Property" runat="server"></asp:label>
		        </td>
                <td width="300" align="right">
                    <asp:RadioButtonList ID="rbFixed" RepeatDirection="Horizontal" runat="server" AutoPostBack="true">
                        <asp:ListItem Text="Fixed Markup" Value="M"></asp:ListItem>
                        <asp:ListItem Text="Fixed Price" Value="P" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td></td>
	        </tr>
        </table>
        <div id="divCostingHeaderContent" style="display:block" width="100%">
		    <table cellspacing="0" cellpadding="0" width="80%" bgColor="#ffffff" border="0">
			    <tr>
				    <td valign="top"><asp:placeholder id="plhCostControls" runat="server"></asp:placeholder></td>
                </tr>
            </table>
        </div>
        <br/>
        <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	        <tr class="TableHeader">
		        <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		        <td width="20">
		            <img id="imgBtnExp_CostingSummary" onclick="return ShowCostingSummaryContent(this)" style="cursor:pointer"  src="../System/Icons/icon_Next.gif" />
		            <img id="imgBtnCol_CostingSummary" onclick="return HideCostingSummaryContent(this)" style="cursor:pointer" src="../System/Icons/icon_Down.gif" />
		        </td>
		        <td class="fontHead">
			        <asp:label id="lblCostingSummary" Text="Costing Summary" runat="server"></asp:label>
		        </td>
	        </tr>
        </table>
        <div id="divCostingSummaryContent" style="display:block" width="100%" bgColor="#ffffff">
            <table cellSpacing="0" cellPadding="0" width="100%" border="0">
			    <tr vAlign="top">
				    <td>
					    <table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
						    border="0">
						    <tr vAlign="middle">
							    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							    <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
							    <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
							    <td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
							    <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
							    <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
							    <td width="10">&nbsp;</td>
							    <td noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>
							    <td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
							    <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
									    <asp:ListItem Value="5">5</asp:ListItem>
									    <asp:ListItem Value="10">10</asp:ListItem>
									    <asp:ListItem Value="15">15</asp:ListItem>
									    <asp:ListItem Value="20">20</asp:ListItem>
									    <asp:ListItem Value="25">25</asp:ListItem>
									    <asp:ListItem Value="30">30</asp:ListItem>
									    <asp:ListItem Value="40">40</asp:ListItem>
									    <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
								    </asp:dropdownlist></td>
							    <td width="10"><asp:button id="btnRepage" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
						    </tr>
					    </table>
					    <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
						    <tr>
							    <td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
							    <td vAlign="top" width="100%">
								    <table height="45">
									    <tr>
										    <td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
									    </tr>
								    </table>
							    </td>
						    </tr>
					    </table>
					    <asp:datagrid id="DataGrid1" runat="server" AllowSorting="true" width="85%" DataKeyField="ScenarioID">
						    <AlternatingItemStyle Height="20px" CssClass="ItemTemplate"></AlternatingItemStyle>
						    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                                <asp:TemplateColumn>
                                	<HeaderStyle CssClass="TableHeaderBlue" Width="20"></HeaderStyle>
						            <ItemStyle></ItemStyle>
                                    <HeaderTemplate>
                                        <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkCompare" runat="server"></asp:CheckBox>
                                        <asp:HiddenField ID="hdnCostingTypeId" runat="server" />
                                        <asp:HiddenField ID="hdnIsScenario" Value='<%# Eval("Sort") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
					    </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			        </td>
			    </tr>
		    </table>
        </div>

    </form>
    <%-- Color_Wait control already provides jquery library --%>
    <script type="text/javascript" src="../System/Jscript/jquery.tablescroll.js"></script>
    <script type="text/javascript">
        var frm = document.form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkCompare") != -1)
                    e.checked = actVar;
            }
        }    

        $.fn.tableScroll.defaults =
            {
                flush: false, // makes the last thead and tbody column flush with the scrollbar
                width: null, // width of the table (head, body and foot), null defaults to the tables natural width
                height: 100, // height of the scrollable area
                containerClass: 'tablescroll' // the plugin wraps the table in a div with this css class
            };

        jQuery(document).ready(function ($) {

            var table = $('#DataGrid1');
            // Creating <thead> element for the first row
            var head = document.createElement("thead");
            var body = table.find("tbody");
            head.appendChild(table[0].rows[0]);
            body.before(head);
            // Adding the scrollbar
            var tableWidth = table.width();
            var tableHeight = $(window).height() - $("#form1").height() + table.height() - $(head).height() - 25;
            table.tableScroll({ height: tableHeight });


            // replace wrong space symbol that brakes validation
            $("#divCostingHeaderContent input[type=text]:enabled:not([readonly])").each(function () {
                this.value = this.value.replace(/\xA0/g, ' ');
            });

        });
    </script>

</body>
</html>
