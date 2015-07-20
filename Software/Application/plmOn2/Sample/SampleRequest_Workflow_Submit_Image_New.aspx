<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Image_New.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Image_New" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="80"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
					<td width="80"><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
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
							ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<asp:panel id="pnlUpload" runat="server">
				<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
						<P><BR>
							<SPAN class="fontHead">
                                <asp:Label ID="lblSelectFiles" runat="server" ><%#GetSystemText("Select Files to Upload... ")%></asp:Label></SPAN>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<SPAN class="fontHead">
                                <asp:Label ID="lblDescription" runat="server" ><%#GetSystemText("Description... ")%></asp:Label></SPAN>
							<BR>
							<BR>
							<INPUT id="File1" type="file" name="file1" runat="server">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<asp:TextBox id="txtDescription1" Runat="server" CssClass="font"  MaxLength="200"  ></asp:TextBox>
							<BR>
							<BR>
							<INPUT id="File2" type="file" name="file2" runat="server">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<asp:TextBox id="txtDescription2" Runat="server" CssClass="font"  MaxLength="200"  ></asp:TextBox><BR>
							<BR>
							<INPUT id="File3" type="file" name="file3" runat="server">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<asp:TextBox id="txtDescription3" Runat="server" CssClass="font"  MaxLength="200"  ></asp:TextBox><BR>
							<BR>
							<INPUT id="File4" type="file" name="file4" runat="server">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<asp:TextBox id="txtDescription4" Runat="server" CssClass="font"  MaxLength="200"  ></asp:TextBox><BR>
							<BR>
							<INPUT id="File5" type="file" name="file5" runat="server">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<asp:TextBox id="txtDescription5" Runat="server" CssClass="font"  MaxLength="200"  ></asp:TextBox></P>
					</BLOCKQUOTE></BLOCKQUOTE>
					<%--<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
						<P><SPAN class="fontHead">Description... </SPAN>&nbsp;
							<asp:TextBox id="txtDescription" Runat="server" CssClass="font"  MaxLength="200"  ></asp:TextBox></P>
					</BLOCKQUOTE></BLOCKQUOTE>--%>
			</asp:panel><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></form>
            <script language="javascript">
	            function btnClose_Click() {
		            <%= strExitScript %>
                    return false;
                }
            </script>
	</body>
</HTML>
