<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Marker_Edit.aspx.vb"
    Inherits="plmOnApp.Style.Marker.Style_Marker_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Style - Marker</title>
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
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()">
                    </cc1:ConfirmedImageButton>
                    <br />
                    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
                        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                        <tr>
                            <td>
                                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Large"
                                    ForeColor="#E0E0E0"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
                </td>
            </tr>
            <tr>
                <td>
                    <%-- <asp:PlaceHolder  runat ="server"  ID="plhControlsHolderEdit" ></asp:PlaceHolder>--%>
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
                        <asp:LinkButton ID="btndownload" runat="Server" OnClick="btndownload_Click" ></asp:LinkButton>
                    </td>
                </tr>
        </table>
    </div>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
