<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Task_New.aspx.vb" Inherits="plmOnApp.Task_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Task Folder</title>
   	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
	    <TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <TR vAlign="middle">
			    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			    <TD><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" style="height: 24px"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
			    id="btnClose" runat="server" Message="NONE" style="height: 24px"></cc1:confirmedimagebutton>
			    </TD>
		    </TR>
	    </TABLE>
	    
	    <table width="100%" height="10" border="0" cellpadding="0" cellspacing="0" bgcolor="#cddeee">
		    <tr>
			    <td></td>
		    </tr>
	    </table>
	    <br/>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
		    <tr>
			    <td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large" ForeColor="#E0E0E0">New Task ...</asp:Label></td>
		    </tr>
	    </table>
        <br/>

        <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
		    <tr>
			    <td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
		    </tr>
	    </table>

    </div>
    </form>
</body>
</html>
