<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit.aspx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Sample Approval</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/mamagi.css" type="text/css" rel="stylesheet">
		<script language="javascript" src='../System/Jscript/YSCalendarFunctions.js'></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
		<%--<script language="javascript" src='../System/Jscript/YSCustomFunctions.js'></script>--%>
		<!--<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>-->
        <script language="javascript" src='../System/Jscript/mamagi/jquery.mamagi.yunique.js'></script>
        <script language="javascript" src='../System/Jscript/mamagi/scroll.comment.js'></script>
        <script language=javascript type="text/javascript">
            function checkSubmit() {
                if (document.getElementById("<%=HFSubmitForm.ClientID %>").value == 1)
                    return false;
                else {
                    document.getElementById("<%=HFSubmitForm.ClientID %>").value = 1;
                    return true;
                }
            }
          </script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				    <TD>
                        <cc1:confirmedimagebutton id="btnSave" OnClientClick="javascript:if(checkSubmit()==false){return false;}" runat="server" MESSAGE="NONE"></cc1:confirmedimagebutton>
                    	<cc1:confirmedimagebutton id="btnPreview" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                        <asp:HiddenField ID="HFSubmitForm" runat="server" Value="0" />
					</TD>
            	    
			
				</TR>
			</TABLE>
			
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<asp:PlaceHolder id="phSeasonYearColor" runat="server"></asp:PlaceHolder>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
					<td><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
				</tr>
			</table>
			<asp:placeholder id="phSpec" runat="server"></asp:placeholder>
			<asp:PlaceHolder id="phMaterial" runat="server"></asp:PlaceHolder></form>
			<asp:PlaceHolder id="phCustom" runat="server"></asp:PlaceHolder>
	</body>
</HTML>
