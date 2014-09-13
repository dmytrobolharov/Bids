<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Group_Copy_Permissions.aspx.vb"
    Inherits="plmOnApp.Control_Group_Copy_Permissions" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Folder</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <script src="../System/Jscript/jquery-1.8.0.js"></script>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td align="right" width="40">
                <asp:Image ID="iconLock" runat="server" ImageUrl="../System/Icons/icon_copyto.gif">
                </asp:Image>
            </td>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnCopy" runat="server" Message="NONE" CausesValidation="false"></cc1:ConfirmedImageButton>
    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <div>
        <asp:Label ID="Label1" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Copy To </asp:Label>
        <asp:RadioButtonList ID="RadioButtonList1" runat="server">
            <asp:ListItem Selected="True" Value="0">New Group</asp:ListItem>
            <asp:ListItem Value="1">Exists Group</asp:ListItem>
        </asp:RadioButtonList>
    </div>
    <div id="newgroup">
       
               	<table  cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td>
									<div align="right"><asp:label id="Label2" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana"></asp:label></div>
								</td>
							</tr>
						</table>
						<asp:panel id="pnlMaterial" runat="server">
							<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="top">
									<TD width="10">&nbsp;</TD>
									<TD>
										<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
								</TR>
							</TABLE>
						</asp:panel>
						<table height="100" cellSpacing="0" cellPadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
							border="0">
							<tr vAlign="top">
								<td width="33%"></td>
								<td width="33%"></td>
								<td width="33%"></td>
							</tr>
						</table>
					</td>
					<td width="10%" bgColor="#f5f5f5">&nbsp;</td>
				</tr>
			</table>
    </div>
    <div id="exesistsgroup" style="display:none;" > 
    <asp:DropDownList ID="ddlGroups" runat="server" AppendDataBoundItems="true" DataTextField="Group_List"
                    DataValueField="id">
                </asp:DropDownList>
    </div>  

    </form>

    <SCRIPT language="javascript">
        $('input:radio').change(
    function () {
        if ($(this).is(':checked') && $(this).val() == '0') {
            $("#exesistsgroup").hide();
            $("#newgroup").show();
        }

        if ($(this).is(':checked') && $(this).val() == '1') {
            $("#exesistsgroup").show();
            $("#newgroup").hide();
         
        }
    });
		</SCRIPT>
</body>
</html>
