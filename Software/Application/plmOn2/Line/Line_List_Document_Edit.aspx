<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Document_Edit.aspx.vb" Inherits="plmOnApp.Line_List_Document_Edit"%>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Attachments</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
     <form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>	 <cc1:bwimagebutton id="btnMultiUploadWin" runat="server" ></cc1:bwimagebutton>
                             <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td vAlign="middle">&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="gray" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Attachments</asp:label></td>
				</tr>
			</table>			
			<TABLE class="TableHeader" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR class="fontHead">
					<TD align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD class="fontHead" width="50">
						<DIV align="right"><asp:Label ID="lblSearch" runat="server" Text="Search:"></asp:Label></DIV>
					</TD>
					<TD width="75"><asp:textbox id="txtSearch" runat="server" CssClass="font"></asp:textbox></TD>
					<TD width="10"><asp:imagebutton id="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif"></asp:imagebutton></TD>
					<TD>
						<DIV align="left">&nbsp;
							<asp:label id="lblPageSize" Runat="server" Visible="False" Text="24"></asp:label></DIV>
					</TD>
					<TD width="20">
						<DIV align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></DIV>
					</TD>
					<TD width="20">
						<DIV align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></DIV>
					</TD>
					<TD width="150">
						<DIV align="center"><asp:label id="lblCounts" CssClass="plaintable" Runat="server"></asp:label></DIV>
					</TD>
					<TD width="20">
						<DIV align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></DIV>
					</TD>
					<TD width="20">
						<DIV align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></DIV>
					</TD>
					<TD>
						<DIV align="left"><B><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;<asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label></B></DIV>
						</B></TD>
				</TR>
			</TABLE>
			<asp:panel id="pnlNew" runat="server">
				<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD width="500">
							<cc1:confirmedimagebutton id="btnAdd" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnAddClose" runat="server"  Message="NONE"  CausesValidation="False"></cc1:confirmedimagebutton>
						</TD>
						<TD>&nbsp;</TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="whitesmoke" border="0">
					<TR>
						<TD vAlign="top" width="400">
							<TABLE cellSpacing="0" cellPadding="0" width="400" border="0">
								<TR>
									<TD width="10">&nbsp;</TD>
									<TD class="fontHead" vAlign="top" width="100"><asp:Label ID="lblFileDescription" runat="server" Text="File Description:"></asp:Label></TD>
									<TD class="font">
										<asp:TextBox id="txtNewFileDescription" runat="server" Rows="5" TextMode="MultiLine" Wrap="false"
											Columns="50" Width="250"></asp:TextBox></TD>
								</TR>
							</TABLE>
						</TD>
						<TD vAlign="top">
							<TABLE cellSpacing="0" cellPadding="0" width="400" border="0">
								<TR>
									<TD width="10">&nbsp;</TD>
									<TD class="fontHead" vAlign="top" width="100"><asp:Label ID="lblFileUpload" runat="server" Text="File Upload:"></asp:Label></TD>
									<TD class="font"><INPUT class="font" id="txtNewLineListDocumentPath" type="file" name="txtLineListDocumentPath"
											runat="server">
										<asp:RequiredFieldValidator id="rvNewFileRquired" runat="server" CssClass="fontHead" ControlToValidate="txtNewLineListDocumentPath"
											Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator></TD>
								</TR>
								<TR>
									<TD width="10" height="35">&nbsp;</TD>
