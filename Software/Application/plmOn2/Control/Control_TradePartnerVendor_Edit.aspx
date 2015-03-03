<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_TradePartnerVendor_Edit.aspx.vb" Inherits="plmOnApp.Control_TradePartnerVendor_Edit" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Vendor</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">    
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>

		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="100%">
					    <cc2:confirmedimagebutton id="btnSaveUser" runat="server"  Message="NONE"></cc2:confirmedimagebutton>
					    <cc2:confirmedimagebutton id="btnDelete" runat="server"  CausesValidation="False"></cc2:confirmedimagebutton>
					    <cc2:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc2:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td vAlign="top" colSpan="2" height="50"><asp:label id="lblTheVendorName" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
										ForeColor="#E0E0E0"></asp:label>&nbsp;</td>
								<TD vAlign="top" height="50"></TD>
							</tr>
						</table>
						<TABLE id="Table2" cellSpacing="2" cellPadding="0" width="100%" border="0">
							<TR>
								<TD><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
							</TR>
						</TABLE>
						<br>
						<BR>
						<cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview>
						<asp:panel id="pnlContact" runat="server">
							<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD width="100%">
										<cc2:bwimagebutton id="btnAddContact" runat="server" ></cc2:bwimagebutton></TD>
									<TD>&nbsp;</TD>
								</TR>
							</TABLE>
							<TABLE id="tblVendorContacts" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD vAlign="top" colSpan="2">
										<asp:datalist id="VendorDataList" runat="server" OnDeleteCommand="VendorDataList_DeleteCommand" 
											OnCancelCommand="VendorDataList_CancelCommand" OnUpdateCommand="VendorDataList_UpdateCommand"
											OnEditCommand="VendorDataList_EditCommand" DataKeyField="TradePartnerVendorContactID" BackColor="White"
											BorderWidth="0px" Width="800">
											<HeaderTemplate>
												<table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0" height="22">
													<tr class="TableHeaderOver">
														<td class="fontHead" width="20">&nbsp;</td>
														<td class="fontHead" width="200"><asp:Label ID="lblContactName" runat="server"><%#GetSystemText("Contact Name")%></asp:Label></td>
														<td class="fontHead" width="100"><asp:Label ID="lblTitle" runat="server"><%#GetSystemText("Title")%></asp:Label></td>
														<td class="fontHead" width="100"><asp:Label ID="lblPhone" runat="server"><%#GetSystemText("Phone No.")%></asp:Label></td>
														<td class="fontHead" width="100"><asp:Label ID="lblMobile" runat="server"><%#GetSystemText("Mobile No.")%></asp:Label></td>
														<td class="fontHead" width="100"><asp:Label ID="lblEmail" runat="server"><%#GetSystemText("Email")%></asp:Label></td>
													</tr>
												</table>
											</HeaderTemplate>
											<EditItemStyle BorderWidth="0px"></EditItemStyle>
											<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
											<FooterTemplate>
											</FooterTemplate>
											<ItemStyle BackColor="White"></ItemStyle>
											<ItemTemplate>
												<TABLE width="100%">
													<TR>
														<TD class="fontHead" width="20">
															<asp:linkbutton id="Linkbutton1" runat="Server" CommandName="edit" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'></asp:linkbutton></TD>
														<TD class="font" width="205"><%#Container.DataItem("FULLNAME")%></TD>
														<TD class="font" width="105"><%#Container.DataItem("Title")%></TD>
														<TD class="font" width="105"><%#Container.DataItem("PhoneNumber")%></TD>
														<TD class="font" width="105"><%#Container.DataItem("MobileNumber")%></TD>
														<TD class="font" width="100"><%#Container.DataItem("Email")%></TD>
													</TR>
												</TABLE>
											</ItemTemplate>
											<EditItemTemplate>
												<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
													<TR>
														<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
														<TD width="500">
															<asp:linkbutton id="Linkbutton2" runat="Server" CommandName="update" NAME="Linkbutton2"></asp:linkbutton>
															<cc2:ConfirmedLinkButton id="Linkbutton4" runat="Server" Message='<%#"Are you sure you want to delete this contact?"%>'	CommandName="delete"  NAME="Linkbutton4"></cc2:ConfirmedLinkButton>
															<asp:linkbutton id="Linkbutton3" runat="Server" CommandName="cancel" NAME="Linkbutton3"></asp:linkbutton></TD>
														<TD>&nbsp;</TD>
													</TR>
												</TABLE>
												<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="gray" border="0">
													<TR>
														<TD width="10">&nbsp;</TD>
														<TD class="fontHead"><FONT color="white"><asp:Label ID="lblEditContact" runat="server"><%#GetSystemText("Edit Contact")%>:</asp:Label>
																<asp:Label id=lblContactName runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FullName").ToString  %>'>
																</asp:Label></FONT></TD>
													</TR>
												</TABLE>
												<TABLE cellSpacing="1" cellPadding="1" width="800" border="0">
													<TR>
														<TD width="10">&nbsp;</TD>
														<TD class="fontHead" width="125"><asp:Label ID="lblFirstName" runat="server"><%#GetSystemText("First Name")%></asp:Label></TD>
														<TD>
															<asp:TextBox id=txtFirstName tabIndex=1 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FirstName").ToString  %>'>
															</asp:TextBox></TD>
														<TD width="10">&nbsp;</TD>
														<TD class="fontHead" width="125"><asp:Label ID="lblPhone" runat="server"><%#GetSystemText("Phone No.")%></asp:Label></TD>
														<TD>
															<asp:TextBox id=txtPhoneNumber tabIndex=4 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PhoneNumber").ToString  %>'>
															</asp:TextBox></TD>
													</TR>
													<TR>
														<TD width="10">&nbsp;</TD>
														<TD class="fontHead" width="125"><asp:Label ID="lblLastName" runat="server"><%#GetSystemText("Last Name")%></asp:Label></TD>
														<TD>
															<asp:TextBox id=txtLastName tabIndex=2 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Lastname").ToString  %>'>
															</asp:TextBox></TD>
														<TD width="10">&nbsp;</TD>
														<TD class="fontHead" width="125"><asp:Label ID="lblMobile" runat="server"><%#GetSystemText("Mobile No.")%></asp:Label></TD>
														<TD>
															<asp:TextBox id=txtMobileNumber tabIndex=5 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MobileNumber").ToString  %>'>
															</asp:TextBox></TD>
													</TR>
													<TR>
														<TD width="10">&nbsp;</TD>
														<TD class="fontHead" width="125"><asp:Label ID="lblTitle" runat="server"><%#GetSystemText("Title")%></asp:Label></TD>
														<TD>
															<asp:TextBox id=txtTitle tabIndex=3 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Title").ToString  %>'>
															</asp:TextBox></TD>
														<TD width="10">&nbsp;</TD>
														<TD class="fontHead" width="125"><asp:Label ID="lblEmail" runat="server"><%#GetSystemText("Email")%></asp:Label></TD>
														<TD>
															<asp:TextBox id=txtEmail tabIndex=6 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Email").ToString  %>'>
															</asp:TextBox></TD>
													</TR>
												</TABLE>
											</EditItemTemplate>
										</asp:datalist></TD>
								</TR>
							</TABLE>
						</asp:panel>
                                <table id="TableBtn" class="TableHeader" visible="false" runat="server" cellspacing="0" cellpadding="0"
                                    width="100%" border="0">
                                    <tr valign="middle">
                                        <td valign="middle" align="center" width="10">
                                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="ImageButton1"
                                                runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
                                        </td>
		                                <td>
		                                    <cc2:ConfirmedImageButton id="btnTabEdit" visible="false" runat="server"  Message="NONE" CausesValidation="False"></cc2:ConfirmedImageButton>
		                                    <cc2:bwimagebutton id="btnTabAdd" visible="true" runat="server"  ></cc2:bwimagebutton>       
		                                    <cc2:ConfirmedImageButton id="btnTabDelete" visible="true" runat="server"  Message="NONE"></cc2:ConfirmedImageButton>
                                            <cc2:ConfirmedImageButton id="btnTabSave" visible="false" runat="server"  Message="NONE"></cc2:ConfirmedImageButton>
                                        </td>
                                        <td class="FontHead" align="right" width="75">
                                        </td>
                                        <td width="40">
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>

						    	  <table id="Table3" visible="false" class="TableHeader" runat="server" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			                        <TR vAlign="middle">
				                        <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				                        <TD width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></TD>
				                        <TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></TD>
				                        <TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
				                        <TD width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></TD>
				                        <TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></TD>
				                        <TD width="10">&nbsp;</TD>
				                        <TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
				                        <TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
				                        <TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
						                        <asp:ListItem Value="5">5</asp:ListItem>
						                        <asp:ListItem Value="10">10</asp:ListItem>
						                        <asp:ListItem Value="15">15</asp:ListItem>
						                        <asp:ListItem Value="20">20</asp:ListItem>
						                        <asp:ListItem Value="25">25</asp:ListItem>
						                        <asp:ListItem Value="30">30</asp:ListItem>
						                        <asp:ListItem Value="40">40</asp:ListItem>
						                        <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
					                        </asp:dropdownlist></TD>
 				                        <TD width="10"><asp:button id="btnRepage" onclick="RePage" runat="server" CssClass="fontHead" Text="GO"></asp:button></TD>  
			                        </TR>
		                        </table>
                                

		                        <table id="Table4" height="15" runat="server" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
			                        <tr>
				                        <td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
				                        <td vAlign="top" width="100%">
					                        <table height="45">
						                        <tr>
							                        <td><asp:imagebutton id="imgBtnSearch" Visible="false" runat="server" ></asp:imagebutton></td>
						                        </tr>
					                        </table>
				                        </td>
			                        </tr>
		                        </table>
		                        <asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" Visible="false">
			                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
			                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
			                        <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
                                    <PagerStyle Visible="False"></PagerStyle>
            	                        <Columns>   
                                             <asp:TemplateColumn >
                                                <HeaderStyle Width="50px" CssClass="TableHeaderRed"></HeaderStyle>
					                            <ItemStyle Width="50px"></ItemStyle>
                                                <HeaderTemplate >
                                                    <input type="checkbox" onclick="SelectAll(this)" id="checkAll" />                           
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkDelete" />                            
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            
                                        </Columns>	           
		                        </asp:datagrid>	
                        	    <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
		                        
					</td>
				</tr>
			</table>
		</form>
	</body>
	
 <script language="javascript">
     var frm = document.Form1;

     function SelectAll(checkAllBox) {
         var actVar = checkAllBox.checked;
         for (i = 0; i < frm.length; i++) {
             e = frm.elements[i];
             if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                 if (e.disabled == false)
                 e.checked = actVar;
         }
     }
</script>	
<script language="javascript">
	function btnClose_Click() {
		<%= strExitScript %>
        return false;
    }
</script>
</HTML>
