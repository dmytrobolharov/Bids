<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Image_Edit.aspx.vb" Inherits="plmOnApp.Image_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Image_User" Src="Image_User.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Image_WorkflowStatus" Src="Image_WorkflowStatus.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Image</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" / >
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/jqueryZoom.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <script type="text/javascript">
		<!--

        top.window.moveTo(0, 0);
        if (document.all) {
            top.window.resizeTo(screen.availWidth, screen.availHeight);
        }
        else if (document.layers || document.getElementById) {
            if (top.window.outerHeight < screen.availHeight || top.window.outerWidth < screen.availWidth) {
                top.window.outerHeight = screen.availHeight;
                top.window.outerWidth = screen.availWidth;
            }
        }
		//-->
    </script>
</head>
<body>
    <form id="Form1" method="post" enctype="multipart/form-data" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true">
        
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
        </StyleSheets>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadStyleSheetManager>
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />
    <!--

			-->
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnNew" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="imgBtnCopyImage" runat="server"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnPreview" runat="server" Message="NONE"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnCancelUpdate" runat="server" Message="NONE" Visible="False">
                </cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btn_createstyle" runat="server" Visible="False"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btn_creatematerial" runat="server" Visible="False"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnNewTask" runat="server" Message="NONE"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnNewIssue" runat="server" Message="NONE" CausesValidation="False">
                </cc1:BWImageButton>
                <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;">
                </cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee"
        border="0">
        <tr>
            <td>
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
                &nbsp;<asp:Label ID="lblImageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"><%= GetSystemText("Image Folder...")%></asp:Label>
            </td>
        </tr>
    </table>
    <uc1:Image_WorkflowStatus runat="server" ID="Image_WorkflowStatus1" />
    <table cellspacing="0" cellpadding="1" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="whitesmoke"
                    border="0">
                    <tr class="TableHeader">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td>
                            <cc1:ConfirmedImageButton ID="imgBtnFolderImage" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                            <cc1:ConfirmedImageButton ID="imgBtnEditImage" runat="server" Message="NONE" ToolTip="Edit Image File...">
                            </cc1:ConfirmedImageButton>
                            <asp:ImageButton ID="imgBtnUpload" runat="server" Visible="false"/>
                            <cc1:ConfirmedImageButton ID="btnUpdate" runat="server" Message="NONE" Visible="False">
                            </cc1:ConfirmedImageButton>
                            <cc1:BWImageButton ID="btnDelete" runat="server"></cc1:BWImageButton>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="pnlFileUpdateUpload" runat="server" Visible="false">
                    <div>  
                        <CuteWebUI:UploadAttachments runat="server" ID="UploadAttachmentsUpdate" ManualStartUpload="False" AutoUseSystemTempFolder="False"
                            InsertButtonID="imgBtnUpload" MultipleFilesUpload="false" MaxFilesLimit="1" ShowCheckBoxes="false" ShowFileIcons="false">
                        </CuteWebUI:UploadAttachments>
                        <br />
                    </div>
                </asp:Panel>
                <table class="MenuGroup" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td align="center">
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
                            <asp:panel id="pnlVersionUpdate" runat="server" Visible="False">
								<table borderColor="limegreen" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ccff99"
									border="1">
									<tr>
										<td class="fonthead" align="center"><br />
											<asp:label id="lblQryReplace_1" runat="server">Do you want to replace version #</asp:label>
											<asp:label id="lbVersionCurrent" runat="server"></asp:label><br />
											<asp:label id="lblQryReplace_2" runat="server">with this version #</asp:label>
											<asp:label id="lbVersionSelected" runat="server" ForeColor="Red"></asp:label>&nbsp;?<br />
											<br />
											<cc1:confirmedimagebutton id="btnReplaceYes" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
											<asp:imagebutton id="btnReplaceNo" runat="server" ></asp:imagebutton><br />
											<br />
											<p></p>
										</td>
									</tr>
								</table>
							</asp:panel>
                            <asp:Label ID="lblMessageFileNotFound" runat="server" ForeColor="#C00000"></asp:Label>
                            <table id="TB_Attach" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                                <tr bgcolor="#f4f4f4">
                                    <td width="50" height="50">
                                        <div align="center">
                                            <cc1:ConfirmedImageButton ID="imgBtnLinkImage" runat="server" ImageUrl="../System/Icons/icon_attachimage32.gif"
                                                ToolTip="Attach Image To Style..."></cc1:ConfirmedImageButton></div>
                                    </td>
                                    <td>
                                        &nbsp;
                                        <cc1:ConfirmedLinkButton ID="imgLnlLink" runat="server" CssClass="fonthead"></cc1:ConfirmedLinkButton>
                                    </td>
                                </tr>
                            </table>
                            <br>
                            <div class="zoom-left">
                            <asp:Image ID="imgDesign" runat="server" BorderColor="Transparent"></asp:Image>
                            </div>
                        </td>
                    </tr>
                </table>
                <br>
                <div align="center">
                    <asp:Label ID="lbCopyFrom" runat="server" ForeColor="#C00000"></asp:Label></div>
            </td>
            <td valign="top">
                <asp:Panel ID="pnlProperty" runat="server">
                    <table height="27" cellspacing="0" cellpadding="0" width="100%">
                        <tr class="TableHeader" bgcolor="whitesmoke" border="0">
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                            </td>
                            <td class="fonthead" width="150">
                                <asp:Label ID="lblImageProperty" runat="server">Image Property...</asp:Label>
                            </td>
                            <td align="left">
                                <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE" Visible="False"
                                    CausesValidation="False"></cc1:ConfirmedImageButton>
                                <img alt='' runat="server" id="Img1" style="display: none;" onclick="Upload_Click();return false;" />
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="pnlMulti" runat="server">
                        <div>
                            <CuteWebUI:UploadAttachments runat="server" ID="UploadAttachments1" ManualStartUpload="False"
                                AutoUseSystemTempFolder="False" OnAttachmentAdded="UploadAttachments1_AttachmentAdded"
                                OnAttachmentCreated="UploadAttachments1_AttachmentCreated" OnFileValidating="UploadAttachments1_FileValidating"
                                NumFilesShowCancelAll="1000" MaxFilesLimit="2" TableHeaderTemplate="<td nowrap='nowrap'></td><td>Files</td><td>Description</td>"
                                InsertButtonID="btnAdd">
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
                        </div>
                    </asp:Panel>
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
                                <input id="File1" type="file" name="file1" runat="server">&nbsp;<input id="btnImageUpload"
                                    type="submit" value="Upload" name="Upload" runat="server">
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
                <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
                <table cellspacing="0" cellpadding="1" width="100%" border="0">
                    <tr>
                        <td valign="top" bgcolor="#ffffff">
                            <asp:DataList ID="DataList1" runat="server" Width="100%" ShowHeader="False" ShowFooter="False"
                                RepeatDirection="Horizontal" RepeatColumns="3" EnableViewState="true" CellSpacing="0"
                                CellPadding="0" OnItemCommand="DataList1_ItemCommand">
                                <ItemTemplate>
                                    <table cellspacing="1" cellpadding="0" width="100%" border="0">
                                        <tr bgcolor="#ffffff">
                                            <td valign="middle" align="center">
                                                <cc1:ConfirmedImageButton ID="imgBtnImage" runat="server" Message='NONE' CommandName="Edit">
                                                </cc1:ConfirmedImageButton>
                                            </td>
                                        </tr>
                                        <tr bgcolor="#ffffff">
                                            <td class="font" valign="middle" align="center">
                                                <asp:Label ID="lblVersionH" runat="server"><%#GetSystemText("Version")%>:</asp:Label>
                                                <asp:Label ID="lblVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>' />
                                            </td>
                                        </tr>
                                        <tr bgcolor="#ffffff">
                                            <td class="font" valign="middle" align="center">
                                                <asp:Label ID="lblModified" runat="server"><%#GetSystemText("Last Modified")%>:</asp:Label>
                                                <%#Convert.ToDateTime(SystemHandler.GetLocalTime(DataBinder.Eval(Container.DataItem, "MDate"))).ToString(Me.GetFormatInfo.DateTimeLongFormat)%>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="TableHeader" width="100%">
                    <tr>
                        <td colspan="4">
                            <asp:PlaceHolder ID="pnlComment" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>
                <asp:DataList ID="dlCatalog" runat="server" Width="100%" ShowHeader="False" ShowFooter="False"
                    EnableViewState="true" CellSpacing="0" CellPadding="0">
                    <ItemTemplate>
                        <table height="27" cellspacing="0" cellpadding="0" width="100%">
                            <tr class="TableHeader" bgcolor="whitesmoke" border="0">
                                <td valign="middle" align="center" width="10">
                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                </td>
                                <td valign="middle" align="center" width="10">
                                    <cc1:BWImageButton ID="btnImageCatalog" runat="server" ImageUrl="../System/Icons/icon_openfolder.gif"
                                        ToolTip='<%#GetSystemText("Click here to view catalog") & "..." %>' WindowName="ImageCatalog"
                                        NavigateUrl='<%# Convert.ToString("Image_Catalog_Folder.aspx?IC=" &amp; DataBinder.Eval(Container.DataItem,"ImageCatalogID").ToString)%>'>
                                    </cc1:BWImageButton>
                                </td>
                                <td class="fonthead">
                                    <asp:Label ID="lblCatalogName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"CatalogName")%>'>
                                    </asp:Label>
                                </td>
                            </tr>
                        </table>
                        <asp:PlaceHolder ID="phTrade" runat="server"></asp:PlaceHolder>
                    </ItemTemplate>
                </asp:DataList>
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtURL" runat="server" Visible="False"></asp:TextBox></form>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        $("#imgDesign").elevateZoom();
    }); 
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
//    function CuteWebUI_AjaxUploader_OnSelect(files) {
//        var sames = [];
//        var items = uploader.getitems();
//        for (var i = 0; i < files.length; i++) {
//            var file = files[i];
//            //alert('file ' + file.FileName);
//            var exists = false;
//            for (var j = 0; j < items.length; j++) {
//                var item = items[j];
//                //alert('item ' + item.FileName);
//                if (item.FileName == file.FileName) {
//                    exists = true;
//                }
//            }
//            if (exists) {
//                sames.push(file.FileName);
//                file.Cancel();
//            }
//        }
//        if (sames.length > 0) {
//            alert("These file(s) are already in the queue : \r\n\t" + sames.join('\r\n\t'));
//        }
//    }
    function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
                    }

</script>

    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
</html>
