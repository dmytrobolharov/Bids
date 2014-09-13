<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_Copy_Folder.aspx.vb" Inherits="plmOnApp.Color_Copy_Folder" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<style type="text/css">
		    #DataList1 td.fontHead
		    {
		    	width: 35px;
		    	height: 40px;
		        border-right-style: solid;
		        border-top-style: solid;
		        border-right-width: 1px;
		        border-top-width: 1px;
		    }
		    
		    #DataList1 td.font
		    {
		    	width: 200px;
		    	padding: 2px;
		        border-top-style: solid;
		        border-top-width: 1px;
		    }
		</style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton = "ImgbtnSearch">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblColorHeader" runat="server" ForeColor="#999999" 
                            Font-Size="X-Large" Font-Names="Tahoma,Verdana">Copy Color Palette...</asp:label></td>
				</tr>
			</table>
			   <table cellSpacing="0" cellPadding="0" width="100%" border="0" class="TableHeader">
				<tr>
					<td align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>&nbsp;<asp:Label ID="lblColorSearch" runat="server" Text=""></asp:Label></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<TR>
								<TD>
									<asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></TD>
							</TR>
						</table>
					</td>
				</tr>
			</table>  		
			<table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center" width="10" height="30"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:label id="lblSelectAll" CssClass="fontHead" Runat="server">Select All</asp:label>&nbsp;<input id="checkAll" onclick="CheckAll(this);" type="checkbox" name="checkAll" runat="server"></td>
				</tr>
			</table>
			<table cellSpacing="1" cellPadding="0" width="100%">
				<tr>
					<td vAlign="top" width="550" bgColor="#ffffff">
						<table cellSpacing="1" cellPadding="0" width="100%" border="0">
							<tr>
								<td vAlign="top">
									<table cellSpacing="1" cellPadding="0" width="100%" border="0">
										<tr>
											<td vAlign="top" width="620">
												<table class="TableHeader" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
													<TR class="fontHead">
														<td align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
														<TD>
															<DIV align="left"><b><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;<asp:label id="lblRecordsFound" CssClass="fontHead" Runat="server">Records Found</asp:label>&nbsp;<asp:label id="lblPaletteName" Runat="server" Visible="true"></asp:label></b></DIV>
															</TD>
													</TR>
												</table>
												<asp:datalist id="DataList1" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
													RepeatColumns="5" DataKeyField="ColorPaletteID" Width = "100%">
													<ItemStyle BorderWidth="0" BorderStyle="Solid" BorderColor="Gainsboro"></ItemStyle>
													<ItemTemplate>
														<TABLE height="100" cellSpacing="0" cellPadding="0" border="0" style="border-width:1px; border-style:solid">
															<TR height="50" width="70" valign="top">
																<td><table cellSpacing="0" cellPadding="0" runat="server" id="tblColorPalette" width ="100%">
																		<tr height="60" width="65" valign="top">
																			<td>
																				<asp:CheckBox ID="chkSelect" Runat="server"></asp:CheckBox></td>
																		</tr>
																	</table>
																</td>
															</TR>
															<tr height = "50" width = "75" style="border-width:1px; border-style:solid">
															    <td> 
															        <asp:PlaceHolder ID="pnlHeader" runat="server" >
				                                                    </asp:PlaceHolder>
				                                                </td>
				                                            </tr>
														</TABLE>
														<INPUT id="HEXCode" type="hidden" runat="server" value='<%#DataBinder.Eval(Container.DataItem,"Hex")%>' NAME="HEXCode">
													</ItemTemplate>
												</asp:datalist></td>
										</tr>
									</table>
								</td>
								<td vAlign="top" width="500">
									
									<table class="ToolbarShort" cellSpacing="0" cellPadding="0" width="400" border="0">
										<tr bgColor="#ffffff">
											<td width="16">&nbsp;</td>
											<td><asp:datagrid id="DataGrid1" AutoGenerateColumns="true" runat="server" DataKeyField="ColorPaletteID">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
							
						</asp:datagrid></td>
											<TD></TD>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<script language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
		                e.checked = actVar;
		        }
		    }
		</script>
	</body>
</HTML>
