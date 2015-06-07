<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_MultiUploadImages.aspx.vb" Inherits="srmOnApp.Material_MultiUploadImages" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title runat="server" id="PageTitle">Attachments</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
       
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
            <asp:ImageButton runat="server" ID="btnSave" OnClick="btnSave_Click" OnClientClick="return btnSave_Click()" Visible="False"  />
                <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE" 
                    Visible="True" CausesValidation="False"></cc1:ConfirmedImageButton> 
                <img  id='Img1' runat="server"  style="display: none;" onclick="Upload_Click();return false;" /> 
                <asp:ImageButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" Visible="False"  />
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" 
                    Visible="True" CausesValidation="False"></cc1:ConfirmedImageButton>
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
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#999999" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana">Attachments</asp:Label>
            </td>
        </tr>
    </table>   
    <asp:Panel ID="pnlMulti" runat="server">
        <div>           
            <CuteWebUI:UploadAttachments runat="server" ID="UploadAttachments1" ManualStartUpload="False" AutoUseSystemTempFolder="False"
                OnAttachmentAdded="UploadAttachments1_AttachmentAdded" OnAttachmentCreated="UploadAttachments1_AttachmentCreated" OnFileValidating="UploadAttachments1_FileValidating"
                NumFilesShowCancelAll="1000" InsertText="Add files" TableHeaderTemplate="<td nowrap='nowrap'></td><td>Files</td><td>Description</td>" InsertButtonID="btnAdd">
                <ItemTemplate>
                    <table>
                        <tr valign="middle">
                            <td>
                                <asp:TextBox runat="server" ID="textboxDesc" TextMode="MultiLine" />
                            </td>
                            <td>
                                <asp:CheckBox ID="cbSharedNew" visible="false" runat="server" Text='<%#GetSystemText("Share with Agent")%>' ForeColor="Red" Font-Size="XX-Small" />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </CuteWebUI:UploadAttachments>
            <br />
             <%--<table class="TableHeaderGreen" id='clientTable' style="border-color: #CCCCCC; display: none; font-size: 9pt; border-collapse: collapse; background-color: #FFFFFF;"
                border="1" cellspacing="0" cellpadding="1">
                <tr>
                    <td width="200">File Name</td>
                    <td width="75">Status</td>
                </tr>
            </table>--%> 
            <br />
           <%-- <asp:Button ID="ButtonDeleteAll" runat="server" Text="Delete All" OnClick="ButtonDeleteAll_Click"
                Visible="False" />&nbsp;&nbsp;
            <asp:Button runat="server" ID="buttonTell" Text="Save All" OnClick="buttonTell_Click"
                OnClientClick="return buttonTell_Click()" Visible="False" />--%>
            <br />
           
        </div>
    </asp:Panel>
    </form>

</body>

<script>
//    var disabledExtList = "aspx,asp,ashx,html,htm,mht,exe,dll,php,jsp"; 
//    var btnUpload = document.getElementById("btnUpload");
//    var clientTable = document.getElementById("clientTable");
    var uploader = document.getElementById('<%=UploadAttachments1.ClientID %>');
    var btnSave = document.getElementById('<%=btnSave.ClientID %>');
    var btnSaveClicked = false;

    function Upload_Click() {
        uploader.startupload();

    }

    function btnSave_Click() {
        btnSaveClicked = true;
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
        if (btnSaveClicked) {
            btnSave.click();
            return false;
        }


    }


//    function CuteWebUI_AjaxUploader_OnQueueUI(files) {
//        btnUpload.style.display = files.length > 0 ? "" : "none";

//        clientTable.style.display = files.length > 0 ? "" : "none";

//        ShowMyClientTable(files);

//        return false;
//    }

//    function ShowMyClientTable(files) {
//        var map = {}
//        var newlist = [];
//        for (var i = 1; i < clientTable.rows.length; i++) {
//            var row = clientTable.rows.item(i);
//            row._scan = false;
//            map[row._filekey] = row;
//        }
//        //update existing row
//        for (var i = 0; i < files.length; i++) {
//            var file = files[i];
//            var row = map[file.InitGuid || file.FileName];
//            if (row == null) {
//                newlist.push(file);
//                continue;
//            }
//            row._scan = true;
//            UpdateToRow(row, file);
//        }
//        //delete removed row
//        for (var i = 1; i < clientTable.rows.length; i++) {
//            var row = clientTable.rows.item(i);
//            if (!row._scan) {
//                clientTable.deleteRow(i);
//                i--;
//            }
//        }
//        //add new row:
//        for (var i = 0; i < newlist.length; i++) {
//            var file = newlist[i];
//            var row = clientTable.insertRow(-1);
//            row.insertCell(-1);
//            row.insertCell(-1);
////            row.insertCell(-1);
//            //            row.insertCell(-1);
//            UpdateToRow(row, file);
//        }
//    }
//    function UpdateToRow(row, file) {
//        row._file = file;

//        row._filekey = file.InitGuid || file.FileName;

//      
//        row.cells.item(0).innerHTML = file.FileName;



//        switch (file.Status) {
//            case "Queue":
//                row.cells.item(1).innerHTML = "<a href='#' onclick='CancelQueueItem(this);return false'>remove</a>";
//                break;
//            case "Finish": //uploaded
//            case "Upload": //uploading
//            case "Error": //cancelled
//            default:
//                row.cells.item(1).innerHTML = file.Status;
//                break;

//        }

//    }

    function CancelQueueItem(link) {
        var td = link.parentNode;
        var row = td.parentNode;
        var file = row._file;
        file.Cancel();
    }

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
</script>

</html>


