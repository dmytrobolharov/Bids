<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_New.aspx.vb" Inherits="plmOnApp.Image_New" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>New Image</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
        <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
        <meta content="JavaScript" name="vs_defaultClientScript">
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
          <wc1:Color_Wait ID="Color_Wait" runat="server" />
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE" Visible="False" CausesValidation="False"></cc1:ConfirmedImageButton>
					<img alt='' runat="server" id="Img1" style="display: none;" onclick="Upload_Click();return false;" />
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"  CausesValidation="False"></cc1:confirmedimagebutton>
					</td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">New Image...</asp:label></td>
				</tr>
			</table>
		
			<asp:panel id="pnlUpload" runat="server">
				<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
						<P><BR>
							<SPAN class="fontHead"><asp:Label ID="lblSelectFile" runat="server" Text="Select File to Upload..."></asp:Label></SPAN>
							
                            <br>
                                <br>
                                    <input id="File1" runat="server" name="file1" type="file">
                                    </input>
                                </br>
                            </br>
                        </P>
					</BLOCKQUOTE></BLOCKQUOTE>
			</asp:panel>

			<TABLE id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD width="900"><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></TD>
					<TD></TD>
				</TR>
			</TABLE>
            
	<asp:Panel ID="pnlMulti" runat="server">
        <div>  
            <CuteWebUI:UploadAttachments runat="server" ID="UploadAttachments1" ManualStartUpload="False" AutoUseSystemTempFolder="False"
                OnAttachmentAdded="UploadAttachments1_AttachmentAdded" OnAttachmentCreated="UploadAttachments1_AttachmentCreated" OnFileValidating="UploadAttachments1_FileValidating"
                NumFilesShowCancelAll="1000" TableHeaderTemplate="<td nowrap='nowrap'></td><td>Files</td><td>Description</td>" InsertButtonID="btnAdd">
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
     <%--       <table id='clientTable' style="display: none; font-size: 9pt; border-collapse: collapse"
                border="1" cellspacing="0" cellpadding="5">
                <tr>
                    <td>
                        <%#GetSystemText("FileName")%>
                    </td>
                    <td>
                        <%#GetSystemText("Status")%>
                    </td>
                </tr>
            </table>--%>
            <br />          
            <br />
        </div>
    </asp:Panel>
		</form>
	</body>
		<script type="text/javascript">
		    //    var btnUpload = document.getElementById("btnUpload");
		    //    var clientTable = document.getElementById("clientTable");
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
</script>
</HTML>