<%--									<TD class="fontHead" colSpan="2" height="35">&nbsp;&nbsp;
										<asp:CheckBox id="cbSharedNew" runat="server" ForeColor="Red"></asp:CheckBox></TD>--%>
								</TR>
							</TABLE>
						</TD>
						<TD></TD>
					</TR>
				</TABLE>
			</asp:panel>
			<%--<asp:Panel ID="pnlMulti" runat="server">
        <div>
            <button id='btnUpload' style="display: none;" onclick="Upload_Click();return false;">
                Start Upload</button>
                
            <CuteWebUI:UploadAttachments runat="server" ID="UploadAttachments1" ManualStartUpload="True"
                OnAttachmentAdded="UploadAttachments1_AttachmentAdded" OnAttachmentCreated="UploadAttachments1_AttachmentCreated"
                NumFilesShowCancelAll="1000" InsertText="Add files" TableHeaderTemplate="<td nowrap='nowrap'></td><td>Files</td><td>Description</td>">
                <ItemTemplate>
                    <table>
                        <tr valign="middle">
                            <td>
                                <asp:TextBox runat="server" ID="textboxDesc" TextMode="MultiLine" />
                            </td>
                            <td>
                                <asp:CheckBox ID="cbSharedNew" runat="server" Text="Share with Agent" ForeColor="Red" Font-Size="XX-Small" />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </CuteWebUI:UploadAttachments>
            <br />
            <table id='clientTable' style="display: none; font-size: 9pt; border-collapse: collapse"
                border="1" cellspacing="0" cellpadding="5">
                <tr>
                    <td>
                        <%#GetSystemText("FileName")%>
                    </td>
                    <td>
                       <%#GetSystemText("Status")%>
                    </td>
 
                </tr>
            </table>
            <br />
            <asp:Button ID="ButtonDeleteAll" runat="server" Text="Delete All" OnClick="ButtonDeleteAll_Click"
                Visible="False" />&nbsp;&nbsp;
            <asp:Button runat="server" ID="buttonTell" Text="Save All" OnClick="buttonTell_Click"
                OnClientClick="return buttonTell_Click()" Visible="False" />
            <br />
           
        </div>
    </asp:Panel>--%>
        <table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
			<asp:datalist id="DataList1" runat="server" Width="100%" OnDeleteCommand="DataList_DeleteCommand"
				OnCancelCommand="DataList_CancelCommand" OnUpdateCommand="DataList_UpdateCommand" OnEditCommand="DataList_EditCommand"
				DataKeyField="LineListDocumentID" BackColor="White" BorderColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1px">
				<HeaderTemplate>
						<tr class="Toolbar">
							<td class="fontHead" width="27" height="20">&nbsp;</td>
							<td class="fontHead" width="200"><%=GetSystemText("File Name")%></td>
							<td class="fontHead" width="200"><%=GetSystemText("File Description")%></td>
							<td class="fontHead" width="100"><%=GetSystemText("File Size")%></td>
<%--							<td class="fontHead" width="100"><%=GetSystemText("File Shared")%></td>--%>
                            <td class="fontHead" width="100"><%= GetSystemText("File Created By")%></td>
                            <td class="fontHead" width="125"><%= GetSystemText("File Created Date")%></td>
							<td class="fontHead">&nbsp;</td>
						</tr>
				</HeaderTemplate>
				<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
				<FooterTemplate>
				</FooterTemplate>
				<ItemStyle BackColor="White"></ItemStyle>
				<ItemTemplate>
						<TR>
							<TD width="20" height="20">
								<asp:linkbutton id="btnAttEdit" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'
									CommandName="edit" ></asp:linkbutton></TD>
							<TD class="font" width="200"><%# Container.DataItem("LineListDocumentName")%></TD>
							<TD class="font" width="200"><%# Container.DataItem("LineListDocumentDescription").Replace(vbCrLf, "<BR>").ToString%></TD>
							<TD class="font" width="100"><%# Container.DataItem("LineListDocumentSize")%></TD>
