﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_MeasPOMTemplate_Library.aspx.vb" Inherits="plmOnApp.Style.Measurements.Style_MeasPOMTemplate_Library" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="TableHeader" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnSave" runat="server" ToolTip="Save..." 
							Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" ToolTip="" OnClientClick="return btnClose_Click()"
							 Message="NONE"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
					<tr>
            <td valign="middle">
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
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
					            <td class="fontHead" width="10">&nbsp;</td>
					            <asp:Label id="Label1" runat="server"></asp:Label></td>
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
			            
            <asp:datagrid id="DataGrid1" runat="server" DataKeyField="POMAlternatesID" 
            		AutoGenerateColumns="false" Width="100%">
            		<PagerStyle Visible ="false"></PagerStyle>
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				    <headerStyle Height="25px" CssClass="TableHeaderRed"></headerStyle>
                       <Columns>
                        <asp:TemplateColumn HeaderStyle-Width="20" HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                            <HeaderTemplate >
                                <asp:CheckBox runat="server" ID="chkSelectAll" onclick="CheckAll(this);"/>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chkSelect"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>                                    
                    </Columns> 
             </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
                               
			                			
		 </form>
		<script language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkSelect") != -1 )
			e.checked= actVar ;
		}
		}
		</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
</body>
</html>
