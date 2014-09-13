<%@ Register TagPrefix="uc1" TagName="Material_Style_Component_Add_Header" Src="Material_Style_Component_Add_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Edit.aspx.vb" Inherits="plmOnApp.Material_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Material_Comment" Src="Material_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Material_WorkflowStatus" Src="Material_WorkflowStatus.ascx" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head id="Head1" runat="server">
		<title>Material Header</title>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>				
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
          <wc1:Color_Wait ID="Color_Wait" runat="server" />
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="TablePage" runat="server">
		<tr>
		<td>

			<table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSaveMaterial" runat="server"  Message="NONE">
                    </cc1:confirmedimagebutton><asp:imagebutton id="imgBtnCopy" runat="server" CausesValidation="False" >
                    </asp:imagebutton><cc1:confirmedimagebutton id="btnPDFView" runat="server"  Message="NONE">
                    </cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnNewTask" runat="server"  Message="NONE">
                    </cc1:confirmedimagebutton><cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table id="Table1" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;
						<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material</asp:label></td>
				</tr>
			</table>
            <uc1:Material_WorkflowStatus ID="Material_WorkflowStatus1" MaterialTemplatePageID="10000000-0000-0000-0000-000000000000" runat="server" />
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td><uc1:material_comment id="Material_Comment1" runat="server"></uc1:material_comment></td>
				</tr>
			</table>
			<table class="fontHead" cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900">
						<table id="tb_MaterialIDAlert" borderColor="royalblue" cellSpacing="0" cellPadding="0"
							width="100%" bgColor="#cddeee" border="1" runat="server">
							<tr>
								<td>
									<table height="35" cellSpacing="0" cellPadding="0" width="800" 
                                        border="0" >
										<tr>
											<td width="10">&nbsp;</td>
											<td class="fontHead" width="35">&nbsp;
												<asp:image id="imgBlock" runat="server" ImageUrl="../System/Icons/icon_info_32.gif"></asp:image></td>
											<td class="fontHead">&nbsp;
												<asp:label id="lblMaterialNoAlert" runat="server" ForeColor="Black" CssClass="fontHead">New Material Number</asp:label>&nbsp;
												<cc1:confirmedlinkbutton id="lnk_UpdateMaterialNo" runat="server" ></cc1:confirmedlinkbutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>

						    <asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder>
  
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<uc1:material_style_component_add_header id="Material_Style_Component_Add_Header1" runat="server"></uc1:material_style_component_add_header>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top" width="550" runat="server" id="tdColorList">
						<table class="TableHeader" height="32" cellSpacing="0" cellPadding="0" 
                            border="0" width="100%">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3">
								</td>
								<td class="fontHead" width="75">
                                    <asp:Label ID="lblColor" runat="server" Text="Label"></asp:Label>
								</td>
								<td class="fontHead">&nbsp;<cc1:bwimagebutton id="btnAddColor" runat="server" 
								 ></cc1:bwimagebutton><cc1:bwimagebutton 
								id="btnDeleteColor" runat="server"  ></cc1:bwimagebutton><cc1:bwimagebutton 
								id="btnAddImage" runat="server"
										 Visible="false"></cc1:bwimagebutton>
								</td>
							</tr>
						</table>
                        <table id="SearchControls" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td width="100%">
                                    <asp:PlaceHolder ID="plhSearchControls" runat="server"></asp:PlaceHolder>
                                </td>
                                <td style="padding-right:5px;">
                                    <cc1:ConfirmedImageButton ID="imgBtnSearch" runat="server" Message="NONE" CausesValidation="false" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table class="ToolbarShort" id="Table2" height="20" cellSpacing="0" cellPadding="0" border="0">
							<tr class="fontHead">
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td>
									<div align="left">&nbsp;
										<asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label>
										<asp:label id="lblPageSize" Runat="server" Visible="false" Text="25"></asp:label>
                                    </div>
								</td>
								<td width="20">
									<div align="center">
									    <asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton>
									</div>
								</td>
								<td width="20">
									<div align="center">
									    <asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton>
								    </div>
								</td>
								<td width="150">
									<div align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
								</td>
								<td width="20">
									<div align="center">
			                            <asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton>
			                        </div>
								</td>
								<td width="20">
			                        <div align="center">
			                            <asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton>
			                        </div>
								</td>
								<td>
									<div align="left">
									    <B>
									        <asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>
									        &nbsp;
									        <asp:Label id="lblRecordsFound" runat="server" Text="Records Found"></asp:Label>
                                        </B>
                                    </div>
								</td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td width="25">
								    <asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25" Selected="True">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50">50</asp:ListItem>
									</asp:dropdownlist>
								</td>
								<td>&nbsp;</td>
								<td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead"></asp:button></td>
							</tr>
						</table>
						<table border="0" bordercolor="gainsboro" cellpadding="0" cellspacing="1">
                        <tr>           
                            <td valign="top">
                                                        
						     <asp:datalist id="DataListMaterialColor" GridLines="Both" 
                                RepeatDirection="Horizontal" RepeatColumns="4" BackColor="White"
	                            BorderColor="Gray" BorderWidth="0px" CellPadding="2" 
                                CssClass="font" runat="server" DataKeyField="MaterialColorID">
	                            <ItemStyle BackColor="White" BorderColor="Gainsboro" BorderStyle="Solid" 
                                    BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Top" />
	                            <ItemTemplate>
	                                    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
	                                        <tr height="75px" width="75px">
	                                            <td height="75px" align="center">
    	                                            <asp:Image runat="server" id="imgStyleFile" Width="75px" Height="75px"/>
        	                                    </td>
                                            </tr>
    									    <tr height="25px">
    									        <td align="left">                
                                                        <asp:PlaceHolder ID="plhHeaderItem" runat="server">
                                                        </asp:PlaceHolder>                                                
                                                </td>
                                            </tr>
                                        </table>
                                        <br/>	                    
	                            </ItemTemplate>
                            </asp:datalist>    
                            </td></tr></table>
                            
					</td>
					<td vAlign="top">
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td>
									<table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td align="center" width="3"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
											<td class="fontHead" width="100"><asp:label id="lblMaterialSizeType" runat="server"></asp:label></td>
											<td height="30">
												<table id="TbTrim" cellSpacing="2" cellPadding="0" width="250" border="0" runat="server">
													<tr class="fontHead">
														<td>&nbsp;</td>
														<td noWrap width="85"><asp:Label ID="lblNoofRow" runat="server" Text="No. of Row(s):"></asp:Label></td>
														<td width="35"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
																<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
																<asp:ListItem Value="2">2</asp:ListItem>
																<asp:ListItem Value="3">3</asp:ListItem>
																<asp:ListItem Value="4">4</asp:ListItem>
																<asp:ListItem Value="5">5</asp:ListItem>
																<asp:ListItem Value="10">10</asp:ListItem>
																<asp:ListItem Value="15">15</asp:ListItem>
																<asp:ListItem Value="20">20</asp:ListItem>
															</asp:dropdownlist></td>
														<td><cc1:confirmedimagebutton id="imgBtnAdd" runat="server" ></cc1:confirmedimagebutton></td>
													</tr>
												</table>
												<cc1:bwimagebutton id="btnAddTreatment" runat="server" ></cc1:bwimagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table id="TD_ImgFolder" cellSpacing="1" cellPadding="0" border="0" runat="server">
										<tr bgColor="#ffffff">
											<td><cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
											<td>
											    <asp:label id="lblSortBy" CssClass="font" Runat="server"><b>&nbsp;Sort by:</b></asp:label>
											    </td>
											<td><asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></td>
											<td><cc1:confirmedimagebutton id="btnSort" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
											<td></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<asp:datagrid id="Datagrid2" runat="server" OnItemDataBound="DataGrid2_ItemEventHandler" DataKeyField="MaterialSizeID" Width="250" AutoGenerateColumns="False" PageSize="1000"
										BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
										<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
										<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
										<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
										<FooterStyle></FooterStyle>
										<Columns>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" NAME="checkAll">
												</HeaderTemplate>
												<ItemTemplate>
													<asp:CheckBox id="chkDelete" runat="server"></asp:CheckBox>
													<asp:TextBox id="txtMaterialSizeVersion" runat="server" Visible="false" />
													<asp:HiddenField ID="hdnMaterialSizeVersion" runat="server" />
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<asp:Label id="lblMaterialSize" runat="server"></asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtMaterialSize" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														MaxLength="100" Columns="30"></asp:TextBox>
												    <asp:HiddenField ID="hdnMaterialSize" runat="server" />
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<div align="center">
														<asp:Label id="lblMaterialPrice" runat="server"></asp:Label>
														<asp:HiddenField ID="hdnMaterialPrice" runat="server" />
													</div>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtMaterialPrice" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0" maxlength="5" columns="5"></asp:TextBox>
												    <asp:HiddenField ID="hdnMaterialPrice" runat="server" />
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<DIV align="center">
														<asp:Label id="Label1" runat="server"><%=GetSystemText("Sort")%></asp:Label></DIV>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtSort" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0" maxlength="5" columns="5"></asp:TextBox>
												    <asp:HiddenField ID="hdnSort" runat="server" />
												</ItemTemplate>
											</asp:TemplateColumn>
										</Columns>
									</asp:datagrid>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>		
		</td>
		</tr>
		</table>
		<input type="hidden"  id="hdnContent"  runat ="server" />        			
		</form>
		<P>&nbsp;</P>
		<script language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
		                e.checked = actVar;
		        }
		    }
	    </script>
		
	</body>
</html>
