<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_NBOL_MachineClass_New.aspx.vb" Inherits="plmOnApp.Control_NBOL_MachineClass_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
        .rightAlign
        {
        	text-align: right;
        }
    </style>
</head>
<body style="background-color: #ffffff;">
    <form id="form1" runat="server">

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="80"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
					<td><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
            </table>
            <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
                cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                <tr>
                    <td width="10">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
			<table height="90%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<asp:panel id="pnlControls" runat="server">
							<table class="fontHead" height="100" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<tr vAlign="top">
									<td width="25">&nbsp;</td>
									<td>
										<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
								</tr>
							</table>
						</asp:panel>
					</td>
					<td width="10%">&nbsp;</td>
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
