<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Compliance_Edit.aspx.vb"
    Inherits="plmOnApp.Compliance_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Compliance_SelectedAgents" Src="Compliance_SelectedAgents.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title runat="server" id="PageTitle">Compliance</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="Form1" method="post" runat="server" defaultbutton="btnImgSearch">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:BWImageButton ID="btnMultiUploadWin" runat="server"></cc1:BWImageButton>
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td valign="middle">
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="#E0E0E0">Compliance</asp:Label>
            </td>
        </tr>
    </table>
    <table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr class="fontHead">
            <td align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td class="fontHead">
                <div align="right">
                    <asp:Label ID="lblSearch" Text="Search:" runat="server"></asp:Label></div>
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
                        ID="lblPageSize" Visible="False" Text="24" runat="server"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif">
                    </asp:ImageButton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif">
                    </asp:ImageButton></div>
            </td>
            <td width="150">
                <div align="center">
                    <asp:Label ID="lblCounts" CssClass="plaintable" runat="server"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif">
                    </asp:ImageButton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif">
                    </asp:ImageButton></div>
            </td>
            <td>
                <div align="left">
                    <b>
                        <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;<asp:Label
                            ID="lblRecordsFound" Visible="true" Text="Records Found" runat="server" /></b></div>
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
                    <asp:LinkButton ID="btnAdd" runat="Server">
                        <img border="0" runat="server" alt="Save" id="imgSave">
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnAddClose" runat="Server" CausesValidation="False">
                        <img border="0" runat="server" alt="Cancel" id="imgCancel">
                    </asp:LinkButton>
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
                                <asp:Label ID="lblFileDescription" Visible="true" Text="File Description:" runat="server" />
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
                                <asp:Label ID="lblFileUpload" Visible="true" Text="File Upload:" runat="server" />
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
                                <asp:CheckBox ID="cbSharedNew" runat="server" ForeColor="Red"></asp:CheckBox>
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
        BorderColor="WhiteSmoke" BackColor="White" DataKeyField="ComplianceId" OnEditCommand="DataList_EditCommand"
        OnUpdateCommand="DataList_UpdateCommand" OnCancelCommand="DataList_CancelCommand"
        OnDeleteCommand="DataList_DeleteCommand">
        <HeaderTemplate>
            <table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr class="Toolbar">
                    <td class="fontHead" width="27" height="20">
                        &nbsp;
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblHeaderFileName" Visible="true" runat="server"><%#GetSystemText("File Name")%></asp:Label>
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblHeaderFileDescription" Visible="true" runat="server"><%#GetSystemText("File Description")%></asp:Label>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblHeaderFileSize" Visible="true" runat="server"><%#GetSystemText("File Size")%></asp:Label>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblHeaderFileShared" Visible="true" runat="server"><%#GetSystemText("File Shared")%></asp:Label>
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
                        <asp:LinkButton ID="Linkbutton1" runat="Server" Text='<IMG border="0" src="../System/Icons/icon_edit.gif">'
                            CommandName="edit" ToolTip='<%#GetSystemText("edit")%>' NAME="Linkbutton1"></asp:LinkButton>
                    </td>
                    <td class="font" width="200">
                        <asp:LinkButton ID="Linkbutton2" runat="Server" Text='<%#Container.DataItem("ComplianceFileName")%>'
                            CommandName="download" OnClientClick="dont_show_wait_twice();">
                        </asp:LinkButton>
                    </td>
                    <td class="font" width="200">
                        <asp:Label runat="server" ID="lblComplianceDescription">
									<%#Container.DataItem("ComplianceDescription")%>
                        </asp:Label>
                    </td>
                    <td class="font" width="100">
                        <%#Container.DataItem("ComplianceFileSize")%>
                    </td>
                    <td class="font" width="100">
                        <%#GetCheckBoxValueDefault(Container.DataItem("ComplianceFileShared"))%>
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
                        <asp:LinkButton ID="btnEdit_update" runat="server" CommandName="update" Visible="<%# AccessModifiy() %>">
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnEdit_Share" runat="Server" CommandName="share"></asp:LinkButton>
                        <cc1:ConfirmedLinkButton ID="btnEdit_delete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this file?")%>'
                            CommandName="delete" Visible="<%# AccessDelete() %>">
                        </cc1:ConfirmedLinkButton>
                        <asp:LinkButton ID="btnEdit_download" runat="Server" CommandName="download" Visible="<%# AccessPrint() %>" OnClientClick="dont_show_wait_twice();">
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
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td class="fontHead" valign="top" width="100">
                                <asp:Label ID="lblEditUploadFile" Visible="true" runat="server"><%#GetSystemText("Upload File") & ":"%></asp:Label>
                            </td>
                            <td class="font">
                                <input class="font" id="txtImagePath" type="file" runat="server">
                            </td>
                            <td class="font" rowspan="6">
                                <asp:Label ID="lblEditFileDescription" Visible="true" runat="server"><%#GetSystemText("File Description") & ":"%></asp:Label>
                            </td>
                            <td class="font" rowspan="6">
                                <asp:TextBox ID="txtFileDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ComplianceDescription").ToString  %>'
                                    Rows="5" TextMode="MultiLine" Wrap="false" Columns="50" Width="250">
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 22px" width="10">
                                &nbsp;
                            </td>
                            <td class="fontHead" width="100">
                                <asp:Label ID="lblEditFileName" Visible="true" runat="server"><%#GetSystemText("File Name") & ":"%></asp:Label>
                            </td>
                            <td class="font">
                                <asp:Label ID="lblFileName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ComplianceFileName").ToString  %>'>
                                </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td class="fontHead" valign="top" width="100">
                                <asp:Label ID="lblEditFileSize" Visible="true" runat="server"><%#GetSystemText("File Size") & ":"%></asp:Label>
                            </td>
                            <td class="font">
                                <asp:Label ID="lblFileSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ComplianceFileSize").ToString  %>'>
                                </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="20">
                                &nbsp;
                            </td>
                            <td class="font" width="100">
                                <asp:Label ID="lblEditCreatedBy" Visible="true" runat="server"><%#GetSystemText("Created By") & ":"%></asp:Label>
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
                                <asp:Label ID="lblEditModifiedBy" Visible="true" runat="server"><%#GetSystemText("Modified By") & ":"%></asp:Label>
                            </td>
                            <td class="font">
                                <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; Container.DataItem("MDate").ToString %>'>
                                </asp:Label>
                            </td>
                        </tr>
                </tr>
            </table>
            </td>
            <%-- <table cellspacing="0" cellpadding="0" width="400" border="0">
                           <tr>
                                <td width="10" height="35">
                                    &nbsp;
                                </td>
                                <td class="fontHead" colspan="2" height="35">
                                    &nbsp;&nbsp;
                                      <asp:CheckBox ID="cbFileShared" runat="server" ForeColor="Red" Text="<%# GetCheckBoxTextDefault() %>"
                                        Checked='<%# DataBinder.Eval(Container.DataItem, "ComplianceFileShared").ToString  %>'>
                                    </asp:CheckBox>
                    </td>
                </tr>
            </table>--%>

            <asp:Panel ID="pnlAgent" runat="server">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td>
                            <uc1:Compliance_SelectedAgents ID="Compliance_SelectedAgents1" runat="server"></uc1:Compliance_SelectedAgents>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </EditItemTemplate> 
    </asp:DataList></form>

    <script language="javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                    e.checked = actVar;
            }
        }

        var frm = document.Form1;
    function CheckAll(checkAllBox) {
        var actVar = checkAllBox.checked;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];
            if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
                e.checked = actVar;
        }
    }

    </script>

</body>
</html>
