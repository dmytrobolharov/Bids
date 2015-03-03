<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Vendor_FolderPage_ProductType.aspx.vb" Inherits="plmOnApp.Vendor_FolderPage_ProductType" %>
<%@ Register TagPrefix="uc1" TagName="Vendor_Header" Src="Vendor_Folder_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="PartnerAccessType" src="Vendor_FolderPage_PartnerAccessType.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title runat="server" id="PageTitle">Product Type</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10">
					    <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3">
					</td>
					<td vAlign="middle" width="265">
					    <cc1:bwimagebutton id="btnadd" runat="server"  />
					    <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnDelete" runat="server"  />
					</td>
                    <td><uc1:PartnerAccessType runat="server" id="ctrlPartnerAccessType" /></td>
					<td valign="middle" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td valign="middle" width="140"><asp:label id="lblSortBy" CssClass="font" 
                            Runat="server" Font-Bold="True" Font-Overline="False"><b>&nbsp; 
								</b></asp:label><asp:dropdownlist id="ddlSortBy" Runat="server">
							<asp:ListItem ></asp:ListItem>
						</asp:dropdownlist></td>
					<td valign="middle"><cc1:confirmedimagebutton id="btnSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
				</tr>
			</table>			
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>
						<table id="Table1" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
							height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td>&nbsp;
									<asp:label id="lblHeader" runat="server" ForeColor="Silver" 
                                        Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" height="25">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif" runat="server"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif" runat="server"></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:Label id="lblVendor" runat="server"></asp:Label></td>
				</tr>
			</table>
			<asp:panel id="Panel1" runat="server" BorderWidth="0" CssClass="font" Width="100%" BackColor="#ffffff">
				<table id="Table2" cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc1:Vendor_Header id="Vendor_Header1" runat="server"></uc1:Vendor_Header></td>
						<td></td>
					</tr>
				</table>
			    <table style="BORDER-BOTTOM: silver thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
							height="1" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				    <tr>
					    <td></td>
				    </tr>
			    </table>
			    <br />
			</asp:panel>	
			<table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>            
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr valign="top">
		            <td>
			            <table  class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <tr valign="middle">
					            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td class="fontHead" width="10">&nbsp;</td>
					            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
					            <td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
					            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></td>
					            <td width="10">&nbsp;</td>
					            <td width="125"><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>				
					            <td class = "fontHead"  align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></td>
					            <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							            <asp:ListItem Value="5">5</asp:ListItem>
							            <asp:ListItem Value="10">10</asp:ListItem>
							            <asp:ListItem Value="15">15</asp:ListItem>
							            <asp:ListItem Value="20">20</asp:ListItem>
							            <asp:ListItem Value="25">25</asp:ListItem>
							            <asp:ListItem Value="30">30</asp:ListItem>
							            <asp:ListItem Value="40">40</asp:ListItem>
							            <asp:ListItem Value="50" Selected="true">50</asp:ListItem>
							            <asp:ListItem Value="75">75</asp:ListItem>
							            <asp:ListItem Value="100">100</asp:ListItem>
						            </asp:dropdownlist></td>
					            <td width="10"><asp:button id="Button1" runat="server" CssClass="fontHead" Text="GO"></asp:button></td>
					            <td>&nbsp;</td>
				            </tr>
			            </table>
            			
			            <table width="100%">
			            <tr>
			                <td>
			                <asp:datagrid id="DataGrid1" runat="server"  DataKeyField="TradePartnerProductTypeId">
                                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                                        </AlternatingItemStyle>
                                        <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                                        <headerStyle Height="25px" CssClass="tableheader"></headerStyle>
                                        <PagerStyle Visible="False"></PagerStyle>
                                        <Columns>
                                            <asp:TemplateColumn>
                                                <HeaderTemplate>
                                                    <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkSelected" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:datagrid>			                    
                                    <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			                </td>
			            </tr>
			            </table>          			
		            </td>
	            </tr>
            </table>
		</form>
		<script language="javascript" type="text/javascript"  >
		var frm = document.Form1 ;
		function SelectAll(checkAllBox) {
		    var actVar = checkAllBox.checked ;
		    for(i=0;i< frm.length;i++) {
			    e=frm.elements[i];
			    if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
			        e.checked= actVar ;
		    }
		}
		</script>
	</body>
</HTML>
