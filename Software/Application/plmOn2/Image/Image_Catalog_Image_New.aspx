<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Catalog_Image_New.aspx.vb" Inherits="plmOnApp.Image_Catalog_Image_New" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>New Image</title>
		
		
		
		
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td >
					<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"   CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
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
            <asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder>
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
            <script  language="javascript" type="text/javascript">
                    function btnClose_Click() {
                        <%= strExitScript %>;
                        return false;
                    }
        </script>
	</body>
</HTML>
