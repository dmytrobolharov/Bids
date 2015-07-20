<%@ Control Language="vb" AutoEventWireup="false" Codebehind="QuoteItem_Document.ascx.vb" Inherits="srmOnApp.QuoteItem_Document" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<table class="TableHeader" id="toolbar" height="20" cellSpacing="0" cellPadding="0" width="100%"
	border="0" runat="server">
	<tr vAlign="middle">
		<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td><cc1:confirmedimagebutton id="btnRemove" runat="server" ></cc1:confirmedimagebutton>	
		<cc1:bwimagebutton id="btnMultiUploadWin" runat="server" ></cc1:bwimagebutton>								
		</td>
		<td></td>
	</tr>
</table>
<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td vAlign="middle">&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Attachments</asp:label></td>
	</tr>
</table>
<TABLE class="TableHeader" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR class="fontHead">
		<TD align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
		<TD class="fontHead" width="50">
			<DIV align="right"><asp:label id="lblSearch" runat="server">Search:</asp:label></DIV>
		</TD>
		<TD width="75"><asp:textbox id="txtSearch" runat="server" CssClass="font"></asp:textbox></TD>
		<TD width="10"><asp:imagebutton id="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif"></asp:imagebutton></TD>
		<TD>
			<DIV align="left">&nbsp;
				<asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label><asp:label id="lblPageSize" Text="10" Visible="False" Runat="server"></asp:label></DIV>
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
			<DIV align="left"><asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label></DIV>
		</TD>
	</TR>
</TABLE>
<asp:panel id="pnlNew" runat="server">
	<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<TR>
			<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			<TD width="500">
				<cc1:confirmedimagebutton id="btnAddClose" runat="server" Message="NONE" 
					CausesValidation="False"></cc1:confirmedimagebutton></TD>
			<TD>&nbsp;</TD>
		</TR>
	</TABLE>
	<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="whitesmoke" border="0">
		<TR>
			<TD vAlign="top" width="400">
				<TABLE cellSpacing="0" cellPadding="0" width="400" border="0">
					<TR>
						<TD width="10">&nbsp;</TD>
						<TD class="fontHead" vAlign="top" width="100"><asp:label id="lblFileDescription" runat="server">File Description:</asp:label></TD>
						<TD class="font">
							<asp:TextBox id="txtNewFileDescription" runat="server" Rows="5" TextMode="MultiLine" Wrap="false"
								Columns="50" Width="250"></asp:TextBox></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
		<TR>
			<TD vAlign="top">
				<TABLE cellSpacing="0" cellPadding="0" width="400" border="0">
					<TR>
						<TD width="10">&nbsp;</TD>
						<TD class="fontHead" vAlign="top" width="100"><asp:label id="lblFileUpload" runat="server">File Upload:</asp:label></TD>
						<TD class="font"><INPUT class="font" id="txtNewDocumentPath" type="file" name="txtNewDocumentPath" runat="server">
							<asp:RequiredFieldValidator id="rvNewFileRquired" runat="server" CssClass="fontHead" ControlToValidate="txtNewDocumentPath"
								Display="Dynamic" ErrorMessage="*" ToolTip='<%#GetSystemText("File path required")%>...'></asp:RequiredFieldValidator></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</TABLE>
</asp:panel>
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
    </asp:Panel>--%>
