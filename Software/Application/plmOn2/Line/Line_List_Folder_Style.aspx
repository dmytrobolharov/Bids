<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_Style.aspx.vb" Inherits="plmOnApp.Line_List_Folder_Style" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Line Item</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />

    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
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
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1"></telerik:RadAjaxManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>            
            <telerik:RadWindow ID="AddSeasonalColor" runat="server" Title="Add Color" Height="500px" Width="700px"
                ReloadOnShow="true" ShowContentDuringLoad="false" NavigateUrl="Line_List_Folder_Style_SeasonalColorAdd.aspx"
                Behaviors="Close" IconUrl="../System/Icons/icon_table.gif" KeepInScreenBounds="true" Modal="true" />
        </Windows>
    </telerik:RadWindowManager>

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnGoToStyle" runat="server" ></cc1:bwimagebutton><cc1:confirmedimagebutton id="btn_drop" runat="server" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnDelete" runat="server" ></cc1:confirmedimagebutton>
						<cc1:BWImageButton id="btnNewIssue" runat="server" Message="NONE" CausesValidation="False"></cc1:BWImageButton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton><asp:textbox id="txtStatus" runat="server" Visible="False"></asp:textbox></TD>
				</TR>
			</TABLE>
			<TABLE id="TB_Version" borderColor="#ffcc66" height="30" cellSpacing="0" cellPadding="1"
				width="99%" align="center" bgColor="#ffff99" border="1" runat="server">
				<TR>
					<TD vAlign="middle" align="center">
						<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR>
								<TD align="center" width="25">&nbsp;<IMG src="../System/Icons/icon_warning.gif"></TD>
								<TD class="font">&nbsp;&nbsp;
									<asp:label id="lbStatus" runat="server"></asp:label>&nbsp;&nbsp;
									<cc1:confirmedlinkbutton id="lnkDropUndo" runat="server" CssClass="FontHead" ForeColor="Blue"></cc1:confirmedlinkbutton></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
			<TABLE class="TableHeaderOver" height="24" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><asp:label id="Label4" runat="server" CssClass="fontHead"></asp:label></TD>
				</TR>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
					<td width="100"></td>
				</tr>
			</table>
			<table borderColor="whitesmoke" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="1">
				<tr>
					<td width="370">
						<TABLE class="TableHeaderOver" height="24" cellSpacing="0" cellPadding="0" width="100%"
							border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD><asp:label id="Label2" runat="server" CssClass="fontHead"></asp:label></TD>
							</TR>
						</TABLE>
						<cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton>
                        <div id="divBOM" runat="server" style="margin-top:5px;margin-bottom:5px;padding-left:20px;">
                            <asp:HiddenField ID="hdnStyleBOMDimensionId" runat="server" Value="" />
                            <asp:Label ID="lblBOM" runat="server" CssClass="fontHead"></asp:Label>
                            <asp:DropDownList ID="drlStyleBOMDimensionId" runat="server" AutoPostBack="true" CssClass="font" Width="100"></asp:DropDownList>
                            <cc1:bwimagebutton id="imgBtnBOMAdd" runat="server" ImageUrl="../System/Icons/icon_add.gif"></cc1:bwimagebutton>
                        </div>
						<table class="TableHeader" height="24" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr vAlign="middle">
								<td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td>
                                    <cc1:bwimagebutton id="btnColorAdd" runat="server" Visible="false"></cc1:bwimagebutton>
                                    <asp:ImageButton ID="btnSeasonalColorAdd" runat="server" />
									<cc1:ConfirmedImageButton id="btnColorDrop" runat="server"  ></cc1:ConfirmedImageButton>
                                    <cc1:ConfirmedImageButton id="btnColorActive" runat="server"  ></cc1:ConfirmedImageButton>
									<cc1:ConfirmedImageButton id="btnColorRemove" runat="server"  ></cc1:ConfirmedImageButton>
                                </td>
							</tr>
						</table>
						<asp:datagrid id="dgStyleColorCombo" runat="server" Width="300px" AutoGenerateColumns="false"
							DataKeyField="StyleColorID">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
                                <asp:TemplateColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
									<HeaderTemplate>
										<asp:CheckBox id="chkSelectAll" runat="server" onclick="CheckAll(this);"></asp:CheckBox>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="chkSelect" runat="server"></asp:CheckBox>
                                        <asp:HiddenField ID="hdnSelect" runat="server" />
                                        <asp:HiddenField ID="hdnColorPaletteID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "ColorPaletteID").ToString %>' />
									</ItemTemplate>
                                </asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Width="20px" HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>
									<HeaderTemplate>
										<asp:Image id="imgDrop" runat="server" ImageUrl="../System/Icons/icon_drop.gif"></asp:Image>
									</HeaderTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
									<ItemTemplate>
										<asp:Image id="imgDrop" runat="server" ImageUrl="../System/Icons/icon_drop.gif" Visible="False"></asp:Image>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Width="25px"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label id="lblColor" runat="server" Text='<%# GetSystemText("Color") %>'></asp:Label>
									</HeaderTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
									<ItemTemplate>
                                        <img id="imgColorPalette" runat="server" alt="" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Width="115px"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label id="lblColorCode" runat="server" Text='<%# GetSystemText("Color Code") %>'></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label ID="txtColorCode" Runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Width="120px"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label id="lblColorCombo" runat="server" Text='<%# GetSystemText("Color Name") %>'></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label ID="txtColorCombo" Runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid><BR>
					</td>
					<td vAlign="top">
						<TABLE class="TableHeaderOver" id="Table2" height="24" cellSpacing="0" cellPadding="0"
							width="100%" border="0" runat="server">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>								
								<TD><asp:label id="Label1" runat="server" CssClass="fontHead"></asp:label></TD>
							</TR>
						</TABLE>
						<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
		</form>

    <script type="text/javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
                    e.checked = actVar;
            }
        }

        function refreshPage() {
            document.location.href = document.location.href;
        }

        function showSeasonalColor(strStyleID, strLineFolderID, strLineFolderItemID, strStyleBOMDimensionID) {
            window.radopen("Line_List_Folder_Style_SeasonalColorAdd.aspx?SID=" + strStyleID + "&LFID=" + strLineFolderID + "&LFIID=" + strLineFolderItemID + "&DBOM=" + strStyleBOMDimensionID, "AddSeasonalColor");
        }
        function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>

	</body>
</HTML>
