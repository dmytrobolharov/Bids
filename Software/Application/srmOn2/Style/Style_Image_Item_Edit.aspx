<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Image_Item_Edit.aspx.vb" Inherits="srmOnApp.Style_Image_Item_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title runat="server" id="PageTitle"></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
		<script type="text/javascript" language="javascript">
            function CheckDetails(con) {
                if (Page_ClientValidate() == true) {
                    //hide the original submit button
                    con.style.display = "none";
                    //show the html image instead of original button                   
                    document.getElementById("btnhide").style.display = "";
                    return true;
                }
                else {
                    return false;
                }
            }
        </script> 
	</head>
	<body>
		<form id="Form1" method="post" encType="multipart/form-data" runat="server">
			<!--

			-->
			<table height="25" cellSpacing="0" cellpadding="1" width="100%" border="0">
				<tr class="TableHeader" bgColor="whitesmoke">
					<td style="WIDTH: 11px" valign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fonthead"><cc1:confirmedimagebutton id="imgBtnFolderImage" runat="server" ToolTip="Edit Image ..." visible="false"
							Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnDownload" runat="server" Message="NONE" 
								ToolTip="Download Image ..."></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnEditImage" runat="server" ToolTip="Edit Image File..." visible="false"
							Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnSaveForm" runat="server"  Message="NONE"
							CausesValidation="False"></cc1:confirmedimagebutton>	
													
							<img  id="btnhide" runat="server" style="display:none;" />
														
							<cc1:confirmedimagebutton id="btnCreateNewImage" runat="server"  OnClientClick="return CheckDetails(this);"
							Message="NONE"></cc1:confirmedimagebutton>
														
							<cc1:confirmedimagebutton id="imgBtnImageSelect" runat="server" visible="false"
							Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnUpdate" runat="server"  Message="NONE"
							Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnCancelUpdate" runat="server"  Message="NONE"
							CausesValidation="False" Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnCopyImage" runat="server" ToolTip="Copy Image From..." 
							DESIGNTIMEDRAGDROP="18"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server" ToolTip="Remove Image From Style..." 
							Message="Do you want to remove this image?" CausesValidation="False"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table id="Table1" cellSpacing="1" cellpadding="1" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900"><asp:placeholder id="plhHeaderControl" runat="server"></asp:placeholder></td>
					<td></td>
				</tr>
			</table>
			<br>
			<table cellSpacing="0" cellpadding="1" width="100%" border="0">
				<tr>
					<td id="tblImage" valign="top" width="20%" runat="server" >
						<table cellSpacing="0" cellpadding="0" width="100%" >
							<tr><td colspan="3"><table height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="whitesmoke" border="0">
								<tr class="TableHeader">
									<td style="WIDTH: 11px" valign="middle" align="center" width="11"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td>&nbsp;<asp:label id="lblImage" runat="server" CssClass="fontHead">Image...</asp:label></td>
								</tr>
								</table>
							</td>
							</tr>
							<tr bgColor="#ffffff" >
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><asp:panel id="pnlFileLocked" runat="server" Visible="False">
										<table cellSpacing="0" cellpadding="1" width="100%" bgColor="#ea0000" border="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td width="20"><IMG height="16" src="../System/Icons/icon_lock.gif" width="16"></td>
												<td>&nbsp;
													<asp:Label id="lblFileLocked" runat="server" ForeColor="White"></asp:Label></td>
											</tr>
										</table>
									</asp:panel><asp:panel id="pnlVersionUpdate" runat="server" Visible="False">
										<table borderColor="limegreen" cellSpacing="0" cellpadding="0" width="100%" bgColor="white"
											border="1">
											<tr>
												<td class="fonthead" align="center"><BR>
													<asp:Label id="lbVersionCurrent" runat="server"></asp:Label><BR>
													<BR>
													<cc1:confirmedimagebutton id="btnReplaceYes" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
													<asp:ImageButton id="btnReplaceNo" runat="server" ></asp:ImageButton><BR>
													<BR>
													<P></P>
												</td>
											</tr>
										</table>
									</asp:panel><asp:panel id="pnlCurrentImage" runat="server" HorizontalAlign="Center">
										<asp:label id="lblMessageFileNotFound" runat="server" ForeColor="#C00000"></asp:label>
										<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
										<BR>
										<DIV align="center">
											<asp:label id="lbCopyFrom" runat="server" ForeColor="#C00000"></asp:label></DIV>
									</asp:panel>								
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr> 
							
						</table>
					</td>
					<td valign="top" bgColor="#ffffff"><asp:panel id="pnlProperty" runat="server">
							<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
								<tr class="TableHeader" bgColor="whitesmoke">
									<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td class="fonthead"><asp:label id="lblImageProperty" runat="server" CssClass="fontHead">Image Property...</asp:label></td>
								</tr>
							</table>
						</asp:panel><asp:panel id="pnlUpload" runat="server" Visible="false">
							<table height="75" cellSpacing="0" cellpadding="1" width="100%" border="0">
								<tr bgColor="#ffffff">
									<td style="WIDTH: 15px" width="16">&nbsp;</td>
									<td class="fontHead" width="125">&nbsp;<asp:label id="lblImageFile" runat="server" CssClass="fontHead">Image File</asp:label></td>
									<td>&nbsp; <INPUT id="File1" type="file" name="file1" runat="server">&nbsp;<INPUT id="btnImageUpload" type="submit" value="Upload" name="Upload" runat="server"></td>
								</tr>
							</table>
						</asp:panel>&nbsp;&nbsp;&nbsp;<asp:checkbox id="cbImageLinked" runat="server" CssClass="fontred" Text=" Link Image to all size class <BR>"
							Font-Bold="True" Checked="True"></asp:checkbox><br>
						<asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder>
						<table height="25" cellSpacing="0" cellpadding="1" width="100%" border="0">
							<tr class="TableHeader" bgColor="whitesmoke">
								<td width="10">&nbsp;</td>
								<td class="fonthead"><asp:label id="lblImageHistory" runat="server" CssClass="fontHead">Image History...</asp:label></td>
							</tr>
						</table>
						<table cellSpacing="0" cellpadding="1" width="100%" border="0">
							<tr>
								<td valign="top"><asp:datalist id="DataList1" runat="server" ShowHeader="False" ShowFooter="False" RepeatDirection="Horizontal"
										RepeatColumns="3" EnableViewState="true" CellSpacing="0" CellPadding="0" OnItemCommand="DataList1_ItemCommand">
										<ItemTemplate>
											<table cellSpacing="0" cellpadding="1" width="125" border='<%# SelectHTMLImageCurrentVersion(DataBinder.Eval(Container.DataItem,"Version")) %>' bordercolor=CornflowerBlue>
												<tr bgColor="#ffffff">
													<td valign="middle" align="center">
														<cc1:ConfirmedImageButton id=imgBtnImage runat="server"  Message='<%# string.Concat(" Do you want to view version " &amp; DataBinder.Eval(Container.DataItem,"Version").tostring &amp; "?") %>' CommandName="Edit">
														</cc1:ConfirmedImageButton></td>
												</tr>
												<tr bgColor="#ffffff">
													<td class="font" valign="middle" align="center"><%#GetSystemText("Version")%>:
														<asp:Label id="lblVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>'/>
													</td>
												</tr>
												<tr bgColor="#ffffff">
													<td class="font" valign="middle" align="center"><%#GetSystemText("Last Modified")%>:<%#SystemHandler.GetLocalTime(DataBinder.Eval(Container.DataItem, "MDate"))%></td>
												</tr>
											</table>
										</ItemTemplate>
									</asp:datalist></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
		</form>
	</body>
</html>
