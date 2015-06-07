<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Task_List_Grid.aspx.vb" 
Inherits="plmOnApp.Task_List_Grid" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Task Folder</title>
   	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
	    <TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <TR vAlign="middle">
			    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			    <TD><cc1:confirmedimagebutton id="btnNew" runat="server" Message="NONE" style="height: 24px"></cc1:confirmedimagebutton></TD>
		    </TR>
	    </TABLE>
	    
	    <table width="100%" height="10" border="0" cellpadding="0" cellspacing="0" bgcolor="#cddeee">
		    <tr>
			    <td></td>
		    </tr>
	    </table>
	    <br/>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
		    <tr>
			    <td>&nbsp;<asp:Label id="lblHeader"  Font-Names="Tahoma,Verdana" Font-Size="XX-Large" ForeColor="#E0E0E0" runat="server">Task Folder...</asp:Label></td>
		    </tr>
	    </table>
        <br/>
        <table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
						<TABLE class="TableHeader" width="100%" border="0" cellPadding="0" cellSpacing="0"
							bgcolor="#ffffff">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD width="16"></TD>
								<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
								<TD align="center" width="75" nowrap><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
								<TD width="10">&nbsp;</TD>
								<TD nowrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>								
								<TD width="110" align="right" class="fontHead">
								    <asp:Label ID="lblRecordsperPage" runat="server">Records per Page:</asp:Label>
								</TD>								
								<TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
									</asp:dropdownlist></TD>									
								<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
							</TR>
						</TABLE>
						<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
								<td width="100%" vAlign="top"><table height="45">
										<tr>
											<td><asp:imagebutton id="imgBtnSearch" runat="server" /></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="TaskID">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</table>	    

    
    </div>
    </form>
</body>
</html>
