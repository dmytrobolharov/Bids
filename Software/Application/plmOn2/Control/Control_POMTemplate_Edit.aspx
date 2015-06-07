<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_POMTemplate_Edit.aspx.vb" Inherits="plmOnApp.Control_POMTemplate_Edit" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>POM Template</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<style type="text/css">.DataGridHeader { PADDING-RIGHT: 2px; PADDING-LEFT: 2px; FONT-WEIGHT: bold; FONT-SIZE: 11px; BACKGROUND-IMAGE: url(../System/Images/table_header.gif); PADDING-BOTTOM: 2px; PADDING-TOP: 2px; BACKGROUND-REPEAT: repeat-x; FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;  TOP: expression(this.offsetParent.scrollTop) }
	.DataGridControl { FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;  TOP: expression(this.offsetParent.scrollTop); BACKGROUND-COLOR: #f5f5f5 }
		</style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnAddSizeRange" runat="server" 
							Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnCopy" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnPDFView" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" CausesValidation="false"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview><asp:textbox id="txtPOMTempGroupID" runat="server" Visible="False"></asp:textbox><asp:panel id="pnlTemplate" runat="server">
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD vAlign="top">
							<DIV id="div_Grid" runat="server">
								<TABLE class="ms-formlabel DataGridControl" cellSpacing="1" cellPadding="0" width="100%"
									border="0">
									<TR>
										<TD style="height: 27px">
											<cc1:bwimagebutton id="btnPOMLinked" runat="server" 
												WindowName="POMLibrary" Visible="false" ></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPomCritical" runat="server" 
												WindowName="POMLibrary"></cc1:bwimagebutton>
                                                <cc1:bwimagebutton id="btnWhereUsed" runat="server" 
											WindowName="POMTemplateWhereUsed"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPOMDelete" runat="server" 
												WindowName="POMLibrary"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPomLibraryTop" runat="server" 
												WindowName="POMLibrary"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPOMSort" runat="server"  WindowName="POMLibrary"></cc1:bwimagebutton></TD>
									</TR>
								</TABLE>
								<asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
									PageSize="1000" AutoGenerateColumns="False" OnItemDataBound="ItemDataBoundEventHandler" OnItemCommand="DisplayBoundColumnValues"
									Width="300px">
									<ItemStyle Height="20px" CssClass="font"></ItemStyle>
									<HeaderStyle Height="20px" CssClass="ms-formlabel DataGridHeader"></HeaderStyle>
									<Columns>
										<asp:TemplateColumn>
											<HeaderTemplate>
												<DIV align="center">
													<asp:Label id="lblLink" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></DIV>
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
												<div align="center">
													<asp:label id="lblHeaderPOM" runat="server"><%#GetSystemText("POM")%></asp:label>
												</div>
											</HeaderTemplate>
											<ItemTemplate>
												<DIV align="center" noWrap>
													<asp:TextBox id="txtPOM" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
														maxlength="3" columns="5"></asp:TextBox>
													<asp:RequiredFieldValidator id="rvPOM" runat="server" CssClass="fontHead" ErrorMessage="POM Code Required!"
														ControlToValidate="txtPOM">*</asp:RequiredFieldValidator></DIV>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderTemplate>
												<asp:Label id="lblHeaderPointMeasur" Width="200px" runat="server"><%#GetSystemText("Point of Measurement")%></asp:Label>
											</HeaderTemplate>
											<ItemTemplate>
												<asp:TextBox id="txtPointMeasur" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
													maxlength="100" columns="40"></asp:TextBox>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
											<HeaderTemplate>
												<DIV align="center">
													<asp:Label id="lblHeaderTOL" runat="server" CssClass="fontRed"><%#GetSystemText("TOL")%></asp:Label></DIV>
											</HeaderTemplate>
											<ItemTemplate>
												<DIV align="center">
													<asp:TextBox id="txtTOL" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
														ForeColor="#C00000" Columns="5" MaxLength="10"></asp:TextBox></DIV>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
											<HeaderTemplate>
												<DIV align="center">
													<asp:Label id="lblHeaderTOLN" runat="server" ForeColor="Red"><%#GetSystemText("TOL")%></asp:Label><FONT style="FONT-WEIGHT: normal; FONT-SIZE: xx-small; COLOR: red; FONT-FAMILY: Arial"><%#GetSystemText("NONWASH")%></FONT></DIV>
											</HeaderTemplate>
											<ItemTemplate>
												<DIV align="center">
													<asp:TextBox id="txtTOLN" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
														ForeColor="#C00000" Columns="5" MaxLength="10"></asp:TextBox></DIV>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderStyle CssClass="TableHeaderGreen"></HeaderStyle>
											<HeaderTemplate>
												<DIV align="center">
													<asp:Label id="lblConv" runat="server" ForeColor="GREEN"><%#GetSystemText("Conv")%></asp:Label></DIV>
											</HeaderTemplate>
											<ItemTemplate>
												<DIV align="center">
													<asp:TextBox id="txtConv" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
														ForeColor="#C00000" Columns="5" MaxLength="10"></asp:TextBox></DIV>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderStyle CssClass="TableHeaderBlue"></HeaderStyle>
											<HeaderTemplate>
												<DIV align="center">
													<asp:Label id="lblSpec" runat="server" ForeColor="BLUE"><%#GetSystemText("Spec")%></asp:Label></DIV>
											</HeaderTemplate>
											<ItemTemplate>
												<DIV align="center">
													<asp:TextBox id="txtSpec" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
														ForeColor="#C00000" Columns="5" MaxLength="10"></asp:TextBox></DIV>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderTemplate>
												<div align="center">
													<asp:Label id="lblSize0" runat="server" /></div>
											</HeaderTemplate>
											<ItemTemplate>
												<div align="center">
													<asp:TextBox id="txtGrade0" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade1" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade2" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade3" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade4" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade5" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade6" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade7" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade8" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade9" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade10" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade11" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade12" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade13" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade14" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade15" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade16" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade17" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade18" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
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
													<asp:TextBox id="txtGrade19" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														MaxLength="10" columns="5"></asp:TextBox></div>
											</ItemTemplate>
										</asp:TemplateColumn>
									</Columns>
								</asp:datagrid></DIV>
							<TABLE cellSpacing="2" cellPadding="0" border="0">
								<TR class="fontHead">
									<TD>&nbsp;</TD>
									<TD noWrap width="85">
                                        <asp:Label ID="lblNumRows" runat="server"></asp:Label></TD>
									<TD width="35">
										<asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
											<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
											<asp:ListItem Value="2">2</asp:ListItem>
											<asp:ListItem Value="3">3</asp:ListItem>
											<asp:ListItem Value="4">4</asp:ListItem>
											<asp:ListItem Value="5">5</asp:ListItem>
											<asp:ListItem Value="10">10</asp:ListItem>
											<asp:ListItem Value="15">15</asp:ListItem>
											<asp:ListItem Value="20">20</asp:ListItem>
										</asp:dropdownlist></TD>
									<TD width="50">
										<cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
									<TD width="100">
										<cc1:bwimagebutton id="btnPomLibrary" runat="server" 
											WindowName="POMLibrary"></cc1:bwimagebutton></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</asp:panel>
			<asp:panel id="pnlHowTo" runat="server">
				<asp:datalist id="DataList1" runat="server" BorderColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1px"
					Width="100%" BackColor="White">
					<HeaderTemplate>
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr class="Toolbar">

                    <td class="fontHead" width="75">
                        <asp:Label ID="lblCode" runat="server"><%#GetSystemText("Code")%></asp:Label>
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblPointofMeasure" runat="server"><%#GetSystemText("Point of Measure")%>
                        </asp:Label>
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblHowToMeasure" runat="server"><%#GetSystemText("How to Measure")%></asp:Label>
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblHowToImage" runat="server"><%#GetSystemText("How to Image")%></asp:Label>
                    </td>
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
								<TD class="font" width="200">
									<asp:Label Runat="server" ID="lblHowTomeasurText">
										<%#Container.DataItem("HowTomeasurText")%>
									</asp:Label></TD>
								<TD class="font" width="200">
									<asp:Image id=Image1 runat="server" ImageUrl='<%# GetImageThumbnail(DataBinder.Eval(Container.DataItem, "POMLibraryID").ToString,"50","jpg") %>'>
									</asp:Image></TD>
							</TR>
						</TABLE>
					</ItemTemplate>
				</asp:datalist>
			</asp:panel>
			<asp:panel id="pnlWhere" runat="server"></asp:panel></form>
		<SCRIPT language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
		                e.checked = actVar;
		        }
		    }

		    function CheckDeleteAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
		                e.checked = actVar;
		        }
		    }

		    function CheckCriticalAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkCritical") != -1)
		                e.checked = actVar;
		        }
		    }		
		
		</SCRIPT>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
