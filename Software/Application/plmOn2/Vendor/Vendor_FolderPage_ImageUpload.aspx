<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_FolderPage_ImageUpload.aspx.vb" Inherits="plmOnApp.Vendor_FolderPage_ImageUpload" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server" id="pgTitle">Infrastructure</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
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
                 <cc1:ConfirmedImageButton runat="server" ID="btnSave" OnClick="btnSave_Click" Message="NONE" OnClientClick="return btnSave_Click()" Visible="False"/>
                    <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE" Visible="True" CausesValidation="False"></cc1:ConfirmedImageButton> 
                    <img alt='' runat="server" id="Img1" style="display: none;" onclick="Upload_Click();return false;" /> 
                    <asp:ImageButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" Visible="False"  />
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
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
                <br />
          
                <br />
            </div>
        </asp:Panel>
        <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
    </form>
</body>

<script type="text/javascript">
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
