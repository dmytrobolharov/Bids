<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DevelopmentSpec_Edit.aspx.vb" Inherits="plmOnApp.Style.DevelopmentSpec.Style_DevelopmentSpec_Edit" ResponseEncoding="UTF-8" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10" style="height: 28px"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="600" style="height: 28px"><cc1:confirmedimagebutton 
					id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="imgBtnCopy" runat="server" Message="Are you sure you want to copy from style spec ?" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnSamplesize" runat="server" Message="NONE"  ToolTip="Change Sample Size..."></cc1:confirmedimagebutton><cc1:bwimagebutton 
					id="btnSizeRange" runat="server"  ToolTip="Change Size Range..." WindowName="Sizerange"></cc1:bwimagebutton><cc1:confirmedimagebutton 
					id="btnGradeRules" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:BWImageButton ID="btnChangeLog" runat="server" /> </td>
					<td class="FontHead" align="right" width="75" style="height: 28px">&nbsp;<asp:Label id="lblSelectSet" runat="server" >Select Set:</asp:Label></td>
					<td width="40" style="height: 28px"><asp:dropdownlist id="dpStyleSet" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value"
							CssClass="font"></asp:dropdownlist></td>
					<td style="height: 28px"><asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton></td>
				</tr>
			</table>
			<uc1:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc1:style_workflow_edit><asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			</asp:panel><uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="450">
						<table cellspacing="2" cellpadding="0" width="100%" border="0">
							<tr class="fontHead">
								<td><cc1:bwimagebutton id="btnPOMLinked" runat="server" 
										WindowName="POMLibrary"></cc1:bwimagebutton><cc1:bwimagebutton id="btnPOMLink" runat="server"  WindowName="POMLibrary"></cc1:bwimagebutton><cc1:bwimagebutton id="btnPomCritical" runat="server" 
										WindowName="POMLibrary"></cc1:bwimagebutton><cc1:bwimagebutton id="btnPOMDelete" runat="server" 
										WindowName="POMLibrary"></cc1:bwimagebutton><cc1:bwimagebutton id="btnPOMTemplate" runat="server" 
										WindowName="POMLibrary"></cc1:bwimagebutton><cc1:bwimagebutton id="btnPomLibraryTop" runat="server" 
										WindowName="POMLibrary" Visible="False"></cc1:bwimagebutton><cc1:bwimagebutton id="btnPOMSort" runat="server"  WindowName="POMLibrary"></cc1:bwimagebutton></td>
							</tr>
						</table>
						<table id="tblPomTemplate" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
							runat="server">
							<tr valign="middle">
								<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
								<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_template.gif"></td>
								<td class="TableBar"><cc1:bwhyperlink id="lnkPomTemplate" runat="server" WindowName="PomTemplate"></cc1:bwhyperlink></td>
								<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
							</tr>
						</table>
						<asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							PageSize="100" AutoGenerateColumns="False" OnItemDataBound="ItemDataBoundEventHandler" Width="300px">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblLink" runat="server" CssClass="fontHead">L</asp:Label></div>
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
											<asp:Label id="lblHowTo" runat="server" CssClass="fontHead"><%#GetSystemText("H")%></asp:Label></div>
									</HeaderTemplate>
									<ItemTemplate>
										<cc1:BWImageButton id="imgBtnHowTo" runat="server" ImageUrl="../System/Icons/icon_howto.gif" WindowName="POMLibrary"></cc1:BWImageButton>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblHeaderPOM" runat="server"><%#GetSystemText("POM")%></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<DIV align="center" noWrap>
											<asp:TextBox id="txtPOM" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
												maxlength="3" columns="5"></asp:TextBox>
											<asp:HiddenField ID="hdnPOM" runat="server" />
											<asp:RequiredFieldValidator id="rvPOM" runat="server" ToolTip='<%#GetSystemText("POM Code Required") & "!" %>' CssClass="fontHead" ErrorMessage='<%#GetSystemText("POM Code Required") & "!"%>'
												ControlToValidate="txtPOM">*</asp:RequiredFieldValidator></DIV>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label id="lblHeaderPointMeasur" runat="server"><%#GetSystemText("Point of Measurement")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtPointMeasur" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
											maxlength="100" columns="40"></asp:TextBox>
										<asp:HiddenField ID="hdnPointMeasur" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblHeaderTol" runat="server" ForeColor="Red"><%#GetSystemText("TOL")%></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtTOL" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
											Columns="5" MaxLength="10" ForeColor="#C00000"></asp:TextBox>
										<asp:HiddenField ID="hdnTOL" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblHeaderTolN" runat="server" ForeColor="Red"><%#GetSystemText("TOLN")%></asp:Label>
											<FONT style="FONT-WEIGHT: normal; FONT-SIZE: xx-small; COLOR: red; FONT-FAMILY: Arial">
											    <asp:Label id="lblNonWash" runat="server"><%#GetSystemText("(NonWash)")%></asp:Label>
											</FONT>
										</DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtTOLN" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
											ForeColor="#C00000" MaxLength="10" Columns="5"></asp:TextBox>
										<asp:HiddenField ID="hdnTOLN" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="TableHeaderYellow"></HeaderStyle>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblInitialSpec" runat="server"><%#GetSystemText("Initial")%></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtInitialSpec" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
											columns="5" maxlength="10"></asp:TextBox>
										<asp:HiddenField ID="hdnInitialSpec" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="TableHeaderGreen"></HeaderStyle>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblSampleSize" runat="server"></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtSpec" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
											columns="5" maxlength="10"></asp:TextBox>
										<asp:HiddenField ID="hdnSpec" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
						<table cellspacing="2" cellpadding="0" width="550" border="0">
							<tr class="fontHead">
								<td width="10" style="height: 24px">&nbsp;</td>
								<td noWrap width="85" style="height: 24px"><asp:Label id="lblNoofRows" runat="server">No. of Row(s)</asp:Label>:</td>
								<td width="35" style="height: 24px"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
										<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
										<asp:ListItem Value="2">2</asp:ListItem>
										<asp:ListItem Value="3">3</asp:ListItem>
										<asp:ListItem Value="4">4</asp:ListItem>
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
									</asp:dropdownlist></td>
								<td style="width: 400px; height: 24px"><cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnPomLibrary" runat="server" 
										WindowName="POMLibrary"></cc1:bwimagebutton><cc1:bwimagebutton id="btnPOMTemp" runat="server" 
										WindowName="POMTemplate"></cc1:bwimagebutton>
                                    <cc1:ConfirmedImageButton ID="btnPomreconvert" runat="server" 
                                        Message="NONE" /></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgColor="#ffffff">
						<table>
							<tr>
								<td height="3"></td>
							</tr>
						</table>
						<cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview><asp:panel id="pnlImage" runat="server">
							<cc1:confirmedimagebutton id="imgBtnEdit1" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnSelect1" runat="server" 
								Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server" 
							ToolTip="Delete Image From Style..." Message="Do you want to remove this image from this Style?"></cc1:confirmedimagebutton>
							<BR>
							<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
						</asp:panel><asp:panel id="pnlHowTo" runat="server">
							<asp:datalist id="DataList1" runat="server" Width="100%" BorderWidth="1px" BorderStyle="Solid"
								BorderColor="WhiteSmoke" BackColor="White">
								<HeaderTemplate>
									<table cellspacing="0" cellpadding="0" width="100%" border="0">
										<tr class="TableHeader">
											<td class="fonthead" width="75"><asp:Label id="lblCode" runat="server"><%#GetSystemText("Code")%></asp:Label></td>
											<td class="fonthead" width="200"><asp:Label id="Label1" runat="server"><%#GetSystemText("Point of Measure")%></asp:Label></td>
											<td class="fonthead" width="200"><asp:Label id="Label2" runat="server"><%#GetSystemText("How To Measure")%></asp:Label></td>
											<td class="fonthead" width="200"><asp:Label id="Label3" runat="server"><%#GetSystemText("How To Image")%></asp:Label></td>
										</tr>
									</table>
								</HeaderTemplate>
								<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
								<FooterTemplate>
								</FooterTemplate>
								<ItemStyle BackColor="White"></ItemStyle>
								<ItemTemplate>
									<table width="100%">
										<tr>
											<td class="font" width="75"><%#Container.DataItem("POM")%></td>
											<td class="font" width="200"><%#Container.DataItem("PointMeasur")%></td>
											<td class="font" width="200"><%#Container.DataItem("HowTomeasurText")%></td>
											<td class="font" width="200">
												<asp:Image id=Image1 runat="server" ImageUrl='<%# GetImageThumbnail(DataBinder.Eval(Container.DataItem, "POMLibraryID").ToString,"50","jpg") %>'>
												</asp:Image></td>
										</tr>
									</table>
								</ItemTemplate>
							</asp:datalist>
						</asp:panel></td>
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
		<table id="Table3" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
				<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
				<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
			</tr>
		</table>
	</body>
</html>
