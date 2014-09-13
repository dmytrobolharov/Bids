<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Control_NBOL_Operation.ascx.vb" Inherits="plmOnApp.Control_NBOL_Operation" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<style type="text/css">    .TableHeader td.header_dots { width: 10px!important;}    .TableHeader td.header_buttons { width: 500px!important;}</style>

<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr>
        <td valign="middle" align="center" width="10" class="header_dots">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
        </td>
        <td width="500" class="header_buttons">
            <cc1:ConfirmedImageButton ID="btnSave" runat="Server" Message="NONE" OnClientClick="setEventTarget_SAVE()"></cc1:ConfirmedImageButton>
            <cc1:ConfirmedImageButton ID="btnDelete" runat="Server" OnClientClick="setEventTarget_DELETE()" Message='<%#GetSystemText("Are you sure you want to delete this operation?") %>' CausesValidation="false"></cc1:ConfirmedImageButton>
            <cc1:ConfirmedImageButton ID="btnClose" runat="Server" Message="NONE" OnClientClick="setEventTarget_CLOSE()" CausesValidation="false"></cc1:ConfirmedImageButton>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
<table height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="gray" border="0">
    <tr>
        <td width="10">
            &nbsp;
        </td>
        <td class="fontHead">
            <font color="white">
                <asp:Label ID="lblEditContact" runat="server"><%#GetSystemText("Edit Operation")%></asp:Label>
                <asp:Label ID="lblName" runat="server"></asp:Label>
            </font>
        </td>
    </tr>
</table>
<table cellspacing="1" cellpadding="1" cellpadding="0" width="100%" border="0">
    <tr>
        <td class="fontHead">
            <asp:PlaceHolder ID="plhOperationControlsHolder" runat="server"></asp:PlaceHolder>
        </td>
        <td valign="top">
            <table cellspacing="0" cellpadding="0" width="300" border="0" style="background-color: White">
                <tr>
                    <td class="fontHead" valign="top" width="100">
                        <asp:Label ID="lblImageFile" runat="server"></asp:Label>:
                    </td>
                    <td class="font">
                        <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="font" width="50">
                        <br />
                        <cc1:BWImageButton ID="imgFeature" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <cc1:ConfirmedImageButton ID="btnImageRemove" runat="server" OnClientClick="setEventTarget_ImgREMOVE()" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr height="40">
        <td></td>
    </tr>
</table>
<asp:HiddenField ID="hdnOperationID" runat="server"/>


<script language="javascript">

    function setEventTarget_SAVE() {
        document.getElementById("__EVENTTARGET").value = 'UC_btnSave';
    }

    function setEventTarget_DELETE() {
        document.getElementById("__EVENTTARGET").value = 'UC_btnDelete';
    }

    function setEventTarget_CLOSE() {
        document.getElementById("__EVENTTARGET").value = 'UC_btnClose';
    }

    function setEventTarget_ImgREMOVE() {
        document.getElementById("__EVENTTARGET").value = 'UC_btnImageRemove';
    }

</script>
