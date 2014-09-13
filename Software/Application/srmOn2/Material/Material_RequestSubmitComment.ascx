<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmitComment.ascx.vb" Inherits="srmOnApp.Material_RequestSubmitComment" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr class="TableHeader">
        <td valign="middle" align="center" width="20"><IMG src="../System/Icons/icon_comments.gif"></td>
        <td class="fontHead">
	        <asp:label id="lblCommentLabel" runat="server">Messages</asp:label></td>
        <td align="right" >
        <asp:panel id="AddCommentPnl" Runat="server"><asp:LinkButton ID="lnk_NewComment" runat="server" CssClass="fontHead" CommandName="new" 
                ForeColor="#0066CC" Font-Underline="True" onclick="lnk_NewComment_Click"></asp:LinkButton>
        </asp:panel>
	        
        </td>
    </tr>
</table>
<asp:panel id="Panel2" runat="server" BackColor="#ffffff" BorderStyle="Solid" BorderColor="LightGray"
	Width="450px" CssClass="font" BorderWidth="1">
	<table cellspacing="0" cellpadding="0" width="100%" border="0">
		<tr >			
			<td>
				<asp:TextBox id="txtNewComment" runat="server" CssClass="font" ToolTip="Type your message here..."
					TextMode="MultiLine" MaxLength="4000" BorderColor="Silver" BorderStyle="Solid" 
            BorderWidth="1px" Height="150px" Width="450px"></asp:TextBox></td>
		</tr>
		<tr class="TableHeader">
            <td>
                <table cellspacing="0" cellpadding="0" border="0">	
                    <tr >		
                        <td align="right" width="10">
                            <asp:CheckBox ID="chbSharedNew" runat="server" 
                                Checked="True" Enabled="False" Visible="false"/></td>		
                        <td align="right" >    
				            <cc1:ConfirmedImageButton id="imgBtnInsert" CausesValidation="False" 
					            runat="server" Message="NONE" ></cc1:ConfirmedImageButton>
				            <asp:ImageButton id="imgBtnCancelInsert" CausesValidation="False" 
					            runat="server"></asp:ImageButton></td>
		                <td class="font" width="10">&nbsp;</td>
		            </tr>
                </table>
		   </td>         
		</tr>
	</table>
</asp:panel>
<asp:panel id="Panel1" runat="server" BackColor="#ffffff" Width="450" CssClass="font" BorderWidth="0">
	<asp:datalist id="DataList1" runat="server" BorderWidth="1px" Width="100%" BorderColor="WhiteSmoke"
		BorderStyle="Solid" BackColor="White" DataKeyField="MaterialRequestSubmitCommentID" OnEditCommand="DataList_EditCommand"
		OnUpdateCommand="DataList_UpdateCommand" OnCancelCommand="DataList_CancelCommand" OnDeleteCommand="DataList_DeleteCommand">
		<HeaderTemplate></HeaderTemplate>
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
                                    <asp:Label ID="lblComment" Runat="server" ForeColor="Black"><%#Container.DataItem("MaterialRequestSubmitComment")%></asp:Label>
                                    <asp:LinkButton ID="lnk_EditComment"  Font-Underline="True" runat="server" CommandName="edit" CssClass="fontHead" ForeColor="#0066CC" Visible='<%# ShowAddComment(Container.DataItem("CTeamID").ToString) %>'>(<%#GetSystemText("edit")%>)</asp:LinkButton>
                                </td>
                            </tr>
                        </table>	
                        <table style="background-position: left bottom; padding-bottom: 30px; padding-left: 0px; width: 400px; padding-right: 5px; margin-bottom: 10px; background: url(../System/Images/box_base.gif) no-repeat;">
                            <tr>
                                <td width="30" height="40">&nbsp;</td>
                                <td>
							        <div Class="fontHead"><%#GetSystemText("By")%>:&nbsp;<%#Container.DataItem("MUser")%>&nbsp;<%# SystemHandler.GetLocalTime(Container.DataItem("MDate"))%></div>
							    </td>
							    <td><div Class="fontRed">&nbsp;<%#GetSharedComment(Container.DataItem("MaterialRequestSubmitCommentType").ToString)%></div></td>
							</tr>
                        </table>		        
			        </td>
			    </tr>
			</TABLE>
		</ItemTemplate>
		<EditItemTemplate>
	        <table cellspacing="0" cellpadding="0" width="100%" border="0">	
		        <tr >
			        <td>
				        <asp:TextBox id="txtComment" runat="server" CssClass="font"
					        TextMode="MultiLine" MaxLength="4000" BorderColor="Silver" BorderStyle="Solid" 
                            BorderWidth="1px" Height="150px" Width="450px" Text='<%# DataBinder.Eval(Container.DataItem, "MaterialRequestSubmitComment").ToString  %>'>
                        </asp:TextBox>
                    </td>
		        </tr>
		        <tr>
		            <td height="25"><div class="fontHead"><%#GetSystemText("By")%>:&nbsp;<%#Container.DataItem("MUser")%>&nbsp;<%# SystemHandler.GetLocalTime(Container.DataItem("MDate"))%></div></td>
		        </tr>
		        <tr class="TableHeader">
		            <td>
	                    <table cellspacing="0" cellpadding="0" border="0">	
		                    <tr>
			                    <td align="right" width="10">
		                            <asp:CheckBox ID="chbShared" runat="server" Checked='<%# ShowSharedComment(Container.DataItem("MaterialRequestSubmitCommentType").ToString) %>' Visible="false"/></td>		
			                    <td align="right" >              
			                         <asp:linkbutton id="Linkbutton1" CausesValidation="False" runat="Server" NAME="Linkbutton2" CommandName="update" ></asp:linkbutton>
			                        <cc1:ConfirmedLinkButton id="Linkbutton4"  CausesValidation="False"  runat="Server" NAME="Linkbutton4" CommandName="delete" 
				                        Visible="TRUE" Message='<%#GetSystemText("Are you sure you want to Delete this message?")%>'></cc1:ConfirmedLinkButton>
			                        <asp:linkbutton id="Linkbutton5" runat="Server"  CausesValidation="False"  NAME="Linkbutton3" CommandName="cancel" ></asp:linkbutton>
		                        </td>
		                      </tr>
		                 </table>    
		              </td>     
		        </tr>	
	        </table>
			<br/>
		</EditItemTemplate>
	</asp:datalist>
</asp:panel>
