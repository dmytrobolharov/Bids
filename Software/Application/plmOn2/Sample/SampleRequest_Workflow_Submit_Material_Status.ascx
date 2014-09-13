<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Material_Status.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Material_Status" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<script type="text/javascript">              
	function doubleclickEnd(){
		document.Form1['<%= strParentID%>$Status$txt_EndBy'].value = document.Form1['<%= strParentID%>$Status$hd_UserName'].value;
		document.Form1['<%= strParentID%>$Status$txt_EndDate'].value = document.Form1['<%= strParentID%>$Status$hd_UserDate'].value;
		}
	function doubleclickRec(){
		document.Form1['<%= strParentID%>$Status$txt_RecBy'].value = document.Form1['<%= strParentID%>$Status$hd_UserName'].value;
		document.Form1['<%= strParentID%>$Status$txt_RecDate'].value = document.Form1['<%= strParentID%>$Status$hd_UserDate'].value;
		}			
</script>
<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr class="TableHeader">
		<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></td>
		<td class="fontHead"><asp:Label ID="lblSubmitStatusH" runat="server"></asp:Label>
</td>
	</tr>
</table>
<asp:panel id="Panel1" runat="server">
	<cc1:confirmedimagebutton id="btnDelete"  runat="server"></cc1:confirmedimagebutton>
	<TABLE cellSpacing="0" cellPadding="0" border="0">
		<TR>
			<TD vAlign="top" bgColor="#ffffff">
				<TABLE cellSpacing="0" cellPadding="0" bgColor="#ffffff" border="0">
					<TR height="20">
						<TD class="TableHeaderRed" width="130" height="25">&nbsp;<asp:Label ID="lblSubmitStatus" runat="server"></asp:Label></TD>
						<TD class="TableHeaderRed" width="100" height="25">&nbsp;<asp:Label ID="lblDueDate" runat="server"></asp:Label></TD>
					</TR>
					<TR height="25">
						<TD width="130">
							<asp:DropDownList id="drl_Status" runat="server" Width="125px"></asp:DropDownList></TD>
						<TD style="HEIGHT: 15px" width="100">
							<TABLE id="Table2" cellSpacing="1" cellPadding="1" width="100%" border="0">
								<TR>
									<TD>
										<asp:TextBox id="txt_DueDate" runat="server" Width="80px" CssClass="font" ReadOnly="true" ></asp:TextBox></TD>
									<TD>
                                        <a id="a<%= strParentID%>$Status$txt_DueDate" href="javascript:calendar('<%= strParentID%>$Status$txt_DueDate')" 
                                        name="a<%= strParentID%>$Status$txt_DueDate"><img border="0" src="../System/Icons/icon_calendar.gif"></img></a></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					<TR height="20">
						<TD class="TableHeaderBlue" width="130" height="25">&nbsp;<asp:Label ID="lblReviewedBy" runat="server"></asp:Label></TD>
						<TD class="TableHeaderBlue" width="100" height="25">&nbsp;<asp:Label ID="lblReviewedDate" runat="server"></asp:Label></TD>
					</TR>
					<TR height="20">
						<TD width="130"><asp:TextBox id="txt_RevBy" runat="server" Width="125px" CssClass="font"></asp:TextBox></TD>
						<TD width="100"><TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
									<TR><TD><asp:TextBox id="txt_RevDate" runat="server" Width="80px" CssClass="font"></asp:TextBox></TD>
									<TD><a id="a<%= strParentID%>$Status$txt_RevDate" href="javascript:calendar('<%= strParentID%>$Status$txt_RevDate')" 
                                    name="a<%= strParentID%>$Status$txt_RevDate"><img border="0" src="../System/Icons/icon_calendar.gif"></img></a></TD></TR>
								</TABLE></TD>
					</TR>
				</TABLE>
			</TD>
			<TD vAlign="top">
				<TABLE id="Table1" cellSpacing="0" cellPadding="0" bgColor="#ffffff" border="0">
					<TR height="20">
						<TD class="TableHeader" width="5" height="25"></TD>
						<TD class="TableHeader" width="130" height="25"><asp:Label ID="lblReceivedBy" runat="server"></asp:Label></TD>
						<TD class="TableHeader" width="100" height="25">&nbsp;<asp:Label ID="lblReceivedDate" runat="server"></asp:Label></TD>
						<TD class="TableHeaderGreen" width="5" height="25"></TD>
						<TD class="TableHeaderGreen" noWrap width="130" height="25">&nbsp;<asp:Label ID="lblApprovedBy" runat="server"></asp:Label></TD>
						<TD class="TableHeaderGreen" noWrap width="100" height="25">&nbsp;<asp:Label ID="lblApprovedDate" runat="server"></asp:Label></TD>
					</TR>
					<TR height="25">
						<TD width="5"></TD>
						<TD width="130">
							<DIV ondblclick="doubleclickRec();">
								<asp:TextBox id="txt_RecBy" runat="server" Width="125px" CssClass="font"></asp:TextBox></DIV>
						</TD>
						<TD width="100">
							<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
								<TR>
									<TD><asp:TextBox id="txt_RecDate" runat="server" Width="80px" CssClass="font"></asp:TextBox></TD>
									<TD>
                                        <a id="a<%= strParentID%>$Status$txt_RecDate" 
            href="javascript:calendar('<%= strParentID%>$Status$txt_RecDate')" 
            name="a<%= strParentID%>$Status$txt_RecDate">
                                        <img border="0" 
            src="../System/Icons/icon_calendar.gif"></img></a></TD>
								</TR>
							</TABLE>
						</TD>
						<TD width="5"></TD>
						<TD width="130">
						<DIV ondblclick="doubleclickEnd();">
							<asp:TextBox id="txt_EndBy" runat="server" Width="125px" CssClass="font"></asp:TextBox></div></TD>
						<TD width="100">
							<TABLE id="Table6" cellSpacing="1" cellPadding="1" width="100%" border="0">
								<TR>
									<TD><asp:TextBox id="txt_EndDate" runat="server" Width="80px" CssClass="font"></asp:TextBox></TD>
									<TD>
                                        <a id="a<%= strParentID%>$Status$txt_EndDate" 
            href="javascript:calendar('<%= strParentID%>$Status$txt_EndDate')" 
            name="a<%= strParentID%>$Status$txt_EndDate">
                                        <img border="0" 
            src="../System/Icons/icon_calendar.gif"></img></a></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					<TR height="20">
						<TD class="TableHeaderYellow" width="5" height="25"></TD>
						<TD class="TableHeaderYellow" width="130" height="25"><asp:Label ID="lblVendorBy" runat="server"></asp:Label></TD>
						<TD class="TableHeaderYellow" width="100" height="25">&nbsp;<asp:Label ID="lblVendorDate" runat="server"></asp:Label></TD>
						<TD class="TableHeaderRed" width="5" height="25"></TD>
						<TD class="TableHeaderRed" width="130" height="25">&nbsp;<asp:Label ID="lblFinalDate" runat="server"></asp:Label></TD>
						<TD width="100" height="25">&nbsp;</TD>
					</TR>
					<TR height="20">
						<TD width="5"></TD>
						<TD width="130">
							<asp:TextBox id="txt_VendorBy" runat="server" Width="125px" CssClass="font"></asp:TextBox></TD>
						<TD width="100">
							<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
								<TR>
									<TD><asp:TextBox id="txt_VendorDate" runat="server" Width="80px" CssClass="font"></asp:TextBox></TD>
									<TD>
                                        <a 
            id="a<%= strParentID%>$Status$txt_VendorDate" 
            href="javascript:calendar('<%= strParentID%>$Status$txt_VendorDate')" 
            name="a<%= strParentID%>$Status$txt_VendorDate">
                                        <img id="calVendorDate" runat="server" 
            border="0" src="../System/Icons/icon_calendar.gif"></img></a></TD>
								</TR>
							</TABLE>
						</TD>
						<TD width="5"></TD>
						<TD class="fontHead" width="130">&nbsp;
							<asp:Label id="lbl_FinalDate" runat="server" ForeColor="Red"></asp:Label></TD>
						<TD width="100">&nbsp;</TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</TABLE>
	<INPUT id="hd_UserName" type="hidden" name="Hidden1" runat="server"><INPUT id="hd_UserDate" type="hidden" name="Hidden2" runat="server">
	<asp:TextBox id="txt_InternalComment" runat="server" Width="250px" MaxLength="4000" TextMode="MultiLine"
		Height="65px" Visible="False"></asp:TextBox>
</asp:panel>
