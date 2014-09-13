<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_TradePartner_Tab_Edit.aspx.vb"
    Inherits="plmOnApp.Control_TradePartner_Tab_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administrator Panel</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td width="100%">
                <cc1:ConfirmedImageButton ID="btnSaveUser" runat="server"  Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnPassword" runat="server"  ToolBar="False" Status="False" ScrollBars="False" Resizable="False" MenuBar="False" Location="False" WindowHeight="250px" WindowWidth="600px"
                        WindowName="Control_TradePartner_Edit_Password" NavigateUrl="Control_TradePartner_Edit_Password.aspx">
                    </cc1:BWImageButton><cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top" colspan="2" height="50">
                            <asp:Label ID="lblTradeName" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                                ForeColor="#E0E0E0"></asp:Label>&nbsp;
                        </td>
                        <td valign="top" height="50">
                        </td>
                    </tr>
                </table>
                <table id="Table2" cellspacing="2" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>
                <br>
                <cc1:YSTabView ID="YSTabView1" runat="server"></cc1:YSTabView>
            </td>
        </tr>
    </table>
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnNewUpload" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
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
                    <asp:Label ID="lblSearch" runat="server"></asp:Label></div>
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
                    <asp:Label ID="lblCurrentIndex" Visible="False" Text="0" runat="server"></asp:Label><asp:Label
                        ID="lblPageSize" Visible="False" Text="3" runat="server"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <a id="First" href="pagingdatalist.aspx#BookMark" runat="server" onserverclick="ShowFirstPage">
                        <img height="16" alt="First Record" src="../System/Icons/icon_first.gif" width="16"
                            border="0"></a></div>
            </td>
            <td width="20">
                <div align="center">
                    <a id="Previous" href="pagingdatalist.aspx#BookMark" runat="server" onserverclick="ShowPreviousPage">
                        <img height="16" alt="Previous Record" src="../System/Icons/icon_Previous.gif" width="16"
                            border="0"></a></div>
            </td>
            <td width="150">
                <div align="center">
                    <asp:Label ID="lblCounts" CssClass="plaintable" runat="server"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <a id="Next" href="pagingdatalist.aspx#BookMark" runat="server" onserverclick="ShowNextPage">
                        <img height="16" alt="Next Record" src="../System/Icons/icon_next.gif" width="16"
                            border="0"></a></div>
            </td>
            <td width="20">
                <div align="center">
                    <a id="Last" href="pagingdatalist.aspx#BookMark" runat="server" onserverclick="ShowLastPage">
                        <img height="16" alt="Last Record" src="../System/Icons/icon_last.gif" width="16"
                            border="0"></a></div>
            </td>
            <td>
                <div align="left">
                    <b>
                        <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;
                        <asp:Label ID="RecordCount" runat="server"></asp:Label>
                    </b>
                </div>
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
                    <asp:LinkButton ID="btnAdd" runat="Server" >
					    <IMG border="0" alt="Save" id="ImgAdd"  runat="server" ></asp:LinkButton>
                    <asp:LinkButton ID="btnAddClose" runat="Server" CausesValidation="False">
						<IMG border="0" alt="Cancel" id="ImgCancel" runat="server"  ></asp:LinkButton>
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
                                <asp:Label ID="lblFileDescription" runat="server"></asp:Label>
                            </td>
                            <td class="font">
                                <asp:TextBox ID="txtNewFileDescription" runat="server" Rows="5" TextMode="MultiLine"
                                    Wrap="false" Columns="50" Width="250"></asp:TextBox>
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
                                <asp:Label ID="lblFileUpload" runat="server"></asp:Label>
                            </td>
                            <td class="font">
                                <input class="font" id="txtNewDocumentPath" type="file" name="txtStyleDocumentPath"
                                    runat="server">
                            </td>
                        </tr>
                        <tr>
                            <td width="10" height="35">
                                &nbsp;
                            </td>
                            <td class="fontHead" colspan="2" height="35">
                                &nbsp;&nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:DataList ID="DataList1" runat="server" Width="100%" BorderWidth="1px" BorderStyle="Solid"
        BorderColor="WhiteSmoke" BackColor="White" DataKeyField="TradePartnerContactTabItemID">
        <HeaderTemplate>
            <table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr class="Toolbar">
                    <td class="fontHead" width="27" height="20">
                        &nbsp;
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblFileName" runat="server"><%#GetSystemText("File Name")%></asp:Label>
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblFileDesc" runat="server"><%#GetSystemText("File Description")%></asp:Label>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblFileSize" runat="server"><%#GetSystemText("File Size")%></asp:Label>
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
                        <asp:LinkButton ID="Linkbutton1" runat="server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'
                            CommandName="edit" NAME="Linkbutton1"></asp:LinkButton>
                    </td>
                    <td class="font" width="200">
                        <asp:LinkButton ID="lnkFilename" runat="server" CommandName="download"></asp:LinkButton>
                    </td>
                    <td class="font" width="200">
                        <asp:Label runat="server" ID="lblDescription"></asp:Label>
                    </td>
                    <td class="font" width="100">
                        <asp:Label runat="server" ID="lblFileSize"></asp:Label>
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
                        <asp:LinkButton ID="btnEdit_update" runat="server" CommandName="update"></asp:LinkButton>
                        <cc1:ConfirmedLinkButton ID="btnEdit_delete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this file?") %>' CommandName="delete">
                        </cc1:ConfirmedLinkButton>
                        <asp:LinkButton ID="btnEdit_download" runat="Server" CommandName="download">
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnEdit_close" runat="Server" CommandName="cancel"></asp:LinkButton>
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
                                    <asp:Label ID="lblFileNameE" runat="server"><%#GetSystemText("File Name")%>:</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:Label ID="lblFileName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TabItemFileName").ToString  %>'>
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td class="fontHead" valign="top" width="100">
                                    <br>
                                    <asp:Label ID="lblFileDescription" runat="server"><%#GetSystemText("File Description")%>:</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:TextBox ID="txtFileDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TabItemDescription").ToString  %>'
                                        Rows="5" TextMode="MultiLine" Wrap="false" Columns="50" Width="250" ToolTip='<%#GetSystemText("Enter file description here") %>...'>
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
                                    <asp:Label ID="lblUploadFile" runat="server"><%#GetSystemText("UploadFile")%>:</asp:Label>
                                </td>
                                <td class="font">
                                    <input class="font" id="txtImagePath" type="file" runat="server">
                                </td>
                            </tr>
                            <tr>
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td class="fontHead" valign="top" width="100">
                                    <asp:Label ID="lblFileSizeE" runat="server"><%#GetSystemText("File Size")%>:</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:Label ID="lblFileSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FileSize").ToString  %>'>
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
                        <asp:Label ID="lblCreatedByE" runat="server"><%#GetSystemText("Created By")%>:</asp:Label>
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
                        <asp:Label ID="lblModifiedByE" runat="server"><%#GetSystemText("Modified By")%>:</asp:Label>
                    </td>
                    <td class="font">
                        <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; Container.DataItem("MDate").ToString %>'>
                        </asp:Label>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:DataList>
    </form>
</body>
</html>
