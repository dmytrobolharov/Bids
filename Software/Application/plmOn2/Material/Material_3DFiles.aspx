<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_3DFiles.aspx.vb" Inherits="plmOnApp.Material_3DFiles" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<%@ Register TagPrefix="uc1" TagName="Material_WorkflowStatus" Src="Material_WorkflowStatus.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server" id="PageTitle">3D Files</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" /> 
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .item-3d {
	        display: inline-block;
	        border: 1px solid #ddd;	  
	        vertical-align: top;      
        }
    </style>     
    <script type="text/javascript" src="../System/Jscript/jsc3d.js"></script>
    <script type="text/javascript" src="../System/Jscript/jsc3d.webgl.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <script type="text/javascript">
        var toLoad = [];
        function Load3DFile(canvas, url, mtl) {
            toLoad.push({ canvas: canvas, url: url, mtl: mtl });
        }

        function Load3D(i) {

            if (i < toLoad.length) {
                var viewer = new JSC3D.Viewer(toLoad[i].canvas);
                viewer.setParameter('SceneUrl', toLoad[i].url);
                viewer.setParameter('InitRotationX', 0);
                viewer.setParameter('InitRotationY', 0);
                viewer.setParameter('InitRotationZ', 0);
                viewer.setParameter('ModelColor', '#C5C5C5');
                viewer.setParameter('BackgroundColor1', '#FFFFFF');
                viewer.setParameter('BackgroundColor2', '#FFFFFF');
                viewer.setParameter('RenderMode', 'texturesmooth');
                viewer.setParameter('MipMapping', JSC3D.PlatformInfo.supportWebGL ? 'off' : 'on');
                viewer.setParameter('Renderer', 'webgl');
                viewer.setParameter('MaterialUrl', toLoad[i].mtl);

                viewer.onloadingstarted = function () {
                    if (i == 0) { show_wait_text(); }
                };

                viewer.onloadingcomplete = function () {
                    var scene = viewer.getScene();
                    if (scene) {
                        scene.forEachChild(function (mesh) {
                            mesh.isDoubleSided = true;
                        });
                    }
                    if (i == toLoad.length) { hide_wait_text(); }
                    Load3D(i);
                };

                viewer.init();
                viewer.update();
                i++;
            }
        };

        window.onload = function () { Load3D(0); }
    </script>
