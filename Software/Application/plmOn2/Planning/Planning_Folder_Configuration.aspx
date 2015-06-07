<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder_Configuration.aspx.vb" Inherits="plmOnApp.Planning_Folder_Configuration" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Planning Style Configuration</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle" align="left">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
                    <td align="left">
					    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" Visible="True"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnSaveClose" runat="server" Message="NONE" Visible="True"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnBatchUpdate" runat="server" Message="NONE" Visible="True" CausesValidation="false"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnClose" runat="server" visible="true" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
                    </td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
				</tr>
			</table>			
			<table class="TableHeaderYellow" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr valign="middle">
				    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:Label id="LabelEdit" runat="server" Font-Names="Tahoma,Verdana"  ></asp:Label></td>
				</tr>
			</table>
			<table id="BatchTable" runat="server" cellspacing="0" cellpadding="0" width="100%" bgcolor="#EEEB9F" border="0">
				<tr>
					<td>
                        <asp:placeholder id="plhEditControlsHolder" runat="server"
                            EnableViewState="False" ></asp:placeholder>
                    </td>
                    <td>&nbsp;</td>
				</tr>
			</table>
            <table class="TableHeaderBlue" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr valign="middle">
				    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:Label id="LabelSearch" runat="server" Font-Names="Tahoma,Verdana" ></asp:Label></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder><br /></td>
					<td width="100%" valign="top">
						<table>
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" CausesValidation="false"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

            <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	            <TR vAlign="top">
		            <TD>
			            <TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <TR vAlign="middle">
					            <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
                                <TD nowrap width="30">&nbsp;</TD>
					            <TD width="20"><asp:imagebutton id="btnImgFirst" runat="server" CausesValidation="false"> </asp:imagebutton></TD>
					            <TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server" CausesValidation="false"></asp:imagebutton></TD>
					            <TD noWrap align="center" width="200"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					            <TD width="20"><asp:imagebutton id="btnImgNext" runat="server" CausesValidation="false"></asp:imagebutton></TD>
					            <TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last" CausesValidation="false"></asp:imagebutton></TD>
					            <TD width="10">&nbsp;</TD>
					            <TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
                                <td width="100%"></td>
					            <TD class="fontHead" align="right" width="110" nowrap><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
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
					            <TD width="10"><asp:button id="Button1" runat="server" onclick="RePage" CssClass="fontHead" CausesValidation="false"></asp:button></TD>
				            </TR>
			            </TABLE>
			            <asp:datagrid id="DataGrid1" runat="server" AllowSorting="false" DataKeyField="PlanningConfigID">
				            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				            <ItemStyle CssClass="ItemTemplate"></ItemStyle>
				            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				            <PagerStyle Visible="False"></PagerStyle>	
				            <Columns>
				                <asp:TemplateColumn Visible="True">
				                    <HeaderTemplate>
				                        <asp:CheckBox ID="cbSelectAll" OnClick="CheckAll(this);" AutoPostBack="False" runat="server"></asp:CheckBox>
				                    </HeaderTemplate> 
				                    <ItemTemplate>
				                        <asp:CheckBox ID="chbSelectRow" name="chbSelectRow" runat="server"></asp:CheckBox>
                                        <asp:HiddenField ID="hdnDivisionID" runat="server" Value='<%# Eval("DivisionID") %>' />
                                        <asp:HiddenField ID="hdnStyleTypeID" runat="server" Value='<%# Eval("StyleTypeID") %>' />
                                        <asp:HiddenField ID="hdnStyleCategoryID" runat="server" Value='<%# Eval("StyleCategoryID") %>' />
                                        <asp:HiddenField ID="hdnSubCategoryID" runat="server" Value='<%# Eval("SubCategoryID") %>' />
				                    </ItemTemplate>
				                </asp:TemplateColumn>
				            </Columns> 						
			            </asp:datagrid><asp:HiddenField id="SortOrder" runat="server"></asp:HiddenField></TD>
	            </TR>
            </TABLE>

    </form>
    <script language="javascript" type="text/javascript"  >
		var frm = document.Form1 ;
		function CheckAll(checkAllBox) {
		    var actVar = checkAllBox.checked;
		    for (i = 0; i < frm.length; i++) {
		        e = frm.elements[i];
		        if (e.type == 'checkbox' && e.name.indexOf('chbSelectRow') != -1) {
		            e.checked = actVar;
		        }
		    }
		}
        function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
