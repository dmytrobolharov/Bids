<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Color.aspx.vb" Inherits="plmOnApp.Material_Color" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Material_WorkflowStatus" Src="Material_WorkflowStatus.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title runat="server" id="PageTitle">Palette</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10">
					    <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3">
					</td>
					<td width="550">				
					    <cc1:confirmedimagebutton id="btnSaveColorList" runat="server"  Message="NONE" />
					    <cc1:bwimagebutton id="btnaddColor" runat="server"  />
					    <cc1:confirmedimagebutton id="btnDelete" runat="server"  />
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
					    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"/>
					</td>
					<td width="140">
					    <table>
					        <tr>
					            <td>
					                <asp:label id="lblSortBy" Runat="server" CssClass="font"></asp:label>
					                <asp:dropdownlist id="ddlSortBy" Runat="server" />
					            </td>
					        </tr>
					    </table>
					</td>
					<td>
					    <cc1:confirmedimagebutton id="btnSort" runat="server" Message="NONE"  />
					</td>
				</tr>
			</table>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>
						<table id="Table1" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
							height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td>&nbsp;
									<asp:label id="lblImageHeader" runat="server" ForeColor="Silver" 
                                        Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<uc1:Material_WorkflowStatus ID="Material_WorkflowStatus1" runat="server" MaterialWorkflowPageID='<%# Request.QueryString("MWPID") %>' />
			<table cellspacing="0" cellpadding="0" width="100%" border="0" height="25">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif" runat="server"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif" runat="server"></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:Label id="lblMaterialDetail" runat="server"></asp:Label></td>
				</tr>
			</table>
			<asp:panel id="Panel1" runat="server" BorderWidth="0" CssClass="font" Width="100%" BackColor="#ffffff">
				<table id="Table2" cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc1:Material_Header id="Material_Header2" runat="server"></uc1:Material_Header></td>
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
            			
			            <table width="100%" >
			            <tr>
			                <td>
			                    <asp:datagrid id="DataGrid1" runat="server"  EnableViewState="True" 
                                        DataKeyField="MaterialColorID">
                                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate" />
                                        <ItemStyle Height="20px" CssClass="ItemTemplate" />
                                        <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
                                        <PagerStyle Visible="False"></PagerStyle>
                                        <Columns>
                                            <asp:TemplateColumn HeaderStyle-CssClass="TableHeaderRed" ItemStyle-CssClass="TableHeaderRed" HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                                <HeaderTemplate >
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
            
        <asp:HiddenField ID="hdnXMLFile" runat="server" />
        <asp:HiddenField ID="hdnSQL" runat="server" />
        
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
        function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
                    }
		</script>
	</body>
</HTML>
