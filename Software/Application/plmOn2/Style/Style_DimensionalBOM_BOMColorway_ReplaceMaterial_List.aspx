<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DimensionalBOM_BOMColorway_ReplaceMaterial_List.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_BOMColorway_ReplaceMaterial_List" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head runat="server">
		<title></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body MS_POSITIONING="GridLayout">
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
                        <cc1:confirmedimagebutton id="btnReplace" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                        <cc1:ConfirmedImageButton ID="btnReplaceAll" runat="server" Message="NONE" />
                        <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="window.close(); return false;"></cc1:confirmedimagebutton>
                    </td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="1" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top">
						<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="top">
					<td>
						<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<tr valign="middle">
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td width="16"><asp:checkbox id="cbThumbnail" runat="server" AutoPostBack="True"></asp:checkbox></td>
								<td class="fontHead" width="100">
                                    <asp:Label ID="lblThumbnail" runat="server" ></asp:Label></td>
								<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
								<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
								<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
								<td width="10">&nbsp;</td>
								<td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
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
								<td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
							</tr>
						</table>
						<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="false"></asp:placeholder></td>
								<td valign="top" width="100%">
									<table height="45">
										<tr>
											<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="MaterialID" BorderStyle="Solid" BorderWidth="1px">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
							<Columns>
							    <asp:TemplateColumn>
							        <HeaderTemplate>
							            &nbsp;
							        </HeaderTemplate>
									<ItemTemplate>
										<input type="radio" id="rdbSelected" name="rdbSelected" value='<%# DataBinder.Eval(Container.DataItem, "MaterialID").ToString() %>' />
									</ItemTemplate>							        
							    </asp:TemplateColumn>
							    							
                            </Columns>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></td>
				</tr>
			</table>
		</form>
		<SCRIPT language="javascript">
			var frm = document.Form1 ;
			function CheckAll( checkAllBox )
			{
			var actVar = checkAllBox.checked ;
			for(i=0;i< frm.length;i++)
			{
				e=frm.elements[i];
				if ( e.type=='checkbox' && e.name.indexOf("chkSelected") != -1 )
				e.checked= actVar ;
			}
			}
		</SCRIPT>
	</body>
</html>
