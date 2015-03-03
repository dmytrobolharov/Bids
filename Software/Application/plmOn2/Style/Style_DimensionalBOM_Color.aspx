<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_Color.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_Color" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title><%= Me.strColorway %></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">

			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:ImageButton 
					    id="btnSave" runat="server" TabIndex="100"></asp:ImageButton><asp:ImageButton
					    id="btnClose" runat="server" TabIndex="101" OnClientClick="return btnClose_Click()"></asp:ImageButton></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Select Color...</asp:label></td>
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
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="top">
					<td>
					<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
						border="0">
						<TR vAlign="middle">
							<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
							<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
							<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
							<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
							<TD width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
							<TD width="10">&nbsp;</TD>
							<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></TD>
							<TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></TD>
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
							<TD width="10"><asp:button id="Button1" runat="server" CssClass="fontHead" Text="GO"></asp:button></TD>
						</TR>
					</TABLE>
					    <asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="ColorPaletteID">
						    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
						    <PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                                <asp:TemplateColumn>
	                                <HeaderTemplate>
                                        <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
	                                </HeaderTemplate>
	                                <ItemTemplate>
		                                <asp:CheckBox id="chkSelect" runat="server"></asp:CheckBox>
	                                </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns> 
					    </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
						</td>
				</tr>
			</table>			    
    </form>
    <script type="text/javascript" language="javascript">
        var frm = document.forms['form1'];
        function SelectAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
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
