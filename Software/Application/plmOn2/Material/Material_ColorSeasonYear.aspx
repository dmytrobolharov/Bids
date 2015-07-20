<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_ColorSeasonYear.aspx.vb" Inherits="plmOnApp.Material_ColorSeasonYear" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title>Seasonal Color</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        
	</HEAD>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" encType="multipart/form-data" runat="server" defaultbutton="imgBtnSearch" defaultfocus="Form1">
			        <input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td valign="top">
					<cc1:bwimagebutton id="btnColorAdd" runat="server" ></cc1:bwimagebutton>
					<cc1:bwimagebutton id="btnColorRemove" runat="server"></cc1:bwimagebutton>
                    <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                    </td>
					<td width="75">&nbsp;</td>
					<td align="right"></td>
				</TR>
			</TABLE>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" 
                            Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
            <table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgcolor="White">
					
					<td width="900"  >&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
            <table cellSpacing="0" cellPadding="0" width="100%" border="0" class="TableHeader">
				<tr>
					<td align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>&nbsp;<asp:Label ID="lblColorSearch" runat="server" Text=""></asp:Label></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<TR>
								<TD>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
							</TR>
						</table>
					</td>
				</tr>
			</table>            


		<script language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		</script>
            <asp:HiddenField ID="hdnCurrentIndex" runat="server" Value="0" />
            <asp:HiddenField ID="hdnPageSize" runat="server" Value="50" />
	        <table id="Table2" border="0" cellpadding="0" cellspacing="0" class="TableHeader" height="25" width="100%">
                <tr vAlign="middle">
                    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
                    <td width="20"><asp:imagebutton id="btnImgFirstRecord" runat="server" ImageUrl="../System/Icons/icon_first.gif" ></asp:imagebutton></td>
                    <td width="20"><asp:imagebutton id="btnImgPreviousRecord" runat="server" ImageUrl="../System/Icons/icon_Previous.gif" ></asp:imagebutton></td>
                    <td noWrap align="center" width="125"><asp:Label ID="lblCounts" Runat="server" CssClass="plaintable"></asp:Label></td>
                    <td width="20"><asp:imagebutton id="btnImgNextRecord" runat="server" ImageUrl="../System/Icons/icon_next.gif" ></asp:imagebutton></td>
                    <td width="20"><asp:imagebutton id="btnImgLastRecord" runat="server" ImageUrl="../System/Icons/icon_last.gif" ></asp:imagebutton></td>
                    <TD width="10">&nbsp;</TD>
                    <td noWrap>
                        <asp:Label ID="lblRecordCount" Runat="server" Visible="true"></asp:Label>
                        <asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label>
                    </td>
                    <td align="right" noWrap>
                        <asp:DropDownList ID="ddlSortField" runat="server">
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlSortBy" runat="server">
                            <asp:ListItem Value="ASC">ASC</asp:ListItem>
                            <asp:ListItem Value="DESC">DESC</asp:ListItem>
                        </asp:DropDownList>
                        <asp:ImageButton ID="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif" />
                    </td>
                </tr>
            </table>
            <table border="0" bordercolor="gainsboro" cellpadding="0" cellspacing="1">
                <tr>
                    <td valign="top">
                        <asp:DataList ID="Datalist1" runat="server" DataKeyField="MaterialColorId" EnableViewState="false"
                            RepeatColumns="1" RepeatDirection="Horizontal" RepeatLayout="Table">
                            <ItemStyle BackColor="White" BorderColor="Gainsboro" BorderStyle="Solid"
                                BorderWidth="0px" HorizontalAlign="Left" VerticalAlign="Top" />
                            <ItemTemplate>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:DataList>
                    </td>
                </tr>
            </table>
	
			
		</form>
		</body>
</HTML>
