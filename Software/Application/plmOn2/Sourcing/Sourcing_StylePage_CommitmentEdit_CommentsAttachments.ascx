<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_CommitmentEdit_CommentsAttachments.ascx.vb" Inherits="plmOnApp.Sourcing_StylePage_CommitmentEdit_CommentsAttachments" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css">
<table height="25" cellspacing="0" cellpadding="0" width="100%" border="0" class="CollapsibleHeader">
    <tr class="TableHeader">
        <td valign="middle" align="center" width="10">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
        </td>
        <td width="20">
            <asp:ImageButton ID="imgBtnToggleComments" OnClientClick="return toggleSectionVisibility(this);" runat="server"
                ImageUrl="../System/Icons/icon_Down.gif"></asp:ImageButton>
            <asp:HiddenField ID="hdnIsExpandedComments" Value="false" runat="server" />
        </td>
        <td class="fontHead">
            <asp:Label ID="lblCommentsHeader" runat="server"></asp:Label>
        </td>
    </tr>
</table>
<div id="AttachCommentsTab" class="Collapsible">
    <cc2:YSTabView ID="YSTabViewCommentsAttachments" runat="server"></cc2:YSTabView>
    <asp:Panel ID="pnlAttachFiles" runat="server">
        <table id="tbl_AttachFiles" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr>
                <td>
                    <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr class="TableHeader">
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                            </td>
                            <td class="fontHead">
                                <cc1:BWImageButton ID="btnAttachFiles" runat="server" Message="NONE" CausesValidation="False"></cc1:BWImageButton>
                            </td>
                        </tr>
                    </table>
                    <asp:DataList ID="DataListAttachments" runat="server" Width="100%" OnDeleteCommand="DataListAttachments_DeleteCommand"
                        OnCancelCommand="DataListAttachments_CancelCommand" OnUpdateCommand="DataListAttachments_UpdateCommand"
                        OnEditCommand="DataListAttachments_EditCommand" DataKeyField="SourcingCommitmentDocumentID" BackColor="White"
                        BorderColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1px">
                        <HeaderTemplate>
                            <tr>
                                <td class="fontHead" width="27" height="20">
                                    &nbsp;
                                </td>
                                <td class="fontHead" width="200">
                                    <asp:Label ID="lblFName" runat="server"><%#GetSystemText("File Name")%></asp:Label>
                                </td>
                                <td class="font" width="10">
                                    &nbsp;
                                </td>
                                <td class="fontHead" width="200">
                                    <asp:Label ID="lblFDesc" runat="server"><%#GetSystemText("File Description")%></asp:Label>
                                </td>
                                <td class="font" width="10">
                                    &nbsp;
                                </td>
                                <td class="fontHead" width="100">
                                    <asp:Label ID="lblFSize" runat="server"><%#GetSystemText("File Size")%></asp:Label>
                                </td>
                                <td class="fontHead" width="100">
                                    <asp:Label ID="lblFCreatedBy" runat="server"><%#GetSystemText("File Created By")%></asp:Label>
                                </td>
                                <td class="fontHead" width="125">
                                    <asp:Label ID="lblFCreatedDate" runat="server"><%# GetSystemText("File Created Date")%></asp:Label>
                                </td>
                                <td class="fontHead">
                                    &nbsp;
                                </td>
                            </tr>
                        </HeaderTemplate>
                        <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
                        <FooterTemplate>
                        </FooterTemplate>
                        <ItemStyle BackColor="White"></ItemStyle>
                        <ItemTemplate>
                            <tr>
                                <td width="20" height="20">
                                    <asp:LinkButton ID="Linkbutton1" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'
                                        CommandName="edit"></asp:LinkButton>
                                </td>
                                <td class="font" width="200">
                                    <%#Container.DataItem("DocumentName")%>
                                </td>
                                <td class="font" width="10">
                                    &nbsp;
                                </td>
                                <td class="font" width="200">
                                    <asp:Label ID="lblDocumentDesc" runat="server">
								                <%#Container.DataItem("DocumentDescription")%>
                                    </asp:Label>
                                </td>
                                <td class="font" width="10">
                                    &nbsp;
                                </td>
                                <td class="font" width="100">
                                    <%# Container.DataItem("DocumentSize")%>
                                </td>
                                <td class="font" width="100">
                                    <%#Container.DataItem("CUser")%>
                                </td>
                                <td class="font" width="125">
                                    <%# Convert.ToDateTime(Container.DataItem("CDate")).ToString(Me.GetFormatInfo.DateShortFormat)%>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <tr>
                                <td colspan="8">
                                    <br>
                                    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td valign="middle" align="center" width="10">
                                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                            </td>
                                            <td width="500">
                                                <cc1:ConfirmedImageButton ID="edit_btnSave" runat="server" Message="NONE" CommandName="update"></cc1:ConfirmedImageButton>
                                                <cc1:ConfirmedLinkButton ID="edit_btnDelete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this file?")%>'
                                                    CommandName="delete" NAME="edit_btnDelete">
                                                </cc1:ConfirmedLinkButton>
                                                <asp:LinkButton ID="Linkbutton5" runat="Server" CommandName="download" OnClientClick="dont_show_wait_twice(); return true;"></asp:LinkButton>
                                                <cc1:ConfirmedImageButton ID="btnEditCancel" runat="server" Message="NONE" CommandName="cancel"></cc1:ConfirmedImageButton>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                    <table cellspacing="1" cellpadding="1" width="100%" bgcolor="whitesmoke" border="0">
                                        <tr>
                                            <td valign="top" width="400">
                                                <table cellspacing="0" cellpadding="0" width="400" border="0">
                                                    <tr>
                                                        <td style="height: 22px" width="10">
                                                            &nbsp;
                                                        </td>
                                                        <td class="fontHead" width="100">
                                                            <asp:Label ID="lblFlName" runat="server"><%#GetSystemText("File Name")%>:</asp:Label>
                                                        </td>
                                                        <td class="font">
                                                            <asp:Label ID="lblFileName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocumentName").ToString  %>'>
                                                            </asp:Label>
                                                            <asp:HiddenField ID="hdnFileName" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "DocumentName").ToString %>' />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="10">
                                                            &nbsp;
                                                        </td>
                                                        <td class="fontHead" valign="top" width="100">
                                                            <br>
                                                            <asp:Label ID="lblFlDesc" runat="server"><%#GetSystemText("File Description")%>:</asp:Label>:
                                                        </td>
                                                        <td class="font">
                                                            <asp:TextBox ID="txtFileDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocumentDescription").ToString  %>'
                                                                Width="250" Columns="50" Wrap="false" ToolTip="Enter file description here..." TextMode="MultiLine"
                                                                Rows="5">
                                                            </asp:TextBox>
                                                            <asp:HiddenField ID="hdnFileDescription" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "DocumentDescription").ToString %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="top">
                                                <table cellspacing="0" cellpadding="0" width="400" border="0">
                                                    <tr>
                                                        <td width="10">
                                                            &nbsp;
                                                        </td>
                                                        <td class="fontHead" valign="top" width="100">
                                                            <asp:Label ID="LblFlUp" runat="server"><%#GetSystemText("Upload File")%>:</asp:Label>
                                                        </td>
                                                        <td class="font">
                                                            <input class="font" id="txtFilePath" type="file" runat="server">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="10">
                                                            &nbsp;
                                                        </td>
                                                        <td class="fontHead" valign="top" width="100">
                                                            <asp:Label ID="LblFlSize" runat="server"><%#GetSystemText("File Size")%>:</asp:Label>:
                                                        </td>
                                                        <td class="font">
                                                            <asp:Label ID="lblFileSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocumentSize").ToString  %>'>
                                                            </asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                    <table cellspacing="0" cellpadding="0" width="100%" bgcolor="whitesmoke" border="0">
                                        <tr>
                                            <td width="20">
                                                &nbsp;
                                            </td>
                                            <td class="font" width="100">
                                                <asp:Label ID="lblCreatedBy" runat="server"><%#GetSystemText("Created By")%></asp:Label>:
                                            </td>
                                            <td class="font">
                                                <asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; Container.DataItem("CDate").ToString %>'>
                                                </asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="20" bgcolor="whitesmoke">
                                                &nbsp;
                                            </td>
                                            <td class="font" width="100">
                                                <asp:Label ID="lblModifiedBy" runat="server"><%#GetSystemText("Modified By")%></asp:Label>:
                                            </td>
                                            <td class="font">
                                                <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; Container.DataItem("MDate").ToString %>'>
                                                </asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <br>
                                </td>
                            </tr>
                        </EditItemTemplate>
                    </asp:DataList>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <!-- Here goes comments tab -->
    <table height="25" cellspacing="0" cellpadding="0" width="400" border="0" id="tblNewComment" runat="server">
        <tr class="TableHeader">
            <td align="left">
                <asp:ImageButton ID="btnNewComment" runat="server"></asp:ImageButton>
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlNewComment" runat="server" BackColor="#ffffff" BorderStyle="Solid" BorderColor="Silver"
        Width="100%" CssClass="font" BorderWidth="1">
        <table cellspacing="0" cellpadding="0" width="400">
            <tr class="TableHeaderGreen">
                <td width="5" height="20">
                    &nbsp;
                </td>
                <td class="fontHead">
                    <asp:Label ID="lblNewComment" runat="server"><%#GetSystemText("New Comment")%>:</asp:Label>
                </td>
            </tr>
            <tr class="TableHeader">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="imgBtnInsertComment" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <asp:ImageButton ID="imgBtnCancelInsertComment" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td style="width: 18px" width="19" height="20">
                    &nbsp;
                </td>
                <td>
                    <asp:TextBox ID="txtNewComment" runat="server" CssClass="font" Width="350" TextMode="MultiLine" Height="150"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br>
    </asp:Panel>
    <asp:Panel ID="pnlCommentsData" runat="server" BackColor="#ffffff" Width="400" CssClass="font" BorderWidth="0">
        <asp:DataList ID="DataListComments" runat="server" BorderWidth="0px" Width="100%" BorderColor="WhiteSmoke"
            BorderStyle="Solid" BackColor="White" OnDeleteCommand="DataListComments_DeleteCommand" OnCancelCommand="DataListComments_CancelCommand"
            OnUpdateCommand="DataListComments_UpdateCommand" OnEditCommand="DataListComments_EditCommand" DataKeyField="SourcingCommitmentCommentID">
            <HeaderTemplate>
            </HeaderTemplate>
            <FooterTemplate>
            </FooterTemplate>
            <ItemTemplate>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr class="TableHeader">
                        <td class="fonthead" height="25">
                            <%#Container.DataItem("MUser")%>&nbsp;-&nbsp;<%# Convert.ToDateTime(Yunique.Core.Library.SystemHandler.GetLocalTime(Container.DataItem("MDate"))).ToString(Me.GetFormatInfo.DateTimeLongFormat)%>&nbsp;
                        </td>
                        <td align="right" width="20" height="20">
                            <asp:LinkButton ID="btnEditComment" runat="Server" CommandName="edit" Visible='<%# ShowEditComment(Container.DataItem("CTeamID").ToString) %>'>
                            </asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="font" colspan="2">
                            <asp:Label ID="lblSourcingCommitmentComment" runat="server">
							        <%# Container.DataItem("SourcingCommitmentComment")%>
                            </asp:Label>
                        </td>
                    </tr>
                </table>
                <br>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:Panel ID="pnlEdit" BorderWidth="1" BorderColor="LightGrey" BorderStyle="Solid" runat="server">
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr class="TableHeaderBlue">
                            <td width="5" height="20">
                                &nbsp;
                            </td>
                            <td>
                                <asp:Label ID="lblEditComment" runat="server"><%#GetSystemText("Edit Comment")%>...</asp:Label>&nbsp;
                            </td>
                        </tr>
                    </table>
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr class="TableHeader">
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                            </td>
                            <td>
                                <asp:LinkButton ID="edit_btnUpdateComment" runat="Server" CommandName="update" NAME="edit_btnUpdateComment"></asp:LinkButton>
                                <cc1:ConfirmedLinkButton ID="edit_btnDeleteComment" runat="Server" CommandName="delete" Message='<%#GetSystemText("Are you sure you want to Remove this comment?") %>'
                                    Visible="TRUE" NAME="edit_btnDeleteComment"></cc1:ConfirmedLinkButton>
                                <asp:LinkButton ID="edit_btnCancelComment" runat="Server" CommandName="cancel" NAME="edit_btnCancelComment"></asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="font" width="20">
                                &nbsp;
                            </td>
                            <td class="font" valign="top">
                                <asp:TextBox ID="txtComment" runat="server" Width="350" Text='<%# DataBinder.Eval(Container.DataItem, "SourcingCommitmentComment").ToString  %>'
                                    TextMode="MultiLine" ToolTip='<%#GetSystemText("Enter your comments here") & "..." %>' Height="150">
                                </asp:TextBox>
                            </td>
                            <tr>
                                <td width="20">
                                    &nbsp;
                                </td>
                                <td class="font">
                                    <asp:Label ID="lblCreatedBy" runat="server"><%#GetSystemText("Created By")%>:</asp:Label>&nbsp;
                                    <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; "&nbsp;-&nbsp;" &amp; Convert.ToDateTime(Yunique.Core.Library.SystemHandler.GetLocalTime(Container.DataItem("CDate"))).ToString(Me.GetFormatInfo.DateShortFormat) %>'>
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td width="20">
                                    &nbsp;
                                </td>
                                <td class="font">
                                    <asp:Label ID="lblModifiedBy" runat="server"><%#GetSystemText("Modified By")%>:</asp:Label>&nbsp;
                                    <asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; "&nbsp;-&nbsp;" &amp; Convert.ToDateTime(Yunique.Core.Library.SystemHandler.GetLocalTime(Container.DataItem("MDate"))).ToString(Me.GetFormatInfo.DateShortFormat) %>'>
                                    </asp:Label>
                                </td>
                            </tr>
                    </table>
                </asp:Panel>
                <br>
            </EditItemTemplate>
        </asp:DataList>
    </asp:Panel>
</div>
