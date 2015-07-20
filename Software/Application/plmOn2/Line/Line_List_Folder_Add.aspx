<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_Add.aspx.vb" Inherits="plmOnApp.Line_List_Folder_Add" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Image_Folder</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" autocomplete="on">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="imgBtnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
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
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0">Select Style...</asp:label></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
					<td vAlign="top" width="100%">
						<TABLE id="Table3" height="45">
							<TR>
								<TD><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
			<TABLE id="Table1" cellSpacing="1" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top">
						<TABLE class="ToolbarShort" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
							border="0">
							<TR class="fontHead">
								<TD align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></TD>
		                        <TD height="25">
			                        <DIV align="left">&nbsp;
				                        <asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label><asp:label id="lblPageSize" Text="10" Visible="False" Runat="server">10</asp:label></DIV>
		                        </TD>
		                        <TD width="20"><asp:imagebutton id="btnImgFirst" OnClick="ShowFirstPage" runat="server"></asp:imagebutton></TD>
		                        <TD width="20"><asp:imagebutton id="btnImgPrevious" OnClick="ShowPreviousPage" runat="server"></asp:imagebutton></TD>					
		                        <TD noWrap align="center" width="125"><asp:label id="lblCounts" runat="server" CssClass="fontHead"></asp:label></TD>
		                        <TD width="20"><asp:imagebutton id="btnImgNext" OnClick="ShowNextPage" runat="server"></asp:imagebutton></TD>
		                        <TD width="20"><asp:imagebutton id="btnImgLast" OnClick="ShowLastPage" runat="server" ToolTip="Last"></asp:imagebutton></TD>
		                        <TD width="10">&nbsp;</TD>
		                        <TD noWrap height="25"><div align="left"><b>
                                       <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
                                       <asp:label id="lblRecordFound" Runat="server" />
                                     </b></div>
                                </TD>	
							</TR>
						</TABLE>
						<asp:datalist id="DataList1" runat="server" Width="100%" DataKeyField="StyleID" RepeatColumns="5"
							OnItemCommand="DataList1_ItemCommand" RepeatDirection="Horizontal" EnableViewState="True"
							OnItemDataBound="DataList1_ItemDataBound">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<TABLE borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
									border="0">
									<TR>
										<TD>
										    <asp:CheckBox id="cbSelectStyle" runat="server" Text='<%#GetSystemText("Click here to select style") & "..."%>' CssClass="font"></asp:CheckBox></TD>
										    </TD>
									</TR>
									<TR>
										<TD vAlign="top" width="200" bgColor="#ffffff" height="150"><IMG alt="" id="imgCh" runat="server" ></TD>
									</TR>
									<TR>
										<TD>
											<TABLE>
												<TR>
													<TD class="font">
														<asp:Label id="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StyleNo") %>'>
														</asp:Label></TD>
												</TR>
												<TR>
													<TD class="font">
														<asp:Label id="lbImgDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>'>
														</asp:Label></TD>
												</TR>
												<TR>
													<TD class="font">
														<asp:Label id="Label2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeClass") %>'>
														</asp:Label></TD>
												</TR>
												<TR>
													<TD class="font">
														<asp:Label id="Label3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeRange") %>'>
														</asp:Label></TD>
												</TR>
												<TR>
													<TD class="font">
														<asp:Label id="Label4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, strFieldSeason ) %>'>
														</asp:Label></TD>
												</TR>
												<TR>
													<TD class="font">
														<asp:Label id="Label5" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, strFieldYear ) %>'>
														</asp:Label></TD>
												</TR>
												<TR>
													<TD class="font">
														<asp:Label id="Label7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MaterialName") %>'>
														</asp:Label></TD>
												</TR>
											</TABLE>
										</TD>
									</TR>
								</TABLE>
								<INPUT id="txtImageID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "DesignSketchID") %>' name="txtImageID" runat="server">
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist></TD>
				</TR>
			</TABLE>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
