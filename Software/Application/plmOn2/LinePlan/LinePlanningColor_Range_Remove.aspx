<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlanningColor_Range_Remove.aspx.vb" Inherits="plmOnApp.LinePlanningColor_Range_Remove" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Color Remove</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <form id="form1" runat="server">
	    <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
		    </tr>
	    </table>

		<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblBodyHeader" runat="server" ForeColor="#E0E0E0" 
                        Font-Size="X-Large" Font-Names="Tahoma,Verdana">Color Folder</asp:label></td>
			</tr>
		</table>
		
		<asp:datagrid id="DataGrid1" runat="server">
			<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
			<PagerStyle Visible="False"></PagerStyle>
		</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
				
    
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
