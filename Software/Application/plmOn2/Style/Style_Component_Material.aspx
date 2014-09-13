<%@ Register TagPrefix="uc1" TagName="ctrl_Style_Component_Where" Src="Style_Component_Where.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Component_Header" Src="Style_Component_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Material_Comment" Src="../Material/Material_Comment.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Material.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Material" debug="True"%>
<%@ Register TagPrefix="uc1" TagName="Style_Component_Add_Version" Src="Style_Component_Add_Version.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="../Material/Material_Header.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Material Edit</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<uc1:style_component_add_version id="Style_Component_Add_Version1" runat="server"></uc1:style_component_add_version><br />
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:panel id="Panel0" runat="server" Width="1216px" BackColor="White">
				<table class="TableHeader" id="Table13" cellspacing="0" cellpadding="0" width="100%" border="0"
					runat="server">
					<tr valign="middle">
						<td valign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td>
							<cc1:confirmedimagebutton id="imgBtnsave" runat="server" Message="NONE" 
								ToolTip="Save Material..."></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnMaterialAdd" runat="server" Message="NONE" 
															ToolTip="Add New plmOnBizObj.Material to Style..." CausesValidation="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnMaterialRemove" runat="server" Message="Do you want to remove this Material?"
								 ToolTip="Remove Material From Style..." CausesValidation="False"></cc1:confirmedimagebutton>
							<cc1:bwImageButton id="btnGoTo" runat="server"  ToolTip="Go to the Material Folder..."
								CausesValidation="False"></cc1:bwImageButton>
							<cc1:confirmedimagebutton id="btnMaterialClose" runat="server" Message="NONE" 
								ToolTip="Close it and Go to Material List..." CausesValidation="False"></cc1:confirmedimagebutton></td>
					</tr>
				</table>
				<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
					<tr>
						<td></td>
					</tr>
				</table>
				<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
					height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td>&nbsp;
							<asp:Label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Material</asp:Label></td>
					</tr>
				</table>
				<table id="Table16" cellspacing="1" cellpadding="1" width="900" border="0">
					<tr>
						<td>
							<uc1:Style_Component_Header id="Style_Component_Header1" runat="server" SMID='<%# Request.Querystring("SMID") %>' FS='<%# Request.Querystring("FS") %>'>
							</uc1:Style_Component_Header></td>
					</tr>
				</table>
				<table cellspacing="1" cellpadding="1" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td style="WIDTH: 359px" valign="top" runat="server" id="tbcMaterialInfo">
							<table id="tbMainMaterial" borderColor="red" cellspacing="0" cellpadding="0" width="350"
								bgColor="lightsalmon" border="1" runat="server">
								<tr>
									<td>
										<table cellspacing="1" cellpadding="1" width="100%" border="0">
											<tr>
												<td class="fontHead" style="HEIGHT: 16px" width="100">&nbsp;<asp:label id="lblMainMaterial" runat="server" CssClass="fontHead">Main Material</asp:label>:</td>
												<td style="HEIGHT: 16px">
													<asp:CheckBox id="cbMainMaterial" runat="server"></asp:CheckBox></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
							<table height="5" cellspacing="0" cellpadding="0" width="350" border="0">
								<tr>
									<td></td>
								</tr>
							</table>
							<table borderColor="gold" cellspacing="0" cellpadding="0" width="350" bgColor="#ffff99"
								border="1">
								<tr>
									<td>
										<table cellspacing="1" cellpadding="1" width="100%" border="0">
											<tr>
												<td class="fontHead" style="HEIGHT: 16px" width="100">&nbsp;<asp:label id="lblColorwayLabel" runat="server" CssClass="fontHead"></asp:label>:</td>
												<td style="HEIGHT: 16px">
													<asp:DropDownList id="dlColorway" runat="server" Width="80px" CssClass="fonthead"></asp:DropDownList></td>
											</tr>
											<tr>
												<td class="fontHead" width="100">&nbsp;<asp:label id="lblArtworkLabel" runat="server" CssClass="fontHead"></asp:label>:</td>
												<td>
													<asp:DropDownList id="dlArtwork" runat="server" Width="80px" CssClass="fonthead"></asp:DropDownList></td>
											</tr>
											<tr>
												<td class="fontHead" width="100">&nbsp;<asp:label id="lblLicensee" runat="server" CssClass="fontHead">Licensee</asp:label>:</td>
												<td>
													<asp:DropDownList id="dlLicensee" runat="server" Width="80px" CssClass="fonthead"></asp:DropDownList></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
							<table height="5" cellspacing="0" cellpadding="0" width="350" border="0">
								<tr>
									<td></td>
								</tr>
							</table>
							<table borderColor="gainsboro" cellspacing="0" cellpadding="0" width="350" bgColor="whitesmoke"
								border="1">
								<tr>
									<td>
										<table cellspacing="1" cellpadding="1" width="100%" border="0">
											<tr>
												<td class="fontHead" width="100">&nbsp;<asp:label id="lblQty" runat="server" CssClass="fontHead">Qty</asp:label>:</td>
												<td height="10">
													<asp:TextBox id="txt_Unit" runat="server" Width="80px" CssClass="font"></asp:TextBox>
													<asp:RequiredFieldValidator id="rv_QtyReq" runat="server" ToolTip='<%=Getsystemtext("Qty Required!") %>' CssClass="fontHead" ControlToValidate="txt_Unit"
														ErrorMessage="Qty Required">*</asp:RequiredFieldValidator></td>
											</tr>
											<tr>
												<td class="fontHead" width="100" height="10">&nbsp;<asp:label id="lblUOM" runat="server" CssClass="fontHead">UOM</asp:label>:</td>
												<td height="10"><input type="hidden" runat="server" id="hdnUOM" />
													<asp:DropDownList id="dp_UOM" runat="server" Width="125px" CssClass="font"></asp:DropDownList></td>
											</tr>
											<tr>
												<td class="fontHead" width="100" height="10">&nbsp;<asp:label id="lblTreatmentSize" runat="server" CssClass="fontHead">Treatment/Size</asp:label>:</td>
												<td height="10">
													<asp:DropDownList id="dp_SizeWeight" runat="server" Width="125px" CssClass="font" AutoPostBack="true"></asp:DropDownList></td>
											</tr>
											<tr>
												<td class="fontHead" width="100" height="10">&nbsp;<asp:label id="lblPrice" runat="server" CssClass="fontHead">Price</asp:label>:</td>
												<td height="10"><input type="hidden" runat="server" id="hdnPrice" />
													<asp:TextBox id="txt_Price" runat="server" Width="80px" CssClass="font">0</asp:TextBox>
													<asp:RequiredFieldValidator id="rv_PriceReq" runat="server" ToolTip='<%=Getsystemtext("Price Required!") %>' CssClass="fonthead" ControlToValidate="txt_Price"
														ErrorMessage="Price Required!">*</asp:RequiredFieldValidator></td>
											</tr>
											<tr>
												<td class="fontHead" valign="top" width="100" height="10">
													&nbsp;<asp:label id="lblPlacement" runat="server" CssClass="fontHead">Placement</asp:label>:</td>
												<td height="10">
													<asp:TextBox id="txt_Placement"  TextMode="MultiLine" runat="server" Width="187px" Height="88px" MaxLength="4000" Rows="4"></asp:TextBox></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
						<td valign="top">
							<asp:image id="imgMaterial" runat="server" BorderColor="Transparent"></asp:image>
                        </td>
					</tr>
					<tr>
						<td style="WIDTH: 359px"></td>
						<td></td>
					</tr>
				</table>
			</asp:panel>
			
			
			<asp:panel id="Panel2" runat="server">
				<table id="Table1" height="25" cellspacing="0" cellpadding="1" width="100%" border="0">
					<tr class="TableHeader" bgColor="whitesmoke">
						<td style="WIDTH: 11px" valign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td class="fonthead">
							<cc1:confirmedimagebutton id="imgBtnFolderImage" runat="server" Message="NONE" 
								ToolTip="Edit Image ..." CausesValidation="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnEditImage" runat="server" Message="NONE" 
								ToolTip="Edit Image File..." CausesValidation="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnSaveForm" runat="server" Message="NONE" 
								CausesValidation="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnCreateNewImage" runat="server" Message="Are you sure you want to create new image?"
								></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnImageSelect" runat="server" Message="NONE" 
								CausesValidation="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnUpdate" runat="server" Message="NONE" 
								CausesValidation="False" Visible="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnCancelUpdate" runat="server" Message="NONE" 
								CausesValidation="False" Visible="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnCopyImage" runat="server" Message="Are you sure you want to copy this image?"
								 ToolTip="Copy Image From..." CausesValidation="False" DESIGNTIMEDRAGDROP="18"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server" Message="Do you want to remove this image?"
								 ToolTip="Delete Image From Style..." CausesValidation="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="Confirmedimagebutton2" runat="server" Message="NONE" 
								CausesValidation="False"></cc1:confirmedimagebutton></td>
					</tr>
				</table>
				<table id="Table2" height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="#cddeee"
					border="0">
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				<table id="Table3" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
					height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td>&nbsp;
							<asp:label id="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
								ForeColor="#E0E0E0">Material Image</asp:label></td>
					</tr>
				</table>
				<table id="Table8" cellspacing="1" cellpadding="1" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900" bgColor="#ffffff">
							<uc1:Style_Component_Header id=Style_Component_Header3 runat="server" SMID='<%# Request.Querystring("SMID") %>' FS='<%# Request.Querystring("FS") %>'>
							</uc1:Style_Component_Header></td>
						<td></td>
					</tr>
				</table>
				<table id="Table4" cellspacing="0" cellpadding="1" width="100%" border="0">
					<tr>
						<td id="tblImage" valign="top" width="20%" runat="server">
							<table id="Table5" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="whitesmoke"
								border="0">
								<tr class="TableHeader">
									<td style="WIDTH: 11px" valign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td>&nbsp;<asp:label id="lblImageLabel" runat="server" CssClass="fontHead">&nbsp;Image</asp:label>...</td>
								</tr>
							</table>
							<asp:panel id="pnlFileLocked" runat="server" Visible="False">
								<table id="Table6" cellspacing="0" cellpadding="1" width="100%" bgColor="#ea0000" border="0">
									<tr>
										<td width="10">&nbsp;</td>
										<td width="20"><IMG height="16" src="../System/Icons/icon_lock.gif" width="16"></td>
										<td>&nbsp;
											<asp:Label id="lblFileLocked" runat="server" ForeColor="White"></asp:Label></td>
									</tr>
								</table>
							</asp:panel>
							<asp:panel id="pnlVersionUpdate" runat="server" Visible="False">
								<table id="Table7" borderColor="limegreen" cellspacing="0" cellpadding="0" width="100%"
									bgColor="white" border="1">
									<tr>
										<td class="fonthead" align="center"><br />
											<asp:label id="lblReplaceVersionNumber" runat="server" CssClass="fontHead">Do you want to replace version # with this version #?</asp:label>
											<br />
											<br />
											<cc1:confirmedimagebutton id="btnReplaceYes" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
											<asp:ImageButton id="btnReplaceNo" runat="server" ></asp:ImageButton><br />
											<br />
											<P></P>
										</td>
									</tr>
								</table>
							</asp:panel>
							<asp:panel id="pnlCurrentImage" runat="server" HorizontalAlign="Center">
								<asp:label id="lblMessageFileNotFound" runat="server" ForeColor="#C00000"></asp:label>
								<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
								<br />
								<asp:label id="lbCopyFrom" runat="server" ForeColor="#C00000"></asp:label>
							</asp:panel></td>
						<td valign="top">
							<asp:panel id="pnlProperty" runat="server">
								<table id="Table9" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
									<tr class="TableHeader" bgColor="whitesmoke">
										<td valign="middle" align="center" width="10">
                                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td class="fonthead"><asp:label id="lblImagePropertyLabel" runat="server" CssClass="fontHead">Image Property</asp:label>...</td>
									</tr>
								</table>
							</asp:panel>
							<asp:panel id="pnlUpload" runat="server" Visible="false">
								<table id="Table10" height="75" cellspacing="0" cellpadding="1" width="100%" border="0">
									<tr bgColor="#ffffff">
										<td style="WIDTH: 15px" width="16">&nbsp;</td>
										<td class="fontHead" width="125">&nbsp;<asp:label id="lblImageFileLabel" runat="server" CssClass="fontHead">Image File</asp:label></td>
										<td>&nbsp; <INPUT id="File1" type="file" name="file1" runat="server">&nbsp;<INPUT id="btnUploadImage" type="submit" value="Upload" name="Upload" runat="server"></td>
									</tr>
								</table>
							</asp:panel>
							<asp:placeholder id="plhImageControlHolder" runat="server" EnableViewState="False"></asp:placeholder>
                            <br />
							<table id="Table11" border="0" cellpadding="1" cellspacing="0" 
                        height="25" width="100%">
								<tr bgcolor="whitesmoke" class="TableHeader">
									<td width="10">&#160;</td>
									<td class="fontHead"><asp:label id="lblImageHistoryLabel" runat="server" CssClass="fontHead">Image History</asp:label>...</td>
								</tr>
							</table>
							<table id="Table12" border="0" cellpadding="1" cellspacing="0" 
                        width="100%">
								<tr>
									<td valign="top">
										<asp:DataList ID="dlImageHistory" runat="server" 
                        CellPadding="0" cellspacing="0" EnableViewState="true" RepeatColumns="3" 
                        RepeatDirection="Horizontal" ShowFooter="False" ShowHeader="False">
											<ItemTemplate>
												<table 
                                                    border='<%# SelectHTMLImageCurrentVersion(DataBinder.Eval(Container.DataItem,"Version")) %>' 
                                                    bordercolor="CornflowerBlue" cellpadding="1" cellspacing="0" width="125">
													<tr bgcolor="#ffffff">
														<td align="center" valign="middle">
															<cc1:ConfirmedImageButton ID="imgBtnImage" runat="server" 
                                                    CommandName="Edit" enabled="<%# ModifyMaterialAccess() %>" 
                                                    ImageUrl='<%# string.Concat("../Image/Image_Thumbnail.aspx?S=100&amp;Path=" &amp; Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("STORAGE"))("IMAGETHUMBPATH")&amp; "\{" &amp; DataBinder.Eval(Container.DataItem,"ImageID").tostring &amp; "}\Version\000\{" &amp; DataBinder.Eval(Container.DataItem,"ImageHistoryID").tostring &amp; "}.jpg") %>' 
                                                    Message='<%# string.Concat(" Do you want to view version " &amp; DataBinder.Eval(Container.DataItem,"Version").tostring &amp; "?") %>'>
															</cc1:ConfirmedImageButton></td>
													</tr>
													<tr bgcolor="#ffffff">
														<td align="center" class="font" valign="middle"><%#GetSystemText("Version")%>:
															<asp:Label ID="lblVersion" runat="server" 
                                                    Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>' />
														</td>
													</tr>
													<tr bgcolor="#ffffff">
														<td align="center" class="font" valign="middle"><%#GetSystemText("Last Modified")%>:<%#GetLocalTime(DataBinder.Eval(Container.DataItem, "ImageDateLastModified"))%></td>
													</tr>
												</table>
											</ItemTemplate>
                                            
										</asp:DataList></td>
								</tr>
							</table>
						    <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
						    <br />
						</td>
					</tr>
				</table>
			</asp:panel><asp:panel id="Panel3" runat="server">
				<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td>
							<cc1:confirmedimagebutton id="btnBatchUpdate" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnwhereusedclose" runat="server" Message="NONE" 
								ToolTip="Close it and Go to Material List..." CausesValidation="False"></cc1:confirmedimagebutton></td>
						<td width="80">
						</td>
						<td width="75">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				<table height="5" cellspacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
					<tr>
						<td></td>
					</tr>
				</table>
				<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
					height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td>&nbsp;
							<asp:Label id="lblMaterialWhereUsed" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
								ForeColor="#E0E0E0">Material Where Used...</asp:Label></td>
					</tr>
				</table>
				<table id="Table18" cellspacing="1" cellpadding="1" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc1:Style_Component_Header id=Style_Component_Header2 runat="server" SMID='<%# Request.Querystring("SMID") %>' FS='<%# Request.Querystring("FS") %>'>
							</uc1:Style_Component_Header></td>
						<td></td>
					</tr>
				</table>
				<table id="Table14" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr bgColor="#ffffff">
						<td valign="top">
							<asp:datagrid id="dgStyletype" runat="server" Width="100%" BorderColor="Silver" AutoGenerateColumns="false"
								ShowHeader="False">
								<Columns>
									<asp:TemplateColumn>
										<ItemTemplate>
											<table cellspacing="0" cellpadding="0" width="100%" border="0">
												<tr class="TableHeader">
													<td width="10" bgColor="white" height="24"></td>
													<td class="fontHead" bgColor="white"><%#GetSystemText("Version No")%>.
														<%# DataBinder.Eval(Container.DataItem, "MChange") %>
													</td>
												</tr>
											</table>
											<uc1:ctrl_Style_Component_Where id="Ctrl_Style_Component_Where1" runat="server" MV='<%# DataBinder.Eval(Container.DataItem, "MChange") %>' MTID='<%# DataBinder.Eval(Container.DataItem, "MaterialID") %>'>
											</uc1:ctrl_Style_Component_Where>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></td>
					</tr>
				</table>
			</asp:panel></form>
	</body>
</html>
