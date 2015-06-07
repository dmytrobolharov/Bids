<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_GradedMeasurTemp_Edit.aspx.vb" Inherits="plmOnApp.Style.GradedSpecTemp.Style_GradedMeasurTemp_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="110" align="right">
                        <asp:Label ID="lblHeader1" runat="server" ></asp:Label></td>
					<td class="FontHead" align="left" width="50">
						<asp:DropDownList id="drl_SampleSize" runat="server" Width="55px" tabIndex="10"></asp:DropDownList></td>
					<td width="375">
						<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnCreateSpec" runat="server"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnDelete" runat="server" ></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton>
					</td>
					<td class="FontHead" align="right" width="75">&nbsp;<asp:Label ID="lblHeader2" runat="server"></asp:Label></td>
					<td width="40"><asp:dropdownlist id="dpStyleSet" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value"
							CssClass="font"></asp:dropdownlist></td>
					<td><asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton></td>
					<td></td>
				</tr>
			</table>
			<uc1:Style_Workflow_Edit id="Style_Workflow_Edit1" runat="server"></uc1:Style_Workflow_Edit>
			<asp:panel id="pnlChange" runat="server">
			    <uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>	
			</asp:panel><uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<BR>
			<cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview>
			<asp:CheckBox id="cbTolerance" runat="server" CssClass="fontHead" ForeColor="Red" Text="No Tolerance &nbsp;"></asp:CheckBox>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="300">
						<asp:datagrid id="DataGrid1" runat="server" Width="100%" OnItemDataBound="ItemDataBoundEventHandler"
							AutoGenerateColumns="False" PageSize="100" BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblHeaderPOM" runat="server"><%#GetSystemText("Select Set:")%></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<DIV align="center">
											<asp:Label id="txtPOM" runat="Server" Width="50px"></asp:Label>
											<asp:TextBox id="txtSpec" runat="server" Width="16px" Visible="False"></asp:TextBox></DIV>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label id="lblHeaderPointMeasur" Width="200px" runat="server"><%#GetSystemText("Point of Measurement")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="txtPointMeasur" runat="Server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderTOL"  runat="server"><%#GetSystemText("TOL")%></asp:Label> </div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:TextBox id="txtTOL" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
												ForeColor="#C00000" MaxLength="8" Columns="5"></asp:TextBox></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderTOLN" runat="server" ForeColor="Red"><%#GetSystemText("TOL")%></asp:Label><font style="FONT-WEIGHT: normal; FONT-SIZE: xx-small; COLOR: red; FONT-FAMILY: Arial"><asp:Label id="lblHeaderTOLNNonWash" runat="server" ForeColor="Red"><%#GetSystemText("(NONWASH)")%></asp:Label></font></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:TextBox id="txtTOLN" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
												ForeColor="#C00000" MaxLength="8" Columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
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
												MaxLength="10" columns="5"></asp:TextBox></div>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
		</form>
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
		<table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
				<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
				<td class="TableBar">
					<asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
			</tr>
		</table>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
