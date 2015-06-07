<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Image_Edit.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Image_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
	<form id="Form1" method="post" encType="multipart/form-data" runat="server">
		<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
			<tr vAlign="middle">
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td>
                    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnRemove" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:ConfirmedImageButton ID="btnDownload" runat="server" CausesValidation="false" Message="NONE" OnClientClick="dont_show_wait_next_time();" />
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
                </td>
				<td>&nbsp;</td>
			</tr>
		</TABLE>
		<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="whitesmoke" border="0">
			<TR>
				<TD vAlign="top" width="400">
					<TABLE cellSpacing="0" cellPadding="0" width="400" border="0">
						<TR>
							<TD style="HEIGHT: 22px" width="10">&nbsp;</TD>
							<TD class="fontHead" width="100"><%=GetSystemText("File Name")%>:</TD>
							<TD class="font"><asp:Label id=lblFileName runat="server"></asp:Label></TD>
						</TR>
						<TR>
							<TD width="10">&nbsp;</TD>
							<TD class="fontHead" vAlign="top" width="100"><BR><%=GetSystemText("File Description")%>:</TD>
							<TD class="font"><asp:TextBox id="txtFileDescription" runat="server" Width="250" Columns="50" Wrap="false" TextMode="MultiLine" Rows="5"></asp:TextBox></TD>
						</TR>
					</TABLE>
				</TD>
				<TD vAlign="top">
					<TABLE cellSpacing="0" cellPadding="0" width="400" border="0">
						<TR>
							<TD width="10">&nbsp;</TD>
							<TD class="fontHead" vAlign="top" width="100"><%=GetSystemText("Upload File")%>:</TD>
							<TD class="font"><INPUT class="font" id="txtImagePath" type="file" runat="server" NAME="txtImagePath"></TD>
						</TR>
						<TR>
							<TD width="10">&nbsp;</TD>
							<TD class="fontHead" vAlign="top" width="100"><%=GetSystemText("File Size")%>:</TD>
							<TD class="font"><asp:Label id=lblFileSize runat="server"></asp:Label></TD>
						</TR>
					</TABLE>
				</TD>
				<TD></TD>
			</TR>
		</TABLE>
		<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="whitesmoke" border="0">
			<TR>
				<TD width="20">&nbsp;</TD>
				<TD class="font" width="100"><%=GetSystemText("Created By")%>:</TD>
				<TD class="font"><asp:Label id=lblCData runat="server"></asp:Label></TD>
			</TR>
			<TR>
				<TD width="20" bgColor="whitesmoke">&nbsp;</TD>
				<TD class="font" width="100"><%=GetSystemText("Modified By")%>:</TD>
				<TD class="font"><asp:Label id=lblMData runat="server"></asp:Label></TD>
			</TR>
		</TABLE>
    </form>

    <script type="text/javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
    </body>
</HTML>