</head>
<body>
    <div id="fixed_icons">
        <a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank"
            id="yHelp"></a>
    </div>
    <form id="form1" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:BWImageButton ID="btnMultiUploadWin" runat="server"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" CausesValidation="false" Message="NONE" OnClientClick="return btnClose_Click()"/>
                <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:BWImageButton>
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td valign="middle">
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="gray" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Attachments</asp:Label>
            </td>
        </tr>
    </table>
    <uc1:Material_WorkflowStatus ID="Material_WorkflowStatus1" runat="server" />
    <uc1:Material_Header id="Material_Header1" runat="server" IsCollapsible="true" IsCollapsed="true" />
    <table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr class="fontHead">
            <td align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td class="fontHead" width="50">
                <div align="right">
                    <asp:Label ID="lblSearch" runat="server" Text="Search:"></asp:Label></div>
            </td>
            <td width="75">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="font"></asp:TextBox>
            </td>
            <td width="10">
                <asp:ImageButton ID="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif"></asp:ImageButton>
            </td>
            <td>
                <div align="left">
                    &nbsp;
                    <asp:Label ID="lblCurrentIndex" runat="server" Visible="False" Text="0"></asp:Label><asp:Label ID="lblPageSize"
                        runat="server" Visible="False" Text="24"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:ImageButton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:ImageButton></div>
            </td>
            <td width="150">
                <div align="center">
                    <asp:Label ID="lblCounts" CssClass="plaintable" runat="server"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:ImageButton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:ImageButton></div>
            </td>
            <td>
                <div align="left">
                    <b>
                        <asp:Label ID="lblRecordCount" runat="server" Visible="true"></asp:Label>&nbsp;<asp:Label ID="lblRecordsFound"
                            runat="server" Text="Records Found"></asp:Label></b></div>
            </td>
        </tr>
    </table>
    <asp:DataList ID="DataList1" runat="server" OnDeleteCommand="DataList_DeleteCommand" OnCancelCommand="DataList_CancelCommand"
        OnUpdateCommand="DataList_UpdateCommand" OnEditCommand="DataList_EditCommand" DataKeyField="MaterialDocumentID" RepeatLayout="Flow" RepeatDirection="Horizontal"
        BackColor="White" BorderColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1px">        
        <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
        <ItemStyle BackColor="White" CssClass="item-3d"></ItemStyle>
        <ItemTemplate>
            <table>
                <tr>
                    <td><asp:LinkButton ID="btnAttEdit" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">' CommandName="edit"></asp:LinkButton></td>
                </tr>
            </table>
            <canvas id="imageCanvas" runat="server" width="400" height="400"></canvas>            
            <table>
                <tr>   
                    <td class="fontHead">
                        <%=GetSystemText("File Name")%>:
                    </td>                 
                    <td class="font">
                        <%#Container.DataItem("MaterialDocumentName")%>
                    </td>
                    <td class="fontHead">                        
                        <%=GetSystemText("File Description")%>:
                    </td>
                    <td class="font">
                        <%#Container.DataItem("MaterialDocumentDescription").Replace(vbCrLf, "<BR>").toString%>
                    </td>
                </tr>
                <tr> 
                    <td class="fontHead"> 
                        <%=GetSystemText("File Size")%>: 
                    </td> 
                    <td class="font"> 
                        <%#Container.DataItem("MaterialDocumentSize")%>
                    </td>
                    <td class="fontHead"> 
                        <%# GetCheckBoxTextDefault()%>
                    </td> 
                    <td class="font"> 
                        <%#GetCheckBoxValueDefault(Container.DataItem("MaterialDocumentShared"))%> 
                    </td>
                </tr>
            </table>
        </ItemTemplate>        
        <EditItemTemplate>
            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                    </td>
                    <td>
                        <cc1:ConfirmedImageButton ID="edit_btnSave" runat="server" Message="NONE" Visible='<%# ShowHideSaveBtn() %>'
                            CommandName="update"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedLinkButton ID="edit_btnDelete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this file?")%>'
                            CommandName="delete" NAME="edit_btnDelete" Visible='<%# ShowHideDeleteBtn() %>'>
                        </cc1:ConfirmedLinkButton>
                        <asp:LinkButton ID="Linkbutton5" runat="Server" CommandName="download" OnClientClick="dont_show_wait_next_time();"></asp:LinkButton>
                        <cc1:ConfirmedImageButton ID="btnEditCancel" runat="server" Message="NONE" CommandName="cancel"></cc1:ConfirmedImageButton>
                    </td>                    
                </tr>
            </table>
            <canvas id="imageCanvas" runat="server" width="300" height="300"></canvas>
            <table>
                <tr>                    
                    <td class="fontHead" valign="top" width="100">
                        <%=GetSystemText("Upload File")%>:
                    </td>
                    <td class="font" colspan="3">
                        <input class="font" id="txtImagePath" type="file" runat="server" name="txtImagePath" />
                    </td>
                </tr>
                <tr>
                    <td class="fontHead">
                        <%=GetSystemText("File Name")%>:
                    </td>
                    <td class="font">
                        <%#Container.DataItem("MaterialDocumentName")%>
                        <asp:HiddenField runat="server" ID="hdnlblFileName" Value='<%# DataBinder.Eval(Container.DataItem, "MaterialDocumentName").ToString  %>' />
                    </td>                    
                    <td class="fontHead">
                        <%=GetSystemText("File Size")%>:
                    </td>
                    <td class="font">
                        <%#Container.DataItem("MaterialDocumentSize")%>
                    </td>
                </tr>
                <tr>
                    <td class="fontHead">
                        <%=GetSystemText("File Description")%>:
                    </td>
                    <td class="font">
                        <asp:TextBox ID="txtFileDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MaterialDocumentDescription").ToString  %>'
                            Width="150" Columns="30" Wrap="false" ToolTip='<%#GetSystemText("Enter file description here") & "..."%>'
                            TextMode="MultiLine" Rows="3">
                        </asp:TextBox>
                        <asp:HiddenField runat="server" ID="hdnFileDescription" Value='<%# DataBinder.Eval(Container.DataItem, "MaterialDocumentDescription").ToString  %>' />
                    </td>                    
                    <td class="font" colspan="2">
                        <asp:CheckBox ID="cbFileShared" runat="server" ForeColor="Red" Text="<%# GetCheckBoxTextDefault() %>"
                            Checked='<%# GetCheckBoxBooleanDefault(DataBinder.Eval(Container.DataItem, "MaterialDocumentShared").ToString)  %>'>
                        </asp:CheckBox>
                        <asp:HiddenField runat="server" ID="hdnFileShared" Value='<%# GetCheckBoxBooleanDefault(DataBinder.Eval(Container.DataItem, "MaterialDocumentShared").ToString) %>' />
                    </td>
                </tr>
                <tr>                    
                    <td class="font" width="100">
                        <%=GetSystemText("Created By")%>:
                    </td>
                    <td class="font">
                        <asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("CDate")).ToString %>'>
                        </asp:Label>
                    </td>
                </tr>
                <tr>                    
                    <td class="font" width="100">
                        <%=GetSystemText("Modified By")%>:
                    </td>
                    <td class="font">
                        <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("MDate")).ToString %>'>
                        </asp:Label>
                    </td>
                </tr>
            </table>            
        </EditItemTemplate>
    </asp:DataList>
    </form>
        <script  language="javascript" type="text/javascript">
                    function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
                    }
        </script>
</body>
</html>
