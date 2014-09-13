<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_Palette.aspx.vb" Inherits="plmOnApp.Color_Palette" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title>Palette</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        
	</HEAD>
	<body onKeyPress="DisableEnterKey()">
        <script>
            function DisableEnterKey() 
            {
            //alert(window.event.keyCode)
            if (window.event.keyCode == 13)
            window.event.keyCode =0;
            } 
        </script> 


		<form id="Form1" method="post" encType="multipart/form-data" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td valign="top"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" EnableViewState="False"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnNewImage" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnCopy" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnNewTask" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:BWImageButton id="btnPreview" runat="server"  />
					<cc1:confirmedimagebutton id="btnNewIssue" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnDeletePalette" runat="server"  CausesValidation="False"></cc1:confirmedimagebutton>
                      
                    </td>
					<td width="75">&nbsp;</td>
					<td align="right"></td>
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
					<td>&nbsp;<asp:label id="lblColorHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			
			
            <table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center" width="10"></td>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>

            <br />
            <table cellSpacing="0" cellPadding="0" width="100%" border="0" class="TableHeader">
				<tr>
					<td align="center" width="10" height="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				</tr>
			</table>
            <br />
            
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<TR>
								<TD>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
							</TR>
						</table>
					</td>
				</tr>
			</table>            


