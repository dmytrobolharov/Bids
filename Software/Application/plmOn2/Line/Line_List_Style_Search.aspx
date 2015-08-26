<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="Line_List_Header.ascx" TagName="Header" TagPrefix="hc1" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Style_Search.aspx.vb" Inherits="plmOnApp.Line_List_Style_Search" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Style Search</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/jquery-ui-1.10.3.css" type="text/css" rel="stylesheet" />
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style type="text/css"">
            #RadGridStyles .rgMasterTable td {
            border-color: #ddd !important;
            }
            th.rgHeaderYPLM, th.rgHeader {
                padding: 0 0px !important;
                white-space: normal !important;
                word-wrap:break-word !important;  
            }
            .rbView
            {
                font-family: Tahoma, Geneva, Arial, Helvetica, sans-serif;
	            font-size: 11px;
	            font-weight: bold;
            }
             .imgContainer
            {
                position:relative;
            }
            .imgContainer div 
            {
                position:absolute;
                left:0;
                background-color: White;
                visibility: hidden;
            }
            .rgAltRowYPLM>td, .rgRowYPLM>td
                {   
                    white-space: normal !important;
                    word-wrap:break-word  !important;  
                }
        </style>
        <style type="text/css">
             .imgContainer
            {
                position:relative;
            }
            .imgContainer div 
            {
                position:absolute;
                background-color: White;
                left: 0px;
                visibility: hidden;
            }
        
            .imgContainer div:before,
            .frame_before {
                content: "";
                display: inline-block;
                height: 100%;
                vertical-align: middle;
            }

            .imgContainer img {
                vertical-align: middle;
            }           
        </style>
        <!--[IF IE]>
        <style type="text/css">
            .imgContainer div {
                list-style:none;
                behavior: expression(
                    function(t){
                        t.insertAdjacentHTML('afterBegin','<span class="frame_before"></span>');
                        t.runtimeStyle.behavior = 'none';
                    }(this)
                );
            }
        </style>
        <![endif]-->		
	</head>
	<body>
		<form id="Form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true" EnablePartialRendering="true">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadScriptManager>
        <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
            <StyleSheets>
                <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
            </StyleSheets>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadStyleSheetManager>
        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td>
					<asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px"></asp:imagebutton>
					<cc1:confirmedimagebutton id="btnNew" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
				    <!--<cc1:confirmedimagebutton id="btnNewStyle" runat="server" Message="NONE"></cc1:confirmedimagebutton>-->
					<cc1:confirmedimagebutton id="imgBtnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Add Existing Styles</asp:Label></td>
				</tr>
			</table>
            <hc1:Header ID="LineListHeader" runat="server" />
			<%--<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>--%>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
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
            <TABLE class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
	            border="0">
	            <TR class="fontHead">
                <TD align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></TD>
                    <td align="left" runat="server"  id="tdSelectAll" visible="true">
		                <TD width="55"><asp:Label runat="server" ID="lblChkAll">Select All</asp:Label></TD>
                        <TD width="20" height="25" align="left">
                            <asp:CheckBox onclick="SelectAll(this)" runat="server" id="checkAll"/>
                        </TD>
                    </td>
                    <td width="85" runat="server" id="tdThumbnail" visible="false">
                        <asp:CheckBox runat="server" id="chbThumbnail" AutoPostBack="true" />
                    </td>
                    
		            <TD height="25">
			            <DIV align="left">&nbsp;
				            <asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label>
                            <asp:label id="lblPageSize" Runat="server" Visible="False" Text="25">25</asp:label>
                        </DIV>
		            </TD>
		            <TD width="20"><asp:imagebutton id="btnImgFirst" OnClick="ShowFirstPage" runat="server"></asp:imagebutton></TD>
		            <TD width="20"><asp:imagebutton id="btnImgPrevious" OnClick="ShowPreviousPage" runat="server"></asp:imagebutton></TD>					
		            <TD noWrap align="center" width="125"><asp:label id="lblCounts" runat="server" CssClass="fontHead"></asp:label></TD>
		            <TD width="20"><asp:imagebutton id="btnImgNext" OnClick="ShowNextPage" runat="server"></asp:imagebutton></TD>
		            <TD width="20"><asp:imagebutton id="btnImgLast" OnClick="ShowLastPage" runat="server" ToolTip="Last"></asp:imagebutton></TD>
		            <TD width="10">&nbsp;</TD>
		            <TD noWrap height="25"><div align="left"><b>
                           <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
                           <%--<asp:label id="lblRecordFound" Runat="server" />--%>
                         </b>
                         <asp:HiddenField ID="hdnRecordCount" runat="server" Value='' />
                         </div>
                    </TD>
                    <TD align="left">
                        <asp:RadioButtonList ID="rbViewType" RepeatDirection="Horizontal" runat="server" AutoPostBack="true">
                            <asp:ListItem Text="Thumb View" Value="T" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="List View" Value="L"></asp:ListItem>
                        </asp:RadioButtonList>
                    </TD>	
		            <TD height="25">
                        <P align="right" style="margin: 0;">
                            <span id="spanSortPanel" runat="server">
                                <asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist>
				                <asp:dropdownlist id="ddlSortBy" runat="server"></asp:dropdownlist>
				                <asp:ImageButton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:ImageButton>
                            </span>
                        </P>
		            </TD>
                    <td align="right"><asp:label id="lblRecordPerPage" runat="server" CssClass="fontHead"></asp:label></td>
		            <td width="25" align="right"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
                            <asp:ListItem Value="5">5</asp:ListItem>
				            <asp:ListItem Value="10">10</asp:ListItem>
				            <asp:ListItem Value="15">15</asp:ListItem>
				            <asp:ListItem Value="20">20</asp:ListItem>
				            <asp:ListItem Value="25">25</asp:ListItem>
				            <asp:ListItem Value="30">30</asp:ListItem>
				            <asp:ListItem Value="40">40</asp:ListItem>
				            <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
			            </asp:dropdownlist></td>
		            <td width="10" align="right"><asp:button id="btnGo" OnClick="ShowFirstPage" runat="server" CssClass="fontHead" text="GO"></asp:button></td>
	            </TR>
            </TABLE>
            <asp:Panel ID="pnlStyles" runat="server"> 
                 <asp:PlaceHolder ID="plhStylesGrid" runat="server"></asp:PlaceHolder>
                 <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label> 

                <TABLE borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
	                <TR>
		                <TD vAlign="top"><asp:datalist id="Datalist1" runat="server" DataKeyField="styleSeasonYearId" RepeatLayout="Table" RepeatColumns="1"
				                RepeatDirection="Horizontal" EnableViewState="false">
				                <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" BackColor="White"></ItemStyle>
				                <ItemTemplate>
					                <table borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
						                border="0">
						                <tr>
							                <td>
								                <asp:CheckBox id="cbSelectStyle" runat="server" Text='<%#GetSystemText("Click here to select style") & "..."%>' CssClass="font"></asp:CheckBox>
							                </td>
						                </tr>
					                </table> 
					            </ItemTemplate>
				                <HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
			                </asp:datalist>
                        
                        </TD>
	                </TR>
                </TABLE>
                <input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server" />&nbsp;&nbsp;
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
            </asp:Panel>
            <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
            <script type="text/javascript">
                function showMBomStylesDialog() {
                    $("#mbom-styles-dialog").dialog({
                        autoOpen: true,
                        modal: true,
                        resizable: true,
                        draggable: false,
                        appendTo: 'form',
                        title: '<%= GetSystemText("Select BOM for styles") & "..." %>',
                        width: 'auto',
                        buttons: {
                            '<%= GetSystemText("Save") %>': function () { <%= ClientScript.GetPostBackEventReference(New PostBackOptions(btnNew, "mbom") with {.PerformValidation = True}) %>; },
                            '<%= GetSystemText("Cancel") %>': function () { $(this).dialog("close"); $('#dgMBOMStyles').remove(); }
                        }
                    });
                }
            </script>
		</form>
        
        <script type="text/javascript">
            function ColumnHidden(sender, eventArgs) {
                var tableColumns = $find("RadGridStyles").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('RadGridStyles', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }

            function ColumnShown(sender, eventArgs) {
                var tableColumns = $find("RadGridStyles").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('RadGridStyles', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }
            </script>
        <script type="text/javascript" language="javascript">
            window.onload = SetImageHoverEffects;

            function SetImageHoverEffects() {
                var width = 0;
                var height = 0;

                var intervalHandlers = new Array();

                $(".imgContainer").each(function (index) {
                    $(this).attr("id", index);

                    var hasDesignBack = false;

                    hasDesignBack = $(this).find(".imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1;

                    if (hasDesignBack) {
                        width = Math.max(width, Math.max($(this).find(".imgDesign").width(), $(this).find(".imgDesignBack").width()));
                        height = Math.max(height, Math.max($(this).find(".imgDesign").height(), $(this).find(".imgDesignBack").height()));
                    }

                    else {
                        width = Math.max(width, $(this).find(".imgDesign").width());
                        height = Math.max(height, $(this).find(".imgDesign").height());
                    }

                    $(this)
                    .mouseover(function () {
                        if (hasDesignBack) {
                            $(this).find(".imgDesignContainer").fadeOut();
                            clearInterval(intervalHandlers[$(this).attr("id")]);
                            var elementToToggle = $(this).find(".imgDesignContainer");
                            intervalHandlers[$(this).attr("id")] = setInterval(function () {
                                elementToToggle.fadeToggle()
                            }, 1200);
                        }
                    })
                    .mouseleave(function () {
                        if (hasDesignBack) {
                            clearInterval(intervalHandlers[$(this).attr("id")]);
                            $(this).find(".imgDesignContainer").fadeIn();
                        }
                    });
                });

                $(".imgContainer").css({
                    "width": width,
                    "height": height
                });

                $(".imgDesignBackContainer").css({
                    "width": width,
                    "height": height
                });

                $(".imgDesignContainer").css({
                    "width": width,
                    "height": height
                });

                $(".imgContainer").each(function (index) {
                    $(this).find(".imgDesignContainer").css("visibility", "visible");

                    if ($(this).find(".imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1) {
                        $(this).find(".imgDesignBackContainer").css("visibility", "visible");
                    }
                });
            };
            var frm = document.Form1;
            function SelectAll(checkAllBox) {
                var actVar = checkAllBox.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox')
                        e.checked = actVar;
                }
            }
            function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
        <script type="text/javascript">
            var fs = window.top.document.getElementsByTagName("frameset");
            for (var i = 0; i < fs.length; i++) fs[i].rows = fs[i].rows;
        </script>
	</body>
</html>
