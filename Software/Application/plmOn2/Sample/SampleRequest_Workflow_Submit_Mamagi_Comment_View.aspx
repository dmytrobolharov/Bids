<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Mamagi_Comment_View.aspx.vb"
    Inherits="plmOnApp.SampleRequest_Workflow_Submit_Mamagi_Comment_View" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Comment</title>
</head>
<body>
    <form id="form1" runat="server" method="post">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:confirmedimagebutton ImageUrl="../System/Button/EN-US/btn_delete.gif" id="btnDelete" runat="server" Message="Are you sure you want to remove this photo?"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton ImageUrl="../System/Button/EN-US/btn_close.gif" id="btnClose" runat="server" message="NONE"></cc1:confirmedimagebutton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <div>
        <asp:Image ID="commentImage" runat="server" />
    </div>
    </form>
</body>
</html>
