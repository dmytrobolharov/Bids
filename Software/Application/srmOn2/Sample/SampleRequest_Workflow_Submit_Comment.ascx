<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Comment.ascx.vb"
    Inherits="srmOnApp.SampleRequest_Workflow_Submit_Comment" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<table height="25" cellspacing="0" cellpadding="0" width="400" border="0">
    <tr class="TableHeader">
        <td valign="middle" align="center" width="10">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
        </td>
        <td width="20">
            <asp:ImageButton ID="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif" runat="server">
            </asp:ImageButton><asp:ImageButton ID="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif"
                runat="server"></asp:ImageButton>
        </td>
        <td class="fontHead">
            &nbsp;
            <asp:Label ID="lblComment" runat="server">Comments</asp:Label>
        </td>
        <td align="right">
            <asp:ImageButton ID="btnNew" runat="server"></asp:ImageButton>
        </td>
    </tr>
</table>
<asp:Panel ID="Panel2" runat="server" BackColor="#ffffff" BorderStyle="Solid" BorderColor="Silver"
    Width="100%" CssClass="font" BorderWidth="1">
    <table cellspacing="0" cellpadding="0" width="100%">
        <tr class="TableHeaderGreen">
            <td width="5" height="20">
                &nbsp;
            </td>
            <td class="fontHead">
                <asp:Label ID="lblNewComment" runat="server">New Comment:</asp:Label>
            </td>
        </tr>
        <tr class="TableHeader">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="imgBtnInsert" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <asp:ImageButton ID="imgBtnCancelInsert" runat="server"></asp:ImageButton>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td style="width: 18px" width="19" height="20">
                &nbsp;
            </td>
            <td>
                <asp:TextBox ID="txtNewComment" runat="server" CssClass="font" Width="350" TextMode="MultiLine"
                    Height="150"></asp:TextBox>
            </td>
        </tr>
    </table>
    <br>
</asp:Panel>
<asp:Panel ID="Panel1" runat="server" BackColor="#ffffff" Width="400" CssClass="font"
    BorderWidth="0">
    <asp:DataList ID="DataList1" runat="server" BorderWidth="0px" Width="100%" BorderColor="WhiteSmoke"
        BorderStyle="Solid" BackColor="White" OnDeleteCommand="DataList_DeleteCommand"
        OnCancelCommand="DataList_CancelCommand" OnUpdateCommand="DataList_UpdateCommand"
        OnEditCommand="DataList_EditCommand" DataKeyField="SampleRequestCommentID">
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
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr class="TableHeader">
                    <td class="fonthead" height="25">
                        <%#Container.DataItem("MUser")%>&nbsp;-&nbsp;<%#SystemHandler.GetLocalTime(Container.DataItem("MDate"))%>&nbsp;
                    </td>
                    <td align="right" width="20" height="20">
                        <asp:LinkButton ID="Linkbutton1" runat="Server" CommandName="edit" Visible='<%# ShowEditBtn(Container.DataItem("CTeamID").ToString) %>'>
                        </asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td class="font" colspan="2">
                        <asp:Label ID="lblSamplerequestComment" runat="server">
							<%#Container.DataItem("SamplerequestComment")%>
                        </asp:Label>
                    </td>
                </tr>
            </table>
            <br>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:Panel ID="pnlEdit" BorderWidth="1" BorderColor="LightGrey" BorderStyle="Solid"
                runat="server">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr class="TableHeaderBlue">
                        <td width="5" height="20">
                            &nbsp;
                        </td>
                        <td>
                            <asp:Label ID="lblAddress" runat="server"><%#GetSystemText("Edit Comment")%>...</asp:Label>&nbsp;
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr class="TableHeader">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td>
                            <asp:LinkButton ID="Linkbutton2" runat="Server" CommandName="update" NAME="Linkbutton2"></asp:LinkButton>
                            <asp:LinkButton ID="Linkbutton3" runat="Server" CommandName="cancel" NAME="Linkbutton3"></asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="font" width="20">
                            &nbsp;
                        </td>
                        <td class="font" valign="top">
                            <asp:TextBox ID="txtComments" runat="server" Width="350" Text='<%# DataBinder.Eval(Container.DataItem, "SamplerequestComment").ToString  %>'
                                TextMode="MultiLine" ToolTip='<%# GetSystemText("Enter your comment here") & "..."  %>'
                                Height="150">
                            </asp:TextBox>
                        </td>
                        <tr>
                            <td width="20">
                                &nbsp;
                            </td>
                            <td class="font">
                                Created By:&nbsp;
                                <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; "&nbsp;-&nbsp;" &amp; Convert.ToDateTime(SystemHandler.GetLocalTime(Container.DataItem("CDate"))).ToString(Me.GetFormatInfo.DateShortFormat) %>'>
                                </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="20">
                                &nbsp;
                            </td>
                            <td class="font">
                                Modified By:&nbsp;
                                <asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; "&nbsp;-&nbsp;" &amp; Convert.ToDateTime(SystemHandler.GetLocalTime(Container.DataItem("MDate"))).ToString(Me.GetFormatInfo.DateShortFormat) %>'>
                                </asp:Label>
                            </td>
                        </tr>
                </table>
            </asp:Panel>
            <br>
        </EditItemTemplate>
    </asp:DataList>
</asp:Panel>
