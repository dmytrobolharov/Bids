<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Material_Comment.ascx.vb" Inherits="plmOnApp.Material_Comment" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" height="25">
	<tr class="TableHeader">
		<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20"><asp:imagebutton id="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif" runat="server" CausesValidation="False"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif" runat="server" CausesValidation="False"></asp:imagebutton></td>
		<td class="fontHead">&nbsp;
			<asp:Label id="lblComment" runat="server"></asp:Label></td>
	</tr>
</table>
<asp:panel id="Panel1" runat="server" BorderWidth="1" CssClass="font" Width="900" BorderColor="DodgerBlue"
	BorderStyle="Solid" BackColor="#ffffff">
	<asp:datalist id="DataList1" runat="server" BackColor="White" BorderStyle="Solid" BorderColor="WhiteSmoke"
		Width="900" BorderWidth="1px" OnDeleteCommand="DataList_DeleteCommand" OnCancelCommand="DataList_CancelCommand"
		OnUpdateCommand="DataList_UpdateCommand" OnEditCommand="DataList_EditCommand" DataKeyField="MaterialCommentID">
		<HeaderTemplate>
			<table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr class="ToolbarBlue">
					<td class="font" width="20" height="20">&nbsp;</td>
					<td class="font" style="FONT-WEIGHT: bold; COLOR: white"><%=GetSystemText("Comments")%></td>
					<td class="font" style="FONT-WEIGHT: bold; COLOR: white" width="200"><%=GetSystemText("Modified By")%></td>
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
						<asp:linkbutton id="Linkbutton1" runat="Server" Visible='<%# ShowAddComment(Container.DataItem("CTeamID").ToString) %>' CommandName="edit" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'>
						</asp:linkbutton></TD>
					<TD class="font"><%#Container.DataItem("MaterialComment").Replace(vbCrLf, "<BR>").toString%></TD>
					<TD class="font" width="200"><%#Container.DataItem("MUser")%>&nbsp;<%#SystemHandler.GetLocalTime(Container.DataItem("MDate"))%></TD>
				</TR>
			</TABLE>
		</ItemTemplate>
		<EditItemTemplate>
			<br>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD class="font" width="20">&nbsp;</TD>
					<TD class="font" vAlign="top" width="100"><%=GetSystemText("Comments")%>:</TD>
					<TD class="font">
						<asp:TextBox id="txtComments" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MaterialComment").ToString  %>' Columns="50" Rows="5" Wrap="false" TextMode="MultiLine" ToolTip="Enter your comments here...">
						</asp:TextBox></TD>
                        <asp:HiddenField runat="server" ID="hdnComments" Value='<%# DataBinder.Eval(Container.DataItem, "MaterialComment").ToString  %>'/>
				<TR>
					<TD width="20">&nbsp;</TD>
					<TD class="font" width="100"><%=GetSystemText("Created By")%>:</TD>
					<TD class="font">
						<asp:Label id=lblMData runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("CDate")).ToString %>'>
						</asp:Label></TD>
				</TR>
				<TR>
					<TD width="20">&nbsp;</TD>
					<TD class="font" width="100"><%=GetSystemText("Modified By")%>:</TD>
					<TD class="font">
						<asp:Label id=lblCData runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("MDate")).ToString %>'>
						</asp:Label></TD>
				</TR>
				<TR>
					<TD width="20">&nbsp;</TD>
					<TD width="100"><BR>
						<asp:linkbutton id="Linkbutton2" runat="Server" NAME="Linkbutton2" CommandName="update" Text='<IMG border="0" alt="Save" src="../System/Icons/icon_save.gif">'></asp:linkbutton>
						<cc1:ConfirmedLinkButton id="Linkbutton4" runat="Server" NAME="Linkbutton4" CommandName="delete" Message='<%#GetSystemText("Are you sure you want to Delete this comment?")%>' Text='<IMG border="0" alt="Delete" src="../System/Icons/icon_delete.gif">'
							></cc1:ConfirmedLinkButton>
						<asp:linkbutton id="Linkbutton3" runat="Server" NAME="Linkbutton3" CommandName="cancel" Text='<IMG border="0" alt="Cancel" src="../System/Icons/icon_close.gif">'></asp:linkbutton>
					</TD>
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
				<asp:linkbutton id="btnNew" runat="Server" CssClass="fonthead" NAME="btnNew" CommandName="new"></asp:linkbutton>
			<TD>&nbsp;</TD>
		</TR>
	</TABLE>
</asp:panel>
<asp:panel id="Panel2" runat="server" BorderWidth="1" CssClass="font" Width="100%" BorderColor="LightGray"
	BorderStyle="Solid" BackColor="#ffffff">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TR class="TableHeader">
			<TD style="WIDTH: 18px" width="19" height="20">&nbsp;</TD>
			<TD class="fontHead" style="FONT-WEIGHT: bold; COLOR: black; TEXT-DECORATION: none"><asp:Label ID="lblNewComment" runat="server" Text="New Comment:"></asp:Label>
            <asp:Label id="lbCommentRequired" runat="server" ForeColor="Red" Visible="False">"Please enter comments before saving it."</asp:Label></TD>
		</TR>
		<TR bgColor="#ffffff">
			<TD style="WIDTH: 18px" width="19" height="20">&nbsp;</TD>
			<TD>
				<asp:TextBox id="txtNewComment" runat="server" CssClass="font" MaxLength="4000" Columns="50"
					Rows="4" TextMode="MultiLine"></asp:TextBox></TD>
		</TR>
		<TR bgColor="#ffffff">
			<TD style="WIDTH: 18px" width="19" height="20">&nbsp;</TD>
			<TD>&nbsp;
				<cc1:ConfirmedImageButton id="imgBtnInsert" runat="server"  Message="NONE"></cc1:ConfirmedImageButton>
				<asp:ImageButton id="imgBtnCancelInsert" runat="server" ></asp:ImageButton></TD>
		</TR>
	</TABLE>
</asp:panel>
