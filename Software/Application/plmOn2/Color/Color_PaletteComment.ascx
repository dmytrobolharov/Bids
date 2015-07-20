<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Color_PaletteComment.ascx.vb" Inherits="plmOnApp.Color_PaletteComment" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
    <tr class="TableHeader">
        <td vAlign="middle" align="center" width="20"><IMG src="../System/Icons/icon_comments.gif"></td>
        <td class="fontHead">
	        <asp:label id="lblComment" runat="server">Messages</asp:label></td>
        <td align="right" >
        <asp:panel id="AddCommentPnl" Runat="server"><asp:ImageButton ID="lnk_NewComment" runat="server" CssClass="fontHead" CommandName="new" 
                ForeColor="#0066CC" Font-Underline="True" onclick="lnk_NewComment_Click"></asp:ImageButton>
        </asp:panel>
	        
        </td>
    </tr>
</table>
<asp:panel id="Panel2" runat="server" BackColor="#ffffff" BorderStyle="Solid" BorderColor="LightGray"
	Width="400px" CssClass="font" BorderWidth="1">
	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	
		<TR >
			
			<TD>
				<asp:TextBox id="txtNewComment" runat="server" CssClass="font" ToolTip="Type your message here..."
					TextMode="MultiLine" MaxLength="4000" BorderColor="Silver" BorderStyle="Solid" 
            BorderWidth="1px" Height="150px" Width="400px"></asp:TextBox></TD>
		</TR>
		<TR ><TD align="right" >
			    <cc1:ConfirmedImageButton id="imgBtnInsert"  Visible="true" CausesValidation="False" 
			    ImageUrl="../System/Icons/icon_save.gif" runat="server" Message="NONE" alt="save new message..."></cc1:ConfirmedImageButton>
			    <asp:ImageButton id="imgBtnCancelInsert" CausesValidation="False" ImageUrl="../System/Icons/icon_close.gif"
				    runat="server" Alt="cancel new message..."></asp:ImageButton></TD>
	        <TD class="font" width="10">&nbsp;</TD>
		</TR>
	</TABLE>
</asp:panel>
<asp:panel id="Panel1" runat="server" BackColor="#ffffff" Width="450" CssClass="font" BorderWidth="0">
	<asp:datalist id="DataList1" runat="server" BorderWidth="0px" Width="100%" BorderColor="WhiteSmoke"
		BorderStyle="Solid" BackColor="White" DataKeyField="ColorPaletteCommentID" OnEditCommand="DataList_EditCommand"
		OnUpdateCommand="DataList_UpdateCommand" OnCancelCommand="DataList_CancelCommand" OnDeleteCommand="DataList_DeleteCommand">
		<HeaderTemplate>

		</HeaderTemplate>
		<AlternatingItemStyle ></AlternatingItemStyle>
		<FooterTemplate>
		</FooterTemplate>
		<ItemStyle BackColor="White"></ItemStyle>
		<ItemTemplate>
			<TABLE cellSpacing="0" cellPadding="0" border="0">
			    <tr>
			        <td width="25">&nbsp;</td>
			        <td Class="font">
                        <table style="background-position: left top; padding-top: 10px; padding-left: 0px; width: 400px; padding-right: 5px; margin-top: 0px; background: url(../System/Images/box_top.gif) no-repeat;">
                            <tr><td></td></tr>
                        </table>	
                        <table style="background-position: #fff bottom; border-bottom: #d8d9da 0px solid; border-left: #d8d9da 1px solid; background: #fff; width: 400px; border-top: #d8d9da 0px solid; border-right: #d8d9da 1px solid; TEXT-INDENT: 5px; ">
                            <tr>
                                <td>
                                    <asp:Label ID="lblComment" Runat="server" ForeColor="Black"><%#Container.DataItem("ColorPaletteComment")%></asp:Label>
                                    <asp:LinkButton ID="lnk_EditComment"  Font-Underline="True" runat="server" CommandName="edit" CssClass="fontHead" ForeColor="#0066CC" Visible='<%# ShowAddComment(Container.DataItem("CTeamID").ToString) %>'>(<%#GetSystemText("edit")%>)</asp:LinkButton>
                                </td>
                            </tr>
                        </table>	
                        <table style="background-position: left bottom; padding-bottom: 30px; padding-left: 0px; width: 400px; padding-right: 5px; margin-bottom: 10px; background: url(../System/Images/box_base.gif) no-repeat;">
                            <tr><td width="30" height="40">&nbsp;</td><td>
							            <div Class="fontHead"><%#GetSystemText("By") & ":"%>&nbsp;<%#Container.DataItem("MUser")%>&nbsp;<%#Convert.ToDateTime(SystemHandler.GetLocalTime(Container.DataItem("MDate"))).ToString(GetFormatInfo.DateTimeLongFormat)%></div></td></tr>
                        </table>		        
			        </td>
			    </tr>
			</TABLE>
		</ItemTemplate>
		<EditItemTemplate>
	        <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">	
		        <TR >
			        <TD>
				        <asp:TextBox id="txtComment" runat="server" CssClass="font"
					        TextMode="MultiLine" MaxLength="4000" BorderColor="Silver" BorderStyle="Solid" 
                            BorderWidth="1px" Height="150px" Width="450px" Text='<%# DataBinder.Eval(Container.DataItem, "ColorPaletteComment").ToString  %>'>
                        </asp:TextBox>
                    </TD>
		        </TR>
		        <tr>
		            <td><div Class="fontHead"><%#GetSystemText("By") & ":"%>&nbsp;<%#Container.DataItem("MUser")%>&nbsp;<%# SystemHandler.GetLocalTime(Container.DataItem("MDate"))%></div></td>
		        </tr>
		        <TR >
        			
			        <TD align="right" >
				        <asp:linkbutton id="Linkbutton1" CausesValidation="False" runat="Server" NAME="Linkbutton2" 
				        CommandName="update" 
				            Text='<IMG border="0" alt="Save" src="../System/Icons/icon_save.gif">' visible="<%# ModifyAccess() %>" ></asp:linkbutton>
				        <cc1:ConfirmedLinkButton id="Linkbutton4"  CausesValidation="False"  runat="Server" NAME="Linkbutton4" 
				            CommandName="delete" Text='<IMG border="0" alt="Delete" src="../System/Icons/icon_delete.gif">'
					        visible="<%# ModifyAccess() %>" ></cc1:ConfirmedLinkButton>
				        <asp:linkbutton id="Linkbutton5" runat="Server"  CausesValidation="False"  NAME="Linkbutton3" 
				        CommandName="cancel" Text='<IMG border="0" alt="Cancel" src="../System/Icons/icon_close.gif">'></asp:linkbutton>
				        
		            </TD>
		        <TD class="font" width="10">&nbsp;</TD>
		        </TR>
        		
	        </TABLE>
			<BR>
		</EditItemTemplate>
	</asp:datalist>
</asp:panel>
