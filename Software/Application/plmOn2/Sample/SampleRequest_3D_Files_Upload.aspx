<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_3D_Files_Upload.aspx.vb" Inherits="plmOnApp.SampleRequest_3D_Files_Upload" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Attachments</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
  <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
       
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <asp:ImageButton runat="server" ID="btnSave" Visible="False" />
                <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE" Visible="True" CausesValidation="False"></cc1:ConfirmedImageButton> 
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" Visible="True" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>                
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td valign="middle"><asp:Label ID="lblHeader" runat="server" ForeColor="#999999" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Attachments</asp:Label></td>
        </tr>
    </table>
     <asp:Panel ID="pnlMulti" runat="server">
        <div>
            <CuteWebUI:UploadAttachments runat="server" ID="UploadAttachments1" ManualStartUpload="False" DialogFilter="Supported 3D Files|*.obj;*.stl;*.zip" 
                OnAttachmentAdded="UploadAttachments1_AttachmentAdded" OnAttachmentCreated="UploadAttachments1_AttachmentCreated" OnFileValidating="UploadAttachments1_FileValidating"
                NumFilesShowCancelAll="1000" TableHeaderTemplate="<td nowrap='nowrap'></td><td>Files</td><td>Description</td>" InsertButtonID="btnAdd">
                <ValidateOption AllowedFileExtensions=".obj, .stl, .zip" />
                <ItemTemplate>
                    <table> 
                        <tr valign="middle">
                            <td><asp:TextBox runat="server" ID="textboxDesc" TextMode="MultiLine" /></td>
                            <td><asp:CheckBox ID="cbSharedNew" runat="server" Text="Share with Agent" ForeColor="Red" Font-Size="XX-Small" /></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </CuteWebUI:UploadAttachments>
        </div>
    </asp:Panel>
    </form>
</body>
<script type="text/javascript">
    function btnClose_Click() {
        <%= strExitScript %>
        return false;
    }
</script>
</html>

