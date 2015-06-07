<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_POMTemplate_Image.aspx.vb"
    Inherits="plmOnApp.Control_POMTemplate_Image" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Material Image</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" enctype="multipart/form-data" runat="server">
    <!--

			-->
    <table height="25" cellspacing="0" cellpadding="1" width="100%" border="0">
        <tr class="TableHeader" bgcolor="whitesmoke">
            <td style="width: 11px" valign="middle" align="center" width="11">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td class="fonthead">
                <cc1:ConfirmedImageButton ID="imgBtnFolderImage" runat="server" 
                    ToolTip="Edit Image ..."></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="imgBtnEditImage"
                        runat="server"  ToolTip="Edit Image File...">
                    </cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="btnSaveForm" runat="server"
                         Message="NONE"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton
                            ID="btnCreateNewImage" runat="server" 
                            Message="Are you sure you want to create new image?"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton
                                ID="imgBtnImageSelect" runat="server" 
                                Message="Are you sure you want to create new image?"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton
                                    ID="btnUpdate" runat="server" 
                                    Message="Are you sure you want to update it?" Visible="False">
                </cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="btnCancelUpdate" runat="server"
                     Message="Are you sure you want to cancel update?"
                    Visible="False"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="imgBtnCopyImage"
                        runat="server"  ToolTip="Copy Image From..."
                        DESIGNTIMEDRAGDROP="18"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="imgBtnDeleteImage"
                            runat="server"  ToolTip="Remove Image ..."
                            Message="Do you want to remove this image?"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton
                                ID="btnClose" runat="server"  Message="Are you sure you want to do close this form?" OnClientClick="return btnClose_Click()">
                            </cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <asp:PlaceHolder ID="plhHeaderControl" runat="server"></asp:PlaceHolder>
    <br>
    <table cellspacing="0" cellpadding="1" width="1000" border="0" style="width: 1000px;
        height: 360px">
        <tr>
            <td id="tblImage" valign="top" width="20%" runat="server">
                <table height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="whitesmoke"
                    border="0">
                    <tr class="TableHeader">
                        <td style="width: 11px" valign="middle" align="center" width="11">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td>
                            &nbsp;<asp:Label ID="lblImage" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
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
                <asp:Panel ID="pnlVersionUpdate" runat="server" Visible="False">
                    <table bordercolor="limegreen" cellspacing="0" cellpadding="0" width="100%" bgcolor="white"
                        border="1">
                        <tr>
                            <td class="fonthead" align="center">
                                <br>
                                <asp:Label ID="lblVersionText" runat="server"></asp:Label>
                                <asp:Label ID="lbVersionCurrent" runat="server"></asp:Label><br>
                                <asp:Label ID="lblVersionText2" runat="server" ></asp:Label>
                                <asp:Label ID="lbVersionSelected" runat="server" ForeColor="Red"></asp:Label>&nbsp;?<br>
                                <br>
                                <cc1:ConfirmedImageButton ID="btnReplaceYes" runat="server" 
                                    Message="Are you sure you want to cancel update?"></cc1:ConfirmedImageButton>
                                <asp:ImageButton ID="btnReplaceNo" runat="server" >
                                </asp:ImageButton><br>
                                <br>
                                <p>
                                </p>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnlCurrentImage" runat="server" HorizontalAlign="Center">
                    <asp:Label ID="lblMessageFileNotFound" runat="server" ForeColor="#C00000"></asp:Label>
                    <asp:Image ID="imgDesign" runat="server" BorderColor="Transparent"></asp:Image>
                    <table cellspacing="1" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td width="15">
                                &nbsp;
                            </td>
                            <td class="fontHead" width="125">
                                &nbsp;<asp:Label ID="lblCreatedBy" runat="server"></asp:Label>
                            </td>
                            <td class="font">
                                &nbsp;
                                <asp:Label ID="lbCUser" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="15">
                                &nbsp;
                            </td>
                            <td class="fontHead" width="125">
                                &nbsp;<asp:Label ID="lblCreatedDated" runat="server"></asp:Label>
                            </td>
                            <td class="font">
                                &nbsp;
                                <asp:Label ID="lbCDate" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="15">
                                &nbsp;
                            </td>
                            <td class="fontHead" width="125">
                                &nbsp;<asp:Label ID="lblModifiedBy" runat="server"></asp:Label>
                            </td>
                            <td class="font">
                                &nbsp;
                                <asp:Label ID="lbMUser" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td width="15">
                                &nbsp;
                            </td>
                            <td class="fontHead" width="125">
                                &nbsp;<asp:Label ID="lblModifiedDate" runat="server"></asp:Label>
                            </td>
                            <td class="font">
                                &nbsp;
                                <asp:Label ID="lbMDate" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td valign="top">
                <asp:Panel ID="pnlProperty" runat="server">
                    <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr class="TableHeader" bgcolor="whitesmoke">
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                            </td>
                            <td class="fonthead">
                                <asp:Label ID="lblImageFolder" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnlUpload" runat="server" Visible="false">
                    <table height="75" cellspacing="0" cellpadding="1" width="100%" border="0">
                        <tr bgcolor="#ffffff">
                            <td style="width: 15px" width="16">
                                &nbsp;
                            </td>
                            <td class="fontHead" width="125">
                                &nbsp;<asp:Label ID="lblImageFile" runat="server"></asp:Label>
                            </td>
                            
                            <td>
                                &nbsp;
                                <input id="File1" type="file" name="file1" runat="server"/>&nbsp;<input id="Submit1"
                                    type="submit"  name="Upload" value="Upload" runat="server"/>
                                <asp:RequiredFieldValidator ID="rvImageUpload" runat="server" CssClass="fontHead"
                                     Display="Dynamic" ControlToValidate="File1"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                <br />
                <table height="25" cellspacing="0" cellpadding="1" width="100%" border="0">
                    <tr class="TableHeader" bgcolor="whitesmoke">
                        <td width="10">
                            &nbsp;
                        </td>
                        <td class="fonthead">
                            <asp:Label ID="lblImageHistory" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="1" width="100%" border="0">
                    <tr>
                        <td valign="top">
                            <asp:DataList ID="DataList1" runat="server" ShowHeader="False" ShowFooter="False"
                                RepeatDirection="Horizontal" RepeatColumns="3" EnableViewState="true" CellSpacing="0"
                                CellPadding="0" OnItemCommand="DataList1_ItemCommand">
                                <ItemTemplate>
                                    <table cellspacing="0" cellpadding="1" width="125" border='<%# SelectHTMLImageCurrentVersion(DataBinder.Eval(Container.DataItem,"Version")) %>'
                                        bordercolor="CornflowerBlue">
                                        <tr bgcolor="#ffffff">
                                            <td valign="middle" align="center">
                                                <cc1:ConfirmedImageButton ID="imgBtnImage" runat="server" ImageUrl='<%# string.Concat("../Image/Image_Thumbnail.aspx?S=100&amp;Path=" &amp; Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("STORAGE"))("IMAGETHUMBPATH")&amp; "\{" &amp; DataBinder.Eval(Container.DataItem,"ImageID").tostring &amp; "}\Version\000\{" &amp; DataBinder.Eval(Container.DataItem,"ImageHistoryID").tostring &amp; "}.jpg") %>'
                                                    Message=' <%# string.Format(GetSystemText("Do you want to view version {0}?"), DataBinder.Eval(Container.DataItem,"Version").tostring) %>'
                                                    CommandName="Edit"></cc1:ConfirmedImageButton>
                                            </td>
                                        </tr>
                                        <tr bgcolor="#ffffff">
                                            <td class="font" valign="middle" align="center">
                                                <asp:Label ID="lblCurrVersion" runat="server"> <%#GetSystemText("Version")%>:</asp:Label>
                                                <asp:Label ID="lblVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>' />
                                            </td>
                                        </tr>
                                        <tr bgcolor="#ffffff">
                                            <td class="font" valign="middle" align="center">
                                                <asp:Label ID="lblLastModified" runat="server"><%#GetSystemText("Last Modified")%>:</asp:Label><%#SystemHandler.GetLocalTime(DataBinder.Eval(Container.DataItem, "ImageDateLastModified"))%>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <p>
        &nbsp;</p>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
