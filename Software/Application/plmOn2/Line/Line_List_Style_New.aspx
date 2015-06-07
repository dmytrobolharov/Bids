<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Line_List_Style_New.aspx.vb" Inherits="plmOnApp.Line_List_Style_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>New</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>	    
    <script language="javascript" SRC="../System/Jscript/Custom.js"></script>	    
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
		<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td>
					<asp:ImageButton id="btnSaveStyle" runat="server" ></asp:ImageButton><cc1:confirmedimagebutton id="imgBtnNext" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"
                        ></cc1:confirmedimagebutton></td>
			</tr>
		</table>

		<table height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>

			<table height="90%" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" bgColor="#ffffff">
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td>
									<div align="right"><asp:label id="lblStyleHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
											ForeColor="#E0E0E0">New Style...</asp:label></div>
								</td>
							</tr>
						</table>
						<asp:panel id="pnlStyle" runat="server">
							<table height="100" cellSpacing="0" cellpadding="0" width="100%" border="0">
								<tr valign="top">
									<td width="10">&nbsp;</td>
									<td>
										<asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
								</tr>
							</table>
						</asp:panel>
						<table height="100" cellSpacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
							border="0">
							<tr valign="top">
								<td width="33%"></td>
								<td width="33%"></td>
								<td width="33%"></td>
							</tr>
						</table>
					</td>
					<td width="10%" bgColor="#f5f5f5">&nbsp;</td>
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
