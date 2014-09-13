<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Document.aspx.vb" Inherits="srmOnApp.Style_Document" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Style Documents</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		   <table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" 
                height="25" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:BWImageButton id="btnRemove" runat="server" ></cc1:BWImageButton>
						
						 <cc1:bwimagebutton id="btnMultiUploadWin"  Visible="false"  runat="server" ></cc1:bwimagebutton>				
					</td>
					<td></td>
				</tr>
			</table>
			<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblStyleHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
							ForeColor="#E0E0E0">Attachment</asp:label></td>
				</tr>
			</table>
			
			<%--<asp:Panel ID="pnlMulti" runat="server" Visible="false">
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
                                <asp:CheckBox ID="cbSharedNew" runat="server" Text="Share with Agent" ForeColor="Red" visible="false" Font-Size="XX-Small" />
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
                        <%#"FileName"%>
                    </td>
                    <td>
                       <%#"Status"%>
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
    </asp:Panel>	--%>	
			
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td vAlign="top">
						<asp:DataGrid id="dgStyleDocument" runat="server" ShowHeader="true" AutoGenerateColumns="False"
							Width="600px" OnItemDataBound="dgStyleDocument_ItemDataBound" BorderWidth="1px" BorderStyle="Solid"
							BorderColor="Silver" DataKeyField="StyleDocumentId">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
							     <%--<asp:TemplateColumn>
	                                <HeaderTemplate>
		                                <input type="checkbox" id="chkSelectChips" onclick="CheckAll(this,'chkChip');" runat="server" name="checkAll" />
	                                </HeaderTemplate>
	                                <ItemTemplate>
		                                <asp:CheckBox id="chkChip" runat="server"></asp:CheckBox>
		                             </ItemTemplate>
                                </asp:TemplateColumn>--%>
								<asp:TemplateColumn>
									<ItemStyle Width="25px"></ItemStyle>
									<ItemTemplate>
										<div align="center">
											<asp:Image id="imgPdf" runat="server" ImageUrl="../System/Icons/icon_pdf.gif"></asp:Image>
										</div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("File Name")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStyleDocumentName" runat="server" Width="200"/>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("File Description")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStyleDocumentDescription" runat="server" Width="200"/>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("File Size")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStyleDocumentSize" runat="server" Width="100" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Created By")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblCreatedBy" runat="server" Width="100" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Created Date")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblCreatedDate" runat="server"  Width="150"/>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%# GetSystemText("Modified By")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblModifyBy" runat="server"  Width="100" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%# GetSystemText("Modified Date")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblModifyDate" runat="server"  Width="150" />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid></td>
				</tr>
			</table>
		</form>
	</body>
	<script>
	    var frm = document.Form1;

	    function CheckAll(checkAllBox, objName) {
	        var actVar = checkAllBox.checked;
	        for (i = 0; i < frm.length; i++) {
	            e = frm.elements[i];
	            if (e.type == 'checkbox' && e.name.indexOf(objName) != -1)
	                e.checked = actVar;
	        }
	    }   
    
	</script>
	<%--<script>
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
//            row.insertCell(-1);
            //            row.insertCell(-1);
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
