<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_TradePartnerVendor_Add.aspx.vb" Inherits="plmOnApp.Material_TradePartnerVendor_Add" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Select Vendor</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>

		<form id="Form1" method="post" runat="server">	   
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
						<cc1:confirmedimagebutton id="btnSaveMaterial" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton>
                    </TD>
				</TR>
			</TABLE>
			<TABLE style="BORDER-BOTTOM: white thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD>&nbsp;
						<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Custom</asp:label></TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
					<TR>
						<TD width="800" bgColor="#ffffff"></TD>
					</TR>
				</TABLE>

	    <table border="1" cellpadding="0" cellspacing="0"  
                style="padding: inherit; margin: auto; border: thin solid #F0F0F0;">
            <tr>
                
                <td valign="top"><asp:panel id="pnlSearch" runat="server">
				
				<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
					<TR>
						<TD>
							<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD vAlign="top" Width="700px" >
										<TABLE class="TableHeader" id="Table3" height="25" cellSpacing="0" cellPadding="0" width="100%"
											bgColor="#ffffff" border="0">
											<TR vAlign="middle">
												<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
												<TD width="20">
													<asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
												<TD width="20">
													<asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
												<TD noWrap align="center" width="125">
													<asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
												<TD width="20">
													<asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
												<TD width="20">
													<asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
												<TD width="10">&nbsp;</TD>
												<TD noWrap>
													<asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
											</TR>
										</TABLE>
										<TABLE id="Table5" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white"
											border="0">
											<TR>
												<TD>
													<TABLE id="Table7" cellSpacing="1" cellPadding="1" width="100%" border="0">
														<TR>
															<TD>
																<asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></TD>
														</TR>
													</TABLE>
												</TD>
												<TD vAlign="top" width="100%">
													<TABLE id="Table6" height="45">
														<TR>
															<TD>
																<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
														</TR>
													</TABLE>
												</TD>
											</TR>
										</TABLE>            
										<cc1:ScrollingGrid ID="ScrollingGrid1" runat="server" Height="300px" 
                                            Width="700px">
                                            <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" 
                                                DataKeyField="TradePartnerVendorID" PageSize="50" SelectedItemStyle-CssClass="ItemTemplateMouseOver">
                                                <AlternatingItemStyle Height="25px" />
                                                <ItemStyle Height="25px" />
                                                <HeaderStyle CssClass="TableHeader" Height="25px" />
                                                   <Columns>
                                                        <asp:TemplateColumn>
                                                            <HeaderStyle Width="75px" />
                                                            
	                                                        <HeaderTemplate>
		                                                        
	                                                        </HeaderTemplate>
	                                                        <ItemTemplate>
                                                                <asp:ImageButton ID="btnSelect" runat="server"  CommandName="SELECT" />
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>                        			            
                                                    </Columns>
                                                <PagerStyle Visible="False" />
                                            </asp:DataGrid>
                                        </cc1:ScrollingGrid>
			                            <TABLE class="TableHeaderYellow" cellSpacing="0" cellPadding="0" width="100%" border="0">
				                            <TR vAlign="middle">
					                            <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					                            <TD height="23">
                                                    <asp:Label ID="lblMaterialColorAvail" runat="server" Text=""></asp:Label>
                                                </TD>
				                            </TR>
			                            </TABLE>
                                        <cc1:ScrollingGrid ID="sgMaterialColor" runat="server" Height="277px" 
                                            Width="700px">
                                            <asp:DataGrid ID="dgMaterialColor" runat="server" AllowSorting="True" 
                                                DataKeyField="MaterialColorID" PageSize="50" EnableTheming="False" 
                                                EnableViewState="False">
                                                <AlternatingItemStyle CssClass="AlternateItemTemplateYellow" Height="25px" />
                                                <ItemStyle CssClass="ItemTemplateYellow" Height="25px" />
                                                <HeaderStyle CssClass="TableHeaderYellow" Height="25px" />
                                                <PagerStyle Visible="False" />
                                            </asp:DataGrid>
                                        </cc1:ScrollingGrid>
										<asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>

			</asp:panel>
                    </td>
                    <td valign="top"  Width="300px">
			            <TABLE class="TableHeaderGreen" cellSpacing="0" cellPadding="0" width="100%" border="0">
				            <TR vAlign="middle">
					            <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					            <TD height="23">
                                    <asp:Label ID="lblTradeSel" runat="server" Text=""></asp:Label>
                                </TD>
				            </TR>
			            </TABLE>
                                <cc1:ScrollingGrid ID="sgTradePartnerSel" runat="server" Height="675px" 
                                    Width="300px">

                                    <asp:DataGrid ID="dgTradePartnerSel" runat="server" AllowSorting="False" 
                                        DataKeyField="MaterialColorID" PageSize="50" 
                                        EnableTheming="False" EnableViewState="False">
                                        <AlternatingItemStyle CssClass="AlternateItemTemplateGreen" Height="25px" />
                                        <ItemStyle CssClass="ItemTemplateGreen" Height="25px" />
                                        <HeaderStyle CssClass="TableHeaderGreen" Height="25px" />
                                        <PagerStyle Visible="False" />
                                    </asp:DataGrid>
                                </cc1:ScrollingGrid>
                </td>
            </tr>
        </table>
 				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD>&nbsp;
						</TD>
					</TR>
				</TABLE>
				<TABLE id="Table4" style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
					height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
					<TR>
						<TD align="center" width="50">&nbsp;</TD>
						<TD align="center" width="500"></TD>
						<TD align="center">&nbsp;</TD>
					</TR>
				</TABLE>    
			   
		<script language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )			{
			var actVar = checkAllBox.checked ;
			for(i=0;i< frm.length;i++) 			{
				e=frm.elements[i];
				if (e.type == 'checkbox' && e.name.indexOf("chkAddChips") != -1)
				e.checked= actVar ;
			}
		}
		</script>	
		    <asp:HiddenField ID="hdn_TradePartnerVendorID" runat="server" />
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
		    
		</form>
        <script language="javascript">
            function btnClose_Click() {
              <%= strExitScript %>
              return false;
            }
        </script>
		</body>
</HTML>
