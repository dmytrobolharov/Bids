<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmitAttachment_New.aspx.vb" Inherits="plmOnApp.Material_RequestSubmitAttachment_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>

	    <TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td width="80"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
			    <td width="80"><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
			    <td width="75">&nbsp;</td>
			    <td>&nbsp;</td>
		    </tr>
	    </TABLE>

		<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
						ForeColor="#E0E0E0">New Attachment...</asp:label></td>
			</tr>
		</table>

		<asp:panel id="pnlUpload" runat="server">
			<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
					<P><BR>
						<SPAN class="fontHead"><asp:Label ID="lblFiletoUpload" runat="server" Text="File to Upload..."></asp:Label> </SPAN>
						<BR>
						<BR>
						<INPUT id="File1" type="file" name="file1" runat="server"></P>
				</BLOCKQUOTE></BLOCKQUOTE><BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
					<P><SPAN class="fontHead"><asp:Label ID="lblDescription" runat="server" Text="Description..."></asp:Label></SPAN>&nbsp;
						<asp:TextBox id="txtDescription" Runat="server" CssClass="font"  MaxLength="200"  ></asp:TextBox></P>
				</BLOCKQUOTE></BLOCKQUOTE>
		</asp:panel>
    
    </div>
    </form>
    <script language="javascript">
            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
    </script>
</body>
</html>
