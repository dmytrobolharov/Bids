<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder_Color.aspx.vb" Inherits="plmOnApp.Planning_Folder_Color" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Planning Color</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet"/>
        <link href="../System/CSS/toastr.min.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style type="text/css">
            a img {border:none; outline: none;}
            .search-cell td {
            	vertical-align: top !important;
            }

            th.rgHeaderYPLM, th.rgHeader {
                padding: 0 0px !important;
            }
            td.font{white-space: normal;}
            #DataList1 > span {
            	vertical-align: top;
            }
        </style>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script type="text/javascript">
            function reloadParentPage() {
                window.parent.reloadPage(window.location.href.replace('Planning_Folder_Color.aspx', 'Planning_FlashEdit_Color.aspx'));
                return false;
            }
        </script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch" defaultfocus="Form1">
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
                        <cc1:BWImageButton id="btnImportColor" runat="server" CausesValidation="false"></cc1:BWImageButton>
                        <cc1:BWImageButton id="btnColorAdd" runat="server" CausesValidation="false"></cc1:BWImageButton>
                        <cc1:confirmedimagebutton id="btnAllocation" runat="server" Message="NONE" OnClientClick="return reloadParentPage()"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnColorDrop" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnSetActive" runat="server" ></cc1:confirmedimagebutton>
                        <cc1:ConfirmedImageButton ID="btnColorRemove" runat="server"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnWhereUsed" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>  
                        <cc1:confirmedimagebutton id="btnExcelExport" runat="server"  Message="NONE" OnClientClick="enable_close_link();"></cc1:confirmedimagebutton>
                    </td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Line Plan Folder...</asp:label></td>
				</tr>
			</table>
            <hc1:Planning_Header ID="PlanningHeader" runat="server" />
            <br />
            <%--<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>	--%>
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
                                <td width="100" runat="server" id="tdCheckAll"><input type="checkbox" onclick="SelectAll(this, 'colorCheck')" /><%=GetSystemText("Select All")%></td>
					            <td height="25">
						            <div align="left">&nbsp;
							            <asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label>
                                        <asp:Label ID="lblPageSize" Runat="server" Text="25" Visible="False"></asp:Label>
                                        </div>
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
                                        <asp:HiddenField ID="hdnRecordCount" runat="server" Value='' />
                                    </div>
					            </td>
                                <td width="300" align="right">
                                    <asp:RadioButtonList ID="rbViewType" RepeatDirection="Horizontal" runat="server" AutoPostBack="true">
                                        <asp:ListItem Text="Thumb View" Value="T" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="List View" Value="L"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
<%--					            <td height="25">
						            <p align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist><asp:dropdownlist id="ddlSortBy" runat="server">
								            <asp:ListItem Value="ASC">ASC</asp:ListItem>
								            <asp:ListItem Value="DESC">DESC</asp:ListItem>
							            </asp:dropdownlist><asp:imagebutton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:imagebutton></p>
					            </td>--%>
                                <td height="25">
                                    <p align="right" style="margin: 0;">
                                        <span id="spanSortPanel" runat="server">
                                            <asp:DropDownList ID="ddlSortField" runat="server"></asp:DropDownList>
                                            <asp:DropDownList ID="ddlSortBy" runat="server"></asp:DropDownList>
                                            <asp:ImageButton ID="btnSort" runat="server" CausesValidation="false" ImageUrl="../System/Icons/icon_sort.gif" />
                                        </span>
                                    </p>
                                </td>
                                <TD  align="right"><asp:label id="lblRecordPerPage" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="25" align="right"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
									</asp:dropdownlist></TD>
								<TD width="10" align="right"><asp:button id="btnGo" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
				            </tr>
			            </table>			            				
				
                        <asp:datalist id="DataList1" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" EnableViewState="True" DataKeyField="ColorPaletteID">
	                        <ItemStyle BorderWidth="1px" BorderStyle="Solid" BackColor="white" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
	                        <ItemTemplate>
                                <asp:HiddenField ID="hdnPlanningColorID" runat="server" Value='<%# Eval("PlanningColorID") %>' />
                                <asp:HiddenField ID="hdnPlanningColorDrop" runat="server" Value='<%# Eval("PlanningColorDrop") %>' />
                                <table width="170px">
                                    <tr><td><asp:Label ID="lblMessage" runat="server"></asp:Label></td></tr>
                                    <tr>
                                        <td>
                                            <div style="width:170px">
		                                    <asp:Label align="left" ID="colorChip" runat="server" AssociatedControlID="colorCheck" style="display:block;">
		                                    <asp:CheckBox ID="colorCheck" runat="server" /> 
		                                    </asp:Label>
		                                    <asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder>
		                                    </div>
                                        </td>
                                    </tr>
                                </table>
	                        </ItemTemplate>
                        </asp:datalist>
                        <asp:PlaceHolder runat="server" ID="plhColorsGrid"></asp:PlaceHolder>			                    
                        <script type="text/javascript">
                            $("#DataList1 td:has([id*=lbl]):has([id*=hdr])").removeAttr("width");
                            $("#DataList1 [id*=hdr]").removeAttr("width");
                            Sys.Application.add_load(function () {
                                function resizeByRows() {
                                    var height = 0, groups = {};
                                    $("#DataList1 > span").each(function () {
                                        var $this = $(this), top = $this.position().top;
                                        groups[top] = groups[top] || { elems: $(), height: 0 };

                                        groups[top].elems = groups[top].elems.add($this);
                                        groups[top].height = Math.max(groups[top].height, $(this).height());
                                    });

                                    $.each(groups, function (top, e) {
                                        if (e.height > <%= ImageWidth %>) {
                                            e.elems.height(e.height);
                                        }
                                    });
                                }

                                resizeByRows();
                                $(window).on('resize', function () {
                                    $("#DataList1 > span").height("auto");
                                    resizeByRows();
                                })
                            });
                        </script>
			            <input id="imageSize" type="hidden" runat="server" />
                        </td>
                    </tr>
			</table>
	
			
        <script type="text/javascript" language="javascript">
            var frm = document.Form1;
            function SelectAll(checkAllBox, namePiece) {
                var actVar = checkAllBox.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox' && e.name.indexOf(namePiece) != -1)
                        e.checked = actVar;
                }
            }

            function ShowHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnCol').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'block';
                return false;
            }

            function HideHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnExp').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'none';
                return false;
            }



            function ColumnHidden(sender, eventArgs) {
                var tableColumns = $find("RadGridColors").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('RadGridColors', '<%= aspxPageName & "?PLID=" & strPlanningId %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }

            function ColumnShown(sender, eventArgs) {
                var tableColumns = $find("RadGridColors").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('RadGridColors', '<%= aspxPageName & "?PLID=" & strPlanningId %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }
        </script>
    
        <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="../System/Jscript/toastr.min.js"></script>

        <script type="text/javascript">

            toastr.options = {
                "closeButton": true,
                "debug": false,
                "positionClass": "toast-bottom-right",
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "0",
                "extendedTimeOut": "0",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }

        </script>

		</form>
	</body>
</html>
