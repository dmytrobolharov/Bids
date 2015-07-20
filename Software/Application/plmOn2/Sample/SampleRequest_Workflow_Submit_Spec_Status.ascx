<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Spec_Status.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Spec_Status" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<script type="text/javascript">              
	function doubleclickEnd(){
		document.Form1['Spec$Status$txt_EndBy'].value = document.Form1['Spec$Status$hd_UserName'].value;
		document.Form1['Spec$Status$txt_EndDate'].value = document.Form1['Spec$Status$hd_UserDate'].value;
		}
	function doubleclickRec(){
		document.Form1['Spec$Status$txt_RecBy'].value = document.Form1['Spec$Status$hd_UserName'].value;
		document.Form1['Spec$Status$txt_RecDate'].value = document.Form1['Spec$Status$hd_UserDate'].value;
		}	
	function doubleclickRev(){
		document.Form1['Spec$Status$txt_RevBy'].value = document.Form1['Spec$Status$hd_UserName'].value;
		document.Form1['Spec$Status$txt_RevDate'].value = document.Form1['Spec$Status$hd_UserDate'].value;
		}					
</script>
<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr class="TableHeader">
		<td vAlign="middle" align="center" width="10" height="30"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20" height="25"><asp:imagebutton id="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif" runat="server"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif" runat="server"></asp:imagebutton></td>
		<td class="fontHead" height="25"><asp:Label ID="lblSubmitStatusH" runat="server"></asp:Label></td>
	</tr>
