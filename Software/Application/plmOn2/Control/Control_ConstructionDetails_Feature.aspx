<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_ConstructionDetails_Feature.aspx.vb"
    Inherits="plmOnApp.Control_ConstructionDetails_Feature" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
      <wc1:Color_Wait ID="Color_Wait" runat="server" />
    <div>
        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10">
                    <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="500">
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnAddFeature" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()">
                    </cc1:ConfirmedImageButton>
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
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                        ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>
        <table cellspacing="2" cellpadding="0" width="100%" border="0">
            <tr>
                <td>
                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                </td>
                <td valign="top">
                    <table cellspacing="0" cellpadding="0" width="300" border="0" style="background-color: White">
                        <tr>
                            <td colspan="2">
                                <table cellspacing="0" cellpadding="0" runat="server" id="tblUpload">
                                    <tr>
                                        <td class="fontHead" valign="top" width="100">
                                            <asp:Label ID="lblNImageFile" runat="server"></asp:Label>:
                                        </td>
                                        <td class="font">
                                            <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <br />
                                <asp:Panel ID="pnlFileLocked" runat="server" Visible="False">
                                    <table cellspacing="0" cellpadding="1" width="100%" bgcolor="#ea0000" border="0">
                                        <tr>
                                            <td width="10">
                                                &nbsp;
                                            </td>
                                            <td width="20">
                                                <img height="16" src="../System/Icons/icon_lock.gif" width="16">
                                            </td>
                                            <td>
                                                &nbsp;
                                                <asp:Label ID="lblFileLocked" runat="server" ForeColor="White"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <br />
                                <cc1:ConfirmedImageButton ID="imgBtnEditImage" runat="server" Message="NONE" ToolTip="Edit Image File...">
                                </cc1:ConfirmedImageButton>
                                <cc1:ConfirmedImageButton ID="btnImageRemove" runat="server" ToolTip="Delete Image File..." />
                                <cc1:ConfirmedImageButton ID="btnUpdate" runat="server" Message="NONE" Visible="False">
                                </cc1:ConfirmedImageButton>
                                <cc1:ConfirmedImageButton ID="btnCancelUpdate" runat="server" Message="NONE" Visible="False">
                                </cc1:ConfirmedImageButton>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="font" width="50">
                                <br />
                                <cc1:BWImageButton ID="imgFeature" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>

    <script type="text/javascript" language="javascript">
        var frm = document.Form1;
        var iFlag = 0;
        function DisableMe(obj, i) {
            if (iFlag == 0) {
                obj.disabled = true;
            }
            iFlag = i;

        }
    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
