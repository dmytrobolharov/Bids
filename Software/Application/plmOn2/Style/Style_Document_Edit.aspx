<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Document_Edit.aspx.vb"
    Inherits="plmOnApp.Style.Document.Style_Document_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title>Attachments</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
</head>
<body>
 <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnNewUpload" runat="server" Message="NONE" >
                </cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnNewTask" runat="server" 
                    Message="NONE" OnClientClick="btnNewTask_Click()"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnNewIssue" runat="server" Message="NONE" 
                    CausesValidation="False" OnClientClick="btnNewIssue_Click()"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" 
                    Visible="False" CausesValidation="False"></cc1:ConfirmedImageButton>
                 <cc1:bwimagebutton id="btnImageSelect" runat="server" ></cc1:bwimagebutton>   
                 <cc1:bwimagebutton id="btnMultiUploadWin" runat="server" ></cc1:bwimagebutton>

            </td>
            <td class="fontHead" align="right" width="75">
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
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana">Attachments</asp:Label>
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
                    <asp:Label ID="lblSearch" runat="server">Search:</asp:Label></div>
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
                    <asp:Label ID="lblCurrentIndex" runat="server" Visible="False" Text="0"></asp:Label><asp:Label
                        ID="lblPageSize" runat="server" Visible="False" Text="24"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"
                        OnClick="ShowFirstPage"></asp:ImageButton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"
                        OnClick="ShowPreviousPage"></asp:ImageButton></div>
            </td>
            <td width="150">
                <div align="center">
                    <asp:Label ID="lblCounts" CssClass="plaintable" runat="server"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"
                        OnClick="ShowNextPage"></asp:ImageButton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"
                        OnClick="ShowLastPage"></asp:ImageButton></div>
            </td>
            <td>
                <div align="left">
                    <b>
                        <asp:Label ID="lblRecordCount" runat="server" Visible="true"></asp:Label>&nbsp;
                        <asp:Label ID="lblRecordsFound" runat="server">Records Found</asp:Label></b></div>
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
                    <cc1:ConfirmedImageButton ID="btnAdd" runat="server" 
                        Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnAddClose" runat="server" 
                        Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
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
                                <asp:Label ID="lblFileDescription" runat="server">File Description:</asp:Label>
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
                                <asp:Label ID="lblFileUpload" runat="server">File Upload:</asp:Label>
                            </td>
                            <td class="font">
                                <input class="font" id="txtNewStyleDocumentPath" type="file" size="20" name="txtStyleDocumentPath"
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
   <%-- <asp:Panel ID="pnlMulti" runat="server">
        <div>
            <button id='btnUpload' style="display: none;" onclick="Upload_Click();return false;">
                Start Upload</button>
                
            <CuteWebUI:UploadAttachments runat="server" ID="UploadAttachments1" ManualStartUpload="True"
                OnAttachmentAdded="UploadAttachments1_AttachmentAdded" OnAttachmentCreated="UploadAttachments1_AttachmentCreated"
                NumFilesShowCancelAll="1000" InsertText="Add files" TableHeaderTemplate="<td nowrap='nowrap'></td><td>Files</td><td>Description</td>">
                <ItemTemplate>
                    <table>
                        <tr valign="middle">
                            <td>
                                <asp:TextBox runat="server" ID="textboxDesc" TextMode="MultiLine" />
                            </td>
                            <td>
                                <asp:CheckBox ID="cbSharedNew" runat="server" Text="Share with Agent" ForeColor="Red" Font-Size="XX-Small" />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </CuteWebUI:UploadAttachments>
            <br />
            <table id='clientTable' style="display: none; font-size: 9pt; border-collapse: collapse"
                border="1" cellspacing="0" cellpadding="5">
                <tr>
                    <td>
                        <%#GetSystemText("FileName")%>
                    </td>
                    <td>
                       <%#GetSystemText("Status")%>
                    </td>
 
                </tr>
            </table>
            <br />
            <asp:Button ID="ButtonDeleteAll" runat="server" Text="Delete All" OnClick="ButtonDeleteAll_Click"
                Visible="False" />&nbsp;&nbsp;
            <asp:Button runat="server" ID="buttonTell" Text="Save All" OnClick="buttonTell_Click"
                OnClientClick="return buttonTell_Click()" Visible="False" />
            <br />
           
        </div>
    </asp:Panel>--%>
    <table cellspacing="0" cellpadding="1" border="1" bordercolor="blue">
        <asp:DataList ID="DataList1" runat="server" Width="100%" OnDeleteCommand="DataList_DeleteCommand"
            OnCancelCommand="DataList_CancelCommand" OnUpdateCommand="DataList_UpdateCommand"
            OnEditCommand="DataList_EditCommand" DataKeyField="StyleDocumentID" BackColor="White"
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
                        <asp:Label ID="lblFShared" runat="server"><%#GetSystemText("File Shared")%></asp:Label>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblFCreatedBy" runat="server"><%# GetSystemText("File Attached By")%></asp:Label>
                    </td>
                    <td class="fontHead" width="120">
                        <asp:Label ID="lblCreatedDate" runat="server"><%#GetSystemText("File Attached Date")%></asp:Label>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblModifyBy" runat="server"><%#GetSystemText("File Modified By")%></asp:Label>
                    </td>
                    <td class="fontHead" width="120">
                        <asp:Label ID="lblModifyDate" runat="server"><%#GetSystemText("File Modified Date")%></asp:Label>
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
                        <%#Container.DataItem("StyleDocumentName")%>
                    </td>
                    <td class="font" width="10">
                        &nbsp;
                    </td>
                    <td class="font" width="200">
                        <asp:Label ID="lblStyleDocumentDescription" runat="server">
									<%#Container.DataItem("StyleDocumentDescription")%>
                        </asp:Label>
                    </td>
                    <td class="font" width="10">
                        &nbsp;
                    </td>
                    <td class="font" width="100">
                        <%#Container.DataItem("StyleDocumentSize")%>
                    </td>
                    <td class="font" width="100">
                        <%#GetCheckBoxValueDefault(Container.DataItem("StyleDocumentShared"))%>
                    </td>
                    <td class="font" width="100">
                        <%#Container.DataItem("CUser")%>
                    </td>
                    <td class="font" width="120">
                        <%# Convert.ToDateTime(Container.DataItem("CDate")).ToString(Me.GetFormatInfo.DateTimeLongFormat)%>
                    </td>
                    <td class="font" width="100">
                        <%#Container.DataItem("MUser")%>
                    </td>
                    <td class="font" width="120">
                        <%# Convert.ToDateTime(Container.DataItem("MDate")).ToString(Me.GetFormatInfo.DateTimeLongFormat)%>
                    </td>
                    <td class="font">
                        &nbsp; <a href="#" onclick='window.open("Style_Document_Activity.aspx?DID=<%#Container.DataItem("StyleDocumentID")%>", "Activitylog", "top=10, left=10, width=800,height=600,location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes");'><%# GetSystemText("Activity Log")%></a>
                    </td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td colspan="11">
                        <br>
                        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td valign="middle" align="center" width="10">
                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                </td>
                                <td width="500">
                                    <cc1:ConfirmedImageButton ID="edit_btnSave" runat="server" 
                                        Message="NONE" Visible='<%# ShowHideSaveBtn() %>' CommandName="update"></cc1:ConfirmedImageButton>
                                    <cc1:ConfirmedLinkButton ID="edit_btnDelete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this file?")%>'
                                        CommandName="delete" NAME="edit_btnDelete" Visible='<%# ShowHideDeleteBtn() %>'>
                                    </cc1:ConfirmedLinkButton>
                                    <asp:LinkButton ID="Linkbutton5" runat="Server" 
                                        CommandName="download" OnClientClick="parent.dont_show_wait_next_time();"></asp:LinkButton>
                                    <cc1:bwimagebutton id="btnActivityLog" runat="server" ></cc1:bwimagebutton>  

                                    <cc1:ConfirmedImageButton ID="btnEditCancel" runat="server" 
                                        Message="NONE" CommandName="cancel"></cc1:ConfirmedImageButton>
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
                                                <asp:Label ID="lblFileName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StyleDocumentName").ToString  %>'>
                                                </asp:Label>
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
                                                <asp:TextBox ID="txtFileDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StyleDocumentDescription").ToString  %>'
                                                    Width="250" Columns="50" Wrap="false" ToolTip="Enter file description here..."
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
                                                <asp:Label ID="LblFlUp" runat="server"><%#GetSystemText("Upload File")%>:</asp:Label>
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
                                                <asp:Label ID="LblFlSize" runat="server"><%#GetSystemText("File Size")%>:</asp:Label>:
                                            </td>
                                            <td class="font">
                                                <asp:Label ID="lblFileSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StyleDocumentSize").ToString  %>'>
                                                </asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="10" height="35">
                                                &nbsp;
                                            </td>
                                            <td class="fontHead" colspan="2" height="35">
                                                &nbsp;&nbsp;
                                                <asp:CheckBox ID="cbFileShared" runat="server" ForeColor="Red" Text="<%# GetCheckBoxTextDefault() %>"
                                                    Checked='<%# DataBinder.Eval(Container.DataItem, "StyleDocumentShared").ToString  %>'>
                                                </asp:CheckBox>
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
                                    <asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("CDate")).ToString %>'>
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
                                    <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("MDate")).ToString %>'>
                                    </asp:Label>
                                </td>
                            </tr>
                        </table>
                        <br>
                    </td>
                </tr>
            </EditItemTemplate>
        </asp:DataList>
    </table>
    </form>

    <script language="javascript" type="text/javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                    e.checked = actVar;
            }
        }

        function btnNewTask_Click() {
		    <%= strOpenScript %>
            return false;
        }

        function btnNewIssue_Click() {
		    <%= strIssueScript %>
            return false;
        }
        
    </script>

