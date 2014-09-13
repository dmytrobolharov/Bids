<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Image_Catalog_Comment.ascx.vb" Inherits="plmOnApp.Image_Catalog_Comment" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>

<table cellSpacing="0" cellPadding="0" width="100%" border="0" height="25">
	<tr class="TableHeaderOver">
		<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20"><asp:imagebutton id="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif" runat="server"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif" runat="server"></asp:imagebutton></td>
		<td class="fontHead">
			<asp:Label id="lblTradeName" runat="server"></asp:Label>&nbsp;
			<asp:Label id="lblNoComments" runat="server">Comments</asp:Label>&nbsp;
		</td>
	</tr>
</table>
<asp:panel id="Panel1" runat="server" BackColor="#ffffff" BorderStyle="Solid" BorderColor="DodgerBlue"
	Width="100%" CssClass="font" BorderWidth="1">
	<asp:datalist id="DataList1" runat="server" BorderWidth="1px" Width="100%" BorderColor="WhiteSmoke"
		BorderStyle="Solid" BackColor="White" DataKeyField="ImageCommentID" OnEditCommand="DataList_EditCommand"
		OnUpdateCommand="DataList_UpdateCommand" OnCancelCommand="DataList_CancelCommand" OnDeleteCommand="DataList_DeleteCommand">
		<HeaderTemplate>
			<table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr class="ToolbarBlue">
					<td class="font" width="20" height="20">&nbsp;</td>
					<td class="font" style="FONT-WEIGHT: bold; COLOR: white">
					    <asp:Label id="lblTheComment" runat="server"><%#GetSystemText("Comment")%></asp:Label>&nbsp;
					 </td>
					<td class="font" style="FONT-WEIGHT: bold; COLOR: white" width="200">
					    <asp:Label id="lblModofiedBy" runat="server"><%#GetSystemText("Modified By")%></asp:Label>&nbsp;
					</td>
				</tr>
			</table>
		</HeaderTemplate>
		<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
		<FooterTemplate>
		</FooterTemplate>
		<ItemStyle BackColor="White"></ItemStyle>
		<ItemTemplate>
			<TABLE width="100%">
				<TR>
					<TD width="20" height="20">
						<asp:linkbutton id="Linkbutton1" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'
							CommandName="edit"   Visible='<%# ShowAddComment(Container.DataItem("CTeamID").ToString) %>'  ></asp:linkbutton></TD>
					<TD class="font"><%#Container.DataItem("ImageComment").Replace(vbCrLf, "<BR>").toString%></TD>
					<TD class="font" width="200"><%#Container.DataItem("MUser")%>&nbsp;<%#SystemHandler.GetLocalTime(Container.DataItem("MDate")).ToString%></TD>
				</TR>
			</TABLE>
		</ItemTemplate>
		<EditItemTemplate>
			<BR>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD class="font" width="20">&nbsp;</TD>
					<TD class="font" vAlign="top" width="100">Comments:</TD>
					<TD class="font">
						<asp:TextBox id=txtComments runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageComment").ToString  %>' ToolTip="Enter your comments here..." TextMode="MultiLine" Rows="5" Columns="50" Wrap="false">
						</asp:TextBox></TD>
				<TR>
					<TD width="20">&nbsp;</TD>
					<TD class="font" width="100">Created By:</TD>
					<TD class="font">
						<asp:Label id=lblMData runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("CDate")).ToString %>'>
						</asp:Label></TD>
				</TR>
				<TR>
					<TD width="20">&nbsp;</TD>
					<TD class="font" width="100">Modified By:</TD>
					<TD class="font">
						<asp:Label id=lblCData runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("MDate")).ToString %>'>
						</asp:Label></TD>
				</TR>
				<TR>
					<TD width="20">&nbsp;</TD>
					<TD width="100"><BR>
						<asp:linkbutton id="Linkbutton2" runat="Server" Text='<IMG border="0" alt="Save" src="../System/Icons/icon_save.gif">'
							CommandName="update" NAME="Linkbutton2"></asp:linkbutton>
						<cc1:ConfirmedLinkButton id="Linkbutton4" runat="Server" Text='<IMG border="0" alt="Delete" src="../System/Icons/icon_delete.gif">'
							CommandName="delete" NAME="Linkbutton4" Message="Are you sure you want to Delete this comment?"></cc1:ConfirmedLinkButton>
						<asp:linkbutton id="Linkbutton3" runat="Server" Text='<IMG border="0" alt="Cancel" src="../System/Icons/icon_close.gif">'
							CommandName="cancel" NAME="Linkbutton3"></asp:linkbutton></TD>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
			<BR>
		</EditItemTemplate>
	</asp:datalist>
	<TABLE>
		<TR>
			<TD width="20">&nbsp;</TD>
			<TD width="100" height="16">
				<asp:linkbutton id="btnNew" runat="Server" CssClass="fonthead" Text='<IMG border="0" alt="New" src="../System/icons/icon_add.gif"> Add New...'
					CommandName="new" NAME="btnNew"></asp:linkbutton>
			<TD>&nbsp;</TD>
		</TR>
	</TABLE>
</asp:panel>
<asp:panel id="Panel2" runat="server" BorderWidth="1" CssClass="font" Width="100%" BorderColor="LightGray"
	BorderStyle="Solid" BackColor="#ffffff">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TR class="TableHeader">
			<TD style="WIDTH: 18px" width="19" height="20">&nbsp;</TD>
			<TD class="fontHead" style="FONT-WEIGHT: bold; COLOR: black; TEXT-DECORATION: none">
			    <asp:Label id="lblNewComment" runat="server">New Comment:</asp:Label>&nbsp;    
				<asp:Label id="lblCommentRequired" runat="server" ForeColor="Red" Visible="False">Please enter comments before saving it.</asp:Label></TD>
		</TR>
		<TR bgColor="#ffffff">
			<TD style="WIDTH: 18px" width="19" height="20">&nbsp;</TD>
			<TD>
				<asp:TextBox id="txtNewComment" runat="server" CssClass="font" ToolTip="Enter your comment here..."
					TextMode="MultiLine" Rows="4" Columns="50" MaxLength="4000"></asp:TextBox></TD>
		</TR>
		<TR bgColor="#ffffff">
			<TD style="WIDTH: 18px" width="19" height="20">&nbsp;</TD>
			<TD>&nbsp;
				<cc1:ConfirmedImageButton id="imgBtnInsert" runat="server"  Message="NONE"></cc1:ConfirmedImageButton>
				<asp:ImageButton id="imgBtnCancelInsert" runat="server" ></asp:ImageButton></TD>
		</TR>
	</TABLE>
</asp:panel>
<asp:TextBox id="txtImageID" runat="server" Visible="False"></asp:TextBox>
<asp:TextBox id="txtImageVersion" runat="server" Visible="False"></asp:TextBox>
<asp:TextBox id="txtTradeID" runat="server" Visible="False"></asp:TextBox>
