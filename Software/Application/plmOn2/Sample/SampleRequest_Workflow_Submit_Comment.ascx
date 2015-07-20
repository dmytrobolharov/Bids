<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Comment.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Comment" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<table height="25" cellSpacing="0" cellPadding="0" width="400" border="0">
	<tr class="TableHeader">
		<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20"><asp:imagebutton id="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif" runat="server"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif" runat="server"></asp:imagebutton></td>
		<td class="fontHead">&nbsp;
			<asp:label id="lblComment" runat="server"></asp:label></td>
		<TD align="right">
		    <cc1:bwimagebutton id="btnCommentTemplate" runat="server"  WindowName="POMLibrary"></cc1:bwimagebutton>
			<asp:imagebutton id="btnNew" runat="server" ></asp:imagebutton>
		</TD>
	</tr>
</table>
<asp:panel id="Panel2" runat="server" BackColor="#ffffff" BorderStyle="Solid" BorderColor="Silver"
	Width="100%" CssClass="font" BorderWidth="1">
	<TABLE cellSpacing="0" cellPadding="0" width="100%">
		<TR class="TableHeaderGreen">
			<TD width="5" height="20">&nbsp;</TD>
			<TD class="fontHead">
                <asp:Label ID="lblNewComment" runat="server"><%#GetSystemText("New Comment")%>:</asp:Label></TD>
		</TR>
		<TR class="TableHeader">
			<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			<TD>
				<cc1:ConfirmedImageButton id="imgBtnInsert" runat="server"  Message="NONE"></cc1:ConfirmedImageButton>
				<asp:ImageButton id="imgBtnCancelInsert" runat="server" ></asp:ImageButton></TD>
		</TR>
		<TR bgColor="#ffffff">
			<TD style="WIDTH: 18px" width="19" height="20">&nbsp;</TD>
			<TD>
				<asp:TextBox id="txtNewComment" runat="server" CssClass="font" Width="350" TextMode="MultiLine"
					 Height="150"></asp:TextBox></TD>
		</TR>
	</TABLE>
	<BR>
</asp:panel>
<asp:panel id="Panel1" runat="server" BackColor="#ffffff" Width="400" CssClass="font" BorderWidth="0">
	<asp:datalist id="DataList1" runat="server" BorderWidth="0px" Width="100%" BorderColor="WhiteSmoke"
		BorderStyle="Solid" BackColor="White" OnDeleteCommand="DataList_DeleteCommand" OnCancelCommand="DataList_CancelCommand"
		OnUpdateCommand="DataList_UpdateCommand" OnEditCommand="DataList_EditCommand" DataKeyField="SampleRequestCommentID">
		<HeaderTemplate>
			<!--
			<table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr class="ToolbarBlue">
					<td class="font" width="20" height="20">&nbsp;</td>
					<td class="font" style="FONT-WEIGHT: bold; COLOR: white">Comments</td>
					<td class="font" style="FONT-WEIGHT: bold; COLOR: white" width="200">Modified By</td>
				</tr>
			</table>
		-->
		</HeaderTemplate>
		<FooterTemplate>
		</FooterTemplate>
		<ItemTemplate>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR class="TableHeader">
					<TD class="fonthead" height="25"><%#Container.DataItem("MUser")%>&nbsp;-&nbsp;<%# Convert.ToDateTime(SystemHandler.GetLocalTime(Container.DataItem("MDate"))).ToString(Me.GetFormatInfo.DateTimeLongFormat)%>&nbsp;</TD>
					<TD align="right" width="20" height="20">
						<asp:linkbutton id="Linkbutton1" runat="Server" CommandName="edit" Visible='<%# ShowEditComment(Container.DataItem("CTeamID").ToString) %>'>
						</asp:linkbutton></TD>
				</TR>
				<TR>
					<TD class="font" colSpan="2">
						<asp:Label id="lblSamplerequestComment" Runat="server">
							<%#Container.DataItem("SamplerequestComment")%>
						</asp:Label></TD>
				</TR>
			</TABLE>
			<BR>
		</ItemTemplate>
		<EditItemTemplate>
			<asp:panel id="pnlEdit" BorderWidth="1" BorderColor="LightGrey" BorderStyle="Solid" Runat="server">
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR class="TableHeaderBlue">
						<TD width="5" height="20">&nbsp;
						</TD>
						<TD>
                            <asp:Label ID="lblEditComment" runat="server"><%#GetSystemText("Edit Comment")%>...</asp:Label>&nbsp;</TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR class="TableHeader">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD>
							<asp:linkbutton id="Linkbutton2" runat="Server" CommandName="update" NAME="Linkbutton2"></asp:linkbutton>
							<cc1:ConfirmedLinkButton id="Linkbutton4" runat="Server" CommandName="delete" Message='<%#GetSystemText("Are you sure you want to Remove this comment?") %>' Visible="TRUE" NAME="Linkbutton4"></cc1:ConfirmedLinkButton>
							<asp:linkbutton id="Linkbutton3" runat="Server" CommandName="cancel" NAME="Linkbutton3"></asp:linkbutton></TD>
					</TR>
					<TR>
						<TD class="font" width="20">&nbsp;</TD>
						<TD class="font" vAlign="top">
							<asp:TextBox id=txtComments runat="server" Width="350" Text='<%# DataBinder.Eval(Container.DataItem, "SamplerequestComment").ToString  %>' TextMode="MultiLine" ToolTip='<%#GetSystemText("Enter your comments here") & "..." %>' Height="150">
							</asp:TextBox></TD>
					<TR>
						<TD width="20">&nbsp;</TD>
						<TD class="font">
                            <asp:Label ID="lblCreatedBy" runat="server"><%#GetSystemText("Created By")%>:</asp:Label>&nbsp;
							<asp:Label id=lblMData runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; "&nbsp;-&nbsp;" &amp; Convert.ToDateTime(SystemHandler.GetLocalTime(Container.DataItem("CDate"))).ToString(Me.GetFormatInfo.DateShortFormat) %>'>
							</asp:Label></TD>
					</TR>
					<TR>
						<TD width="20">&nbsp;</TD>
						<TD class="font">
                            <asp:Label ID="lblModifiedBy" runat="server"><%#GetSystemText("Modified By")%>:</asp:Label>&nbsp;
							<asp:Label id=lblCData runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; "&nbsp;-&nbsp;" &amp; Convert.ToDateTime(SystemHandler.GetLocalTime(Container.DataItem("MDate"))).ToString(Me.GetFormatInfo.DateShortFormat) %>'>
							</asp:Label></TD>
					</TR>
				</TABLE>
			</asp:panel><BR>
		</EditItemTemplate>
	</asp:datalist>
</asp:panel>
<script type = "text/javascript">
    function DisableButton() {
        document.getElementById("<%=imgBtnInsert.ClientID %>").disabled = true;
    }
    window.onbeforeunload = DisableButton;
</script>
