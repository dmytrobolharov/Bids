<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Edit.aspx.vb" Inherits="plmOnApp.Style_Edit" %>

<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title>Style</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../System/Jscript/System.js"></script>
    <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <div id="fixed_icons">
        <a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help"
            target="_blank" id="yHelp"></a>
    </div>
    <form id="Form1" method="post" runat="server">
    <br />
    <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
    <asp:Panel ID="Panel1" runat="server">
        <table class='<%=GetTableHeaderClass() %>' id="toolbar" cellspacing="0" cellpadding="0"
            width="100%" border="0">
            <tr>
                <td align="center" valign="middle" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSaveStyle" runat="server" Message="NONE" />
                    <cc1:BWImageButton ID="btnStyleSet" runat="server" Message="NONE" />
                    <cc1:BWImageButton ID="btnSamplesize" runat="server" Message="NONE" />
                    <cc1:BWImageButton ID="btnDrop" runat="server" CausesValidation="False" Message="NONE" Visible="False" />
                    <cc1:BWImageButton ID="btnNewTask" runat="server" Message="NONE" />
                    <cc1:BWImageButton ID="btnNewIssue" runat="server" CausesValidation="False" Message="NONE" />
                    <cc1:BWImageButton ID="btnDelete" runat="server" CausesValidation="False" Message="NONE" />
                    <cc1:confirmedimagebutton id="btnUnlockHeader" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                    <cc1:BWImageButton ID="btnStatus" runat="server" Visible="false" />
                    <cc1:BWImageButton ID="btnPrint" runat="server"></cc1:BWImageButton>
                    <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;" />
                </td>
            </tr>
        </table>
        <asp:PlaceHolder ID="pnlStyleChangeAlertPage" runat="server"></asp:PlaceHolder>
        <asp:PlaceHolder ID="pnlStyleIDAlertPage" runat="server"></asp:PlaceHolder>
        <table height="90%" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="top" bgcolor="#ffffff">
                    <!--
							<table cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr>
									<td>
										<DIV align="right">
											<asp:label id="lblStyleHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
												ForeColor="#E0E0E0">Edit Style...</asp:label></DIV>
									</td>
								</tr>
							</table>
							-->
                    <asp:Panel ID="pnlStyle" runat="server">
                        <br>
                        <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr valign="top">
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
                                </td>
                            </tr>
                        </table>
                        <br>
                        <asp:PlaceHolder ID="pnlStyleComments1" runat="server"></asp:PlaceHolder>
                    </asp:Panel>
                    <table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
                        border="0">
                        <tr valign="top">
                            <td width="33%">
                            </td>
                            <td width="33%">
                            </td>
                            <td width="33%">
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="10%" bgcolor="#f5f5f5">
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server" EnableViewState="TRUE">
        <table height="25" cellspacing="0" cellpadding="1" width="100%" border="0">
            <tr class='<%=GetTableHeaderClass() %>' bgcolor="whitesmoke">
                <td style="width: 11px" valign="middle" align="center" width="11">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td class="fonthead">
                    <%--<cc1:ConfirmedImageButton ID="imgBtnFolderImage" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="imgBtnEditImage" runat="server" Message="NONE" ToolTip="Edit Image File...">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnCreateNewImage" runat="server" Message="NONE"></cc1:ConfirmedImageButton>                    
                    <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE" Visible="False" CausesValidation="False"></cc1:ConfirmedImageButton>
                    <img alt='' runat="server" id="Img1" style="display: none;" onclick="Upload_Click();return false;" />
                    <cc1:ConfirmedImageButton ID="imgBtnImageSelect" runat="server" Message="NONE" CausesValidation="False">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnUpdate" runat="server" Message="NONE" Visible="False">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnCancelUpdate" runat="server" Message="NONE" Visible="False">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="imgBtnCopyImage" runat="server" DESIGNTIMEDRAGDROP="18">
                    </cc1:ConfirmedImageButton>--%>
                </td>
            </tr>
        </table>
        <uc1:Style_Header ID="Style_Header1" runat="server"></uc1:Style_Header>
        <br />
        <asp:PlaceHolder ID="pnlStyleComments2" runat="server"></asp:PlaceHolder>
        <asp:PlaceHolder ID="pnlDesignImage" runat="server">
        <asp:datalist id="DataList1" runat="server" Width="100%" OnItemCommand="DataList1_ItemCommand"
				OnItemDataBound="DataList1_ItemDataBound" DataKeyField="StyleDetailFormID" RepeatColumns="2"
				RepeatDirection="Horizontal" EnableViewState="True">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="White">
				</ItemStyle>
				<AlternatingItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="AliceBlue">
				</AlternatingItemStyle>	
				<ItemTemplate>
					<table style="border-color:silver" cellspacing="2" cellpadding="2" width="100%" border="0">
					   <tr>
					     <td>
					        <asp:label id="lblHeader" runat="server" CssClass="fontHead"></asp:label>
					     </td>
					     </tr>
						<tr>
							<td align="left" valign="top">							
					                  <cc1:bwimagebutton id="btnImageNew" runat="server" ></cc1:bwimagebutton>
					                  <cc1:bwimagebutton id="btnImageSelect" runat="server" ></cc1:bwimagebutton>	
								      <cc1:BWImageButton id="btnImageEdit" runat="server" CommandName="Window"></cc1:BWImageButton>
								</td>						
							<td valign="top" style="height:150;" rowspan="2">	
							  <input id="txtRecID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "Rec_Id") %>' runat="server" />						   							
								<input id="txtImageVersion" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageVersion") %>' runat="server" />
								<input id="txtImageID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server" />
							</td>						
						</tr>
						<tr>
							<td style=" height:150; width:350px">
								<cc1:BWImageButton id="btnImgNewWindow" runat="server" 
									CommandName="Window"></cc1:BWImageButton>
							</td>
						</tr>
					</table>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist>
        </asp:PlaceHolder>
        <%--<table style="width: 1000px; height: 360px" cellspacing="0" cellpadding="1" width="1000"
            border="0">
            <tr>
                <td id="tblImage" valign="top" runat="server">
                    <table height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="whitesmoke"
                        border="0">
                        <tr class="TableHeader">
                            <td style="width: 11px" valign="middle" align="center" width="11">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                            </td>
                            <td>
                                &nbsp;<asp:Label ID="lblImage" runat="server" CssClass="fontHead">Image...</asp:Label>
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
                                    <asp:Label ID="lbVersionCurrent" runat="server"></asp:Label><br>
                                    <br>
                                    <cc1:ConfirmedImageButton ID="btnReplaceYes" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                                    <asp:ImageButton ID="btnReplaceNo" runat="server"></asp:ImageButton><br>
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
                        <br>
                        <div align="center">
                            <asp:Label ID="lbCopyFrom" runat="server" ForeColor="#C00000"></asp:Label></div>
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
                                    <asp:Label ID="lblImageProperty" runat="server" CssClass="fontHead">Image Property...</asp:Label>
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
                                    &nbsp;<asp:Label ID="lblImageFile" runat="server" CssClass="fontHead">Image File</asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                    <input id="File1" type="file" name="file1" runat="server">&nbsp;<input id="btnImageUpload"
                                        type="submit" value="Upload" name="Upload" runat="server">
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:PlaceHolder ID="plhImageControlHolder" runat="server" EnableViewState="FALSE">
                    </asp:PlaceHolder>
                    <br>
                    <table height="25" cellspacing="0" cellpadding="1" width="100%" border="0">
                        <tr class="TableHeader" bgcolor="whitesmoke">
                            <td width="10">
                                &nbsp;
                            </td>
                            <td class="fonthead">
                                <asp:Label ID="lblImageHistory" runat="server" CssClass="fontHead">Image History...</asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table cellspacing="0" cellpadding="1" width="100%" border="0">
                        <tr>
                            <td valign="top">
                                <asp:DataList ID="dlImageHistory" runat="server" EnableViewState="true" ShowHeader="False"
                                    ShowFooter="False" CellSpacing="0" CellPadding="0" RepeatDirection="Horizontal"
                                    RepeatColumns="3" OnItemCommand="dlImageHistory_ItemCommand">
                                    <ItemTemplate>
                                        <table cellspacing="0" cellpadding="1" width="125" border='<%# SelectHTMLImageCurrentVersion(DataBinder.Eval(Container.DataItem,"Version")) %>'
                                            bordercolor="CornflowerBlue">
                                            <tr bgcolor="#ffffff">
                                                <td valign="middle" align="center">
                                                    <cc1:ConfirmedImageButton ID="imgBtnImage" Enabled='<%# ModifyStyleAccess() %>' runat="server"
                                                        Message='NONE' CommandName="Edit"></cc1:ConfirmedImageButton>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#ffffff">
                                                <td class="font" valign="middle" align="center">
                                                    <%#GetSystemText("Version")%>:
                                                    <asp:Label ID="lblVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Version")%>' />
                                                </td>
                                            </tr>
                                            <tr bgcolor="#ffffff">
                                                <td class="font" valign="middle" align="center">
                                                    <%#GetSystemText("Last Modified")%>:<%#Convert.ToDateTime(SystemHandler.GetLocalTime(DataBinder.Eval(Container.DataItem, "ImageDateLastModified"))).ToString(Me.GetFormatInfo.DateTimeShortFormat)%></td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>--%>
        <table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
            border="0">
            <tr valign="top">
                <td width="33%">
                </td>
                <td width="33%">
                </td>
                <td width="33%">
                </td>
            </tr>
        </table>
        <p>
            &nbsp;</p>
    </asp:Panel>
    <asp:Panel ID="tabsPanel" runat="server">
        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" alt="" width="3" />
                </td>
                <td height="24">
                    <cc1:ConfirmedImageButton ID="btnSaveTabDetails" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                </td>
            </tr>
        </table>
        <uc1:Style_Header ID="Style_header5" runat="server"></uc1:Style_Header>
        <uc1:Style_Comment ID="styleTabComments" runat="server" />
        <asp:PlaceHolder ID="plhTabControlsHolder" runat="server"></asp:PlaceHolder>
    </asp:Panel>
    <%--<asp:Panel ID="pnlMulti" runat="server">
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
            <br />
        </div>
    </asp:Panel>--%>
    </form>
</body>
<%--<script type="text/javascript">

    var uploader = document.getElementById('<%=UploadAttachments1.ClientID %>');
    var btnSave = document.getElementById('<%=btnCreateNewImage.ClientID %>');
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
            //alert('file ' + file.FileName);
            var exists = false;
            for (var j = 0; j < items.length; j++) {
                var item = items[j];
                //alert('item ' + item.FileName);
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
</script>--%>
</html>
