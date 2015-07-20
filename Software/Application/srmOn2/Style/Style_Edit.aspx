<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Edit.aspx.vb" Inherits="srmOnApp.Style_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style</title>

		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../System/Jscript/System.js"></script>
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<br>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:panel id="Panel1" runat="server">
				<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
					runat="server">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td>
							<cc1:confirmedimagebutton 
							id="btnSaveStyle" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
							id="btnStyleSet" runat="server" Message="NONE"  ToolTip="Edit Style Set..."></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
							id="btnSamplesize" runat="server" Message="NONE"  ToolTip="Change Sample Size..."></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
							id="btnChangeLog" runat="server" Message="NONE" Visible="false" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
							id="btnDrop" runat="server" Message="NONE"  CausesValidation="False" Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
							id="btnNewTask" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
							id="btnNewIssue" runat="server" Message="NONE"  CausesValidation="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
							id="btnDelete" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton><cc1:BWImageButton 
							id="btnStatus" runat="server"  Visible ="false" />
							</td>
					</tr>
				</table>
				<asp:placeholder id="pnlStyleChangeAlertPage" runat="server"></asp:placeholder>
				<asp:PlaceHolder id="pnlStyleIDAlertPage" runat="server"></asp:PlaceHolder>
				<table height="90%" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr>
						<td valign="top" bgColor="#ffffff"><!--
							<table cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr>
									<td>
										<DIV align="right">
											<asp:label id="lblStyleHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
												ForeColor="#E0E0E0">Edit Style...</asp:label></DIV>
									</td>
								</tr>
							</table>
							-->
							<asp:panel id="pnlStyle" runat="server">
								<BR>
								<table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
									<tr valign="top">
										<td width="10">&nbsp;</td>
										<td>
											<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
									</tr>
								</table>
								<BR>
								<asp:placeholder id="pnlStyleComments1" runat="server"></asp:placeholder>
							</asp:panel>
							<table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
								border="0">
								<tr valign="top">
									<td width="33%"></td>
									<td width="33%"></td>
									<td width="33%"></td>
								</tr>
							</table>
						</td>
						<td width="10%" bgColor="#f5f5f5">&nbsp;</td>
					</tr>
				</table>
			</asp:panel><asp:panel id="Panel3" runat="server">
				<table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0"
					runat="server">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td height="24">
							<cc1:confirmedimagebutton id="btnSaveDetail" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					</tr>
				</table>
				<uc1:Style_Header id="Style_header2" runat="server"></uc1:Style_Header>
				<BR>
				<asp:placeholder id="pnlStyleComments3" runat="server"></asp:placeholder>
				<table height="90%" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr>
						<td valign="top" bgColor="#ffffff"><!--
							<table cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr>
									<td>
										<DIV align="right">
											<asp:label id="Label1" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large" ForeColor="#E0E0E0">Edit Detail...</asp:label></DIV>
									</td>
								</tr>
							</table>
							--><BR>
							<table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr valign="top">
									<td width="10">&nbsp;</td>
									<td>&nbsp;
										<asp:TextBox id="txtStyleDetail" runat="server" Height="400px" Width="800px" TextMode="MultiLine"
											DESIGNTIMEDRAGDROP="77"></asp:TextBox></td>
								</tr>
							</table>
							<table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
								border="0">
								<tr valign="top">
									<td width="33%"></td>
									<td width="33%"></td>
									<td width="33%"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				
			</asp:panel><asp:panel id="Panel4" runat="server">
				<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td height="24">
							<cc1:confirmedimagebutton id="btnSaveDetail1" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					</tr>
				</table>
				<uc1:Style_Header id="Style_header3" runat="server"></uc1:Style_Header>
				<BR>
				<asp:placeholder id="pnlStyleComments4" runat="server"></asp:placeholder>
				<table height="90%" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr>
						<td valign="top" bgColor="#ffffff"><BR>
							<table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr valign="top">
									<td width="10">&nbsp;</td>
									<td>&nbsp;
										<asp:TextBox id="txtStyleDetail1" runat="server" Height="400px" Width="800px" TextMode="MultiLine"></asp:TextBox></td>
								</tr>
							</table>
							<table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
								border="0">
								<tr valign="top">
									<td width="33%"></td>
									<td width="33%"></td>
									<td width="33%"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</asp:panel>
            <asp:panel id="PanelImg" runat="server" EnableViewState="TRUE">
            <table height="25" cellspacing="0" cellpadding="1" width="100%" border="0">
					<tr class="TableHeader" bgColor="whitesmoke">
						<td style="WIDTH: 11px" valign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td class="fonthead">
							<cc1:confirmedimagebutton id="imgBtnFolderImage" runat="server" Message="NONE"  Visible="false"
								ToolTip="Edit Image ..."></cc1:confirmedimagebutton>
								<cc1:confirmedimagebutton id="imgBtnDownload" runat="server" Message="NONE" 
								ToolTip="Download Image ..."></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnEditImage" runat="server" Message="NONE" Visible="false"
								ToolTip="Edit Image File..."></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnSaveForm" runat="server" Message="NONE" Visible="false"
								CausesValidation="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnCreateNewImage" runat="server" Message="NONE" Visible="false"></cc1:confirmedimagebutton>
							<%--<cc1:confirmedimagebutton id="imgBtnImageSelect" runat="server" Message="NONE" 
								CausesValidation="False"></cc1:confirmedimagebutton>--%>
							<cc1:confirmedimagebutton id="btnUpdate" runat="server" Message="NONE" 
								Visible="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnCancelUpdate" runat="server" Message="NONE" 
								Visible="False"></cc1:confirmedimagebutton>
							<%--<cc1:confirmedimagebutton id="imgBtnCopyImage" runat="server" Message="Are you sure you want to copy this image?"
								ToolTip="Copy Image From..." DESIGNTIMEDRAGDROP="18"></cc1:confirmedimagebutton>--%>
							<cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server" Visible="false" Message="Do you want to remove this image?"
								ToolTip="Delete Image From Style..."></cc1:confirmedimagebutton></td>
													</tr>
				</table>
				<uc1:Style_Header id="Style_Header1" runat="server"></uc1:Style_Header>
				<BR>
				<asp:placeholder id="pnlStyleComments2" runat="server"></asp:placeholder>
                <asp:datalist id="DataListImg" runat="server" Width="100%" OnItemCommand="DataListImg_ItemCommand"
				OnItemDataBound="DataListImg_ItemDataBound" DataKeyField="StyleDetailFormID" RepeatColumns="2"
				RepeatDirection="Horizontal" EnableViewState="True">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="White">
				</ItemStyle>
				<AlternatingItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="AliceBlue">
				</AlternatingItemStyle>	
				<ItemTemplate>
					<table style="border-color:silver" cellspacing="2" cellpadding="2" width="100%" border="0">
					     <tr>
					     <td>
					        <asp:label id="lblHeader" runat="server" CssClass="fontHead"></asp:label>
					     </td>
					     </tr>
						<tr>
							<td align="left" valign="top">							
					                  <cc1:bwimagebutton id="btnImageNew" runat="server" visible="false"></cc1:bwimagebutton>
					                  <cc1:bwimagebutton id="btnImageSelect" runat="server" visible="false"></cc1:bwimagebutton>	
								      <cc1:BWImageButton id="btnImageEdit" runat="server" CommandName="Window" visible="false"></cc1:BWImageButton>
								</td>						
							<td valign="top" style="height:150;" rowspan="2">	
							  <input id="txtRecID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "Rec_Id") %>' runat="server" />						   							
								<input id="txtImageVersion" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageVersion") %>' runat="server" />
								<input id="txtImageID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server" />
							</td>						
						</tr>
						<tr>
							<td style=" height:150; width:350px">
								<cc1:BWImageButton id="btnImgNewWindow" runat="server" 
									CommandName="Window" ></cc1:BWImageButton>
							</td>
						</tr>
					</table>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist>
            </asp:panel>
            <asp:panel id="Panel2" runat="server" EnableViewState="TRUE">
				
				<table style="WIDTH: 1000px; HEIGHT: 360px" cellspacing="0" cellpadding="1" width="1000"
					border="0">
					<tr>
						<td id="tblImage" valign="top" width="20%" runat="server">
							<table height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="whitesmoke" border="0">
								<tr class="TableHeader">
									<td style="WIDTH: 11px" valign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td>&nbsp;<asp:label id="lblImage" runat="server" CssClass="fontHead">Image...</asp:label></td>
								</tr>
							</table>
							<asp:panel id="pnlFileLocked" runat="server" Visible="False">
								<table cellspacing="0" cellpadding="1" width="100%" bgColor="#ea0000" border="0">
									<tr>
										<td width="10">&nbsp;</td>
										<td width="20"><IMG height="16" src="../System/Icons/icon_lock.gif" width="16"></td>
										<td>&nbsp;
											<asp:Label id="lblFileLocked" runat="server" ForeColor="White"></asp:Label></td>
									</tr>
								</table>
							</asp:panel>
							<asp:panel id="pnlVersionUpdate" runat="server" Visible="False">
								<table borderColor="limegreen" cellspacing="0" cellpadding="0" width="100%" bgColor="white"
									border="1">
									<tr>
										<td class="fonthead" align="center"><BR>
											<asp:Label id="lbVersionCurrent" runat="server"></asp:Label><BR>
											<BR>
											<cc1:confirmedimagebutton id="btnReplaceYes" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
											<asp:ImageButton id="btnReplaceNo" runat="server" ></asp:ImageButton><BR>
											<BR>
											<P></P>
										</td>
									</tr>
								</table>
							</asp:panel>
							<asp:panel id="pnlCurrentImage" runat="server" HorizontalAlign="Center">
								<asp:label id="lblMessageFileNotFound" runat="server" ForeColor="#C00000"></asp:label>
								<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
								<BR>
								<DIV align="center">
									<asp:label id="lbCopyFrom" runat="server" ForeColor="#C00000"></asp:label></DIV>
							</asp:panel></td>
						<td valign="top">
							<asp:panel id="pnlProperty" runat="server">
								<table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
									<tr class="TableHeader" bgColor="whitesmoke">
										<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td class="fonthead"><asp:label id="lblImageProperty" runat="server" CssClass="fontHead">Image Property...</asp:label></td>
									</tr>
								</table>
							</asp:panel>
							<asp:panel id="pnlUpload" runat="server" Visible="false">
								<table height="75" cellspacing="0" cellpadding="1" width="100%" border="0">
									<tr bgColor="#ffffff">
										<td style="WIDTH: 15px" width="16">&nbsp;</td>
										<td class="fontHead" width="125">&nbsp;<asp:label id="lblImageFile" runat="server" CssClass="fontHead">Image File</asp:label></td>
										<td>&nbsp; <INPUT id="File1" type="file" name="file1" runat="server">&nbsp;<INPUT id="btnImageUpload" type="submit" value="Upload" name="Upload" runat="server">
										</td>
									</tr>
								</table>
							</asp:panel>
							<asp:placeholder id="plhImageControlHolder" runat="server" EnableViewState="FALSE"></asp:placeholder><BR>
							<table height="25" cellspacing="0" cellpadding="1" width="100%" border="0">
								<tr class="TableHeader" bgColor="whitesmoke">
									<td width="10">&nbsp;</td>
									<td class="fonthead"><asp:label id="lblImageHistory" runat="server" CssClass="fontHead">Image History...</asp:label></td>
								</tr>
							</table>
							<table cellspacing="0" cellpadding="1" width="100%" border="0">
								<tr>
									<td valign="top">
										<asp:datalist id="dlImageHistory" runat="server" EnableViewState="true" ShowHeader="False" ShowFooter="False"
											cellspacing="0" CellPadding="0" RepeatDirection="Horizontal" RepeatColumns="3" OnItemCommand="DataList1_ItemCommand">
											<ItemTemplate>
												<table cellspacing="0" cellpadding="1" width="125" border='<%# SelectHTMLImageCurrentVersion(DataBinder.Eval(Container.DataItem,"Version")) %>' bordercolor=CornflowerBlue>
													<tr bgColor="#ffffff">
														<td valign="middle" align="center">
															<cc1:ConfirmedImageButton id=imgBtnImage Enabled='true' runat="server"  Message='NONE' CommandName="Edit">
															</cc1:ConfirmedImageButton></td>
													</tr>
													<tr bgColor="#ffffff">
														<td class="font" valign="middle" align="center"><%#GetSystemText("Version")%>:
															<asp:Label id="lblVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>'/>
														</td>
													</tr>
													<tr bgColor="#ffffff">
														<td class="font" valign="middle" align="center"><%#GetSystemText("Last Modified")%>:<%#SystemHandler.GetLocalTime(DataBinder.Eval(Container.DataItem, "ImageDateLastModified"))%></td>
													</tr>
												</table>
											</ItemTemplate>
										</asp:datalist></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
					border="0">
					<tr valign="top">
						<td width="33%"></td>
						<td width="33%"></td>
						<td width="33%"></td>
					</tr>
				</table>
				<P>&nbsp;</P>
			</asp:panel><asp:panel id="Panel5" runat="server">
				<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td height="24">
							<cc1:confirmedimagebutton id="btnSaveDetail2" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					</tr>
				</table>
				<uc1:Style_Header id="Style_header4" runat="server"></uc1:Style_Header>
				<BR>
				<asp:placeholder id="pnlStyleComments5" runat="server"></asp:placeholder>
				<table height="90%" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr>
						<td valign="top" bgColor="#ffffff"><BR>
							<table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr valign="top">
									<td width="10">&nbsp;</td>
									<td>&nbsp;
										<asp:TextBox id="txtStyleDetail2" runat="server" Height="400px" Width="800px" TextMode="MultiLine"
											DESIGNTIMEDRAGDROP="77"></asp:TextBox></td>
								</tr>
							</table>
							<table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
								border="0">
								<tr valign="top">
									<td width="33%"></td>
									<td width="33%"></td>
									<td width="33%"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</asp:panel>
			

			</form>
	</body>
</html>