</body>

<%--<script>
    var btnUpload = document.getElementById("btnUpload");
    var clientTable = document.getElementById("clientTable");
    var uploader = document.getElementById('<%=UploadAttachments1.ClientID %>');
    var buttonTell = document.getElementById('<%=buttonTell.ClientID %>');
    var buttonTellClicked = false;

    function Upload_Click() {
        uploader.startupload();

    }

    function buttonTell_Click() {
        buttonTellClicked = true;
        var items = uploader.getitems();
        for (var i = 0; i < items.length; i++) {
            switch (items[i].Status) {
                case "Queue":
                case "Upload":
                    uploader.startupload();
                    return false;
            }

        }
        return true;
    }

    function CuteWebUI_AjaxUploader_OnPostback() {
        if (buttonTellClicked) {
            buttonTell.click();
            return false;
        }


    }


    function CuteWebUI_AjaxUploader_OnQueueUI(files) {
        btnUpload.style.display = files.length > 0 ? "" : "none";

        clientTable.style.display = files.length > 0 ? "" : "none";

        ShowMyClientTable(files);

        return false;
    }

    function ShowMyClientTable(files) {
        var map = {}
        var newlist = [];
        for (var i = 1; i < clientTable.rows.length; i++) {
            var row = clientTable.rows.item(i);
            row._scan = false;
            map[row._filekey] = row;
        }
        //update existing row
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            var row = map[file.InitGuid || file.FileName];
            if (row == null) {
                newlist.push(file);
                continue;
            }
            row._scan = true;
            UpdateToRow(row, file);
        }
        //delete removed row
        for (var i = 1; i < clientTable.rows.length; i++) {
            var row = clientTable.rows.item(i);
            if (!row._scan) {
                clientTable.deleteRow(i);
                i--;
            }
        }
        //add new row:
        for (var i = 0; i < newlist.length; i++) {
            var file = newlist[i];
            var row = clientTable.insertRow(-1);
            row.insertCell(-1);
            row.insertCell(-1);
//            row.insertCell(-1);
            //            row.insertCell(-1);
            UpdateToRow(row, file);
        }
    }
    function UpdateToRow(row, file) {
        row._file = file;

        row._filekey = file.InitGuid || file.FileName;

      
        row.cells.item(0).innerHTML = file.FileName;



        switch (file.Status) {
            case "Queue":
                row.cells.item(1).innerHTML = "<a href='#' onclick='CancelQueueItem(this);return false'>remove</a>";
                break;
            case "Finish": //uploaded
            case "Upload": //uploading
            case "Error": //cancelled
            default:
                row.cells.item(1).innerHTML = file.Status;
                break;

        }

    }

    function CancelQueueItem(link) {
        var td = link.parentNode;
        var row = td.parentNode;
        var file = row._file;
        file.Cancel();
    }




</script>

<script type="text/javascript">
    //prevent duplicated items
    function CuteWebUI_AjaxUploader_OnSelect(files) {
        var sames = [];
        var items = uploader.getitems();
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            var exists = false;
            for (var j = 0; j < items.length; j++) {
                var item = items[j];
                if (item.FileName == file.FileName) {
                    exists = true;
                }
            }
            if (exists) {
                sames.push(file.FileName);
                file.Cancel();
            }
        }
        if (sames.length > 0) {
            alert("These file(s) are already in the queue : \r\n\t" + sames.join('\r\n\t'));
        }
    }
</script>--%>

</html>