</table>
<asp:panel id="Panel1" runat="server">
	<cc1:confirmedimagebutton id="btnDelete" runat="server" ></cc1:confirmedimagebutton>
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TR>
			<TD vAlign="top" width="100">
				<TABLE cellSpacing="0" cellPadding="0" width="255" bgColor="#ffffff" border="0">
					<TR height="20">
						<TD class="TableHeaderRed" width="10" height="25">&nbsp;</TD>
						<TD class="TableHeaderRed" style="WIDTH: 140px" height="25">&nbsp;<asp:Label ID="lblSubmitStatus" runat="server"></asp:Label></TD>
						<TD class="TableHeaderRed" style="WIDTH: 140px" height="25">&nbsp; <asp:Label ID="lblDueDate" runat="server"></asp:Label></TD>
					</TR>
					<TR height="25">
						<TD style="HEIGHT: 16px" width="10">&nbsp;</TD>
						<TD style="WIDTH: 140px">
							<asp:DropDownList id="drl_Status" runat="server" Width="125px"></asp:DropDownList></TD>
						<TD style="HEIGHT: 15px">&nbsp;
							<asp:TextBox id="txt_DueDate" runat="server" Width="80px" CssClass="font" ReadOnly="true" ></asp:TextBox>
                            <a id="aSpec$Status$txt_DueDate" 
            href="javascript:calendar('Spec$Status$txt_DueDate')" 
            name="aSpec$Status$txt_DueDate">
                            <img border="0" 
            src="../System/Icons/icon_calendar.gif"></img></a>
						</TD>
					</TR>
					<TR height="20">
						<TD class="TableHeaderYellow" width="10" height="25">&nbsp;</TD>
						<TD class="TableHeaderYellow" style="WIDTH: 140px" height="25">&nbsp;<asp:Label ID="lblVendorBy" runat="server"></asp:Label></TD>
						<TD class="TableHeaderYellow" height="25">&nbsp;<asp:Label ID="lblVendorDate" runat="server"></asp:Label></TD>
					</TR>
					<TR height="25">
						<TD width="10">&nbsp;</TD>
						<TD>
							<asp:TextBox id="txt_VendorBy" runat="server" Width="125px" CssClass="font"></asp:TextBox></TD>
						<TD>&nbsp;
							<asp:TextBox id="txt_VendorDate" runat="server" Width="80px" CssClass="font" ></asp:TextBox>
                            <a id="aSpec$Status$txt_VendorDate" 
            href="javascript:calendar('Spec$Status$txt_VendorDate')" 
            name="aSpec$Status$txt_VendorDate">
                            <img id="calVendorDate" runat="server" 
            border="0" src="../System/Icons/icon_calendar.gif"></img></a></TD>
					</TR>
					<TR height="20">
						<TD class="TableHeaderBlue" width="10" height="25">&nbsp;</TD>
						<TD class="TableHeaderBlue" style="WIDTH: 140px" height="25"><asp:Label ID="lblReviewedBy" runat="server"></asp:Label></TD>
						<TD class="TableHeaderBlue" height="25">&nbsp;<asp:Label ID="lblReviewedDate" runat="server"></asp:Label></TD>
					</TR>
					<TR height="25">
						<TD width="10">&nbsp;</TD>
						<TD style="WIDTH: 140px">
							<DIV ondblclick="doubleclickRev();">
								<asp:TextBox id="txt_RevBy" runat="server" Width="125px" CssClass="font"></asp:TextBox></DIV>
						</TD>
						<TD>&nbsp;
							<asp:TextBox id="txt_RevDate" runat="server" Width="80px" CssClass="font" ></asp:TextBox>
                            <a id="aSpec$Status$txt_RevDate" 
            href="javascript:calendar('Spec$Status$txt_RevDate')" 
            name="aSpec$Status$txt_RevDate">
                            <img border="0" 
            src="../System/Icons/icon_calendar.gif"></img></a></TD>
					</TR>
				</TABLE>
			</TD>
			<TD vAlign="top">
				<TABLE cellSpacing="0" cellPadding="0" bgColor="#ffffff" border="0" 
            style="width: 425px">
					<TR height="20">
						<TD class="TableHeader" style="WIDTH: 140px" height="25">&nbsp; <asp:Label ID="lblReceivedBy" runat="server"></asp:Label></TD>
						<TD class="TableHeader" style="WIDTH: 140px" height="25">&nbsp; <asp:Label ID="lblReceivedDate" runat="server"></asp:Label></TD>
						<TD class="TableHeader" style="WIDTH: 140px" height="25">&nbsp; <asp:Label ID="lblReceivedWeight" runat="server"></asp:Label></TD>
					</TR>
					<TR height="25">
						<TD style="WIDTH: 140px">
							<DIV ondblclick="doubleclickRec();">&nbsp;
								<asp:TextBox id="txt_RecBy" runat="server" Width="125px" CssClass="font"></asp:TextBox></DIV>
						</TD>
						<TD style="WIDTH: 140px">&nbsp;
							<asp:TextBox id="txt_RecDate" runat="server" Width="80px" CssClass="font" ></asp:TextBox>
                            <a id="aSpec$Status$txt_RecDate" 
            href="javascript:calendar('Spec$Status$txt_RecDate')" 
            name="aSpec$Status$txt_RecDate">
                            <img border="0" 
            src="../System/Icons/icon_calendar.gif"></img></a></TD>
						<TD style="WIDTH: 140px">
							<DIV ondblclick="doubleclickEnd();">&nbsp;
								<asp:TextBox id="txt_ReceivedWeight" runat="server" Width="125px" CssClass="font"></asp:TextBox></DIV>
						</TD>
					</TR>
					<TR height="20">
						<TD class="TableHeaderYellow" style="WIDTH: 140px; HEIGHT: 25px">&nbsp; <asp:Label ID="lblShipMethod" runat="server"></asp:Label></TD>
						<TD class="TableHeaderYellow" style="WIDTH: 140px; HEIGHT: 25px">&nbsp; <asp:Label ID="lblVendorWeight" runat="server"></asp:Label>
							</TD>
						<TD class="TableHeaderYellow" style="WIDTH: 140px; HEIGHT: 25px">&nbsp; <asp:Label ID="lblTrackingNum" runat="server"></asp:Label>
							</TD>
					</TR>
					<TR height="25">
						<TD style="WIDTH: 140px">&nbsp;
							<asp:DropDownList id="drl_ShipMethod" runat="server" Width="125px"></asp:DropDownList></TD>
						<TD style="WIDTH: 140px" noWrap>&nbsp;
							<asp:TextBox id="txt_VendorWeight" runat="server" Width="125px" CssClass="font"></asp:TextBox>
                            <A href="javascript:calendar('Spec$Status$txt_VendorDate')" name='aSpec$Status$txt_VendorDate' id='aSpec$Status$txt_VendorDate' ></A></TD>
						<TD style="WIDTH: 140px">&nbsp;
							<asp:TextBox id="txt_TrackingNo" runat="server" Width="100px" CssClass="font"></asp:TextBox>
							<cc1:ConfirmedImageButton id="btnShipTrack" runat="server" ImageUrl="../System/Icons/icon_popup.gif" Message="NONE"></cc1:ConfirmedImageButton></TD>
					</TR>
					<TR height="20">
						<TD class="TableHeaderGreen" height="25">&nbsp;<asp:Label ID="lblApprovedBy" runat="server"></asp:Label></TD>
						<TD class="TableHeaderGreen" height="25">&nbsp;<asp:Label ID="lblApprovedDate" runat="server"></asp:Label></TD>
						<TD class="TableHeaderRed" height="25">&nbsp; <asp:Label ID="lblFinalDate" runat="server"></asp:Label></TD>
					</TR>
					<TR height="25">
						<TD>
							<DIV ondblclick="doubleclickEnd();">&nbsp;
								<asp:TextBox id="txt_EndBy" runat="server" Width="125px" CssClass="font"></asp:TextBox></DIV>
						</TD>
						<TD>&nbsp;
							<asp:TextBox id="txt_EndDate" runat="server" Width="80px" CssClass="font" ></asp:TextBox>
                            <a id="aSpec$Status$txt_EndDate" 
            href="javascript:calendar('Spec$Status$txt_EndDate')" 
            name="aSpec$Status$txt_EndDate">
                            <img border="0" 
            src="../System/Icons/icon_calendar.gif"></img></a></TD>
						<TD>&nbsp;&nbsp;
							<asp:Label id="lbl_FinalDate" runat="server" CssClass="fontHead" ForeColor="Red"></asp:Label></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</TABLE>
	<INPUT id="hd_UserName" type="hidden" name="Hidden1" runat="server"><INPUT id="hd_UserDate" type="hidden" name="Hidden2" runat="server">
	<asp:TextBox id="txt_InternalComment" runat="server" Width="250px" Visible="False" TextMode="MultiLine"
		Height="110px"></asp:TextBox></asp:panel>