<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="top">
		<TD>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD class="fontHead" width="50">&nbsp;</TD>
					<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
					<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
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
					<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></TD>
				</TR>
			</TABLE>
			
			<table width="100%" >
			<tr>
			    <td width="400" valign="top">
					<asp:datalist id="DataList1" runat="server" DataKeyField="ColorPaletteID" RepeatColumns="8"
						RepeatDirection="Horizontal" EnableViewState="True">
						<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
						<ItemTemplate>
							<TABLE height="100" cellSpacing="0" cellPadding="0" width="65" border="0">
								<TR height="50" width="65">
									<TD height="50" valign="top">
										<asp:ImageButton id="btnColorChip" runat="server" CommandName="ColorChip">
										</asp:ImageButton>
									</TD>
								</TR>
								<TR height="15">
									<TD bgColor="#ffffff"><FONT color="#000000" size="1">
											<asp:label id="dlColorCode" runat="server"></asp:label></FONT></TD>
								</TR>
								<TR height="25">
									<TD bgColor="#ffffff"><FONT color="#000000" size="1">
											<asp:label id="dlColorName" runat="server"></asp:label></FONT></TD>
								</TR>
							</TABLE>
							<INPUT id="Selected_ID" type="hidden" name="Selected_ID" runat="server"> <INPUT id="Selected_ColorSource" type="hidden" name="Selected_ColorSource" runat="server">
							<INPUT id="Selected_ColorNotes" type="hidden" name="Selected_ColorNotes" runat="server">
							<INPUT id="Selected_R" type="hidden" name="Selected_R" runat="server"> <INPUT id="Selected_G" type="hidden" name="Selected_G" runat="server">
							<INPUT id="Selected_B" type="hidden" name="Selected_B" runat="server"> <INPUT id="Selected_HEX" type="hidden" name="Selected_HEX" runat="server">
							<INPUT id="Selected_LL" type="hidden" name="Selected_LL" runat="server"> <INPUT id="Selected_LA" type="hidden" name="Selected_LA" runat="server">
							<INPUT id="Selected_LB" type="hidden" name="Selected_LB" runat="server"> <INPUT id="ColorImage" type="hidden" name="ColorImage" runat="server">
						</ItemTemplate>
					</asp:datalist>			    
			    </td>
			    <td>
	                <asp:panel id="pnlColorProperty" Runat="server">
					    <TABLE class="ToolbarShort" cellSpacing="0" cellPadding="0" width="100%" border="0">
						    <TR>
							    <TD align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							    <TD class="fontHead" height="20"><%=Me.strColor + " Property..."%></TD>
						    </TR>
					    </TABLE>
					    <TABLE id="TD_ColorProperty" cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff"
						    border="0" runat="server">
						    <TR>
							    <TD bgColor="#ffffff" colSpan="3"><INPUT id="txtEditColorPaletteID" type="hidden" name="txtEditColorPaletteID" runat="server">
								    <asp:imagebutton id="btnCloseColorProperty" runat="server" ></asp:imagebutton></TD>
						    </TR>
					    </TABLE>
					    <TABLE id="Table1" cellSpacing="1" cellPadding="1" width="400" bgColor="#ffffff" border="0">
						    <TR>
							    <TD vAlign="top" align="center" width="200">
								    <asp:Image id="imgColorChipSelected" runat="server"></asp:Image>
								    <asp:Table id="tbColorChip" Visible="False" Runat="server" BorderColor="Silver" Height="200"
									    Width="200" BorderWidth="1">
									    <asp:TableRow>
										    <asp:TableCell Text="&amp;nbsp;"></asp:TableCell>
									    </asp:TableRow>
								    </asp:Table></TD> <!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
							    <TD width="200" valign="top">
								    <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
									    <TR>
										    <TD>
											    <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
												    <TR>
													    <TD>
														    <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
															    <TR>
																    <TD class="fontHead">
																	    <DIV align="left"><%=strColorNo%></DIV>
																    </TD>
															    </TR>
															    <TR>
																    <TD style="height: 42px">
																	    <DIV align="left">
																		    <asp:textbox id="txtEditColorCode" runat="server">0</asp:textbox>
                                                                            <asp:TextBox ID="hdnEditColorCode" runat="server" Visible="False">0</asp:TextBox></DIV>
																    </TD>
															    </TR>
														    </TABLE>
													    </TD>
												    </TR>
											    </TABLE>
										    </TD>
									    </TR>
									    <TR>
										    <TD>
											    <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
												    <TR>
													    <TD class="fontHead" style="HEIGHT: 9px">
														    <DIV align="left"><%=strColorName%></DIV>
													    </TD>
												    </TR>
												    <TR>
													    <TD>
														    <DIV align="left">
															    <asp:textbox id="txtEditColorName" runat="server">0</asp:textbox>
                                                                <asp:TextBox ID="hdnEditColorName" runat="server" Visible="False">0</asp:TextBox></DIV>
													    </TD>
												    </TR>
											    </TABLE>
										    </TD>
									    </TR>
									    <TR>
										    <TD>
											    <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
												    <TR>
													    <TD class="fontHead" style="height: 13px">
														    <DIV align="left"><%=strColorSource%></DIV>
													    </TD>
												    </TR>
												    <TR>
													    <TD>
														    <DIV align="left">
															    <asp:textbox id="txtColorEditSource" runat="server"></asp:textbox>
                                                                <asp:TextBox ID="hdnColorEditSource" runat="server" Visible="False">0</asp:TextBox></DIV>
													    </TD>
												    </TR>
											    </TABLE>
										    </TD>
									    </TR>
								    </TABLE>
								    <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
									    <TR>
										    <TD>
											    <DIV class="fontHead" align="center">
												    <DIV align="left"><%=strColorNotes%></DIV>
											    </DIV>
										    </TD>
									    </TR>
									    <TR>
										    <TD>
											    <DIV align="left">
												    <asp:textbox id="txtColorEditNotes" runat="server" TextMode="MultiLine" Rows="4"></asp:textbox>
                                                    <asp:TextBox ID="hdnColorEditNotes" runat="server" Rows="4" TextMode="MultiLine"
                                                        Visible="False"></asp:TextBox></DIV>
										    </TD>
									    </TR>
									    <TR>
										    <TD>&nbsp;</TD>
									    </TR>
								    </TABLE>
								    <asp:CheckBox id="chkColorImage" Runat="server" AutoPostBack="True" CssClass="fontHead" ></asp:CheckBox><BR>
								    <asp:panel id="pnlUpload" runat="server" Visible="False">
									    <SPAN class="fontHead">
                                            <asp:Label ID="lblSelectFile"  runat="server" ></asp:Label></SPAN>
									    <BR>
									    <INPUT id="File1" type="file" name="file1" runat="server">
									    <P></P>
								    </asp:panel>
								    <asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" CssClass="fontHead" ErrorMessage="Color No Required!"
									    ControlToValidate="txtEditColorCode"></asp:requiredfieldvalidator>
								    <asp:requiredfieldvalidator id="RequiredFieldValidator2" runat="server" CssClass="fontHead" ErrorMessage="Color Name Required!"
									    ControlToValidate="txtEditColorName"></asp:requiredfieldvalidator></TD>
							    <TD vAlign="top" width="200">
								    <asp:panel id="pnlRGBInfo" Runat="server" Width="200px">
									    <TABLE cellSpacing="0" cellPadding="0" border="0">
										    <TR>
											    <TD style="height: 204px">
												    <TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
													    <TR>
														    <TD class="fontHead" width="25">&nbsp;</TD>
														    <TD class="fontHead" align="right" width="25"></TD>
														    <TD width="75">&nbsp;</TD>
														    <TD></TD>
													    </TR>
													    <TR>
														    <TD class="fontHead" width="25"></TD>
														    <TD class="fontHead" align="right" width="25">L:</TD>
														    <TD width="75"><INPUT class="InputBox" id="ll" maxLength="3" size="5" name="ll" runat="server"></TD>
														    <TD></TD>
													    </TR>
													    <TR>
														    <TD class="fontHead" width="25"></TD>
														    <TD class="fontHead" align="right" width="25">A:</TD>
														    <TD width="75"><INPUT class="InputBox" id="la" maxLength="3" size="5" name="la" runat="server"></TD>
														    <TD></TD>
													    </TR>
													    <TR>
														    <TD class="fontHead" width="25"></TD>
														    <TD class="fontHead" align="right" width="25">B:</TD>
														    <TD width="75"><INPUT class="InputBox" id="lb" maxLength="3" size="5" name="lb" runat="server"></TD>
														    <TD></TD>
													    </TR>
													    <TR>
														    <TD class="fontHead" width="25"></TD>
														    <TD class="fontHead" align="right" width="25"></TD>
														    <TD width="75">&nbsp;</TD>
														    <TD></TD>
													    </TR>
													    <TR>
														    <TD class="fontHead" width="25"></TD>
														    <TD class="fontHead" align="right" width="25">
															    <DIV align="right"><B>R:</B></DIV>
														    </TD>
														    <TD width="75"><INPUT class="InputBox" id="txtR" maxLength="3" size="5" name="r" runat="server">
														    </TD>
														    <TD>
                                                                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtR"
                                                                    CssClass="fontHead" Display="Dynamic" ErrorMessage="*" MaximumValue="255" MinimumValue="0"
                                                                    SetFocusOnError="True" ToolTip="Select between 0 to 255..." Type="Integer"></asp:RangeValidator></TD>
													    </TR>
													    <TR>
														    <TD class="fontHead" width="25"></TD>
														    <TD class="fontHead" align="right" width="25">
															    <DIV align="right"><B>G:</B></DIV>
														    </TD>
														    <TD width="75"><INPUT class="InputBox" id="txtG" maxLength="3" size="5" name="g" runat="server">
														    </TD>
														    <TD>
                                                                <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtG"
                                                                    CssClass="fontHead" Display="Dynamic" ErrorMessage="*" MaximumValue="255" MinimumValue="0"
                                                                    ToolTip="Select between 0 to 255..." Type="Integer"></asp:RangeValidator></TD>
													    </TR>
													    <TR>
														    <TD class="fontHead" width="25"></TD>
														    <TD class="fontHead" align="right" width="25">
															    <DIV align="right"><B>B:</B></DIV>
														    </TD>
														    <TD width="75"><INPUT class="InputBox" id="txtB" maxLength="3" size="5" name="b" runat="server">&nbsp;
														    </TD>
														    <TD>
                                                                <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="txtB"
                                                                    CssClass="fontHead" Display="Dynamic" ErrorMessage="*" MaximumValue="255" MinimumValue="0"
                                                                    ToolTip="Select between 0 to 255..." Type="Integer"></asp:RangeValidator></TD>
													    </TR>
													    <TR>
														    <TD width="25"></TD>
														    <TD align="right" width="25">
															    <DIV align="right"><B><INPUT id="txtHEX" type="hidden" name="h" runat="server"></B></DIV>
														    </TD>
														    <TD width="75"><INPUT class="button" id="btnSetRGB" type="button" value="Set RGB" name="btnSetRGB" runat="server" onclick="return btnSetRGB_onclick()">
														    </TD>
														    <TD>&nbsp;</TD>
													    </TR>
												    </TABLE>
											    </TD>
										    </TR>
									    </TABLE>
								    </asp:panel></TD>
						    </TR>
					    </TABLE>
				    </asp:panel>

                    <table class="ToolbarShort" cellSpacing="0" cellPadding="0" width="100%" border="0">
						<tr>
							<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
							<td class="fontHead" height="20"><%= strColor + " List..."%></td>
						</tr>
					</table>				    
					<table id="TD_ImgFolder" cellSpacing="1" cellPadding="0" border="0" runat="server">
						<tr bgColor="#ffffff">
							<TD><cc1:confirmedimagebutton id="btnaddColor" runat="server" Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnDelete" runat="server" Message="Are you sure you want to remove selected color chips?"></cc1:confirmedimagebutton></TD>
							<td><asp:label id="lblSortBy" Runat="server" CssClass="font"><b>&nbsp;</b></asp:label></td>
							<td><asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></td>
							<TD><cc1:confirmedimagebutton id="btnSort" runat="server" Message="NONE"></cc1:confirmedimagebutton></TD>
							<TD></TD>
						</tr>
					</table>
				    
			        <asp:datagrid id="DataGrid1" runat="server"  EnableViewState="False" DataKeyField="ColorPaletteID">
				        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				        <ItemStyle CssClass="ItemTemplate"></ItemStyle>
				        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				        <PagerStyle Visible="False"></PagerStyle>
				        <Columns>
				            <asp:TemplateColumn>
				                <ItemTemplate>
				                    <asp:CheckBox runat="server" ID="chkDelete" /> 
				                </ItemTemplate>
				            </asp:TemplateColumn>
				        </Columns>
			        </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			        <input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>
			    </td>
			</tr>
			</table>
			
		</TD>
	</TR>
</TABLE>
	
			
		</form>
		<script language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		function btnSetRGB_onclick() {

		}

        </script>
	</body>
</HTML>
