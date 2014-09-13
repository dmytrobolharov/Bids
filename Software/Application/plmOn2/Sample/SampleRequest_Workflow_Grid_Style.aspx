<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Grid_Style.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Grid_Style" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
    <head>
		<title runat="server" id="PageTitle"></title>
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
        <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
        <meta content="JavaScript" name="vs_defaultClientScript">
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    </head>
	<body>
    <script type="text/javascript">
        var SelectedSY = top.menu.document.getElementById("ddlStyleSeasonYearID").value
        var CurrentSY = '<%= Request("SYID") %>'
        if (SelectedSY != CurrentSY) { location.href = location.href.replace(CurrentSY, SelectedSY) }
    </script>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3" border="0"></td>
					<td>
					    <cc1:confirmedimagebutton id="btnNew" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
					</td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40">&nbsp;</td>
					<td></td>
				</tr>
			</table>
            <table id="tbHeader" runat="server" style="border-bottom: orange thin solid; border-left-style: none;
                background-color: white" height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                border="0">
                <tr>
                    <td>
                        &nbsp;<asp:Label ID="lblBigHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
                    </td>
                </tr>
            </table>
							
            <br />
            
           	 <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
				    <td valign="top" >
						<table height="45" width="100" border="0">
						    <tr><td align="center"><asp:Label ID="lblList" runat="server" CssClass="fontHead"></asp:Label><br/>
						    <asp:CheckBox runat="server" ID="chkMyList" /></tr>
						</table>
					</td>
					<td><asp:placeholder id="plhControlSearchHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" vAlign="top">
						<TABLE id="Table3" height="45">
							<TR>
								<TD>
									<asp:ImageButton id="imgBtnSearch" runat="server"></asp:Imagebutton></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
			<br /><br />
            <table class="TableHeader" id="tblSRStyleHeader" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle" height="20">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3" border="0"></td>
					<td align="left">
					    <asp:Label ID="lblStyleSampleRequestHeader" runat="server"></asp:Label>
					</td>
					<td></td>
				</tr>
			</table>
	        <asp:datagrid id="dgSampleRequest" runat="server" BorderStyle="NotSet" AllowSorting="true"
                 AutoGenerateColumns="false" OnItemDataBound="SampleRequestBinding"
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                CellSpacing="0" DataKeyField="SampleRequestTradeID">
		        <PagerStyle />
		        <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
		        <ItemStyle Height="20px" CssClass="font"></ItemStyle>
		        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
		        <Columns>
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <ItemTemplate>
                            <cc1:BWImageButton runat="server" ID="imgRedirect" ImageUrl="../System/icons/icon_search.gif" />
                         </ItemTemplate>
                    </asp:TemplateColumn>

		        </Columns>
	        </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>

			<asp:datagrid id="dgSampleBOMRequest" runat="server" BorderStyle="NotSet" AllowSorting="true"
                 AutoGenerateColumns="false" OnItemDataBound="SampleRequestBOMBinding"
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                CellSpacing="0" DataKeyField="SampleRequestTradeID">
		        <PagerStyle />
		        <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
		        <ItemStyle Height="20px" CssClass="font"></ItemStyle>
		        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
		        <Columns>
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <ItemTemplate>
                            <cc1:BWImageButton runat="server" ID="imgBOMRedirect" ImageUrl="../System/icons/icon_search.gif" />
                         </ItemTemplate>
                    </asp:TemplateColumn>

		        </Columns>
	        </asp:datagrid>

            <br />
            <asp:Panel runat="server" ID="pnlSilho">
                <table class="TableHeaderYellow" id="tblSRSilhoHeader" cellspacing="0" cellpadding="0" width="100%" border="0"
                    runat="server">
                    <tr valign="middle" height="20">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" border="0">
                        </td>
                        <td align="left">
                            <asp:Label ID="lblSilhoSampleRequestHeader" runat="server"></asp:Label>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <asp:DataGrid ID="dgSilhoSampleRequest" runat="server" BorderStyle="NotSet" AllowSorting="false" AutoGenerateColumns="false"
                    OnItemDataBound="SampleRequestBinding" BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White"
                    CellSpacing="0" DataKeyField="SampleRequestTradeID">
                    <PagerStyle />
                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <HeaderStyle CssClass="TableHeader" />
                            <ItemTemplate>
                                <cc1:BWImageButton runat="server" ID="imgRedirect" ImageUrl="../System/icons/icon_search.gif" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
                <asp:DataGrid ID="dgSilhoSampleRequestBOM" runat="server" BorderStyle="NotSet" AllowSorting="false" AutoGenerateColumns="false"
                    OnItemDataBound="SampleRequestBOMBinding" BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White"
                    CellSpacing="0" DataKeyField="SampleRequestTradeID">
                    <PagerStyle />
                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <HeaderStyle CssClass="TableHeader" />
                            <ItemTemplate>
                                <cc1:BWImageButton runat="server" ID="imgBOMRedirect" ImageUrl="../System/icons/icon_search.gif" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </asp:Panel>

		</form>
	</body>
</html>