<%--							<TD class="font" width="100"><%#GetCheckBoxValueDefault(Container.DataItem("MaterialDocumentShared"))%></TD>--%>
                            <TD class="font" width="100"><%# Container.DataItem("CUser").ToString%></TD>
                            <TD class="font" width="125"><%# Convert.ToDateTime(Container.DataItem("CDate")).ToString(Me.GetFormatInfo.DateTimeLongFormat)%></TD>
							<TD class="font">&nbsp;</TD>
						</TR>
				</ItemTemplate>
				<EditItemTemplate>
                    <tr><td colspan="6">
					<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
						<TR>
							<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<TD width="500">
								<cc1:confirmedimagebutton id="edit_btnSave" runat="server"  Message="NONE" Visible='<%# ShowHideSaveBtn() %>' CommandName="update"></cc1:confirmedimagebutton>								
								<cc1:ConfirmedLinkButton id="edit_btnDelete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this file?")%>'  CommandName="delete" NAME="edit_btnDelete" Visible='<%# ShowHideDeleteBtn() %>' ></cc1:ConfirmedLinkButton>
								<asp:linkbutton id="btnDownload" runat="Server" CommandName="download" OnClientClick="dont_show_wait_twice();" ></asp:linkbutton>
								<cc1:confirmedimagebutton id="btnEditCancel" runat="server" Message="NONE" CommandName="cancel"></cc1:confirmedimagebutton>															
							</TD>
							<TD>&nbsp;</TD>
						</TR>
					</TABLE>
					<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="whitesmoke" border="0">
						<TR>
							<TD vAlign="top" width="400">
								<TABLE cellSpacing="0" cellPadding="0" width="400" border="0">
									<TR>
										<TD style="HEIGHT: 22px" width="10">&nbsp;</TD>
										<TD class="fontHead" width="100"><%=GetSystemText("File Name")%>:</TD>
										<TD class="font">
											<asp:Label id=lblFileName runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "LineListDocumentName").ToString  %>'>
											</asp:Label>
                                            <asp:HiddenField runat="server" ID="hdnlblFileName" Value='<%# DataBinder.Eval(Container.DataItem, "LineListDocumentName").ToString  %>' />
                                            </TD>
									</TR>
									<TR>
										<TD width="10">&nbsp;</TD>
										<TD class="fontHead" vAlign="top" width="100"><BR>
											<%=GetSystemText("File Description")%>:</TD>
										<TD class="font">
											<asp:TextBox id=txtFileDescription runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "LineListDocumentDescription").ToString  %>' Width="250" Columns="50" Wrap="false" ToolTip='<%#GetSystemText("Enter file description here") & "..."%>' TextMode="MultiLine" Rows="5">
											</asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hdnFileDescription" Value='<%# DataBinder.Eval(Container.DataItem, "LineListDocumentDescription").ToString  %>' />
                                            </TD>
									</TR>
								</TABLE>
							</TD>
							<TD vAlign="top">
								<TABLE cellSpacing="0" cellPadding="0" width="400" border="0">
									<TR>
										<TD width="10">&nbsp;</TD>
										<TD class="fontHead" vAlign="top" width="100"><%=GetSystemText("Upload File")%>:</TD>
										<TD class="font"><INPUT class="font" id="txtImagePath" type="file" runat="server" NAME="txtImagePath"></TD>
									</TR>
									<TR>
										<TD width="10">&nbsp;</TD>
										<TD class="fontHead" vAlign="top" width="100"><%=GetSystemText("File Size")%>:</TD>
										<TD class="font">
											<asp:Label id=lblFileSize runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "LineListDocumentSize").ToString  %>'>
											</asp:Label></TD>
									</TR>
									<TR>
										<TD width="10" height="35">&nbsp;</TD>
