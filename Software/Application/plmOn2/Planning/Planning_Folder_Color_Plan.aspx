<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder_Color_Plan.aspx.vb" Inherits="plmOnApp.Planning_Folder_Color_Plan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Planning Color Allocation</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet"/>
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10">
					    <asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/>
                    </td>
					<td valign="top">
                        <cc1:BWImageButton id="btnColorAdd" runat="server" CausesValidation="false" Visible="false"></cc1:BWImageButton>
                        <cc1:confirmedimagebutton id="btnColorDrop" runat="server" Message="NONE" Visible="false"></cc1:confirmedimagebutton>
                        <cc1:ConfirmedImageButton ID="btnColorRemove" runat="server" Visible="false"></cc1:ConfirmedImageButton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" Visible="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>  
                    </td>
					<td></td>
				</tr>
			</table>
			<table height="10" cellspacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Line Plan Folder...</asp:label></td>
				</tr>
			</table>
            <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr class="TableHeader">
		            <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td width="20">
		                <img id="imgBtnExp" onclick="return ShowHeaderContent(this)" style="cursor:pointer;"  src="../System/Icons/icon_Next.gif" />
		                <img id="imgBtnCol" onclick="return HideHeaderContent(this)" style="cursor:pointer; display:none;" src="../System/Icons/icon_Down.gif" />
		            </td>
		            <td class="fontHead">
			            <asp:label id="lblHeaderDetail" runat="server"></asp:label>
		            </td>
	            </tr>
            </table>
            <div id="divHeaderContent" style="display:none;">
			<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900"><asp:placeholder id="plhHeaderControlsHolder" runat="server"></asp:placeholder></td>
					<td>&nbsp;</td>
				</tr>
			</table>
            </div>
            <br />
            <cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>	
			
		</form>
        <script type="text/javascript" language="javascript">
            var frm = document.Form1;
            function SelectAll(checkAllBox) {
                var actVar = checkAllBox.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
                        e.checked = actVar;
                }
            }

            function ShowHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnCol').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'block';
                return false;
            }

            function HideHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnExp').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'none';
                return false;
            }
        </script>
	</body>
</html>
