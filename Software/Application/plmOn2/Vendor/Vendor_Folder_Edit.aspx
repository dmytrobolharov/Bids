<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_Folder_Edit.aspx.vb"
    Inherits="plmOnApp.Vendor_Folder_Edit" %>

<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Trading Partner</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/CheckListDropDown.css" type="text/css" rel="stylesheet"/>		
    <script language="javascript" src="../System/Jscript/arc90_multiselect.js"></script>
	<script language="javascript" type="text/javascript">
	    // change the default options for all multiselects
	    a$.NO_SELECTION = 'No selection'; 	// TEXT for 'No selection' when nothing selected
	    a$.SELECTED = 'items selected'; // TEXT for 'XX Options selected' when over 1 selected
	    a$.SELECT_ALL = 'Select All'; 		// TEXT for 'Select All' for checkboxes
	    a$.SelectAllMin = 3; 				// minimum number of options needed to show 'Select All'
	    a$.WhenToUse = 'class'; 			// class | multiple | all : for how to make selects become multiselects
	    a$.msSeparator = '|'; 				// separator for values (can be multiple characters)
	</script>	

    <script language="javascript">
    
            if (window.screen) {
                var aw = screen.availWidth;
                var ah = screen.availHeight;
                window.moveTo(0, 0);
                window.resizeTo(aw, ah);
            }
			
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
    </script>

</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td width="100%">
                <cc2:ConfirmedImageButton ID="btnSaveUser" runat="server"  Message="NONE"></cc2:ConfirmedImageButton>                
                <cc2:ConfirmedImageButton ID="btnClose" visible="false" runat="server" Message="NONE"></cc2:ConfirmedImageButton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top" colspan="2" height="50">
                            <asp:Label ID="lblTradeName" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                                ForeColor="#E0E0E0"></asp:Label>&nbsp;
                        </td>
                        <td valign="top" height="50">
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
                <br>
                <cc1:YSTabView ID="YSTabView1" runat="server"></cc1:YSTabView>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlContact" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr>
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="100%">
                    <cc2:BWImageButton ID="btnAddContact" runat="server" >
                    </cc2:BWImageButton>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>        
    </asp:Panel>
   
    </form>
</body>
</html>