<%--										<TD class="fontHead" colSpan="2" height="35">&nbsp;&nbsp;
											<asp:CheckBox id=cbFileShared runat="server" ForeColor="Red" Text="<%# GetCheckBoxTextDefault() %>" Checked='<%# GetCheckBoxBooleanDefault(DataBinder.Eval(Container.DataItem, "MaterialDocumentShared").ToString)  %>'>
											</asp:CheckBox>
                                            <asp:HiddenField runat="server" ID="hdnFileShared" Value='<%# GetCheckBoxBooleanDefault(DataBinder.Eval(Container.DataItem, "MaterialDocumentShared").ToString) %>' />
                                            </TD>--%>
									</TR>
								</TABLE>
							</TD>
							<TD></TD>
						</TR>
					</TABLE>
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="whitesmoke" border="0">
						<TR>
							<TD width="20">&nbsp;</TD>
							<TD class="font" width="100"><%=GetSystemText("Created By")%>:</TD>
							<TD class="font">
								<asp:Label id=lblCData runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("CDate")).ToString %>'>
								</asp:Label></TD>
						</TR>
						<TR>
							<TD width="20" bgColor="whitesmoke">&nbsp;</TD>
							<TD class="font" width="100"><%=GetSystemText("Modified By")%>:</TD>
							<TD class="font">
								<asp:Label id=lblMData runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("MDate")).ToString %>'>
								</asp:Label></TD>
						</TR>
					</TABLE>
                    </td></tr>
				</EditItemTemplate>
			</asp:datalist>
        </table>
        </form>
		<SCRIPT language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		</SCRIPT>
	</body>
<%--	<script type="text/javascript">
	    var btnUpload = document.getElementById("btnUpload");
	    var clientTable = document.getElementById("clientTable");
	    var uploader = document.getElementById('<%=UploadAttachments1.ClientID %>');
	    var buttonTell = document.getElementById('<%=buttonTell.ClientID %>');
	    var buttonTellClicked = false;

	    function Upload_Click() {
	        uploader.startupload();

	    }

	    function buttonTell_Click() {
	        buttonTellClicked = true;
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
	        if (buttonTellClicked) {
	            buttonTell.click();
	            return false;
	        }


	    }


	    function CuteWebUI_AjaxUploader_OnQueueUI(files) {
	        btnUpload.style.display = files.length > 0 ? "" : "none";

	        clientTable.style.display = files.length > 0 ? "" : "none";

	        ShowMyClientTable(files);

	        return false;
	    }

	    function ShowMyClientTable(files) {
	        var map = {}
	        var newlist = [];
	        for (var i = 1; i < clientTable.rows.length; i++) {
	            var row = clientTable.rows.item(i);
	            row._scan = false;
	            map[row._filekey] = row;
	        }
	        //update existing row
	        for (var i = 0; i < files.length; i++) {
	            var file = files[i];
	            var row = map[file.InitGuid || file.FileName];
	            if (row == null) {
	                newlist.push(file);
	                continue;
	            }
	            row._scan = true;
	            UpdateToRow(row, file);
	        }
	        //delete removed row
	        for (var i = 1; i < clientTable.rows.length; i++) {
	            var row = clientTable.rows.item(i);
	            if (!row._scan) {
	                clientTable.deleteRow(i);
	                i--;
	            }
	        }
	        //add new row:
	        for (var i = 0; i < newlist.length; i++) {
	            var file = newlist[i];
	            var row = clientTable.insertRow(-1);
	            row.insertCell(-1);
	            row.insertCell(-1);
	            //row.insertCell(-1);
	            // row.insertCell(-1);
	            UpdateToRow(row, file);
	        }
	    }
	    function UpdateToRow(row, file) {
	        row._file = file;

	        row._filekey = file.InitGuid || file.FileName;


	        row.cells.item(0).innerHTML = file.FileName;



	        switch (file.Status) {
	            case "Queue":
	                row.cells.item(1).innerHTML = "<a href='#' onclick='CancelQueueItem(this);return false'>remove</a>";
	                break;
	            case "Finish": //uploaded
	            case "Upload": //uploading
	            case "Error": //cancelled
	            default:
	                row.cells.item(1).innerHTML = file.Status;
	                break;

	        }

	    }

	    function CancelQueueItem(link) {
	        var td = link.parentNode;
	        var row = td.parentNode;
	        var file = row._file;
	        file.Cancel();
	    }




</script>

<script type="text/javascript">
    //prevent duplicated items
    function CuteWebUI_AjaxUploader_OnSelect(files) {
        var sames = [];
        var items = uploader.getitems();
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            var exists = false;
            for (var j = 0; j < items.length; j++) {
                var item = items[j];
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
</HTML>
