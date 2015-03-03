<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_BOL_Edit.aspx.vb"
    Inherits="plmOnApp.Style.BOL.Style_BOL_Edit" %>

<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>BOL</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td nowrap="nowrap" width="650">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>&nbsp;
                <cc1:confirmedimagebutton id="btnPageCopy" OnClientClick="return NoPostBack()" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>&nbsp;
                <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:BWImageButton>
            </td>
            <td class="FontHead" align="right" width="75">
                &nbsp;<%=GetSystemText("Select Set")%>:
            </td>
            <td width="40">
                <asp:DropDownList ID="dpStyleSet" runat="server" CssClass="font" DataTextField="Value"
                    DataValueField="ID" AutoPostBack="true">
                </asp:DropDownList>
            </td>
            <td>
                <asp:ImageButton ID="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif">
                </asp:ImageButton>
            </td>
        </tr>
    </table>
    <uc1:Style_Workflow_Edit ID="Style_Workflow_Edit1" runat="server"></uc1:Style_Workflow_Edit>
    <asp:Panel ID="pnlChange" runat="server">
        <uc1:Style_Change_Alert ID="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
    </asp:Panel>
    <uc2:Style_Header ID="Style_Header1" runat="server"></uc2:Style_Header>
    <table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td height="20">
                <uc1:Style_Comment ID="Style_Comment1" runat="server"></uc1:Style_Comment>
            </td>
        </tr>
    </table>
    <br />
    <cc2:YSTabView ID="YSTabView" runat="server"></cc2:YSTabView>
    <table cellspacing="2" cellpadding="0" width="100%" border="0">
        <tr class="fontHead">
            <td>
                <cc1:ConfirmedImageButton ID="btnUnlink" runat="server" />&nbsp;<cc1:ConfirmedImageButton
                    ID="btnImageRemove" runat="server" CausesValidation="false"/>
            </td>
        </tr>
    </table>
    <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="False" DataKeyField="PageOperationId">
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <Columns>
            <asp:TemplateColumn >
                <HeaderTemplate>
                    <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox id="chbPageOperationId" runat="server"></asp:CheckBox>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BorderWidth="1">
                <ItemStyle Width="75" />
                <ItemTemplate>
                    <table cellspacing="0" cellpadding="0" width="75" border="0">
                        <tr>
                            <td>
                                <table cellspacing="0" cellpadding="0" width="25" border="0">
                                    <tr>
                                        <td>
                                            <asp:Image ID="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" />
                                            <cc1:ConfirmedImageButton ID="ImgRelinked" OnCommand="RelinkItem" runat="server"
                                                ImageUrl="../System/Icons/icon_link_go.gif" Visible="false" />
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <cc1:ConfirmedImageButton ID="btnDeleteImage" OnCommand="DeleteImage" runat="server"
                                                ImageUrl="../System/Icons/icon_image_delete.gif" Visible="false" />
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <cc1:BWImageButton ID="ImgUpload" runat="server" ImageUrl="../System/Icons/icon_panelup.gif"
                                                MenuBar="False" Status="False" ToolBar="False" Location="False" />
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <cc1:ConfirmedImageButton ID="btnAddOpToMacro" OnCommand="AddOpToMacro" runat="server"
                                                ImageUrl="../System/Icons/icon_add.gif" Visible="False" />
                                        </td>
                                    </tr>
                                </table>
                                <table cellspacing="0" cellpadding="0" width="25" border="0">
                                    <tr>
                                             <td style="height:50px;vertical-align:top">
                                        <div style="position:absolute;">
                                            <cc1:BWImageButton ID="imgConstructionDetail" runat="server" />
                                        </div></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BorderWidth="1">
                <HeaderStyle Width="30px" CssClass="TableHeader"></HeaderStyle>
                <HeaderTemplate>
                    <asp:Label runat="server" ID="lblMacro" Text='<%#GetSystemText("Macro") %>' />
                </HeaderTemplate>
                <ItemStyle Width="30px" HorizontalAlign="Center"></ItemStyle>
                <ItemTemplate>
                    <asp:Image runat="server" ID="imgIsMacro" ImageUrl="../System/Icons/tv_plusdotsbt.gif" />
                    <asp:HiddenField runat="server" ID="hdnMacroParentId" Value="" />
                    <asp:HiddenField runat="server" ID="hdnMacroId" Value="" />
                    <asp:HiddenField runat="server" ID="hdnOperationId" Value="" />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <asp:DataGrid ID="DataGrid2" runat="server" AllowSorting="False" DataKeyField="PageOperationId">
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <Columns>
            <asp:TemplateColumn HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                <HeaderTemplate>
                    <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox id="chbPageOperationId" runat="server"></asp:CheckBox>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BorderWidth="1">
                <ItemStyle Width="75"/>
                <ItemTemplate>
                    <table cellspacing="0" cellpadding="0" width="75" border="0">
                        <tr>
                            <td>
                                <table cellspacing="0" cellpadding="0" width="25" border="0">
                                    <tr>
                                        <td>
                                            <asp:Image ID="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" />
                                            <cc1:ConfirmedImageButton ID="ImgRelinked" OnCommand="RelinkItem" runat="server"
                                                ImageUrl="../System/Icons/icon_link_go.gif" Visible="false" />
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <cc1:ConfirmedImageButton ID="btnDeleteImage" OnCommand="DeleteImage" runat="server"
                                                ImageUrl="../System/Icons/icon_image_delete.gif" Visible="false" />
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <cc1:BWImageButton ID="ImgUpload" runat="server" ImageUrl="../System/Icons/icon_panelup.gif"
                                                MenuBar="False" Status="False" ToolBar="False" Location="False" />
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <cc1:ConfirmedImageButton ID="btnAddOpToMacro" OnCommand="AddOpToMacro2" runat="server"
                                                ImageUrl="../System/Icons/icon_add.gif" Visible="False" />
                                        </td>
                                    </tr>
                                </table>
                                <table cellspacing="0" cellpadding="0" width="25" border="0">
                                    <tr>
                                        <td style="height:50px;vertical-align:top;">
  					 <div style="position:absolute;">
                                            <cc1:BWImageButton ID="imgPageOperations" runat="server" />
                                        </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BorderWidth="1">
                <HeaderStyle Width="30px" CssClass="TableHeader"></HeaderStyle>
                <HeaderTemplate>
                    <asp:Label runat="server" ID="lblMacro" Text='<%#GetSystemText("Macro") %>' />
                </HeaderTemplate>
                <ItemStyle Width="30px" HorizontalAlign="Center"></ItemStyle>
                <ItemTemplate>
                    <asp:Image runat="server" ID="imgIsMacro" ImageUrl="../System/Icons/tv_plusdotsbt.gif" />
                    <asp:HiddenField runat="server" ID="hdnMacroParentId" Value="" />
                    <asp:HiddenField runat="server" ID="hdnMacroId" Value="" />
                    <asp:HiddenField runat="server" ID="hdnOperationId" Value="" />
                    <asp:HiddenField runat="server" ID="hdnIsException" Value="" />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <br />
    <table cellspacing="2" cellpadding="0" width="20%" border="0" align="center" style="background-color: #AABBCC"
        id="tblTTime" runat="server">
        <tr>
            <td class="fontHead" align="center">
            <asp:DropDownList ID="exeptionTypeDD" runat="server" AppendDataBoundItems="true" DataTextField="BOLExceptionName" DataValueField="BOLExceptionId" DataSource='<%# ExeptionTable()%>' AutoPostBack="true">
                                            <asp:ListItem Value="" Text="">Standard</asp:ListItem>
             </asp:DropDownList>

                <asp:DataGrid ID="DataGridTTime" Width="100%" runat="server" ShowHeader="false" AllowSorting="False" DataKeyField="BaseRateId" BorderStyle="Solid" AutoGenerateColumns="false" HeaderStyle-Height="0">
                    <Columns>
                        <asp:BoundColumn DataField="RateCode" ItemStyle-BorderStyle="Solid" ItemStyle-HorizontalAlign="Left"></asp:BoundColumn>
                        <asp:BoundColumn DataField="TotalTime" ItemStyle-BorderStyle="Solid" ItemStyle-HorizontalAlign="Right"></asp:BoundColumn>
                    </Columns>
                </asp:DataGrid>
            </td>
        </tr>
    </table>
    <table cellspacing="2" cellpadding="0" width="100%" border="0" id="tblAdd" runat="server">
        <tr>
            <td align="left">
                <table cellspacing="2" cellpadding="0" border="0">
                    <tr class="fontHead">
                        <td nowrap="nowrap" width="85">
                            &nbsp;<%=GetSystemText("No. of Row(s)")%>:
                        </td>
                        <td width="35">
                            <asp:DropDownList ID="dpNewRow" runat="server" CssClass="fontHead">
                                <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="15">15</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td nowrap="nowrap">
                            <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE" />&nbsp;
                            <cc1:BWImageButton ID="btnLink" runat="server" />&nbsp;
                            <cc1:BWImageButton ID="btnLinkMacro" runat="server" />&nbsp;
                            <cc1:BWImageButton ID="btnCopyTemplate" runat="server" />
                        </td>
                        <td nowrap="nowrap">
                            &nbsp;<%=GetSystemText("Add Operation or Macro by Code")%>:
                        </td>
                        <td>
                            <asp:TextBox ID="tbxSearchByCode" runat="server" ToolTip="Enter Code..." />
                        </td>
                        <td>
                            <cc1:ConfirmedImageButton ID="btnSearchByCode" runat="server"
                                Message="NONE" />&nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <table cellspacing="2" cellpadding="0" width="100%" border="0" id="tblAddException"
        runat="server">
        <tr>
            <td align="left">
                <table cellspacing="2" cellpadding="0" border="0">
                    <tr class="fontHead">
                        <td nowrap="nowrap">
                            &nbsp;<%=GetSystemText("New exception column Name")%>:&nbsp;
                        </td>
                        <td>
                            <asp:TextBox ID="txtExceptionName" runat="server" ToolTip="Enter Exception Column Name..." />
                        </td>
                        <td>
                            <cc1:ConfirmedImageButton ID="btnExceptionAdd" runat="server" 
                                Message="NONE" />&nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <table height="24" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_left.gif" />
            </td>
            <td class="TableBar" valign="middle" align="center" width="20">
                <img src="../System/icons/icon_changeobject.gif">
            </td>
            <td class="TableBar">
                <asp:Label ID="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:Label>&nbsp;/
                <asp:Label ID="lblModifiedBy" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_right.gif" />
            </td>
        </tr>
    </table>
    </form>

    <script type="text/javascript" language="javascript">
        var frm = document.Form1;
        
        function SelectAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.disabled != true && e.name.indexOf("chbPageOperationId") != -1)
                    e.checked = actVar;
            }
        }

        function SelectException(exceptionId, macroParentId, isChecked) {
            for (n = 0; n < frm.length; n++) {
                element = frm.elements[n];
                if (element.type == 'checkbox' && element.name.indexOf("chbException_" + exceptionId) != -1 && element.value==macroParentId) {
                    element.checked = isChecked;
                } 
            }
        }
        
        function RefreshImage() {
            frm.submit();
        }

    

        function getElementsByNameIE(tag, name) {

            var elem = document.getElementsByTagName(tag);
            var arr = new Array();
            for (i = 0, iarr = 0; i < elem.length; i++) {
                att = elem[i].getAttribute("name");
                if (att == name) {
                    arr[iarr] = elem[i];
                    iarr++;
                }
            }
            return arr;
        }

        function hideUnhide(MacroParentId, id) {
            var h = getElementsByNameIE("tr", "hide_" + MacroParentId)
            for (var i = 0; i < h.length; i++) {
                if (h[i].style.display == 'none') {
                    h[i].style.display = ''
                    document.getElementById(id).src = '../System/Icons/tv_minusdotst.gif'
                }
                else {
                    if (h[i].style.display == '') h[i].style.display = 'none'
                    document.getElementById(id).src = '../System/Icons/tv_plusdotsbt.gif'
                }
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
</html>
