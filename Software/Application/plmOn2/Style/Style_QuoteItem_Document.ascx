<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_QuoteItem_Document.ascx.vb"
    Inherits="plmOnApp.Style.Quote.Style_QuoteItem_Document" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<table class="TableHeader" id="toolbar" height="20" cellspacing="0" cellpadding="0"
    width="100%" border="0" runat="server">
    <tr valign="middle">
        <td valign="middle" align="center" width="10">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
        </td>
        <td>
            <cc1:BWImageButton ID="btnMultiUploadWin" runat="server"></cc1:BWImageButton>
        </td>
    </tr>
</table>
<table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
    height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
    <tr>
        <td valign="middle">
            &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                ForeColor="#E0E0E0">Attachments</asp:Label>
        </td>
    </tr>
</table>
<table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%"
    border="0">
    <tr class="fontHead">
        <td align="center" width="10">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
        </td>
        <td class="fontHead" width="50">
            <div align="right">
                <asp:Label ID="lblSrch" runat="server" Text="Search:"></asp:Label></div>
        </td>
        <td width="75">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="font"></asp:TextBox>
        </td>
        <td width="10">
            <asp:ImageButton ID="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif">
            </asp:ImageButton>
        </td>
        <td>
            <div align="left">
                &nbsp;
                <asp:Label ID="lblCurrentIndex" Text="0" Visible="False" runat="server"></asp:Label><asp:Label
                    ID="lblPageSize" Text="10" Visible="False" runat="server"></asp:Label></div>
        </td>
        <td width="20">
            <div align="center">
                <asp:ImageButton ID="btnImgFirstRecord" runat="server" ImageUrl="../System/Icons/icon_first.gif">
                </asp:ImageButton>
            </div>
        </td>
        <td width="20">
            <div align="center">
                <asp:ImageButton ID="btnImgPreviousRecord" runat="server" ImageUrl="../System/Icons/icon_Previous.gif">
                </asp:ImageButton>
            </div>
        </td>
        <td width="150">
            <div align="center">
                <asp:Label ID="lblCounts" CssClass="plaintable" runat="server"></asp:Label></div>
        </td>
        <td width="20">
            <div align="center">
                <asp:ImageButton ID="btnImgNextRecord" runat="server" ImageUrl="../System/Icons/icon_next.gif">
                </asp:ImageButton>
            </div>
        </td>
        <td width="20">
            <div align="center">
                <asp:ImageButton ID="btnImgLastRecord" runat="server" ImageUrl="../System/Icons/icon_last.gif">
                </asp:ImageButton>
            </div>
        </td>
        <td>
            <div align="left">
                <b>
                    <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;
                    <asp:Label ID="lblRecFnd" runat="server" Text="Records Found"></asp:Label></b></div>
            </B>
        </td>
    </tr>
