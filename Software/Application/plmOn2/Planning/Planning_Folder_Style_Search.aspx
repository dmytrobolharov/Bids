<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder_Style_Search.aspx.vb" Inherits="plmOnApp.Planning_Folder_Style_Search" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style Search</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet"/>
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet"/>
        <link href="../System/CSS/jquery-ui-1.10.3.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />    
		<script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>		
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td>
					<asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px"></asp:imagebutton>
					<cc1:confirmedimagebutton id="btnAdd" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                    <cc1:ConfirmedImageButton ID="btnCopy" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
					<cc1:confirmedimagebutton id="imgBtnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Style</asp:Label></td>
				</tr>
			</table>
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
            <table class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
	            border="0">
	            <tr class="fontHead">
		            <td align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
                    <td height="25">
                        <div align="left"><asp:CheckBox runat="server" id="chkSelectAll" LabelAttribute="class:fonthead;" onclick="CheckAll(this)"/></div>
                    </td>
		            <td height="25">
			            <div align="left">&nbsp;
				            <asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label><asp:label id="lblPageSize" Text="10" Visible="False" Runat="server">10</asp:label>
                        </div>
		            </td>
		            <td width="20"><asp:imagebutton id="btnImgFirst" OnClick="ShowFirstPage" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgPrevious" OnClick="ShowPreviousPage" runat="server"></asp:imagebutton></td>					
		            <td noWrap align="center" width="125"><asp:label id="lblCounts" runat="server" CssClass="fontHead"></asp:label></td>
		            <td width="20"><asp:imagebutton id="btnImgNext" OnClick="ShowNextPage" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgLast" OnClick="ShowLastPage" runat="server" ToolTip="Last"></asp:imagebutton></td>
		            <td width="10">&nbsp;</td>
		            <td noWrap height="25"><div align="left"><b>
                           <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
                           <asp:label id="lblRecordFound" Runat="server" />
                         </b></div>
                    </td>	
		            <td height="25">
			            <p align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist>
				            <asp:dropdownlist id="ddlSortBy" runat="server">
					            <asp:ListItem Value="ASC">ASC</asp:ListItem>
					            <asp:ListItem Value="DESC">DESC</asp:ListItem>
				            </asp:dropdownlist>
				            <asp:ImageButton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:ImageButton></P>
		            </td>
	            </tr>
            </table>
            <table borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
	            <tr>
		            <td vAlign="top"><asp:datalist id="Datalist1" runat="server" DataKeyField="StyleId" RepeatLayout="Table" RepeatColumns="1"
				            RepeatDirection="Horizontal" EnableViewState="false">
				            <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" BackColor="White"></ItemStyle>
				            <ItemTemplate>
				            </ItemTemplate>
				            <HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
			            </asp:datalist></td>
	            </tr>
            </table>
            <div id="mbom-styles-dialog">                
                <asp:DataGrid ID="dgMBOMStyles" runat="server" AllowSorting="false" DataKeyField="StyleID" AllowPaging="false" EnableViewState="true">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                        <asp:TemplateColumn Visible="false"></asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </div>
            <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
            <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
            <script type="text/javascript">
                var frm = document.Form1;
		        function CheckAll(checkAllBox) {
		            var actVar = checkAllBox.checked;
		            for (i = 0; i < frm.length; i++) {
		                e = frm.elements[i];
		                if (e.type == 'checkbox' && e.id.indexOf("chkSelectStyle") != -1)
		                    e.checked = actVar;
		            }
		        }

                function showMBomStylesDialog() {
                    $("#mbom-styles-dialog").dialog({
                        autoOpen: true,
                        modal: true,
                        resizable: true,
                        draggable: false,
                        appendTo: 'form',
                        title: '<%= GetSystemText("Select BOM for styles") & "..." %>',
                        width: 400,
                        buttons: {
                            '<%= GetSystemText("Save") %>': function () { <%= ClientScript.GetPostBackEventReference(btnAdd, "mbom") %>; },
                            '<%= GetSystemText("Cancel") %>': function () { $(this).dialog("close"); }
                        }
                    });
                }
            </script>
		</form>
	</body>
</html>
