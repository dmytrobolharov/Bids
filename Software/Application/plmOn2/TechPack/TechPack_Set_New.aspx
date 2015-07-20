<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_Set_New.aspx.vb" Inherits="plmOnApp.TechPack_Set_New" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Tech Pack - New</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tab.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
		<SCRIPT language="JavaScript" type="text/javascript">
		<!--
		    function DoPageLoad() {

		        var Timer = setTimeout('self.focus();', 1000);
		    }
		// -->
		</SCRIPT>
	</HEAD>
	<body onbeforeunload="busyBox.Show();" onload="DoPageLoad();" MS_POSITIONING="GridLayout">
		<script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
		<form id="Form1" method="post" runat="server">
			<br>
			<br>
			<br>
			<cc3:ystabview id="YSTabView1" runat="server"></cc3:ystabview><asp:panel id="pnlOnTheFly" Runat="server">
				<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
					runat="server">
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD>
							<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnBatchQueue" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnBatchQueueAgent" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton>
						</TD>
					</TR>
				</TABLE>
				<BR>
				<BR>
				<TABLE cellSpacing="0" cellPadding="0" width="500" border="0">
					<TR>
						<TD>
							<TABLE cellSpacing="0" cellPadding="0" width="500" border="0">
								<TR>
									<TD width="100">
										<asp:Label id="lblTechpackName" Runat="server" CssClass="fontHead">Tech Pack Name:</asp:Label></TD>
									<TD width="400">
										<asp:TextBox id="txtTechpackName" Runat="server" CssClass="font" MaxLength="100" Width="200"></asp:TextBox></TD>
								</TR>
								<TR>
									<TD>
										<asp:Label id="lblTechPackRelease" Runat="server" CssClass="fontHead" Visible="true"></asp:Label></TD>
									<TD>
										<asp:CheckBox id="chkTechPackRelease" Runat="server" Visible="true"></asp:CheckBox></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					<TR>
						<TD><INPUT onclick="CheckAll(this);" type="checkbox"><SPAN class="fontHead">Select all 
								...</SPAN></TD>
					</TR>
					<TR>
						<TD>
							<asp:datalist id="dlWorkflows" runat="server" Width="100%" DataKeyField="WorkflowID" BorderWidth="1px"
								BorderStyle="Solid" BorderColor="Silver">
								<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White"></ItemStyle>
								<ItemTemplate>
									<table cellSpacing="0" cellPadding="0" width="500px" border="0">
										<tr>
											<td width="500px">
												<table cellpadding="0" cellspacing="0" border="0" class="TableHeaderYellow" width="100%">
													<tr>
														<td height="30"><font size="5">
																<asp:label id="lblWorkflow" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Workflow") %>'></asp:label></font></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="500px">
												<asp:datagrid id="dgReports" runat="server" Width="100%" AutoGenerateColumns="False" PageSize="100"
													BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver" DataKeyField="ReportPageID" OnItemDataBound="dgReports_ItemDataBound">
													<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
													<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
													<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
													<Columns>
														<asp:TemplateColumn>
															<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
															<HeaderTemplate>
																<asp:Label Runat="server" id="lblHeaderCheck">Select</asp:Label>
															</HeaderTemplate>
															<ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>
															<ItemTemplate>
																<asp:CheckBox Runat="server" ID="chkReporte"></asp:CheckBox>
															</ItemTemplate>
														</asp:TemplateColumn>
														<asp:TemplateColumn>
															<HeaderTemplate>
																<asp:Label Runat="server" id="lblHeaderDesc">Select page to print...</asp:Label>
															</HeaderTemplate>
															<ItemStyle Width="450px"></ItemStyle>
															<ItemTemplate>
																<asp:Label Runat="server" ID="lblDesc"></asp:Label>
															</ItemTemplate>
														</asp:TemplateColumn>
													</Columns>
												</asp:datagrid><br>
												<br>
											</td>
										</tr>
									</table>
								</ItemTemplate>
							</asp:datalist></TD>
					</TR>
				</TABLE>
			</asp:panel>
			<asp:Panel ID="pnlPredefined" Runat="server">
<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD>
							<cc1:confirmedimagebutton id="btnSavePredefined" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnBatchQueuePredefined" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnBatchQueueAgentPredefined" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClosePredefined" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						</TD>
					</TR>
				</TABLE>
<TABLE class="TableHeaderGreen" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD class="fontHead" height="25">&nbsp;<asp:Label ID="lblNewTechPack" 
                                runat="server" Text="New Tech Pack">New Tech Pack</asp:Label>
                            &nbsp;</TD>
					</TR>
				</TABLE><BR>
<asp:Label id="lblTechPackName2" Runat="server" CssClass="fontHead">Tech Pack Name</asp:Label>:&nbsp;&nbsp; 
<asp:TextBox id="txtTPNamePredefined" Runat="server" CssClass="font"></asp:TextBox><BR>
<TABLE height="500" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD vAlign="top" bgColor="#ffffff">
							<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="middle">
									<TD vAlign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD class="FontHead">&nbsp;<asp:Label ID="lblSelectTechPack" runat="server" 
                                            Text="Select Tech Pack..."></asp:Label>
                                    </TD>
									<TD>&nbsp;</TD>
								</TR>
							</TABLE>
							<asp:RadioButtonList id="rbTechPack" runat="server" CssClass="font"></asp:RadioButtonList></TD>
					</TR>
				</TABLE>
			</asp:Panel>
			<div id="BusyBoxDiv" style="BORDER-RIGHT: gainsboro 0px solid; PADDING-RIGHT: 5px; BORDER-TOP: gainsboro 0px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: gainsboro 0px solid; PADDING-TOP: 5px; BORDER-BOTTOM: gainsboro 0px solid; POSITION: absolute; BACKGROUND-COLOR: transparent; TEXT-ALIGN: center">
				<p style="WIDTH: 220px; TEXT-ALIGN: center">
					<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
						<TR>
							<TD width="50" height="32"><IMG id="BusyBoxImg" height="32" src="../system/images/busy_Layer_0.gif" width="32"></TD>
							<TD class="fontHead"><asp:Label ID="lblPleaseWait" runat="server" 
                                    Text="Please Wait..."></asp:Label>
                                <br>
								<asp:Label ID="lblTechPackLoading" runat="server" Text="Tech Pack Loading"></asp:Label></TD>
						</TR>
					</TABLE>
				</p>
			</div>
			<script language="javascript" type="text/javascript">
			    // Instantiate our BusyBox object
			    var busyBox = new BusyBox("busyBox", 12, "busy_Layer_", ".gif", 120);

			    var frm = document.Form1;

			    function CheckAll(obj) {
			        var e, rd;

			        var actVar = obj.checked;
			        for (i = 0; i < frm.length; i++) {
			            e = frm.elements[i];
			            try {
			                if (e.type == 'checkbox' && e.name.indexOf("chkReporte") != -1) {
			                    e.checked = actVar;
			                }
			            } catch (err) { }
			        }
			    } 
				
			</script>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
