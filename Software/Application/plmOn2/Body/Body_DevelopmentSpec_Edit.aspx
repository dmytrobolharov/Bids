<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_DevelopmentSpec_Edit.aspx.vb" Inherits="plmOnApp.Body_DevelopmentSpec_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />    
</head>
<body>
    <form id="form1" runat="server">

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10" style="height: 28px"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="600" style="height: 28px">
					<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="imgBtnCopy" Visible="false" runat="server" Message="Are you sure you want to copy from style spec ?" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSamplesize"  Visible="false"  runat="server" Message="NONE" ToolTip="Change Sample Size..."></cc1:confirmedimagebutton>
					<cc1:bwimagebutton id="btnSizeRange"  Visible="false" runat="server" ToolTip="Change Size Range..." WindowName="Sizerange"></cc1:bwimagebutton>
					<cc1:confirmedimagebutton id="btnGradeRules" Visible="false"  runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="90px" style="height: 28px">&nbsp;<asp:Label id="lblSelectSet" runat="server" CssClass="fontHead">Select Set:</asp:Label></td>
					<td width="40" style="height: 28px"><asp:dropdownlist id="dpBodySet" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value"
							CssClass="font"></asp:dropdownlist></td>
					<td style="height: 28px"><asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton></td>
				</tr>
			</table>
			
		    <br />
		    <cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
		    <br />
			
			<asp:PlaceHolder  runat ="server"  ID ="plhHeader" ></asp:PlaceHolder>
			<br />
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr ><td widht="100%" style="height: 28px">&nbsp;</td></tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" width="450">
						<table cellSpacing="2" cellPadding="0" width="100%" border="0">
							<tr class="fontHead">
								<td><cc1:bwimagebutton id="btnPOMLinked" runat="server" WindowName="POMLibrary"></cc1:bwimagebutton>
								<cc1:bwimagebutton id="btnPOMLink" runat="server" WindowName="POMLibrary"></cc1:bwimagebutton>
								<cc1:bwimagebutton id="btnPomCritical" runat="server" WindowName="POMLibrary"></cc1:bwimagebutton>
								<cc1:bwimagebutton id="btnPOMDelete" runat="server" WindowName="POMLibrary"></cc1:bwimagebutton>
								<cc1:bwimagebutton id="btnPOMTemplate" runat="server" WindowName="POMLibrary"></cc1:bwimagebutton>
								<cc1:bwimagebutton id="btnPomLibraryTop" runat="server" WindowName="POMLibrary" Visible="False"></cc1:bwimagebutton>
								<cc1:bwimagebutton id="btnPOMSort" runat="server" WindowName="POMLibrary"></cc1:bwimagebutton></td>
							</tr>
						</table>
						<TABLE id="tblPomTemplate" height="24" cellSpacing="0" cellPadding="0" width="100%" border="0"
							runat="server">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></TD>
								<TD class="TableBar" vAlign="middle" align="center" width="20"><IMG src="../System/icons/icon_template.gif"></TD>
								<TD class="TableBar"><cc1:bwhyperlink id="lnkPomTemplate" runat="server" WindowName="PomTemplate"></cc1:bwhyperlink></TD>
								<TD vAlign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></TD>
							</TR>
						</TABLE>
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
											<asp:Label id="lblCritical" runat="server" CssClass="fontHead">C</asp:Label></div>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Image id="imgCritical" runat="server" ImageUrl="../System/Icons/icon_warning.gif"></asp:Image>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHowTo" runat="server" CssClass="fontHead">H</asp:Label></div>
									</HeaderTemplate>
									<ItemTemplate>
										<cc1:BWImageButton id="imgBtnHowTo" runat="server" ImageUrl="../System/Icons/icon_howto.gif" WindowName="POMLibrary"></cc1:BWImageButton>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderPOM" runat="server">POM</asp:Label></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center" noWrap>
											<asp:TextBox id="txtPOM" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
												maxlength="3" columns="5"></asp:TextBox>
											<asp:RequiredFieldValidator id="rvPOM" runat="server" ToolTip="POM Code Required!" CssClass="fontHead" ErrorMessage="POM Code Required!"
												ControlToValidate="txtPOM">*</asp:RequiredFieldValidator></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label id="lblHeaderPointMeasur" runat="server">Point of Measurement</asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtPointMeasur" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
											maxlength="100" columns="40"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderTol" runat="server" ForeColor="Red">TOL</asp:Label></div>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtTOL" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
											Columns="5" MaxLength="10" ForeColor="#C00000"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderTolN" runat="server" ForeColor="Red">TOLN</asp:Label><FONT style="FONT-WEIGHT: normal; FONT-SIZE: xx-small; COLOR: red; FONT-FAMILY: Arial">(NonWash)</FONT></div>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtTOLN" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
											ForeColor="#C00000" MaxLength="10" Columns="5"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="TableHeaderYellow"></HeaderStyle>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblInitialSpec" runat="server">Initial</asp:Label></div>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtInitialSpec" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
											columns="5" maxlength="10"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle CssClass="TableHeaderGreen"></HeaderStyle>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSampleSize" runat="server"></asp:Label></div>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtSpec" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
											columns="5" maxlength="10"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
						<table cellSpacing="2" cellPadding="0" width="550" border="0">
							<tr class="fontHead">
								<td width="10" style="height: 24px">&nbsp;</td>
								<td nowrap="nowrap" width="85" style="height: 24px"><asp:Label id="lblNumberOfRows" Text="No. of Row(s):" runat="server" /></td>
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
								<td style="width: 400px; height: 24px"><cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE"></cc1:confirmedimagebutton>
								<cc1:bwimagebutton id="btnPomLibrary" runat="server" WindowName="POMLibrary"></cc1:bwimagebutton>
								<cc1:bwimagebutton id="btnPOMTemp" runat="server" WindowName="POMTemplate"></cc1:bwimagebutton>
								<cc1:ConfirmedImageButton ID="btnPomreconvert" runat="server" Message="NONE" /></td>
							</tr>
						</table>
					</td>
					<td vAlign="top" bgColor="#ffffff" runat="server" id="tdTemp" >
						<table>
							<tr>
								<td height="3"></td>
							</tr>
						</table>
						
						
						<cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview>
						<asp:panel id="pnlImage" runat="server">
							<cc1:confirmedimagebutton id="imgBtnEdit1" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnSelect1" runat="server" Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server"></cc1:confirmedimagebutton>
							<BR>
							<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
						</asp:panel>
						<asp:panel id="pnlHowTo" runat="server">
							<asp:datalist id="DataList1" runat="server" Width="100%" BorderWidth="1px" BorderStyle="Solid"
								BorderColor="WhiteSmoke" BackColor="White">
								<HeaderTemplate>
									<table cellspacing="0" cellpadding="0" width="100%" border="0">
										<tr class="TableHeader">
											<td class="fonthead" width="75"><asp:Label id="lblCode" Text="Code" runat="server" /></td>
											<td class="fonthead" width="200"><asp:Label id="lblHeadPOM" Text="Point of Measure" runat="server" /></td>
											<td class="fonthead" width="200"><asp:Label id="lblHeadHTM" Text="How To Measure" runat="server" /></td>
											<td class="fonthead" width="200"><asp:Label id="lblHeadHTI" Text="How To Image" runat="server" /></td>
										</tr>
									</table>
								</HeaderTemplate>
								<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
								<FooterTemplate>
								</FooterTemplate>
								<ItemStyle BackColor="White"></ItemStyle>
								<ItemTemplate>
									<TABLE width="100%">
										<TR>
											<TD class="font" width="75"><%#Container.DataItem("POM")%></TD>
											<TD class="font" width="200"><%#Container.DataItem("PointMeasur")%></TD>
											<TD class="font" width="200"><%#Container.DataItem("HowTomeasurText")%></TD>
											<TD class="font" width="200">
												<asp:Image id=Image1 runat="server" ImageUrl='<%# GetImageThumbnail(DataBinder.Eval(Container.DataItem, "POMLibraryID").ToString,"50","jpg") %>'>
												</asp:Image></TD>
										</TR>
									</TABLE>
								</ItemTemplate>
							</asp:datalist>
						</asp:panel></td>
				</tr>
			</table>

			

    
    </form>
</body>
</html>