<asp:datalist id="DataList1" runat="server" Width="100%" BorderWidth="1px" BorderStyle="Solid"
	BorderColor="WhiteSmoke" BackColor="White" OnEditCommand="DataList_EditCommand"
	OnCancelCommand="DataList_CancelCommand">
	<HeaderTemplate>
		<table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr class="Toolbar">
			 <td class="fontHead" width="27" height="20"><input type="checkbox" id="chkSelectChips" onclick="CheckAll(this,'chkChip');" runat="server" name="checkAll" /></td>
				<td class="fontHead" width="27" height="20">&nbsp;</td>
				<td class="fontHead" width="200"><%#GetSystemText("File Name")%></td>
				<td class="fontHead" width="200"><%#GetSystemText("File Description")%></td>
				<td class="fontHead" width="100"><%#GetSystemText("File Size")%></td>
				<td class="fontHead" width="100"><%#GetSystemText("Created By")%></td>
                <td class="fontHead" width="125"><%#GetSystemText("Created Date")%></td>
				<td class="fontHead">&nbsp;</td>
			</tr>
		</table>
	</HeaderTemplate>
	<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
	<FooterTemplate>
	</FooterTemplate>
	<ItemStyle BackColor="White"></ItemStyle>	
	<ItemTemplate>
		<TABLE width="100%">		
			<TR>
			<TD width="20" height="20">
			<asp:CheckBox id="chkChip" runat="server"></asp:CheckBox></TD>
				<TD width="20" height="20">
					<asp:linkbutton id="Linkbutton1" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'
						CommandName="edit"></asp:linkbutton></TD>
				<TD class="font" width="200"><%#Container.DataItem("DocumentName")%></TD>
				<TD class="font" width="200">
					<asp:Label id="lblDocumentDescription" Runat="server">
						<%#Container.DataItem("DocumentDescription")%>
					</asp:Label></TD>
				<TD class="font" width="100"><%#Container.DataItem("DocumentSize")%></TD>
				<TD class="font" width="100"><%#Container.DataItem("CUser")%></TD>
                <TD class="font" width="125"><%# Convert.ToDateTime(Container.DataItem("CDate")).ToString(Me.GetFormatInfo.DateTimeLongFormat)%></TD>
				<TD class="font">&nbsp;</TD>
			</TR>
		</TABLE>
	</ItemTemplate>
	<EditItemTemplate>
		<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<TR>
				<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<TD width="500">
					<asp:linkbutton id="Linkbutton5" runat="Server"	CommandName="download" OnClientClick="dont_show_wait_twice(); return true;"></asp:linkbutton>
					<cc1:confirmedimagebutton id="btnEditUpdate" runat="server"  Message="NONE" CommandName="update"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnEditCancel" runat="server" Message="NONE" 	CommandName="cancel"></cc1:confirmedimagebutton>
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
							<TD class="fontHead" width="100"><%#GetSystemText("File Name")%>:</TD>
							<TD class="font">
								<asp:Label id=lblFileName runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocumentName").ToString  %>'>
								</asp:Label></TD>
						</TR>
						<TR>
							<TD width="10">&nbsp;</TD>
							<TD class="fontHead" vAlign="top" width="100"><BR>
								<%#GetSystemText("File Description")%>:</TD>
							<TD class="font">
								<asp:TextBox id=txtFileDescription runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocumentDescription").ToString  %>' Width="250" Columns="50" Wrap="false" TextMode="MultiLine" Rows="5">
								</asp:TextBox></TD>
						</TR>
					</TABLE>
				</TR>				
		</TABLE>

		<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="whitesmoke" border="0">
			<TR>
				<TD width="10">&nbsp;</TD>
				<TD class="fontHead" width="100"><%#GetSystemText("File Size")%>:</TD>
				<TD class="font">
					<asp:Label id=lblFileSize runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocumentSize").ToString  %>'></asp:Label></TD>
			</TR>
		</TABLE> 		
		
		
		<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="whitesmoke" border="0">
			<TR>
				<TD width="20">&nbsp;</TD>
				<TD class="font" width="100"><%#GetSystemText("Created By")%>:</TD>
				<TD class="font">
					<asp:Label id=lblCData runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("CDate")).ToString %>'>
					</asp:Label></TD>
			</TR>
			<TR>
				<TD width="20" bgColor="whitesmoke">&nbsp;</TD>
				<TD class="font" width="100"><%#GetSystemText("Modified By")%>:</TD>
				<TD class="font">
					<asp:Label id=lblMData runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("MDate")).ToString %>'>
					</asp:Label></TD>
			</TR>
		</TABLE>
	</EditItemTemplate>
</asp:datalist>

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