</table>
<asp:Panel ID="pnlNew" runat="server">
    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td width="500">
                <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnAddClose" runat="server" Message="NONE" CausesValidation="False">
                </cc1:ConfirmedImageButton>
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
                        <td width="10">
                            &nbsp;
                        </td>
                        <td class="fontHead" valign="top" width="100">
                            <asp:Label ID="lblFileDesc" runat="server" Text="File Description:"></asp:Label>
                        </td>
                        <td class="font">
                            <asp:TextBox ID="txtNewFileDescription" runat="server" Width="250" Columns="50" Wrap="false"
                                TextMode="MultiLine" Rows="5"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <table cellspacing="0" cellpadding="0" width="400" border="0">
                    <tr>
                        <td width="10">
                            &nbsp;
                        </td>
                        <td class="fontHead" valign="top" width="100">
                            <asp:Label ID="lblFileUp" runat="server" Text="File Upload:"></asp:Label>
                        </td>
                        <td class="font">
                            <input class="font" id="txtNewDocumentPath" type="file" name="txtNewDocumentPath"
                                runat="server">
                            <asp:RequiredFieldValidator ID="rvNewFileRquired" runat="server" CssClass="fontHead"
                                ErrorMessage="*" Display="Dynamic" ControlToValidate="txtNewDocumentPath"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:DataList ID="DataList1" runat="server" Width="100%" BorderWidth="1px" BorderStyle="Solid"
    BorderColor="WhiteSmoke" BackColor="White" DataKeyField="StyleQuoteDocumentID"
    OnEditCommand="DataList_EditCommand" OnUpdateCommand="DataList_UpdateCommand"
    OnCancelCommand="DataList_CancelCommand" OnDeleteCommand="DataList_DeleteCommand">
    <HeaderTemplate>
        <table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr class="Toolbar">
                <td class="fontHead" width="27" height="20">
                    &nbsp;
                </td>
                <td class="fontHead" width="200">
                    <%#GetSystemText("File Name")%>
                </td>
                <td class="fontHead" width="200">
                    <%#GetSystemText("File Description")%>
                </td>
                <td class="fontHead" width="100">
                    <%#GetSystemText("File Size")%>
                </td>
                <td class="fontHead">
                    &nbsp;
                </td>
            </tr>
        </table>
    </HeaderTemplate>
    <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
    <FooterTemplate>
    </FooterTemplate>
    <ItemStyle BackColor="White"></ItemStyle>
    <ItemTemplate>
        <table width="100%">
            <tr>
                <td width="20" height="20">
                    <asp:LinkButton ID="Linkbutton1" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'
                        CommandName="edit"></asp:LinkButton>
                </td>
                <td class="font" width="200">
                    <%#Container.DataItem("DocumentName")%>
                </td>
                <td class="font" width="200">
                    <asp:Label ID="lblDocumentDescription" runat="server">
						<%#Container.DataItem("DocumentDescription")%>
                    </asp:Label>
                </td>
                <td class="font" width="100">
                    <%#Container.DataItem("DocumentSize")%>
                </td>
                <td class="font">
                    &nbsp;
                </td>
            </tr>
        </table>
    </ItemTemplate>
    <EditItemTemplate>
        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="500">
                    <cc1:ConfirmedImageButton ID="edit_btnSave" runat="server" Message="NONE" Visible='<%# ShowHideSaveBtn() %>'
                        CommandName="update"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedLinkButton ID="edit_btnDelete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this file?")%>'
               
                        CommandName="delete" NAME="edit_btnDelete" Visible='<%# ShowHideDeleteBtn() %>'>
                    </cc1:ConfirmedLinkButton>
                    <asp:LinkButton ID="Linkbutton5" runat="Server" CommandName="download"></asp:LinkButton>
                    <cc1:ConfirmedImageButton ID="btnEditCancel" runat="server" Message="NONE" CommandName="cancel">
                    </cc1:ConfirmedImageButton>
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
                                <%#GetSystemText("File Name")%>:
                            </td>
                            <td class="font">
                                <asp:Label ID="lblFileName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocumentName").ToString  %>'>
                                </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td class="fontHead" valign="top" width="100">
                                <br>
                                <%#GetSystemText("File Description")%>:
                            </td>
                            <td class="font">
                                <asp:TextBox ID="txtFileDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocumentDescription").ToString  %>'
                                    Width="250" Columns="50" Wrap="false" ToolTip='<%#GetSystemText("Enter file description here...")%>'
                                    TextMode="MultiLine" Rows="5">
                                </asp:TextBox>
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
                                <%#GetSystemText("Upload File")%>:
                            </td>
                            <td class="font">
                                <input class="font" id="txtFilePath" type="file" runat="server" name="txtFilePath">
                            </td>
                        </tr>
                        <tr>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td class="fontHead" valign="top" width="100">
                                <%#GetSystemText("File Size")%>:
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
                    <%#GetSystemText("Created By")%>:
                </td>
                <td class="font">
                    <asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("CDate")).ToString %>'>
                    </asp:Label>
                </td>
            </tr>
            <tr>
                <td width="20" bgcolor="whitesmoke">
                    &nbsp;
                </td>
                <td class="font" width="100">
                    <%#GetSystemText("Modified By")%>:
                </td>
                <td class="font">
                    <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("MDate")).ToString %>'>
                    </asp:Label>
                </td>
            </tr>
        </table>
    </EditItemTemplate>
</asp:DataList>
