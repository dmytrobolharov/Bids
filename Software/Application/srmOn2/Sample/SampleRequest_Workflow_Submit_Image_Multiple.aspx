<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Image_Multiple.aspx.vb"
    Inherits="srmOnApp.SampleRequest_Workflow_Submit_Image_Multiple" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title runat="server" id="PageTitle"></title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

    <script language="javascript">
        function calendar(sTxtBoxName) {
            windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
            windowDatePicker.focus();
        }
    </script>

</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
             <cc1:ConfirmedImageButton runat="server" ID="btnSave" OnClick="btnSave_Click" OnClientClick="return btnSave_Click()" Visible="False"/>
                <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE" Visible="True" CausesValidation="False"></cc1:ConfirmedImageButton> 
                <img alt='' runat="server" id="Img1" style="display: none;" onclick="Upload_Click();return false;" /> 
                <asp:ImageButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" Visible="False"  />
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
            <td width="75">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="#E0E0E0"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlMulti" runat="server">
        <div>
          
            <CuteWebUI:UploadAttachments runat="server" ID="UploadAttachments1" ManualStartUpload="False" AutoUseSystemTempFolder="False"
                OnAttachmentAdded="UploadAttachments1_AttachmentAdded" OnAttachmentCreated="UploadAttachments1_AttachmentCreated" OnFileValidating="UploadAttachments1_FileValidating"
                NumFilesShowCancelAll="1000" TableHeaderTemplate="<td nowrap='nowrap'></td><td>Files</td><td>Description</td>" InsertButtonID="btnAdd">
                <ValidateOption AllowedFileExtensions="*"/>

                <ItemTemplate>
                    <table>
                        <tr valign="middle">
                            <td>
                                <asp:TextBox runat="server" ID="textboxDesc" TextMode="MultiLine" />
                            </td>
                           
                        </tr>
                    </table>
                </ItemTemplate>
            </CuteWebUI:UploadAttachments>
            <br />
     <%--       <table id='clientTable' style="display: none; font-size: 9pt; border-collapse: collapse"
                border="1" cellspacing="0" cellpadding="5">
                <tr>
                    <td>
                        <%#GetSystemText("FileName")%>
                    </td>
                    <td>
                        <%#GetSystemText("Status")%>
                    </td>
                </tr>
            </table>--%>
            <br />
          
            <br />
        </div>
    </asp:Panel>
    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
    </form>
</body>

<script type="text/javascript">
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
//            //row.insertCell(-1);
//            // row.insertCell(-1);
//            UpdateToRow(row, file);
//        }
////    }
//    function UpdateToRow(row, file) {
//        row._file = file;
//        row._filekey = file.InitGuid || file.FileName;
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
   // }

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
	<script type="text/javascript">
		function btnClose_Click() {
			<%= strExitScript %>
			return false;
		}
	</script>

</html>
