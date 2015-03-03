<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder_Material.aspx.vb" Inherits="plmOnApp.Planning_Folder_Material" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Planning Color</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet"/>
        <link href="../System/CSS/toastr.min.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/jquery-ui.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <style type="text/css">
            a img {border:none; outline: none;}
            .search-cell td {
            	vertical-align: top !important;
            }
            th.rgHeaderYPLM, th.rgHeader {
                padding: 0 0px !important;
            }
            .material-chip {
        	    display: block;
        	    width: 60px;
        	    height: 60px;
            }
        
            .material-item {
        	    /*float: left;*/
        	    padding: 2px 10px 10px 2px;
        	    /*border: 1px solid #eee;*/
            }
        </style>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
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
                        <cc1:BWImageButton id="btnImportMaterial" runat="server" CausesValidation="false"></cc1:BWImageButton>
                        <cc1:confirmedimagebutton id="btnMaterialAdd" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnAllocation" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnMaterialDrop" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnSetActive" runat="server" ></cc1:confirmedimagebutton>
                        <cc1:ConfirmedImageButton ID="btnMaterialRemove" runat="server"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnWhereUsed" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>  
                        <cc1:BWImageButton id="btnSort" runat="server" Message="NONE" ></cc1:BWImageButton>
                    </td>
					<td></td>
				</tr>
			</table>
            <TABLE  id="MissingColorAlert" cellSpacing="0" cellPadding="2" width="100%" border="1" bgColor="#cddeee" borderColor="#0061fe" runat="server" visible="false">
				<tr><td>
                    <table cellpadding="0" cellspacing="0" border="0">
                    <TR vAlign="middle" align="left" height="24">
				    <TD vAlign="middle" align="left" width="24">
                        <img alt="" src="../System/Icons/icon_info_32.gif" align="absMiddle" />
                    </TD>
                    <td>
                        <asp:label ID="Label1" runat="server" Font-Bold="true"><%=GetSystemText("As many as") & " "%></asp:label>
                        <asp:label ID="MissingText" runat="server" Font-Bold="true" ForeColor="Red"></asp:label>
                        <asp:label ID="Label2" runat="server" Font-Bold="true">
                            <%=" " & GetSystemText("materials exist outside this plan.")%>
                            <a href='<%= String.Format("Planning_Folder_Material_Missing.aspx?PLID={0}&SYID={1}", strPlanningId, strSeasonYearId) %>' id="MissingLink" target="_blank" style="color:Blue;" ><%=" " & GetSystemText("Click here for more details!")%></a>
                        </asp:label>
                    </td>
			        </TR>
                    </table>
                </td></tr>
			</TABLE>	
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
                                <td width="100" runat="server" id="tdCheckAll"><input type="checkbox" onclick="SelectAll(this, 'materialCheck')" /><%=GetSystemText("Select All")%></td>
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
					
			            <table bordercolor="gainsboro" cellspacing="1" cellpadding="0" border="0" width="100%" id="test">
				            <tr>
					            <td valign="top">
                                <asp:HiddenField ID="hdnDatalistContrainerWidth" runat="server" Value='<%# Eval("PlanningMaterialID") %>' />
                                <asp:HiddenField ID="hdnDatalistItemWidth" runat="server" Value='<%# Eval("PlanningMaterialDrop") %>' />
                                <asp:datalist id="DataList1" runat="server" RepeatLayout="Flow" EnableViewState="True" DataKeyField="MaterialID">
	                                <ItemStyle BorderWidth="1px" BorderStyle="Solid" BackColor="White" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
	                                <ItemTemplate>
                                        <div style="float:left;">
                                            <asp:HiddenField ID="hdnPlanningMaterialID" runat="server" Value='<%# Eval("PlanningMaterialID") %>' />
                                            <asp:HiddenField ID="hdnPlanningMaterialDrop" runat="server" Value='<%# Eval("PlanningMaterialDrop") %>' />
                                            <table>
                                                <tr><td><asp:Label ID="lblMessage" runat="server"></asp:Label></td></tr>
                                                <tr>
                                                    <td>
		                                                <asp:Label align="left" ID="lblMaterialData" runat="server" AssociatedControlID="materialCheck" style="display:block;">
		                                                <asp:CheckBox ID="materialCheck" runat="server" /> 
		                                                </asp:Label>
		                                                <asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder>
		                                                <br/>
                                                    </td>
                                                    <%--<td>
                                                        <asp:Label ID="lblColorCode" runat="server" Width="120" CssClass="font" /><br />
                                                        <asp:Label ID="lblColorName" runat="server" Width="120" CssClass="font" />
                                                        <asp:HiddenField ID="hdnColorPaletteID" runat="server" Value='<% Eval("ColorPaletteID") %>' />
                                                    </td>--%>
                                                </tr>
                                            </table>
                                        </div>
	                                </ItemTemplate>
                                </asp:datalist>
                                <asp:PlaceHolder runat="server" ID="plhMaterialsGrid"></asp:PlaceHolder>
                                </td>
				            </tr>
			            </table>
			            <input id="imageSize" type="hidden" runat="server" />
                        </td>
                    </tr>
			</table>
        
        <div id="dialog-message" title="<%= strMessageTitle %>" style="display: none;">
            <p><%= strMessageFirst%>:</p>
            <p style="background-color: White;">
                <asp:DataList ID="dlMaterials" runat="server" DataKeyField="PlanningMaterialID" RepeatLayout="Flow" RepeatDirection="Horizontal">
                    <ItemStyle CssClass="material-item" Height="70px" />
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <label style='<%# String.Format("background-image:url({0})", GetImageStreamPath("60", Eval("MaterialImageVersion").ToString, Eval("MaterialImageID").ToString))%>' class="material-chip">
                                </td>
                            </tr>
                            <tr><td><label style="font-size: 11px;"><%# Eval("MaterialNo")%></label></td></tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </p>
            <p><%= strMessageSecond %></p>
        </div>	
			
        <script type="text/javascript" language="javascript">
            $(document).ready(function () {
                $("#DataList1 br").remove();
                var max = 0;
                $("#DataList1 span div").each(function () {
                    max = Math.max($(this).height(), max);
                }).height(max);
            });

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

            function reloadParentPage() {
                var currentPageLocation = window.location.href;
                window.parent.location.href = currentPageLocation.replace('Planning_Folder_Material.aspx', 'Planning_FlashEdit_Material.aspx');
                return false;
            }

            function ColumnHidden(sender, eventArgs) {
                var tableColumns = $find("RadGridMaterials").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('RadGridMaterials', '<%= aspxPageName & "?PLID=" & strPlanningId %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }

            function ColumnShown(sender, eventArgs) {
                var tableColumns = $find("RadGridMaterials").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('RadGridMaterials', '<%= aspxPageName & "?PLID=" & strPlanningId %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }
        </script>

        
        <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
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

            function ShowMaterialMessage() {
                $("#dialog-message").dialog({
                    modal: true,
                    resizable: false,
                    width: 410,
                    buttons: {
                        Ok: function () {
                            $(this).dialog("close");
                        }
                    }
                });
            };

        </script>

        </form>
	</body>
</html>
