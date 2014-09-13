<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_CostSheet.aspx.vb" Inherits="srmOnApp.Style_CostSheet" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
    	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    </title>
    <style type="text/css">
        .RightAlign span
        {
        	text-align: right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
		<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow>
        <asp:panel id="pnlChange" runat="server"></asp:panel>
        <uc2:style_header id="Style_Header1" runat="server"></uc2:style_header>
		<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
				<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
			</tr>
		</table>
        <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	        <tr class="TableHeader">
		        <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		        <td width="20">
		            <img id="imgBtnExp_Costing" onclick="return ShowCostingHeaderContent(this)" style="cursor:pointer"  src="../System/Icons/icon_Next.gif" />
		            <img id="imgBtnCol_Costing" onclick="return HideCostingHeaderContent(this)" style="cursor:pointer" src="../System/Icons/icon_Down.gif" />
		        </td>
		        <td class="fontHead">
			        <asp:label id="lblCostingHeader" Text="Costing Property" runat="server"></asp:label>
		        </td>
	        </tr>
        </table>
        <div id="divCostingHeaderContent" style="display:block" width="100%" bgColor="#ffffff">
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
        <div id="divCostingSummaryContent" style="display:block" width="100%">
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
					    <asp:datagrid id="DataGrid1" runat="server" AllowSorting="true" width="80%">
						    <AlternatingItemStyle Height="20px" CssClass="ItemTemplate"></AlternatingItemStyle>
						    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
					    </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			        </td>
			    </tr>
		    </table>
        </div>

    </form>
</body>
</html>
