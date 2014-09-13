<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_DevelopmentSpec_Template.aspx.vb" Inherits="plmOnApp.Body_DevelopmentSpec_Template" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title id="titleHeader" runat="server">Untitled Page</title>
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">    
</head>
<body>
    <form id="form1" runat="server">

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<table id="Table1" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="50" height="50">&nbsp;</td>
					<td class="fonthead"><asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Sample Size</asp:label></td>
				</tr>
			</table>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD width="800" bgColor="#ffffff"></TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
				<tr>
					<TD>
						<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR vAlign="top">
								<TD>
									<TABLE class="TableHeader" id="Table3" height="25" cellSpacing="0" cellPadding="0" width="100%"
										bgColor="#ffffff" border="0">
										<TR vAlign="middle">
											<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
											<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
											<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
											<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
											<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
											<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
											<TD width="10">&nbsp;</TD>
											<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
											<TD class="fontHead" align="right" width="110">
											<asp:label id="lblRecordPerPage" runat="server" CssClass="fontHead">Records per Page:</asp:label>
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
											<TD width="10"><asp:button id="btnGo" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
										</TR>
									</TABLE>
									<TABLE id="Table5" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white"
										border="0">
										<TR>
											<TD vAlign="top" width="100%">
												<TABLE id="Table6" height="45">
													<TR>
														<TD class="fontHead" width="50">
															<DIV align="right"><asp:label id="lblSearch" runat="server">Search:</asp:label></DIV>
														</TD>
														<TD width="75"><asp:textbox id="txtSearch" runat="server" CssClass="font"></asp:textbox></TD>
														<TD width="10"><asp:imagebutton id="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif"></asp:imagebutton></TD>
													</TR>
												</TABLE>
											</TD>
										</TR>
									</TABLE>
									<asp:datagrid id="DataGrid1" runat="server" DataKeyField="POMTempItemID" AllowSorting="True" PageSize="50">
										<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
										<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
										<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
										<PagerStyle Visible="False"></PagerStyle>
									</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
							</TR>
						</TABLE>
					</TD>
				</tr>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td>&nbsp;
					</td>
				</tr>
			</table>
			<TABLE id="Table4" style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
				height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
				<TR>
					<TD align="center" width="50">&nbsp;</TD>
					<TD align="center" width="500"></TD>
					<TD align="center">&nbsp;</TD>
				</TR>
			</TABLE>
			
			<SCRIPT language="javascript">
			    var frm = document.form1 ;
			    function CheckAll( checkAllBox ){
			        var actVar = checkAllBox.checked ;
			        for(i=0;i< frm.length;i++) {
				        e=frm.elements[i];
				        if (e.type == 'checkbox' && e.name.indexOf("chbPOMTempItemID") != -1)
				        e.checked= actVar ;
			        }
			    }
		    </SCRIPT>
			
			    
    </form>
</body>
</html>
