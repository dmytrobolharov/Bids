<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Search.aspx.vb" Inherits="plmOnApp.Image_Search" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Image_Folder</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <style type="text/css">
            th.rgHeaderYPLM, th.rgHeader {
                padding: 0 0px !important;
            }
        </style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
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

		<uc1:Color_Wait ID="Color_Wait" runat="server" />
			<asp:Panel runat="server" ID="pnlPerm" Visible="false">
				<table style="height:50;" cellspacing="0" cellpadding="0" width="100%"  bgColor="#990000" border="1" borderColor="red">
					<tr>
						<td>
                            <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                    <td><asp:Label ID="lblPerm" runat="server" 
                                        Text="You might not have permission to access user groups using your credentials." 
                                        CssClass="fontHead" ForeColor="White"></asp:Label></td>
                                </tr>
                            </table>
                          </td>
                      </tr>
                  </table>			
			</asp:Panel>
			<asp:Panel runat="server" ID="pnlMain">		
		
			    <TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				    runat="server">
				    <tr vAlign="middle">
					    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					    <td>
					        <asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
					        <cc1:confirmedimagebutton id="imgBtnNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                            <cc1:confirmedimagebutton id="btnSaveSearch" runat="server" Message="NONE" AutoPostBack="TRUE" ></cc1:confirmedimagebutton>
					        <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    </td>
				    </tr>
			    </TABLE>
			    <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				    <tr>
					    <td>&nbsp;</td>
					    <td>&nbsp;</td>
				    </tr>
			    </table>
			    <table id="Table4" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				    height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				    <tr>
					    <td>&nbsp;<asp:label id="lblImageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Image Folder...</asp:label></td>
				    </tr>
			    </table>
                <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
                    <tr>
                        <td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
                        <td vAlign="top" width="100%">
                            <table height="45">
                                <tr><td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td></tr>
                            </table>
                        </td>
                    </tr>
                </table>
			    <TABLE class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
				    border="0">
				    <TR class="fontHead">
					    <TD align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					    <TD height="25">
						    <DIV align="left">&nbsp;
							    <asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label><asp:label id="lblPageSize" Runat="server" Visible="False" Text="25">25</asp:label></DIV>
					    </TD>
					    <TD width="20" height="25">
						    <DIV align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></DIV>
					    </TD>
					    <TD width="20" height="25">
						    <DIV align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></DIV>
					    </TD>
					    <TD width="125" height="25">
						    <DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
					    </TD>
					    <TD width="20" height="25">
						    <DIV align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></DIV>
					    </TD>
					    <TD width="20" height="25">
						    <DIV align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></DIV>
					    </TD>
					    <TD height="25">
						    <DIV align="left"><B><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;
						        <%--<asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label>--%>
						        </B>
                            </DIV>
					    </TD>
                        <td width="300" align="right">
                            <asp:RadioButtonList ID="rbViewType" RepeatDirection="Horizontal" runat="server" AutoPostBack="true">
                                <asp:ListItem Text="Thumb View" Value="T" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="List View" Value="L"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
					    <TD height="25">
						    <P align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist><asp:dropdownlist id="ddlSortBy" runat="server">
								    <asp:ListItem Value="ASC">ASC</asp:ListItem>
								    <asp:ListItem Value="DESC">DESC</asp:ListItem>
							    </asp:dropdownlist><asp:imagebutton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:imagebutton></P>
					    </TD>
				    </TR>
			    </TABLE>
			    <!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
			    <TABLE borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
				    <TR>
					    <TD vAlign="top"><asp:datalist id="Datalist2" runat="server" EnableViewState="false" RepeatDirection="Horizontal"
							    RepeatColumns="1" RepeatLayout="Table" DataKeyField="ImageId">
							    <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
								    VerticalAlign="Top" BackColor="White"></ItemStyle>
                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>								
							    <ItemTemplate>
				                    <table id="tbItem" runat="server" bordercolor='#CCCCCC' border="1" cellpadding="0" width="100%" 
				                     cellspacing="0" ><tr><td><table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" >
				                     <tr><td><asp:Label ID="lblEdit" runat="server"></asp:Label></td></tr></table></td></tr>
				                    <tr height='<%#ImageWidth%>' ><td align="center" valign="middle"><asp:Image id="imgDesign" runat="server" /></td>
				                    </tr><tr><td> <asp:PlaceHolder ID="pnlHeader" runat="server" >
				                    </asp:PlaceHolder></td></tr></table>
				                    <input type="hidden" id="txtImageVersion" runat="server" />
				                    <input type="hidden" id="txtImageFileName" runat="server" /><br/>
				     		    </ItemTemplate>
						    </asp:datalist>
                            <asp:PlaceHolder runat="server" ID="plhImagesGrid"></asp:PlaceHolder>
                        </TD>
				    </TR>
			    </TABLE>
			    <input id="imageSize" type="hidden" runat="server">
			</asp:Panel>

        <script type="text/javascript" language="javascript">
            function ColumnHidden(sender, eventArgs) {
                var tableColumns = $find("RadGridImages").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('RadGridImages', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }

            function ColumnShown(sender, eventArgs) {
                var tableColumns = $find("RadGridImages").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('RadGridImages', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }

            function RowClick(sender, eventArgs) {
                window.open('Image_Frame.aspx?IID=' + eventArgs.getDataKeyValue("ImageID"));
            }
        </script>

		</form>
	</body>
</HTML>
