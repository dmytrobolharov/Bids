<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Material_Status.ascx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_Material_Status" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<script type="text/javascript">              
	function doubleclickEnd(){
		document.Form1['Material$Status$txt_EndBy'].value = document.Form1['Material$Status$hd_UserName'].value;
		document.Form1['Material$Status$txt_EndDate'].value = document.Form1['Material$Status$hd_UserDate'].value;
		}
	function doubleclickRec(){
		document.Form1['Material$Status$txt_RecBy'].value = document.Form1['Material$Status$hd_UserName'].value;
		document.Form1['Material$Status$txt_RecDate'].value = document.Form1['Material$Status$hd_UserDate'].value;
		}			
</script>
<table height="25" cellSpacing="0" cellPadding="0" width="600" border="0">
	<tr class="TableHeader">
		<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></td>
		<td class="fontHead"><asp:Label id="lblSubmitStatus" runat="server" CssClass="fontHead">Submit Status</asp:Label></td>
	</tr>
</table>
<asp:panel id="Panel1" runat="server">
	<TABLE cellSpacing="0" cellPadding="0" border="0">
		<TR>
			<TD vAlign="top" width="250">
				<TABLE cellSpacing="0" cellPadding="0" width="250" bgColor="#ffffff" border="0">
					<TR height="20">
						<TD class="TableHeaderRed" width="10">&nbsp;</TD>
						<TD class="TableHeaderRed" style="WIDTH: 140px">&nbsp;<asp:label id="lblSubmitStatus1" runat="server" CssClass="TableHeaderRed">Submit Status</asp:label></TD>
						<TD class="TableHeaderRed" style="WIDTH: 140px">&nbsp;<asp:label id="lblDueDate" runat="server" CssClass="TableHeaderRed">Due Date</asp:label></TD>
					</TR>
					<TR height="25">
						<TD style="HEIGHT: 16px" width="10">&nbsp;</TD>
						<TD style="WIDTH: 140px">&nbsp;
							<asp:Label id="txt_SubmitStatus" runat="server" CssClass="fonthead"></asp:Label></TD>
						<TD style="HEIGHT: 15px"><A href="javascript:calendar('Material$Status$txt_DueDate')"></A>&nbsp;
							<asp:Label id="txt_DueDate" runat="server" CssClass="font"></asp:Label></TD>
					</TR>
					<TR height="20">
						<TD class="TableHeaderBlue" width="10">&nbsp;</TD>
						<TD class="TableHeaderBlue" style="WIDTH: 140px">&nbsp;<asp:Label id="lblReceivedBy" runat="server" CssClass="TableHeaderBlue">Received By</asp:Label>
						</TD>
						<TD class="TableHeaderBlue">&nbsp;<asp:Label id="lblReceivedDate" runat="server" CssClass="TableHeaderBlue">Received Date</asp:Label></TD>
					</TR>
					<TR height="20">
						<TD width="10">&nbsp;</TD>
						<TD style="WIDTH: 140px">&nbsp;
							<asp:Label id="txt_RecBy" runat="server" CssClass="font"></asp:Label></TD>
						<TD>&nbsp;
							<asp:Label id="txt_RecDate" runat="server" CssClass="font"></asp:Label></TD>
					</TR>
				</TABLE>
			</TD>
			<TD vAlign="top" width="260">
				<TABLE id="Table1" cellSpacing="0" cellPadding="0" width="260" bgColor="#ffffff" border="0">
					<TR height="20">
						<TD class="TableHeaderYellow" width="10"></TD>
						<TD class="TableHeaderYellow" style="WIDTH: 140px">&nbsp;<asp:Label id="lblVendorBy" runat="server" CssClass="TableHeaderYellow">Vendor By</asp:Label></TD>
						<TD class="TableHeaderYellow" style="WIDTH: 140px">&nbsp;<asp:Label id="lblVendorDate" runat="server" CssClass="TableHeaderYellow">Vendor Date</asp:Label></TD>
					</TR>
					<TR height="25">
						<TD>&nbsp;</TD>
						<TD style="WIDTH: 140px">
							<asp:TextBox id="txt_VendorBy" runat="server" CssClass="font" Width="125px"></asp:TextBox></TD>
						<TD><A href="javascript:calendar('Material$Status$txt_DueDate')"></A>&nbsp;
							<asp:TextBox id="txt_VendorDate" runat="server" CssClass="font" Width="80px"></asp:TextBox><A href="javascript:calendar('<%= txt_VendorDate.ClientID %>')"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A></TD>
					</TR>
					<TR height="20">
						<TD class="TableHeaderGreen" width="10">&nbsp;</TD>
						<TD class="TableHeaderGreen" style="WIDTH: 140px">&nbsp;<asp:Label id="lblApprovedBy" runat="server" CssClass="TableHeaderGreen">Approved By</asp:Label></TD>
						<TD class="TableHeaderGreen">&nbsp;<asp:Label id="lblApprovedDate" runat="server" CssClass="TableHeaderGreen">Approved Date</asp:Label></TD>
					</TR>
					<TR height="20">
						<TD width="10">&nbsp;</TD>
						<TD style="WIDTH: 140px">&nbsp;
							<asp:Label id="txt_EndBy" runat="server" CssClass="font"></asp:Label></TD>
						<TD>&nbsp;
							<asp:Label id="txt_EndDate" runat="server" CssClass="font"></asp:Label></TD>
					</TR>
				</TABLE>
			</TD>
			</TD></TR>
	</TABLE>
	<INPUT id="hd_UserName" type="hidden" name="Hidden1" runat="server"><INPUT id="hd_UserDate" type="hidden" name="Hidden2" runat="server">
</asp:panel>
