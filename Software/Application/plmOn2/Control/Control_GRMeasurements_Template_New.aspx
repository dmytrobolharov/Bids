<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_GRMeasurements_Template_New.aspx.vb" Inherits="plmOnApp.Control_GRMeasurements_Template_New" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Style_Main</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE" ></cc1:confirmedimagebutton></TD>
					<TD><cc1:confirmedimagebutton id="btnClose" runat="server" Message="Are you sure you want to cancel create new POM?"
							  CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#cddeee">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table width="100%" height="90%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" bgcolor="#ffffff">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><div align="middle">
										<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Large"
											ForeColor="#E0E0E0">New POM Template...</asp:Label></div>
								</td>
							</tr>
						</table>
						<asp:Panel ID="pnlTemplate" runat="server">
							<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="top">
									<TD width="10">&nbsp;</TD>
									<TD>
										<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
								</TR>
							</TABLE>
						</asp:Panel>	
						<TABLE style="BORDER-TOP: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="100" cellSpacing="1" cellPadding="0" width="100%" border="0">
				            <tr valign="top" width="100%"> 
				               <TD width="10">&nbsp;&nbsp</TD>                       
                               <td align="left" width="100%">
                                    <asp:Label ID="lblGradingType" class="fontHead"  runat="server" width="150"></asp:Label>
                                    <asp:RadioButton ID="rbRelative" class="font" runat="server" Checked="True" 
                                       GroupName="rbGradingType" Text="" width="130" />
                                    <asp:RadioButton ID="rbIncremental" class="font" runat="server" GroupName="rbGradingType"/>
                                </td>
                            </tr>                        
                            <tr valign="top" width="100%">
                               <TD width="10">&nbsp;</TD>    
                               <td align="left" width="100%">
                                    <asp:Label ID="lblGradesLSample" class="fontHead" runat="server" width="150"></asp:Label>
                                    <asp:RadioButton ID="rbConvert2Negative" class="font" runat="server" Checked="True" GroupName="rbGradesLSample" width="130" />
                                    <asp:RadioButton ID="rbKeepAsEntred" class="font" runat="server" GroupName="rbGradesLSample"/>
                                </td>
                            </tr>
                            <tr valign="top" width="100%">
                               <TD align="left" width="25">&nbsp;</TD>    
                               <td align="left" width="100%">
                                    <asp:Label ID="lblMeasurements" class="fontHead" runat="server" width="150"></asp:Label>
                                    <asp:RadioButton ID="rbMetric" runat="server" class="font" Checked="True" GroupName="rbMeasurements" width="130" />
                                    <asp:RadioButton ID="rbImperial" runat="server" class="font" GroupName="rbMeasurements" />
                                </td>
                            </tr>
			            </TABLE>					
						<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" background="../System/Images/MiddleFill.jpg">
							<tr valign="top">
								<td width="33%"></td>
								<td width="33%"></td>
								<td width="33%"></td>
							</tr>
						</table>
					</td>
					<%--<td width="10%" bgcolor="#f5f5f5">&nbsp;</td>--%>
				</tr>
			</table>			
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
