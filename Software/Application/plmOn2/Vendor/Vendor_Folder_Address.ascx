<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Vendor_Folder_Address.ascx.vb" Inherits="plmOnApp.Vendor_Folder_Address" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr>
        <td valign="middle" align="center" width="10">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
        </td>
        <td width="500">
            <cc1:ConfirmedImageButton ID="btnSave" runat="Server" Message="NONE" OnClientClick="setEventTarget_SAVE()"></cc1:ConfirmedImageButton>
            <cc1:ConfirmedImageButton ID="btnDelete" runat="Server" OnClientClick="setEventTarget_DELETE()" Message='<%#GetSystemText("Are you sure you want to delete this address?") %>' CausesValidation="false"></cc1:ConfirmedImageButton>
            <cc1:ConfirmedImageButton ID="btnClose" runat="Server" Message="NONE" CausesValidation="false"></cc1:ConfirmedImageButton>
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
            <font color="white"><asp:Label ID="lblEditAddress" runat="server"><%#GetSystemText("Edit Address")%>:</asp:Label>
                <asp:Label ID="lblContactName" runat="server">
                </asp:Label></font>
        </td>
    </tr>
</table>
<table cellspacing="1" cellpadding="1" cellpadding="0" width="100%" border="0">
    <tr>
        <td>
            <asp:PlaceHolder ID="plhAddressControlsHolder" runat="server"></asp:PlaceHolder>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdnAddressID" runat="server"/>


<script language="javascript">

    function setEventTarget_SAVE() {
        document.getElementById("__EVENTTARGET").value = 'UC_btnSave';
    }

    function setEventTarget_DELETE() {
        document.getElementById("__EVENTTARGET").value = 'UC_btnDelete';
    }


</script>
