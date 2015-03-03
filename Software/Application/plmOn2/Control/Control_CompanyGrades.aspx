<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_CompanyGrades.aspx.vb" Inherits="plmOnApp.Control_CompanyGrades" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title runat="server" id="PageTitle">Grades</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="TableHeader" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
						<cc1:confirmedimagebutton id="btnEdit" runat="server" ToolTip="Edit..." 
							Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnDelete" runat="server" ToolTip="Edit..." 
							Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" ToolTip="" OnClientClick="return btnClose_Click()"
							 Message="NONE"></cc1:confirmedimagebutton>
					</TD>
				</TR>
			</TABLE>
			<TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
				    <tr>				        
                        <td valign="middle">
                            &nbsp;<asp:Label ID="lblCompany" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                                ForeColor="#E0E0E0"></asp:Label>
                        </td>                        
                    </tr>					         
				</TBODY>
			</TABLE>			
			
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr valign="top">
		            <td>
			            <table  class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <tr valign="middle">
					            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>        
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
					            <td width="10"><asp:button id="btnRepage" runat="server" CssClass="fontHead" Text="GO"></asp:button></td>
					            <td>&nbsp;</td>
				            </tr>
			            </table>
			  </td></tr></table>
			  <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
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
			<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="GradeRuleGuidID">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
				<Columns>
			        <asp:TemplateColumn>
			         <HeaderStyle Width="50px" CssClass="TableHeaderRed"></HeaderStyle>
					 <ItemStyle Width="50px"></ItemStyle>
			            <HeaderTemplate >
					        <input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll">
				        </HeaderTemplate>
				        <ItemTemplate>
					        <asp:CheckBox ID="chkSelect" runat="server"></asp:CheckBox>
				        </ItemTemplate>
			        </asp:TemplateColumn>
		        </Columns>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Text="SortField" Visible="False"></asp:label>
						
		
			
		</form>
		
	</body>
	<script language="javascript">
	    var frm = document.Form1;
	    function CheckAll(checkAllBox) {
	        var actVar = checkAllBox.checked;
	        for (i = 0; i < frm.length; i++) {
	            e = frm.elements[i];
	            if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
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
