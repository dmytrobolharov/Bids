<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_TradePartner_New.aspx.vb"
    Inherits="plmOnApp.Control_TradePartner_New" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Control</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/CheckListDropDown.css" type="text/css" rel="stylesheet"/>		
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../System/Jscript/arc90_multiselect.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	<script language="javascript" type="text/javascript">
	    // change the default options for all multiselects
	    a$.NO_SELECTION = 'No selection'; 	// TEXT for 'No selection' when nothing selected
	    a$.SELECTED = 'items selected'; // TEXT for 'XX Options selected' when over 1 selected
	    a$.SELECT_ALL = 'Select All'; 		// TEXT for 'Select All' for checkboxes
	    a$.SelectAllMin = 3; 				// minimum number of options needed to show 'Select All'
	    a$.WhenToUse = 'class'; 			// class | multiple | all : for how to make selects become multiselects
	    a$.msSeparator = '|'; 				// separator for values (can be multiple characters)
	</script>	
	    
</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td width="80">
                <cc1:ConfirmedImageButton ID="btnSaveMaterial" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee"
        border="0">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table height="90%" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td>
                            <div align="right">
                                <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large"
                                    Font-Names="Tahoma,Verdana"></asp:Label></div>
                        </td>
                    </tr>
                </table>
                <table id="Table2" cellspacing="2" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" bgcolor="#f5f5f5">
                &nbsp;
            </td>
        </tr>
    </table>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
