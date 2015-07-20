<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_3D_Files.aspx.vb" Inherits="plmOnApp.SampleRequest_3D_Files" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>

<!DOCTYPE HTML>

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

        window.onload = function () {
            window.resizeBy(screen.height, screen.width);
            Load3D(0);
         }
    </script>
</head>
<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    <table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
	    <tr valign="middle">
            <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
		    <td valign="middle" align="left">
                <cc1:BWImageButton ID="btnMultiUploadWin" runat="server"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" CausesValidation="false" Message="NONE" OnClientClick="return btnClose_Click()"/>
		    </td>
        </tr>
    </table>
    <uc2:style_header id=Style_Header1 runat="server"></uc2:style_header>
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
            <td width="20"><asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:ImageButton></td>
            <td width="20"><asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:ImageButton></td>
            <td width="150" align="center"><asp:Label ID="lblCounts" CssClass="plaintable" runat="server"></asp:Label></td>
            <td width="20"><asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:ImageButton></td>
            <td width="20"><asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:ImageButton></td>
            <td><asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label></td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnCurrentPage" Value="0" runat="server" />
    <asp:HiddenField ID="hdnPageSize" Value="10" runat="server" />
    <asp:HiddenField ID="hdnRecordsCount" runat="server" />
    <asp:DataList ID="DataList1" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" DataKeyField="SampleRequest3DFileID"
        BackColor="White" BorderColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1px">
        <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
        <ItemStyle BackColor="White" CssClass="item-3d"></ItemStyle>
        <ItemTemplate>
            <table>
                <tr>
                    <td><asp:LinkButton ID="btnAttEdit" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">' CommandName="edit"></asp:LinkButton></td>
                    <td><cc1:BWImageButton runat="server" id="btn3DShow"></cc1:BWImageButton></td>
                </tr>
            </table>
            <canvas id="imageCanvas" runat="server" width="400" height="400"></canvas>            
            <table>                     
                <tr>   
                    <td class="fontHead"><%=GetSystemText("File Name")%>:</td>
                    <td class="font"><%#Container.DataItem("SampleRequest3DFileName")%></td>
                    <td class="fontHead"><%=GetSystemText("File Description")%>:</td>
                    <td class="font"><%#Container.DataItem("SampleRequest3DFileDescription").Replace(vbCrLf, "<BR>").ToString%></td>
                </tr>
                <tr> 
                    <td class="fontHead"><%=GetSystemText("File Size")%>:</td> 
                    <td class="font"><%#Container.DataItem("SampleRequest3DFileSize")%></td>
                    <td class="fontHead"><%=GetSystemText("Shared")%>:</td> 
                    <td class="font"><%#IIf(Container.DataItem("SampleRequest3DFileShared") = 1, GetSystemText("YES"), GetSystemText("NO"))%></td>
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
                        <cc1:ConfirmedImageButton ID="btnEditSave" runat="server" Message="NONE" Visible='<%# ShowHideSaveBtn() %>' CommandName="update"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedLinkButton ID="btnEditDelete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this file?")%>' CommandName="delete" Visible='<%# ShowHideDeleteBtn() %>'></cc1:ConfirmedLinkButton>
                        <asp:LinkButton ID="btnEditDownload" runat="Server" CommandName="download" OnClientClick="dont_show_wait_twice();"></asp:LinkButton>
                        <cc1:ConfirmedImageButton ID="btnEditCancel" runat="server" Message="NONE" CommandName="cancel"></cc1:ConfirmedImageButton>
                    </td>                    
                </tr>
            </table>
            <span align="center" width="100%" style="display:inline-block;width:100%">
            <canvas id="imageCanvas" runat="server" width="300" height="300"></canvas><br/>
            <a id="dl" download="3d.png" class="screenshot" allign="center" style="align:center">Save to Fit Photo</a>
            </span>
            <asp:HiddenField runat="server" ID="hdnFileName" Value='<%# DataBinder.Eval(Container.DataItem, "SampleRequest3DFileName").ToString  %>' />
            <asp:HiddenField runat="server" ID="hdnFileDescription" Value='<%# DataBinder.Eval(Container.DataItem, "SampleRequest3DFileDescription").ToString  %>' />
            <asp:HiddenField runat="server" ID="hdnFileShared" Value='<%# DataBinder.Eval(Container.DataItem, "SampleRequest3DFileShared").ToString %>' />
            <asp:HiddenField runat="server" ID="hdnFileSize" Value='<%# DataBinder.Eval(Container.DataItem, "SampleRequest3DFileSize").ToString %>' />
            <table>
                <tr>                    
                    <td class="fontHead" valign="top" width="100"><%=GetSystemText("Upload File")%>:</td>
                    <td class="font" colspan="3"><input class="font" id="txtImagePath" type="file" runat="server" name="txtImagePath" /></td>
                </tr>
                <tr>
                    <td class="fontHead"><%=GetSystemText("File Name")%>:</td>
                    <td class="font"><%#Container.DataItem("SampleRequest3DFileName")%></td>                    
                    <td class="fontHead"><%=GetSystemText("File Size")%>:</td>
                    <td class="font"><%#Container.DataItem("SampleRequest3DFileSize")%></td>
                </tr>
                <tr>
                    <td class="fontHead"><%=GetSystemText("File Description")%>:</td>
                    <td class="font">
                        <asp:TextBox ID="txtFileDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SampleRequest3DFileDescription").ToString  %>'
                            Width="150" Columns="30" Wrap="false" ToolTip='<%#GetSystemText("Enter file description here") & "..."%>' TextMode="MultiLine" Rows="3">
                        </asp:TextBox>
                    </td>                    
                    <td class="font" colspan="2">
                        <asp:CheckBox ID="cbFileShared" runat="server" ForeColor="Red"
                            Checked='<%# Convert.ToBoolean(DataBinder.Eval(Container.DataItem, "SampleRequest3DFileShared")).ToString %>'>
                        </asp:CheckBox>
                    </td>
                </tr>
                <tr>                    
                    <td class="fontHead" width="100"><%=GetSystemText("Created By")%>:</td>
                    <td class="font"><asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("CDate")).ToString %>'></asp:Label></td>
                </tr>
                <tr>                    
                    <td class="fontHead" width="100"><%=GetSystemText("Modified By")%>:</td>
                    <td class="font"><asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; SystemHandler.GetLocalTime(Container.DataItem("MDate")).ToString %>'></asp:Label></td>
                </tr>
            </table>       
        </EditItemTemplate>
    </asp:DataList>

    <asp:HiddenField runat="server" ID="hdnScreenShotFile" Value='' />
    <asp:button runat="server" ID="btnCreatePhoto" />
    </form>
    <script  language="javascript" type="text/javascript">
            function dlCanvas() {
                    
                    var canvas = jQuery(this).closest('span').find('canvas');
                    
                    var dt = canvas.get(0).toDataURL('image/png');
                    dt = dt.replace('data:image/png;base64,', '');
                    
                    jQuery('#hdnScreenShotFile').val(dt);
                    //console.log(jQuery('#hdnScreenShotFile').val());
                    jQuery('#btnCreatePhoto').click();
                    return false;
                    //var w=window.open('about:blank');
                    
                    //window.open(dt,'page');
                };

                $(document).ready(function(){
                    jQuery('.screenshot').each(function(){
                    this.addEventListener('click', dlCanvas, false);
                    });
                    jQuery('#btnCreatePhoto').hide();
                
                });

        function btnClose_Click() {
            <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
