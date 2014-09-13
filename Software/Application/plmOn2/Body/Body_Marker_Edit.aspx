<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_Marker_Edit.aspx.vb"
    Inherits="plmOnApp.Body_Marker_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Body - Marker</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%"
            border="0" runat="server">
            <tr>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" >
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" CausesValidation="false" runat="server" Message="NONE" >
                    </cc1:ConfirmedImageButton>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:PlaceHolder runat="server" ID="plhControlsHolder"></asp:PlaceHolder>
                </td>
            </tr>
            <!--Marker Piece Views -->
            <tr>
                <td>
                    <!-- IMAGE -->
                    <asp:Image ID="imgMarker" runat="server" Visible="False" />
                    <input id="imageSize" type="hidden" runat="server" />
                    <%-- <cc2:YSTabView ID="YSTabView2" runat="server"></cc2:YSTabView>--%>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="btndownload" runat="Server" OnClick="btndownload_Click"></asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
