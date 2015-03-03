<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_Group_Wizard_Style_Update.aspx.vb" Inherits="plmOnApp.Material_Group_Wizard_Style_Update" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td><asp:imagebutton 
					    id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><cc1:confirmedimagebutton 
					    id="btnUpdate" runat="server" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
    					id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Style</asp:label></td>
				</tr>
			</table>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="16"><asp:checkbox id="cbThumbnail" runat="server" AutoPostBack="True"></asp:checkbox></TD>
					<TD class="fontHead" width="100"><asp:Label ID="lblThumb" runat="server" Text="Thumbnail?"></asp:Label></TD>
					<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
					<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
					<TD width="10">&nbsp;</TD>
					<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
					<TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></TD>
					<TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
					        <asp:ListItem Value="1">1</asp:ListItem>
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
			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top">
						<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
								<td vAlign="top" width="100%">
									<table height="45">
										<tr>
											<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD><asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleSeasonYearID" AllowSorting="true">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
							<Columns>
							    <asp:TemplateColumn>
							        <HeaderTemplate>
							            <input type="checkbox" onclick="CheckAll(this);" />
							        </HeaderTemplate>
							        <ItemTemplate>  
							            <asp:CheckBox ID="chkSelected" runat="server" />
							        </ItemTemplate>
							    </asp:TemplateColumn>
							    <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <%# GetSystemText("Image")%>
                                    </HeaderTemplate>
							        <ItemTemplate> 
							            <asp:Image runat="server" ID="imgStyle" ImageUrl='<%# GetImageStreamPath("50", Eval("DesignSketchVersion").ToString, Eval("DesignSketchID").ToString)%>' />
							        </ItemTemplate>
							    </asp:TemplateColumn>
							</Columns>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</table>
		</form>

		<script language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
		                e.checked = actVar;
		        }
		    }
		</script>
        <script language="javascript">
            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
        </script>

	</body>
	
	</html>
