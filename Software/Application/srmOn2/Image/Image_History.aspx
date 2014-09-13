<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_History.aspx.vb" Inherits="srmOnApp.Image_History" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>History</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" autocomplete="on">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                    <td>
                        <cc1:confirmedimagebutton id="btnClear" runat="server"  ></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" visible="false"></cc1:confirmedimagebutton>
                    </td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
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
							ForeColor="#E0E0E0">Image Folder...</asp:label></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td></td>
					<td width="100%"></td>
				</tr>
			</table>
			<TABLE id="Table1" cellSpacing="1" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top">
						<TABLE class="ToolbarShort" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
							border="0">
							<TR class="fontHead">
								<TD align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD>
									<DIV align="left">&nbsp;
										<asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label><asp:label id="lblPageSize" Runat="server" Visible="false" Text="24"></asp:label></DIV>
								</TD>
								<TD width="20">
									<DIV align="center">
									    <asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton>
									    <%--<A id="First" href="pagingdatalist.aspx#BookMark" runat="server" OnServerClick="ShowFirstPage"><IMG height="16" alt="First Record" src="../System/Icons/icon_first.gif" width="16" border="0"></A>--%>
									</DIV>
								</TD>
								<TD width="20">
									<DIV align="center">
									    <asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton>
									    <%--<A id="Previous" href="pagingdatalist.aspx#BookMark" runat="server" OnServerClick="ShowPreviousPage"><IMG height="16" alt="Previous Record" src="../System/Icons/icon_Previous.gif" width="16" border="0"></A>--%>
								    </DIV>
								</TD>
								<TD width="150">
									<DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
								</TD>
								<TD width="20">
									<div align="center">
			                            <asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton>
			                            <%--<a id="Next" href="pagingdatalist.aspx#BookMark" OnServerClick="ShowNextPage" runat="server"><IMG height="16" alt="Next Record" src="../System/Icons/icon_next.gif" width="16" border="0"></A>--%>
			                        </div>
								</TD>
								<TD width="20">
			                        <div align="center">
			                            <asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton>
			                            <%--<a id="Last" href="pagingdatalist.aspx#BookMark" OnServerClick="ShowLastPage" runat="server"><IMG height="16" alt="Last Record" src="../System/Icons/icon_last.gif" width="16" border="0"></A>--%>
			                        </div>
								</TD>
								<TD>
									<DIV align="left"><B><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;<asp:Label 
                                            ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label>
                                        </B></DIV>
									</B></TD>
							</TR>
						</TABLE>
						<asp:datalist id="DataList1" runat="server" Width="100%" DataKeyField="ImageID" RepeatColumns="5"
							OnItemCommand="DataList1_ItemCommand" EnableViewState="True" RepeatDirection="Horizontal"
							OnItemDataBound="DataList1_ItemDataBound">
							<ItemStyle HorizontalAlign="Left" VerticalAlign="Top" BorderStyle="Solid" BorderColor="LightGrey"
								BackColor="#ffffff" BorderWidth="1"></ItemStyle>
							<ItemTemplate>
								<TABLE borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
									border="0">
									<TR>
										<TD>
											<cc1:ConfirmedImageButton id="imgBtnEditImage" runat="server" Message="NONE" CommandName="Edit" ></cc1:ConfirmedImageButton>
											<cc1:ConfirmedImageButton id="imgBtnCopyImage" runat="server" CommandName="Copy"></cc1:ConfirmedImageButton>
										</TD>
									</TR>
									<TR>
										<TD vAlign="top" width="200" bgColor="#ffffff" height="150"><IMG alt="" runat="server" Id="ImgHistory"></TD>
									</TR>
									<TR>
										<TD>
											<TABLE>
												<TR>
													<TD class="font">
														<asp:Label id=lbImgDescription runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageDescription") %>'/>
														<br>
														<asp:Label id="lblImageMDate" runat="server" Text='<%# Convert.ToDateTime(SystemHandler.GetLocalTime( DataBinder.Eval(Container.DataItem, "DateViewed"))).ToString(Me.GetFormatInfo.DateTimeLongFormat) %>'/>
													</TD>
												</TR>
											</TABLE>
											<INPUT id=txtImageFileName type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageLocation") %>' runat="server">
											<INPUT id=txtImageVersion type=hidden value='<%# DataBinder.Eval(Container.DataItem, "Version") %>' runat="server">
											<INPUT id=txtImageID type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server"></TD>
									</TR>
								</TABLE>
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
