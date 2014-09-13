<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TechPack_Sourcing_New.aspx.vb" Inherits="plmOnApp.TechPack_Sourcing_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Tech Pack</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">

	    <table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><cc1:confirmedimagebutton id="btnNext" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
			    id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
		    </tr>
	    </table>


        <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
		    height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
		    <tr>
			    <td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Sourcing ...</asp:label></td>
		    </tr>
	    </table>
		
        <asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleSourcingID" AllowSorting="True">
	        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
	        <PagerStyle Visible="False"></PagerStyle>
	        <Columns>
    	        <asp:TemplateColumn>
    	            <ItemTemplate>
    	                <asp:Label runat="server" ID="lblSelect" ></asp:Label>
    	            </ItemTemplate>
	            </asp:TemplateColumn>
	        </Columns>
	        	      

        </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>			
			
    </form>
</body>
</html>
