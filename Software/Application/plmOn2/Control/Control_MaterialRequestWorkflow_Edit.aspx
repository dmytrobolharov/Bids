<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_MaterialRequestWorkflow_Edit.aspx.vb" Inherits="plmOnApp.Control_MaterialRequestWorkflow_Edit" %>

<%@ Register Assembly="YSTab" Namespace="Yunique.WebControls.YSTab" TagPrefix="cc2" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Material Request Workflow</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD ><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                            <cc1:bwimagebutton id="btnGroup" runat="server"></cc1:bwimagebutton>
                            <cc1:confirmedimagebutton id="btnRemove" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                            <cc1:confirmedimagebutton id="btnSaveClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>

                            </TD>
					 
                    <td width="3"></td>        
                    <td valign="middle" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>        
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="50"> <asp:label id="lblSortBy" Runat="server" CssClass="font" 
                                        Font-Bold="True"><b>&nbsp;&nbsp;</b></asp:label></td>
                                <td><asp:dropdownlist id="ddlSortBy" Runat="server" /></td>
                                <td width="3"></td>
                                <td>
                                    <cc1:ConfirmedImageButton ID="btnSort" runat="server" 
                                         Message="NONE" />
                                </td>                                                            
                            </tr>
                        </table>
                    </td>
                    <td></td>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>	
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
						<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
								<TD noWrap align="center" width="175"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
								<TD width="10">&nbsp;</TD>
								<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD class="fontHead" align="right" width="110">
                                    <asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
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
								<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></TD>
							</TR>
						</TABLE>
						<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="MaterialRequestWorkflowItemID">
							<AlternatingItemStyle Height="25px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="25px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid>
                        <table cellspacing="0" cellpadding="0" border="0" 
                            style="height: 28px; width: 100%">
                            <tr class="TableHeader">
                                <td valign="middle" align="center" width="10">
                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                </td>
                                <td width="50" align="right">
                                    <asp:DropDownList ID="ddlAdd" runat="server" CssClass="fontHead">
                                        <asp:ListItem Text="0" Value="0">
                                        </asp:ListItem>
                                        <asp:ListItem Text="1" Value="1" Selected="True">
                                        </asp:ListItem>
                                        <asp:ListItem Text="5" Value="5">
                                        </asp:ListItem>
                                        <asp:ListItem Text="10" Value="10">
                                        </asp:ListItem>
                                        <asp:ListItem Text="15" Value="15">
                                        </asp:ListItem>
                                        <asp:ListItem Text="20" Value="20">
                                        </asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td width="50">
                                    <cc1:ConfirmedImageButton ID="btnAdd" runat="server" 
                                        Message="NONE" />
                                </td>
                                <td></td>
                                                    

                            </tr>
                        </table>
                    <asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>
            <asp:HiddenField ID="hdnXmlFiles" runat="server" />
		</form>
	</body>
</HTML>
