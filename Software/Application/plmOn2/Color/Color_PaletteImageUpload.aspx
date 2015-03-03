<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_PaletteImageUpload.aspx.vb" Inherits="plmOnApp.Color_PaletteImageUpload" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Upload</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <script>
        function btnClose_Click() {
            <%= strExitScript %>
            return false;
        }
   </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>

		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
			    <td width="20">&nbsp;</td>
			    <td width="20">
                    <img src="../System/Icons/icon_colorwheel.gif" /></td>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" 
                        Font-Size="Medium" ForeColor="Gray">Upload Color</asp:label></td>
			</tr>
		</table>   
        <br />
		<br />
		<br />
		<br />
		<asp:panel id="pnlUpload" runat="server">
			<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
					<P><BR>
						<SPAN class="fontHead"><asp:label id="lblSelectFileToUpload" runat="server" CssClass="fontHead">Select File to Upload...</asp:label> </SPAN>
						<BR>
						<BR>
						<INPUT id="File1" type="file" name="file1" runat="server"></P>
				</BLOCKQUOTE></BLOCKQUOTE><BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
					<P></P>
				</BLOCKQUOTE></BLOCKQUOTE>
		</asp:panel>
		<br />
		<br />
		<br />
		<br />
 	    <table bgcolor="gainsboro" border="0" cellpadding="0" cellspacing="0" 
            height="40" 
            style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro" 
            width="100%">
            <tr>
                <td align="center" width="50">
                    &nbsp;</td>
                <td align="center" width="300">
                    <asp:ImageButton ID="btnSave" runat="server" />
                    <asp:ImageButton ID="btnClose" runat="server" OnClientClick="return btnClose_Click();"/>
                </td>
                <td align="center">
                    &nbsp;</td>
            </tr>
        </table>      
    </div>
    </form>
</body>
</html>
