<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SizeClassGR_New.aspx.vb" Inherits="plmOnApp.Control_SizeClassGR_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<HEAD>
		<title runat="server" id="PageTitle">Size Class</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <style type="text/css">
            .style1
            {
                width: 1px;
            }
        </style>
	</HEAD>
<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" 
                    Message="NONE"></cc1:ConfirmedImageButton>                
                <cc1:confirmedimagebutton ID="btClose" runat="server" Message="NONE" CausesValidation="False" ></cc1:confirmedimagebutton>                 
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td valign="middle">
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0" style="border-bottom: orange thin solid;" >
       
        <tr>
            <td class="style1">&nbsp;</td>           
            <td>    
                <asp:Label ID="lblSizeClassName" runat="server"></asp:Label>                               
                <asp:TextBox ID="txtSizeClass" runat="server" MaxLength="60" Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvSizeClassName" runat="server"
                    ControlToValidate="txtSizeClass" Display="Dynamic" ErrorMessage="*"> 
                    </asp:RequiredFieldValidator>
             </td>
             <td width="10">&nbsp;</td>
        </tr>
         <tr>
            <td class="style1">&nbsp;</td>
            <td align="left">
                &nbsp;</td>
            <td align="right"><asp:Label ID="lblLastModifiedLabel" runat="server"></asp:Label>&nbsp;</td>
        </tr>   
         <tr>
            <td class="style1">&nbsp;</td>
            <td class="style2">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>       
    </table>	
   												
		
    <br>
    </form>
    <SCRIPT language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		</SCRIPT>
</body>
</html>
