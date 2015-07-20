<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Spec_Rules.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Spec_Rules" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		 <title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="tbGradeRules" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3" runat="server"></td>
					<TD><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnGradeRulesRefresh" runat="server" ></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></TD>
					<td></td>
				</tr>
			</table>
			<table class="TableHeader" id="tbGradeSpec" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<TD width="75"><cc1:confirmedimagebutton id="btnCreateSpec" runat="server" ></cc1:confirmedimagebutton></TD>
					<td></td>
				</tr>
			</table>
			<BR>
			<cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<asp:datagrid id="dgGradeRules" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
				PageSize="300" AutoGenerateColumns="False" Width="100%">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblLink" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></div>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Image id="imgLink" runat="server" ImageUrl="../System/Icons/icon_link.gif"></asp:Image>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblCritical" runat="server" CssClass="fontHead"><%#GetSystemText("C")%></asp:Label></div>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Image id="imgCritical" runat="server" ImageUrl="../System/Icons/icon_warning.gif"></asp:Image>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblHeaderPOM" runat="server"><%#GetSystemText("POM")%></asp:Label>
							</div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtPOM" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									columns="5" maxlength="5" />
							</div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="lblHeaderPointMeasur" runat="server"><%#GetSystemText("Point of Measurement")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox id="txtPointMeasur" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
								columns="40" maxlength="100"></asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					
					<asp:TemplateColumn>
						<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblHeaderTol" runat="server"><%#GetSystemText("TOL")%></asp:Label></div>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox id="txtTOL" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
								ForeColor="#C00000" maxlength="7" Columns="5"></asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderStyle CssClass="TableHeader"></HeaderStyle>
						<HeaderTemplate>
							<DIV align="center">
                                <asp:Label ID="lblSpecH" runat="server"><%#GetSystemText("Spec")%></asp:Label></DIV>
						</HeaderTemplate>
						<ItemTemplate>
							<DIV align="center">
								<asp:TextBox id="txtSpec" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									columns="5" maxlength="10"></asp:TextBox></DIV>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderStyle CssClass="TableHeaderGreen"></HeaderStyle>
						<HeaderTemplate>
							<DIV align="center">
                                <asp:Label ID="lblRevH" runat="server"><%#GetSystemText("Rev")%></asp:Label></DIV>
						</HeaderTemplate>
						<ItemTemplate>
							<DIV align="center">
								<asp:TextBox id="txtRev" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									columns="5" maxlength="10"></asp:TextBox></DIV>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize0" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec0" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize1" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec1" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize2" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec2" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize3" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec3" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize4" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec4" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize5" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec5" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize6" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec6" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize7" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec7" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize8" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec8" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize9" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec9" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize10" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec10" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize11" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec11" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize12" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec12" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize13" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec13" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize14" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec14" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize15" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec15" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize16" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec16" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize17" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec17" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize18" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec18" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<div align="center">
								<asp:Label id="lblSize19" runat="server" /></div>
						</HeaderTemplate>
						<ItemTemplate>
							<div align="center">
								<asp:TextBox id="txtSpec19" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
									maxlength="7" columns="5"></asp:TextBox></div>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid></form>
		<script language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
