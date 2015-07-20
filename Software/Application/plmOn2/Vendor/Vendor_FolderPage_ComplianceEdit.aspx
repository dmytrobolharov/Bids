<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Vendor_FolderPage_ComplianceEdit.aspx.vb" Inherits="plmOnApp.Vendor_FolderPage_ComplianceEdit" %>
<%@ Register TagPrefix="uc1" TagName="Vendor_FolderPage_Comment" Src="Vendor_FolderPage_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<title>Edit Compliance</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">	
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style type="text/css">
            a img {outline:none; border:none;}
        </style>
        
	</HEAD>
	<body>
        <form id="Form1" method="post" runat="server">
            <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
                border="0" runat="server">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td>
                        <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                    </td>
                </tr>
            </table>
            <table cellspacing="2" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                <tr>
                    <td width="900">
                        <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                    </td>
                </tr>
            </table> 
            <table style="height:50%;" cellspacing="0" cellpadding="0" width="100%" border="0">              
                <tr>
                    <td valign="top" width="40%">                        
                        <asp:DataGrid ID="DataGrid1"  runat="server" BorderColor="Silver" BorderStyle="Solid"
                            BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" AllowPaging="true"
                            DataKeyField="TradePartnerComplianceItemID" PagerStyle-Visible="false">
                            <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                            <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                            <Columns>
                                            <asp:TemplateColumn HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                                <HeaderTemplate >
                                                    <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkSelected" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                        <table cellspacing="2" cellpadding="0" width="100%" border="0" runat="server" id="TblModify">
							<tr class="fontHead" >
								<td width="10" style="height: 24px">&nbsp;</td>
								<td noWrap width="85" style="height: 24px"><asp:Label id="lblNoofRows" runat="server">No. of Row(s)</asp:Label>:</td>
								<td width="35" style="height: 24px"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
										<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
										<asp:ListItem Value="2">2</asp:ListItem>
										<asp:ListItem Value="3">3</asp:ListItem>
										<asp:ListItem Value="4">4</asp:ListItem>
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
									</asp:dropdownlist></td>
								<td style="height: 24px; width: 138px;">
                                    <cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE" ></cc1:confirmedimagebutton>	
                                </td>			
                                <td style="height: 24px; width: 103px;">
                                    <asp:DropDownList ID="ddUpdateAll" runat="server" CssClass="fontHead" Width="100px"></asp:DropDownList>	
                                </td>	
                                <td style="height: 24px">
                                     <cc1:ConfirmedImageButton ID="btnUpdateAll" runat="server" Message="NONE"></cc1:ConfirmedImageButton>	
                                </td>			
                            </tr>
                        </table>
                    </td>    
                    <TD style="WIDTH: 15px">&nbsp;</TD>                                                   
                    <td vAlign="top" width="100%">   
                        <cc2:ystabview id="Ystabview3" runat="server"></cc2:ystabview>
                        <asp:panel id="pnlComment" runat="server">
                        <uc1:Vendor_FolderPage_Comment id="Vendor_FolderPage_Comment1" runat="server"></uc1:Vendor_FolderPage_Comment> 
                        </asp:panel>  
                        <asp:Panel ID="pnlAttachment" runat="server">
                        <table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%"
                            border="0">
                            <tr class="fontHead">
                                <td align="center" width="10">
                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                </td>
                                <td class="fontHead" width="50">
                                    <div align="right">
                                        <asp:Label ID="lblAttachments" runat="server">Attachments</asp:Label></div>
                                </td>
                                <td>
                                    <cc1:ConfirmedImageButton ID="btnNewUpload" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="pnlNew" runat="server">
                            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                                    </td>
                                    <td width="500">
                                        <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                                        <cc1:ConfirmedImageButton ID="btnAddClose" runat="server" Message="NONE" CausesValidation="False">
                                        </cc1:ConfirmedImageButton>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="1" cellpadding="1" width="100%" bgcolor="whitesmoke" border="0">
                                <tr>
                                    <td valign="top" width="400">
                                        <table cellspacing="0" cellpadding="0" width="400" border="0">
                                            <tr>
                                                <td width="10">
                                                    &nbsp;
                                                </td>
                                                <td class="fontHead" valign="top" width="100">
                                                    <asp:Label ID="lblFileDescription" runat="server">File Description:</asp:Label>
                                                </td>
                                                <td class="font">
                                                    <asp:TextBox ID="txtNewFileDescription" runat="server" Rows="5" TextMode="MultiLine"
                                                        Wrap="false" Columns="50" Width="200"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td valign="top">
                                        <table cellspacing="0" cellpadding="0" width="400" border="0">
                                            <tr>
                                                <td width="10">
                                                    &nbsp;
                                                </td>
                                                <td class="fontHead" valign="top" width="100">
                                                    <asp:Label ID="lblFileUpload" runat="server">File Upload:</asp:Label>
                                                </td>
                                                <td class="font">
                                                    <input class="font" id="txtNewDocumentPath" type="file" size="20" name="txtDocumentPath"
                                                        runat="server">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="10" height="35">
                                                    &nbsp;
                                                </td>
                                                <td class="fontHead" colspan="2" height="35">
                                                    &nbsp;&nbsp;
                                                    <asp:CheckBox ID="cbSharedNew" runat="server" ForeColor="Red"></asp:CheckBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <table cellspacing="0" cellpadding="1" border="1" bordercolor="blue">
                            <asp:DataList ID="DataList1" runat="server" Width="100%" OnDeleteCommand="DataList_DeleteCommand"
                                OnCancelCommand="DataList_CancelCommand" OnUpdateCommand="DataList_UpdateCommand"
                                OnEditCommand="DataList_EditCommand" DataKeyField="ComplianceDocumentId" BackColor="White"
                                BorderColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1px">
                                <HeaderTemplate>
                                    <tr>
                                        <td class="fontHead" width="27" height="20">
                                            &nbsp;
                                        </td>
                                        <td class="fontHead" width="200">
                                            <asp:Label ID="lblFName" runat="server"><%#GetSystemText("File Name")%></asp:Label>
                                        </td>
                                        <td class="font" width="10">
                                            &nbsp;
                                        </td>
                                        <td class="fontHead" width="200">
                                            <asp:Label ID="lblFDesc" runat="server"><%#GetSystemText("File Description")%></asp:Label>
                                        </td>
                                        <td class="font" width="10">
                                            &nbsp;
                                        </td>
                                        <td class="fontHead" width="100">
                                            <asp:Label ID="lblFSize" runat="server"><%#GetSystemText("File Size")%></asp:Label>
                                        </td>
                                        <td class="fontHead" width="100">
                                            <asp:Label ID="lblFShared" runat="server"><%#GetSystemText("File Shared")%></asp:Label>
                                        </td>
                                        <td class="fontHead" width="100">
                                            <asp:Label ID="lblFCreatedBy" runat="server"><%#GetSystemText("File Created By")%></asp:Label>
                                        </td>
                                        <td class="fontHead">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </HeaderTemplate>
                                <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
                                <FooterTemplate>
                                </FooterTemplate>
                                <ItemStyle BackColor="White"></ItemStyle>
                                <ItemTemplate>
                                    <tr>
                                        <td width="20" height="20">
                                            <asp:LinkButton ID="Linkbutton1" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'
                                                CommandName="edit"></asp:LinkButton>
                                        </td>
                                        <td class="font" width="200">
                                            <%#Container.DataItem("DocumentName")%>
                                        </td>
                                        <td class="font" width="10">
                                            &nbsp;
                                        </td>
                                        <td class="font" width="200">
                                            <asp:Label ID="lblDocumentDesc" runat="server">
								                <%#Container.DataItem("DocumentDesc")%>
                                            </asp:Label>
                                        </td>
                                        <td class="font" width="10">
                                            &nbsp;
                                        </td>
                                        <td class="font" width="100">
                                            <%#Container.DataItem("DocumentSize")%>
                                        </td>
                                        <td class="font" width="100">
                                            <%#GetCheckBoxValueDefault(Container.DataItem("DocumentShared"))%>
                                        </td>
                                        <td class="font" width="100">
                                            <%#Container.DataItem("CUser")%>
                                        </td>
                                        <td class="font">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <tr>
                                        <td colspan="7">
                                            <br>
                                            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                <tr>
                                                    <td valign="middle" align="center" width="10">
                                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                    </td>
                                                    <td width="500">
                                                        <cc1:ConfirmedImageButton ID="edit_btnSave" runat="server" Message="NONE" CommandName="update">
                                                        </cc1:ConfirmedImageButton>
                                                        <cc1:ConfirmedLinkButton ID="edit_btnDelete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this file?")%>'
                                                            CommandName="delete" NAME="edit_btnDelete">
                                                        </cc1:ConfirmedLinkButton>
                                                        <asp:LinkButton ID="Linkbutton5" runat="Server" CommandName="download"  OnClientClick='dont_show_wait_twice();'></asp:LinkButton>
                                                        <cc1:ConfirmedImageButton ID="btnEditCancel" runat="server" Message="NONE" CommandName="cancel">
                                                        </cc1:ConfirmedImageButton>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                            <table cellspacing="1" cellpadding="1" width="100%" bgcolor="whitesmoke" border="0">
                                                <tr>
                                                    <td valign="top" width="400">
                                                        <table cellspacing="0" cellpadding="0" width="400" border="0">
                                                            <tr>
                                                                <td style="height: 22px" width="10">
                                                                    &nbsp;
                                                                </td>
                                                                <td class="fontHead" width="100">
                                                                    <asp:Label ID="lblFlName" runat="server"><%#GetSystemText("File Name")%>:</asp:Label>
                                                                </td>
                                                                <td class="font">
                                                                    <asp:Label ID="lblFileName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocumentName").ToString  %>'>
                                                                    </asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="10">
                                                                    &nbsp;
                                                                </td>
                                                                <td class="fontHead" valign="top" width="100">
                                                                    <br>
                                                                    <asp:Label ID="lblFlDesc" runat="server"><%#GetSystemText("File Description")%>:</asp:Label>:
                                                                </td>
                                                                <td class="font">
                                                                    <asp:TextBox ID="txtFileDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocumentDesc").ToString  %>'
                                                                        Width="250" Columns="50" Wrap="false" ToolTip="Enter file description here..."
                                                                        TextMode="MultiLine" Rows="5">
                                                                    </asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td valign="top">
                                                        <table cellspacing="0" cellpadding="0" width="400" border="0">
                                                            <tr>
                                                                <td width="10">
                                                                    &nbsp;
                                                                </td>
                                                                <td class="fontHead" valign="top" width="100">
                                                                    <asp:Label ID="LblFlUp" runat="server"><%#GetSystemText("Upload File")%>:</asp:Label>
                                                                </td>
                                                                <td class="font">
                                                                    <input class="font" id="txtImagePath" type="file" runat="server">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="10">
                                                                    &nbsp;
                                                                </td>
                                                                <td class="fontHead" valign="top" width="100">
                                                                    <asp:Label ID="LblFlSize" runat="server"><%#GetSystemText("File Size")%>:</asp:Label>:
                                                                </td>
                                                                <td class="font">
                                                                    <asp:Label ID="lblFileSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocumentSize").ToString  %>'>
                                                                    </asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="10" height="35">
                                                                    &nbsp;
                                                                </td>
                                                                <td class="fontHead" colspan="2" height="35">
                                                                    &nbsp;&nbsp;
                                                                    <asp:CheckBox ID="cbFileShared" runat="server" ForeColor="Red" Text="<%# GetCheckBoxTextDefault() %>"
                                                                        Checked='<%# DataBinder.Eval(Container.DataItem, "DocumentShared").ToString  %>'>
                                                                    </asp:CheckBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table cellspacing="0" cellpadding="0" width="100%" bgcolor="whitesmoke" border="0">
                                                <tr>
                                                    <td width="20">
                                                        &nbsp;
                                                    </td>
                                                    <td class="font" width="100">
                                                        <asp:Label ID="lblCreatedBy" runat="server"><%#GetSystemText("Created By")%></asp:Label>:
                                                    </td>
                                                    <td class="font">
                                                        <asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("CDate")).ToString %>'>
                                                        </asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="20" bgcolor="whitesmoke">
                                                        &nbsp;
                                                    </td>
                                                    <td class="font" width="100">
                                                        <asp:Label ID="lblModifiedBy" runat="server"><%#GetSystemText("Modified By")%></asp:Label>:
                                                    </td>
                                                    <td class="font">
                                                        <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("MDate")).ToString %>'>
                                                        </asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br>
                                        </td>
                                    </tr>
                                </EditItemTemplate>
                            </asp:DataList>
                        </table>
                    </asp:Panel>
                    </td>      
                 </tr>                 
            </table>
          
            
            
        </form>
		<script language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
		                e.checked = actVar;
		        }
		    }		
		</script>

        <script language="javascript" type="text/javascript"  >
            var frm = document.Form1;
            function SelectAll(checkAllBox) {
                var actVar = checkAllBox.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
                        e.checked = actVar;
                }
            }
		</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
