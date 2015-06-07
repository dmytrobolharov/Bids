<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_Group_ColorsRemove.aspx.vb" Inherits="plmOnApp.Material_Group_ColorsRemove" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Remove</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />    
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
					id="btnSave" runat="server" Message="NONE"  style="height: 24px"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			
			<br />
    
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material Colors</asp:label></td>
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
                                        DataKeyField="MaterialCoreColorID">
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
    </form>
	<script language="javascript" type="text/javascript"  >
	var frm = document.form1 ;
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
</html>
