<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_BOL_CopyPage.aspx.vb" Inherits="plmOnApp.Style.BOL.Style_BOL_CopyPage" %>
<%@ Register TagPrefix="uc1" TagName="Style_Copy_Workflow" Src="Style_Copy_Workflow.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
		<title id="titleCopy" runat="server">Copy</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25" border="0">
				<tr>
					<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnCopy" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<uc1:Style_Copy_Workflow id="Style_Copy_Workflow1" runat="server"></uc1:Style_Copy_Workflow>
			<uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			

            <br />
            <table class="TableHeader" cellspacing="0" cellpadding="0" width="20%" border="0">
                <tr>
                    <td class="FontHead" align="right" width="75">
                        &nbsp;<%=GetSystemText("Select Set")%>:
                    </td>
                    <td width="40" align="left">
                        <asp:DropDownList ID="dpStyleSet" runat="server" CssClass="font" DataTextField="Value"
                            DataValueField="ID" AutoPostBack="false">
                        </asp:DropDownList>
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
