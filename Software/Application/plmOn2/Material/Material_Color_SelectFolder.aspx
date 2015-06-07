<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_Color_SelectFolder.aspx.vb" Inherits="plmOnApp.Material_Color_SelectFolder" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title ><%= GetSystemText("Select Color Folder")%></title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />    
	<link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <script language="JavaScript">
		if (window.screen) {
			var aw = screen.availWidth;
			var ah = screen.availHeight;
			window.moveTo(0, 0);
			window.resizeTo(aw, ah);
		}
		if (self != top) top.location.replace(self.location);				
	</script>    
</head>

<body scroll="auto">
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">

    <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		runat="server">
		<tr vAlign="middle">
			<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			<td width="80"><asp:ImageButton id="btnClose" runat="server" OnClientClick="return btnClose_Click()" ></asp:ImageButton></td>
			<td width="80"></td>
			<td width="80"></td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
		<tr>
			<td>
				<table id="Table1" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
					height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td>&nbsp;
							<asp:label id="lblHeader" runat="server" ForeColor="Silver" 
                                Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<cc3:YSTabView ID="YSTabView1" runat="server"></cc3:YSTabView>
    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
	    <tr vAlign="top">
		    <td>
			    <table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				    border="0">
				    <tr vAlign="middle">
					    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					    <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
					    <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
					    <td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
					    <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
					    <td width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></td>
					    <td width="10">&nbsp;</td>
					    <td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
					    <td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></td>
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
					    <td width="10"><asp:button id="Button1" runat="server" CssClass="fontHead" Text="GO"></asp:button></td>
				    </tr>
			    </table>
			    <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				    <tr>
					    <td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
					    <td vAlign="top" width="100%">
						    <table height="45">
							    <tr>
								    <td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							    </tr>
						    </table>
					    </td>
				    </tr>
			    </table>
			    
			        <asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="ColorFolderID">
				        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				        <PagerStyle Visible="False"></PagerStyle>
			        </asp:datagrid>
			    
			    <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			    <input type ="hidden" runat="server" id="hdnPageCount" />
			    <input type ="hidden" runat="server" id="hdnResultCount" />
			    </td>
	    </tr>
    </table>
    <asp:HiddenField ID="hdnXmlFile" runat="server" />
    </form>
        <script  language="javascript" type="text/javascript">
                    function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
                    }
        </script>
</body>
</html>
