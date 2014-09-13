<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TimeAction_TemplateTask_Detail.aspx.vb" Inherits="plmOnApp.TimeAction_TemplateTask_Detail" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Task Details</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script type="text/javascript" src="../System/Jscript/jquery-1.8.0.js"></script>
        <script type="text/javascript">

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.radWindow;
                else if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function Close() {
                var oWindow = GetRadWindow();
                oWindow.argument = null;
                oWindow.close();
                return false;
            }

            function SelectAll(sender) {
                $("input[type='checkbox'][id$='chbRecordChecked']").each(
                    function () {
                        $(this)[0].checked = sender.checked;
                    }
                )
                }

                // Resizing the window to the size of contents
                $(document).ready(function () {
                    var oWindow = GetRadWindow();

                    if (!oWindow.isClosed()) {
                        var docWidth = $(document).width();
                        var docHeight = $(document).height();

                        if (docWidth > oWindow.GetWidth()) {
                            oWindow.SetWidth(docWidth + 35);
                        }
                        if (docHeight > oWindow.GetHeight()) {
                            oWindow.SetHeight(docHeight + 35);
                        }
                        oWindow.center();
                    }
                });
        </script>
        <style type="text/css">
            .search-cell td {
            	vertical-align: top !important;
            }
        </style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" >
		
			<asp:Panel runat="server" ID="pnlMain" Width="100%">	
			
            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25" border="0">
				<tr>
					<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
                    <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnBatchUpdate" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnSaveClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return Close();"></cc1:confirmedimagebutton>
                    </td>
				</tr>
			</table>
            <!-- Header form -->
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Header</asp:label></td>
				</tr>
			</table>
            <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td class="search-cell"><asp:placeholder id="plhControl" runat="server" EnableViewState="False"></asp:placeholder></td>
                    
                </tr>
                <tr><td>&nbsp;</td></tr>
            </table>

            <!--  Batch edit form-->
            <table class="TableHeaderYellow" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr valign="middle">
				    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:Label id="LabelEdit" runat="server" Font-Names="Tahoma,Verdana"  ><%=GetSystemText("Flash Edit")%></asp:Label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgcolor="#EEEB9F" border="0">
				<tr>
                    <td>
                        <asp:placeholder id="plhBatchControlsHolder" runat="server" EnableViewState="False">
                        </asp:placeholder>
                    </td>
                </tr>
			</table>

            <!-- Search form -->
            <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
                <tr colspan="2"><td>&nbsp;</td></tr>
                <tr>
                    <td class="search-cell"><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
                    <td vAlign="top" width="100%">
                        <table height="45">
                            <tr><td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td></tr>
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
								<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
								<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
								<TD width="10">&nbsp;</TD>
								<TD noWrap height="25"><div align="left"><b>
                                   <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
                                   <asp:label id="lblRecordFound" Runat="server" />
                                 </b></div>
                                </TD>	
								<TD  width="110" align="right"><asp:label id="lblRecordPerPage" runat="server" CssClass="fontHead"></asp:label></TD>
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
								<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
							</TR>
						</TABLE>
						<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="TACalRefTaskId">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                                <asp:TemplateColumn FooterStyle-BorderStyle="None">
                                    <HeaderStyle Width="20" />
                                    <ItemStyle Width="20" BorderStyle="None" BorderColor="Gainsboro" />
                                    <HeaderTemplate>
                                        <input type="checkbox" id="chbSelectAll" onclick="SelectAll(this);" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbRecordChecked" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>
			<asp:HiddenField ID="hdnXmlFiles" runat="server" />
			<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">&nbsp;&nbsp;</asp:Panel>
		</form>
	</body>
</HTML>
