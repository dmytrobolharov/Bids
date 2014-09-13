<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder_Material_Missing.aspx.vb" Inherits="plmOnApp.Planning_Folder_Material_Missing" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Planning Color</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet"/>
        <link href="../System/CSS/jquery-ui.css" type="text/css" rel="stylesheet"/>
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            a img {border:none; outline: none;}
            .search-cell td {
            	vertical-align: top !important;
            }
        </style>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
            </Scripts>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadScriptManager>
        <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
            <StyleSheets>
                <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
            </StyleSheets>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadStyleSheetManager>
        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10">
					    <asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/>
                    </td>
					<td valign="top">
                        <cc1:confirmedimagebutton id="btnMaterialAdd" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnMaterialReplace" runat="server" message="NONE" OnClientClick="return ReplaceButtonClick();"></cc1:confirmedimagebutton>
                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    </td>
					<td></td>
				</tr>
			</table>
           	<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"><%=GetSystemText("Missing Active Materials")%></asp:label></td>
				</tr>
			</table>
            <br />
			<table cellspacing="1" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="100%">
			            <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				            <tr>
					            <td class="search-cell"><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					            <td vAlign="top" width="100%">
						            <TABLE id="Table3" height="45">
							            <TR>
								            <TD><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
							            </TR>
						            </TABLE>
					            </td>
				            </tr>
			            </table>	
			            

			            <table class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
				            <tr class="fontHead">
					            <td align="center" width="10" height="25"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                                <td width="100" runat="server" id="tdCheckAll"><input type="checkbox" /><%=GetSystemText("Select All")%></td>
					            <td height="25">
						            <div align="left">&nbsp;
							            <asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label></div>
					            </td>
					            <td width="20" height="25">
						            <div align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div>
					            </td>
					            <td width="20" height="25">
						            <div align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div>
					            </td>
					            <td width="125" height="25">
						            <div align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></div>
					            </td>
					            <td width="20" height="25">
						            <div align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div>
					            </td>
					            <td width="20" height="25">
						            <div align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div>
					            </td>
					            <td height="25">
						            <div align="left"><b><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;
						                <%--<asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label>--%>
						                </b>
                                    </div>
					            </td>
					            <td height="25">
						            <p align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist><asp:dropdownlist id="ddlSortBy" runat="server">
								            <asp:ListItem Value="ASC">ASC</asp:ListItem>
								            <asp:ListItem Value="DESC">DESC</asp:ListItem>
							            </asp:dropdownlist><asp:imagebutton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:imagebutton></p>
					            </td>
				            </tr>
			            </table>			            				
                        <asp:datalist id="DataList1" runat="server" RepeatDirection="Vertical" RepeatLayout="Flow" EnableViewState="True" DataKeyField="MaterialID" Width="100%">
                        <ItemStyle BorderWidth="0px" BorderStyle="Solid" BackColor="white" BorderColor="Gainsboro" VerticalAlign="Top" Width="100%"></ItemStyle>
	                    <ItemTemplate>
                            <table cellpadding="2" cellspacing="0" border="1" bordercolor="Gainsboro" width="100%">
                                <tr><td colspan="2"><table cellspacing="0" cellpadding="0" border="0" width="40%"><tr><td><asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder></td></tr></table></td></tr>
                                <tr>
                                    <td width="<%=ImageWidth %>"><asp:Label align="left" ID="lblMaterialData" runat="server" AssociatedControlID="materialCheck" style="display:block;"><asp:CheckBox ID="materialCheck" runat="server" /></asp:Label></td>
                                    <td Width="100%">
                                        <asp:DataList ID="DataList2" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" RepeatColumns="0" EnableViewState="True" DataKeyField="ItemID">
                                        <ItemStyle BorderWidth="1px" BorderStyle="Solid" BackColor="white" BorderColor="Gainsboro" VerticalAlign="Bottom"></ItemStyle>
                                        <ItemTemplate>
                                            <table width="<%=ImageWidth %>" height="<%=ImageWidth %>" cellpadding="0" cellspacing="0" border="0">
                                                <tr height="<%=ImageWidth-30 %>"><td><img alt="" src='<%# GetImageStreamPath(ImageWidth-30, Eval("ItemImageVersion").ToString, Eval("ItemImageID").ToString) %>' /></td></tr>
                                                <tr><td><%# Eval("ItemNo")%></td></tr>
                                                <tr><td><%# Eval("ItemName") %></td></tr>
                                            </table>
                                        </ItemTemplate>
                                        </asp:DataList>
                                    </td>
                                </tr>
                            </table>
	                    </ItemTemplate>
                        </asp:datalist>
                        </td>
                    </tr>
			</table>
            
            <div id="dialog-message" style="display: none;"><p><%= GetSystemText("Please select materials before clicking the replace material button")%></p></div>
            
            <script type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
            <script type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
            <script type="text/javascript">
                function ReplaceButtonClick() {
                    if ($("#DataList1 [id*='materialCheck']:checked").length > 0) {
                        return true;
                    }
                    else {
                        ShowReplaceMessage();
                        return false;
                    }
                }

                function ShowReplaceMessage() {
                    $("#dialog-message").dialog({
                        modal: true,
                        resizable: false,
                        buttons: {
                            Ok: function () {
                                $(this).dialog("close");
                            }
                        }
                    });
                };

                $("#tdCheckAll input").change(function () { $("#DataList1 [id*='materialCheck']").attr("checked", this.checked); });

            </script>
		</form>
	</body>
</html>
