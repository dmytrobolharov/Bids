<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Comment.ascx.vb" Inherits="plmOnApp.Style_Comment" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<table height="25" cellspacing="0" cellPadding="0" width="100%" border="0">
	<tr class='<%=GetTableHeaderClass() %>'>
		<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20">
		    
		    <img id="imbBtnExpand" onclick="return ShowCommentContent(this)"  src="../System/Icons/icon_Next.gif"  />
		    <img id="imgBtnCollapse" onclick="return HideCommentContent(this)" style="display:none;"  src="../System/Icons/icon_Down.gif" />
		    
		    <%--<asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif" CausesValidation="False"></asp:imagebutton>
		    <asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" CausesValidation="False"></asp:imagebutton>--%>
		</td>
		<td class="fontHead">&nbsp;
			<asp:label id="lblComment" runat="server">Comments</asp:label></td>
	</tr>
</table>

<div id="divCommentContent" style="display:none">
<asp:panel id="Panel1" runat="server" BackColor="#ffffff" BorderStyle="Solid" BorderColor="DodgerBlue"
	Width="100%" CssClass="font" BorderWidth="1">
	<asp:datalist id="DataList1" runat="server" BorderWidth="1px" Width="100%" BorderColor="WhiteSmoke"
		BorderStyle="Solid" BackColor="White" DataKeyField="StyleCommentID" OnEditCommand="DataList_EditCommand"
		OnUpdateCommand="DataList_UpdateCommand" OnCancelCommand="DataList_CancelCommand" OnDeleteCommand="DataList_DeleteCommand">
		<HeaderTemplate>
			<table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr class="ToolbarBlue">
					<td class="font" width="20" height="20">&nbsp;</td>
					<td class="font" style="FONT-WEIGHT: bold; COLOR: white"><%#GetSystemText("Comments")%></td>
					<td class="font" style="FONT-WEIGHT: bold; COLOR: white" width="200"><%#GetSystemText("Modified By")%></td>
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
						<asp:linkbutton id="Linkbutton1"  CausesValidation="False" runat="Server" Visible='<%# ShowAddComment(Container.DataItem("CTeamID").ToString) %>' CommandName="edit" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'>
						</asp:linkbutton></TD>
					<TD class="font">
						<asp:Label ID="lblStyleComment" Runat="server">
							<%#Container.DataItem("StyleComment")%>
						</asp:Label></TD>
					<TD class="font" width="200"><%#Container.DataItem("MUser")%>&nbsp;<%# Convert.ToDateTime(SystemHandler.GetLocalTime(Container.DataItem("MDate"))).ToString(Me.GetFormatInfo.DateTimeShortFormat)%></TD>
				</TR>
			</TABLE>
		</ItemTemplate>
		<EditItemTemplate>
			<br>
			<TABLE cellspacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD class="font" width="20">&nbsp;</TD>
					<TD class="font" vAlign="top" width="100"><%#Getsystemtext("Comments")%>:</TD>
					<TD class="font">
						<asp:TextBox id="txtComments" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StyleComment").ToString  %>' Columns="50" Rows="5" Wrap="false" TextMode="MultiLine" ToolTip='<%# Getsystemtext("Enter your comments here...")%>'>
						</asp:TextBox></TD>
				<TR>
					<TD width="20">&nbsp;</TD>
					<TD class="font" width="100"><%#GetSystemText("Created By")%>:</TD>
					<TD class="font">
						<asp:Label id="lblMData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; Convert.ToDateTime(SystemHandler.GetLocalTime(Container.DataItem("CDate"))).ToString(Me.GetFormatInfo.DateTimeShortFormat) %>'>
						</asp:Label></TD>
				</TR>
				<TR>
					<TD width="20">&nbsp;</TD>
					<TD class="font" width="100"><%#GetSystemText("Modified By")%>:</TD>
					<TD class="font">
						<asp:Label id="lblCData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; Convert.ToDateTime(SystemHandler.GetLocalTime(Container.DataItem("MDate"))).ToString(Me.GetFormatInfo.DateTimeShortFormat) %>'>
						</asp:Label></TD>
				</TR>
				<TR>
					<TD width="20">&nbsp;</TD>
					<TD width="100"><BR>
						<asp:linkbutton id="Linkbutton2" CausesValidation="False" runat="Server" NAME="Linkbutton2" CommandName="update" Text='<IMG border="0" alt="Save" src="../System/Icons/icon_save.gif">'></asp:linkbutton>
						<cc1:ConfirmedLinkButton id="Linkbutton4"  CausesValidation="False"  runat="Server" NAME="Linkbutton4" CommandName="delete" Text='<IMG border="0" alt="Delete" src="../System/Icons/icon_delete.gif">'
							Visible="TRUE" Message='<%#GetSystemtext("Are you sure you want to Delete this comment?")%>'></cc1:ConfirmedLinkButton>
						
					</TD>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
			<BR>
		</EditItemTemplate>
	</asp:datalist>
	<asp:panel id="AddCommentPnl" Runat="server">
		<TABLE>
			<TR>
				<TD width="20">&nbsp;</TD>
				<TD width="100" height="16">
					<asp:linkbutton id="btnNew" CausesValidation="False" runat="Server" CssClass="fonthead" Text='<IMG border="0" alt="New" src="../System/icons/icon_add.gif"><%=Getsystemtext("Add New")%>...'
						CommandName="new"><IMG border="0" alt="New" src="../System/icons/icon_add.gif"><%=Getsystemtext("Add New")%>...</asp:linkbutton>
				<TD>&nbsp;</TD>
			</TR>
		</TABLE>
	</asp:panel>
</asp:panel><asp:panel id="Panel2" runat="server" BackColor="#ffffff" BorderStyle="Solid" BorderColor="LightGray"
	Width="100%" CssClass="font" BorderWidth="1">
	<TABLE cellspacing="0" cellPadding="0" width="100%" border="0">
		<TR class="TableHeader">
			<TD style="WIDTH: 18px" width="19" height="20">&nbsp;</TD>
			<TD class="fontHead" style="FONT-WEIGHT: bold; COLOR: black; TEXT-DECORATION: none"><asp:Label ID="lblNewComment" runat="server">New Comment:</asp:Label></TD>
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
				<cc1:ConfirmedImageButton id="imgBtnInsert" CausesValidation="False" 
					runat="server" Message="NONE"></cc1:ConfirmedImageButton>
				<asp:ImageButton id="imgBtnCancelInsert" CausesValidation="False" 
					runat="server"></asp:ImageButton></TD>
		</TR>
	</TABLE>
</asp:panel>
</div>
