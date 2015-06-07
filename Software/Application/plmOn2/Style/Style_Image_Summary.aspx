<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Image_Summary.aspx.vb" Inherits="plmOnApp.Style.Image.Style_Image_Summary" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td valign="middle" align="left">&nbsp;
						<cc1:confirmedimagebutton id="btnBurn" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnNewTask" runat="server"  Message="NONE" OnClientClick="btnNewTask_Click()"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnNewIssue" runat="server" Message="NONE" OnClientClick="btnNewIssue_Click()" CausesValidation="False"></cc1:confirmedimagebutton>
                        <cc1:BWImageButton ID="btnPrint" runat="server"  />
                    </td>
				</tr>
			</table>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table cellSpacing="1" cellpadding="0" width="100%" bgColor="#cccccc" border="0">
				<tr bgColor="#ffffff">
					<td valign="top" width="100%">
						<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" valign="middle" align="left">&nbsp;<asp:label id="lblStyle" runat="server" CssClass="fontHead">Style</asp:label></td>
							</tr>
						</table>
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td width="201" valign="top">
									<table id="TBDesignSketch" height="200" cellSpacing="1" cellpadding="1" width="200" bgColor="#cccccc"
										border="0" runat="server">
										<tr>
											<td class="fontHead" bgColor="#ffffff" height="25"><asp:label id="lblDesignSketch" runat="server" CssClass="fontHead">Design Sketch</asp:label></td>
										</tr>
									    <tr>
									        <td>
											    <table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" >
				                                    <tr>
				                                        <td><asp:Label ID="lblBtnDesignDetail" runat="server"></asp:Label></td>
				                                    </tr>
				                                </table>
				                            </td>
									    </tr>
										<tr>
											<td bgColor="#ffffff">&nbsp;
												<asp:Image id="imgDesignDetail" runat="server"></asp:Image></td>
										</tr>
									</table>
								</td>

							</tr>
						</table>
						<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" valign="middle" align="left">&nbsp;<asp:label id="lblDesignDetail" runat="server" CssClass="fontHead">Design Detail</asp:label></td>
							</tr>
						</table>
						<asp:datalist id="dlDetail" runat="server" CellPadding="0" RepeatDirection="Horizontal" RepeatColumns="4"
							Datakeyfield="StyleImageItemID">
							<ItemStyle Height="200px" Width="200px" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<table height="200" cellSpacing="1" cellpadding="1" width="200" bgColor="#cccccc" border="0">
									<tr>
										<td class="fontHead" bgColor="#ffffff" height="25">&nbsp;
											<asp:Label id="Label2" runat="server"></asp:Label>
										</td>
									</tr>	
									<tr>
									    <td>
											<table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" >
				                                <tr>
				                                    <td><asp:Label ID="lblBtnDetail" runat="server"></asp:Label></td>
				                                </tr>
				                            </table>
				                        </td>
									</tr>
									<tr>
										<td bgColor="#ffffff">&nbsp;
											<asp:Image id="ImgdlDetails" runat="server" ></asp:Image></td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:datalist>
						<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" valign="middle" align="left">&nbsp;<asp:label id="lblMaterial" runat="server" CssClass="fontHead">Material</asp:label></td>
							</tr>
						</table>
						<asp:datalist id="dlMaterial" runat="server" Datakeyfield="StyleMaterialID" RepeatColumns="4"
							RepeatDirection="Horizontal" CellPadding="0">
							<ItemStyle Height="200px" Width="200px" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<table id="tbTable1" height="200" cellSpacing="1" cellpadding="1" width="200" bgColor="#cccccc"
									border="0">
									<tr>
										<td class="fontHead" bgColor="#ffffff" height="25">&nbsp;
											<asp:Label id="lblLabel1" runat="server"></asp:Label></td>
									</tr>
									<tr>
									    <td>
											<table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" >
				                                <tr>
				                                    <td><asp:Label ID="lblBtnMaterial" runat="server"></asp:Label></td>
				                                </tr>
				                            </table>
				                        </td>
									</tr>
									<tr>
										<td bgColor="#ffffff">&nbsp;
											<asp:Image id="imgMaterial" runat="server">
											</asp:Image></td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:datalist>
                        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td valign="middle" align="center" width="10">
                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                                </td>
                                <td class="TableHeader" valign="middle" align="left">
                                    <asp:Label ID="lblColorwayImages" runat="server" CssClass="fontHead">Colorway Images</asp:Label>
                                </td>
                            </tr>
                        </table>
                        <asp:DataList ID="dlColorwayImages" runat="server" DataKeyField="StyleColorwaySeasonYearID" RepeatColumns="4" RepeatDirection="Horizontal"
                            CellPadding="0">
                            <ItemStyle Height="200px" Width="200px" VerticalAlign="Top"></ItemStyle>
                            <ItemTemplate>
                                <table id="tbTable2" height="200" cellspacing="1" cellpadding="1" width="200" bgcolor="#cccccc" border="0">
                                    <tr>
                                        <td class="fontHead" bgcolor="#ffffff" height="25">
                                            &nbsp;
                                            <asp:Label ID="lblLabel2" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="TableHeader" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblBtnColorwayImages" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#ffffff">
                                            &nbsp;
                                            <asp:Image ID="imgColorwayImages" runat="server"></asp:Image>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
						<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" valign="middle" align="left"><asp:label id="lblArtwork" runat="server" CssClass="fontHead">Artwork</asp:label></td>
							</tr>
						</table>
						<asp:datalist id="dlArtwork" runat="server" Datakeyfield="StyleMaterialID" RepeatColumns="4" RepeatDirection="Horizontal"
							CellPadding="0">
							<ItemStyle Height="200px" Width="200px" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<table id="tbTable2" height="200" cellSpacing="1" cellpadding="1" width="200" bgColor="#cccccc"
									border="0">
									<tr>
										<td class="fontHead" bgColor="#ffffff" height="25">&nbsp;
											<asp:Label id="lblLabel2" runat="server"></asp:Label></td>
									</tr>
									<tr>
									    <td>
											<table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" >
				                                <tr>
				                                    <td><asp:Label ID="lblBtnArtwork" runat="server"></asp:Label></td>
				                                </tr>
				                            </table>
				                        </td>
									</tr>
									<tr>
										<td bgColor="#ffffff">&nbsp;
											<asp:Image id="imgArtwork" runat="server" >
											</asp:Image></td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:datalist>
						<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" valign="middle" align="left">&nbsp;<asp:label id="lblLicense" runat="server" CssClass="fontHead">License</asp:label></td>
							</tr>
						</table>
						<asp:datalist id="dlLicense" runat="server" Datakeyfield="StyleMaterialID" RepeatColumns="4" RepeatDirection="Horizontal"
							CellPadding="0">
							<ItemStyle Height="200px" Width="200px" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<table id="Table1" height="200" cellSpacing="1" cellpadding="1" width="200" bgColor="#cccccc"
									border="0">
									<tr>
										<td class="fontHead" bgColor="#ffffff" height="25">&nbsp;
											<asp:Label id="Label1" runat="server"></asp:Label></td>
									</tr>
									<tr>
									    <td>
											<table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" >
				                                <tr>
				                                    <td><asp:Label ID="lblBtnLicense" runat="server"></asp:Label></td>
				                                </tr>
				                            </table>
				                        </td>
									</tr>
									<tr>
										<td bgColor="#ffffff">&nbsp;
											<asp:Image id="imgLicense" runat="server">
											</asp:Image></td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:datalist>
						<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="TableHeader" valign="middle" align="left"><asp:label id="lblDevelopmentSpec" runat="server" CssClass="fontHead">Development Spec</asp:label></td>
							</tr>
						</table>
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td width="201" valign="top">
									<table height="200" cellSpacing="1" cellpadding="1" width="200" bgColor="#cccccc" border="0">
										<tr>
											<td class="fontHead" bgColor="#ffffff" height="25">&nbsp;
												<asp:Label id="lblDevelopmentSpec1" runat="server"></asp:Label></td>
										</tr>
									    <tr>
									        <td>
											    <table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" >
				                                    <tr>
				                                        <td><asp:Label ID="lblBtnDevelopmentSpec1" runat="server"></asp:Label></td>
				                                    </tr>
				                                </table>
				                            </td>
									    </tr>
										<tr>
											<td bgColor="#ffffff">&nbsp;
												<asp:Image id="imgDevelopmentSpec1" runat="server"></asp:Image></td>
										</tr>
									</table>
								</td>
								
								<td width="201" valign="top" runat="server" id="tdSet2" >
									<table height="200" cellSpacing="1" cellpadding="1" width="200" bgColor="#cccccc" border="0">
										<tr>
											<td class="fontHead" bgColor="#ffffff" height="25">
												<asp:Label id="lblDevelopmentSpec2" runat="server"></asp:Label></td>
										</tr>
									    <tr>
									        <td>
											    <table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" >
				                                    <tr>
				                                        <td><asp:Label ID="lblBtnDevelopmentSpec2" runat="server"></asp:Label></td>
				                                    </tr>
				                                </table>
				                            </td>
									    </tr>
										<tr>
											<td bgColor="#ffffff">&nbsp;
												<asp:Image id="imgDevelopmentSpec2" runat="server"></asp:Image></td>
										</tr>
									</table>
								</td>
								<td width="201" valign="top" runat="server" id="tdSet3">
									<table height="200" cellSpacing="1" cellpadding="1" width="200" bgColor="#cccccc" border="0">
										<tr>
											<td class="fontHead" bgColor="#ffffff" height="25">
												<asp:Label id="lblDevelopmentSpec3" runat="server"></asp:Label></td>
										</tr>
									    <tr>
									        <td>
											    <table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" >
				                                    <tr>
				                                        <td><asp:Label ID="lblBtnDevelopmentSpec3" runat="server"></asp:Label></td>
				                                    </tr>
				                                </table>
				                            </td>
									    </tr>
										<tr>
											<td bgColor="#ffffff">&nbsp;
												<asp:Image id="imgDevelopmentSpec3" runat="server"></asp:Image></td>
										</tr>
									</table>
								</td>
								<td valign="top" runat="server" id="tdSet4">
									<table height="200" cellSpacing="1" cellpadding="1" width="200" bgColor="#cccccc" border="0">
										<tr>
											<td class="fontHead" bgColor="#ffffff" height="25">
												<asp:Label id="lblDevelopmentSpec4" runat="server"></asp:Label></td>
										</tr>
									    <tr>
									        <td>
											    <table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" >
				                                    <tr>
				                                        <td><asp:Label ID="lblBtnDevelopmentSpec4" runat="server"></asp:Label></td>
				                                    </tr>
				                                </table>
				                            </td>
									    </tr>
										<tr>
											<td bgColor="#ffffff">&nbsp;
												<asp:Image id="imgDevelopmentSpec4" runat="server"></asp:Image></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
        <script type="text/javascript">
	        function btnNewTask_Click() {
		        <%= strNewTaskScript %>
                return false;
            }
	        function btnNewIssue_Click() {
		        <%= strNewIssueScript %>
                return false;
            }
        </script>
	</body>
</html>
