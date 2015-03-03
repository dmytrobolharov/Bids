<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_New_Custom.aspx.vb" Inherits="plmOnApp.TechPack_New_Custom" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title>TechPack_New_Custom</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tab.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
         <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<SCRIPT language="JavaScript" type="text/javascript">
		<!--
		    function DoPageLoad() {

		        var Timer = setTimeout('self.focus();', 1000);
		    }
		// -->
		</SCRIPT>
	</HEAD>
	<body onbeforeunload="busyBox.Show();" onload="DoPageLoad();" MS_POSITIONING="GridLayout">
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
		<form id="Form1" method="post" runat="server">
			<br>
			<br>
			<br>
			<cc3:ystabview id="YSTabView1" runat="server"></cc3:ystabview><asp:panel id="pnlOld" Runat="server">
				<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD>
							<CC1:CONFIRMEDIMAGEBUTTON id="btnSave" runat="server"   Message="NONE"></CC1:CONFIRMEDIMAGEBUTTON>
							<cc1:confirmedimagebutton id="btnBatchQueue" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnBatchQueueAgent" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<CC1:CONFIRMEDIMAGEBUTTON id="btnClose" runat="server"  Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></CC1:CONFIRMEDIMAGEBUTTON>
						</TD>
					</TR>
				</TABLE>
			    <TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0" runat="server" id="table1">
				    <TR>
					    <TD><asp:PlaceHolder ID="plhSourcingHeader1" runat ="server" ></asp:PlaceHolder></TD>
				    </TR>			    
			    </TABLE>							
				<table cellSpacing="0" cellPadding="0" border = "0" >
				<tr>
				<td valign ="top">
				    <TABLE cellSpacing="0" cellPadding="0" width="500" border="0">
					    <tr runat="server" id="tbSeasonYear2"  visible ="false">
                            <td valign="top" visible="true">
 	                            <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                                    border="0">
                                    <tr valign="middle">
                                        <td valign="middle" align="center" width="10">
                                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                        </td>
                                        <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                                        <td width="125" align="right" nowrap="nowrap">
                                            <asp:Label runat="server" ID="lblSeasonYear" class="fontHead" >Select Season / Year</asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlSeasonYear2" runat="server"  AutoPostBack="true"></asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>                              
                                <br />					    
                            </td>
					    </tr>				    
				    
				    
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
									    <TD width="100">
										    <asp:Label id="lblTechPackLanguage2" Runat="server" CssClass="fontHead">Language:</asp:Label>
										</TD>
									    <TD width="400">
                                            <asp:DropDownList ID="ddlLanguage2" runat="server" AutoPostBack="false"></asp:DropDownList>
										</TD>
								    </TR>
								    <TR>
									    <TD>
										    <asp:Label id="lblTechPackRelease" Runat="server" CssClass="fontHead"></asp:Label></TD>
									    <TD>
										    <asp:CheckBox id="chkTechPackRelease" Runat="server"></asp:CheckBox></TD>
								    </TR>
								    <TR>
									    <TD>
										    <asp:Label id="lblSizeClassHeader" Runat="server" CssClass="fontHead">Select Size...</asp:Label></TD>
									    <TD>
										    <asp:radiobuttonlist id="rbSizeList" runat="server" CssClass="font" AutoPostBack="True"></asp:radiobuttonlist></TD>
								    </TR>
							    </TABLE>
							    </TD>
					    </TR>
					    
					    
					    

					    
					    <TR>
						    <TD><INPUT onclick="CheckAll(this);" type="checkbox">
						    <SPAN class="fontHead">
						        <asp:Label ID="lblSelectAll" runat="server" Text="Select All..."></asp:Label>
						    </SPAN>
                                
                            </TD>
					    </TR>
                        </TABLE>
                        <br />
                        <TABLE cellSpacing="0" cellPadding="0" border="0">
					    <TR>
						    <TD >
						        <asp:datalist id="dlWorkflows" runat="server" Width="100%" DataKeyField="WorkflowID" BorderWidth="1px"
								    BorderStyle="Solid" BorderColor="Silver">
								    <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White"></ItemStyle>
								    <ItemTemplate>
									    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
										    <tr>
											    <td width="500px">
												    <table cellpadding="0" cellspacing="0" border="0" class="TableHeaderBlue" width="100%" runat="server" id ="tbWorkflows">
													    <tr>
														    <td height="30"><font size="5">
																    <asp:label id="lblWorkflow" runat="server" CssClass="fontHead">Workflow</asp:label></font></td>
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
																    <asp:Label Runat="server" id="lblHeaderCheck" Text='<%#GetSystemText("Select") %>'></asp:Label>
															    </HeaderTemplate>
															    <ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>
															    <ItemTemplate>
																    <asp:CheckBox Runat="server" ID="chkReporte"></asp:CheckBox>
															    </ItemTemplate>
														    </asp:TemplateColumn>
														    <asp:TemplateColumn>
															    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
															    <HeaderTemplate>
																    <asp:Label Runat="server" id="lblHeaderDesc" Text='<%#GetSystemText("Select page(s) to print") & "..." %>'></asp:Label>
															    </HeaderTemplate>
															    <ItemStyle Width="450px"></ItemStyle>
															    <ItemTemplate>
																    <asp:Label Runat="server" ID="lblDesc"></asp:Label>
																    <asp:HiddenField ID="hidWFIID" runat="server" Value="" />
																    <asp:HiddenField ID="hidStyleSet" runat="server" Value="" />
															    </ItemTemplate>
														    </asp:TemplateColumn>
													    </Columns>
												    </asp:datagrid><br>
												    <br>
											    </td>
										    </tr>
									    </table>
								    </ItemTemplate>
							    </asp:datalist>

                            </TD>
                            
					    </TR>
				    </TABLE>
				
				</td>
				</tr>
				</table>
				
				
			</asp:panel><asp:panel id="pnlNew" Runat="server">
				<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD>
							<cc1:confirmedimagebutton id="btnSaveNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnBatchQueueNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnBatchQueueAgentNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnCloseNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						</TD>
					</TR>
				</TABLE>
			    <TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0" runat="server" id="table2">
				    <TR>
					    <TD><asp:PlaceHolder ID="plhSourcingHeader2" runat ="server" ></asp:PlaceHolder></TD>
				    </TR>
				    <tr><td>
				        <TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				            cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0" >
				            <TR>
					            <TD>&nbsp;</TD>
				            </TR>
			            </TABLE>				
				    </td></tr>
			    </TABLE>							
				<TABLE class="TableHeaderGreen" cellSpacing="0" cellPadding="0" width="100%" border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
						<TD class="fontHead" height="25">&nbsp;<asp:Label ID="lblNewTechPack" 
                                runat="server" Text="New Tech Pack"></asp:Label>
                        </TD>
					</TR>
				</TABLE>
                <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                    border="0" id="tbSeasonYear" runat="server" visible="false">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                        <td width="125" align="right" nowrap="nowrap">
                            <asp:Label runat="server" ID="lblSelectSeasonYear" class="fontHead" >Select Season / Year:</asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSeasonYearID" runat="server"  AutoPostBack="true"></asp:DropDownList>
                        </td>
                    </tr>
                </table>

			    <TABLE cellSpacing="0" cellPadding="0" width="500" border="0">
				    <TR>
                        <TD vAlign="middle" align="center" width="20" height="25">
                        </TD>
					    <TD width="100">
						    <asp:Label id="lblTechPackLanguage1" Runat="server" CssClass="fontHead">Language:</asp:Label>
						</TD>
					    <TD width="400">
                            <asp:DropDownList ID="ddlLanguage1" runat="server" AutoPostBack="false"></asp:DropDownList>
						</TD>
				    </TR>
			    </TABLE>

				<TABLE height="500" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
					    
						<TD vAlign="top" width="150" bgColor="#ffffff">
							<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="middle">
									<TD vAlign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD class="FontHead">&nbsp;<asp:Label ID="lblSelectSize" runat="server" 
                                            Text="Select Size..."></asp:Label>
                                    </TD>
									<TD>&nbsp;</TD>
								</TR>
							</TABLE>
							<asp:radiobuttonlist id="rbSizeClass" runat="server" CssClass="font" AutoPostBack="True"></asp:radiobuttonlist></TD>
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
			</asp:panel>
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

			                if (e.type == 'checkbox' && e.name.indexOf("chkReportSourcing") != -1) {
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
