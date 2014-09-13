<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Commitment_Comment.ascx.vb" Inherits="srmOnApp.Commitment_Comment" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<table height="30" cellSpacing="0" cellPadding="0" width="400" border="0" class="TableHeader">
	<tr>
		<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></td>
		<td class="fontHead">&nbsp;
			<asp:label id="lblCommentHeader" runat="server">Comments</asp:label></td>
		<TD align="right"><asp:ImageButton ID="btnNew" Runat="server" ></asp:ImageButton></TD>
	</tr>
</table>
<asp:panel id="Panel2" runat="server" CssClass="font" BorderWidth="1" Width="100%" BorderColor="Silver"
	BorderStyle="Solid" BackColor="#ffffff">
	<TABLE cellSpacing="0" cellPadding="0" width="100%">
		<TR class="TableHeaderGreen">
			<TD width="5" height="20">&nbsp;</TD>
			<TD class="fontHead"><asp:label id="lblNewComment" runat="server">New Comment:</asp:label></TD>
		</TR>
		<TR class="TableHeader">
			<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			<TD>
				<cc1:ConfirmedImageButton id="imgBtnInsert"  runat="server" Message="NONE"></cc1:ConfirmedImageButton>
				<asp:ImageButton id="imgBtnCancelInsert" runat="server"></asp:ImageButton></TD>
		</TR>
		<TR bgColor="#ffffff">
			<TD style="WIDTH: 18px" width="19" height="20">&nbsp;</TD>
			<TD>
				<asp:TextBox id="txtNewComment" runat="server" CssClass="font" Width="350" Height="150" ToolTip="Enter your comment here..."
					TextMode="MultiLine"></asp:TextBox></TD>
		</TR>
	</TABLE>
	<BR>
</asp:panel><asp:panel id="Panel1" runat="server" CssClass="font" BorderWidth="0" Width="400" BackColor="#ffffff">
	<asp:datalist id="DataList1" runat="server" BackColor="White" BorderStyle="Solid" BorderColor="WhiteSmoke"
		Width="100%" BorderWidth="0px" DataKeyField="SourcingCommitmentCommentID">
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
					<TD class="fonthead" height="25"><%#Container.DataItem("MUser")%>&nbsp;-&nbsp;<%# SystemHandler.GetLocalTime(Container.DataItem("MDate"))%>&nbsp;</TD>
					<TD align="right" width="20" height="20">
						<asp:linkbutton id=Linkbutton1 runat="Server" CommandName="edit"  Visible='<%# ShowEditBtn(Container.DataItem("CTeamID").ToString  )   %>' >
						</asp:linkbutton></TD>
				</TR>
				<TR>
					<TD class="font" colSpan="2">
						<asp:Label id="lblComment" Runat="server">
							<%#Container.DataItem("SourcingCommitmentComment")%>
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
						<TD><%#GetSystemText("Edit Comment")%>...&nbsp;</TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR class="TableHeader">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD>
							<asp:linkbutton id="Linkbutton2" runat="Server" CommandName="update" NAME="Linkbutton2"></asp:linkbutton>
							<cc1:ConfirmedLinkButton id="Linkbutton4" runat="Server" CommandName="delete" Message='<%#GetSystemText("Are you sure you want to Delete this comment?")%>' Visible="TRUE" NAME="Linkbutton4"></cc1:ConfirmedLinkButton>
							<asp:linkbutton id="Linkbutton3" runat="Server" CommandName="cancel" NAME="Linkbutton3"></asp:linkbutton></TD>
					</TR>
					<TR>
						<TD class="font" width="20">&nbsp;</TD>
						<TD class="font" vAlign="top">
							<asp:TextBox id=txtComments runat="server" Width="350" Text='<%# DataBinder.Eval(Container.DataItem, "SourcingCommitmentComment").ToString  %>' TextMode="MultiLine" ToolTip='<%#GetSystemText("Enter your comments here") & "..." %>' Height="150">
							</asp:TextBox></TD>
					<TR>
						<TD width="20">&nbsp;</TD>
						<TD class="font"><%#GetSystemText("Created By")%>:&nbsp;
							<asp:Label id=lblMData runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " -&nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("CDate")).ToString %>'>
							</asp:Label></TD>
					</TR>
					<TR>
						<TD width="20">&nbsp;</TD>
						<TD class="font"><%#GetSystemText("Modified By")%>:&nbsp;
							<asp:Label id=lblCData runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " -&nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("MDate")).ToString %>'>
							</asp:Label></TD>
					</TR>
				</TABLE>
			</asp:panel><BR>
		</EditItemTemplate>
	</asp:datalist>
</asp:panel>
