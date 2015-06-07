<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_3DFiles.aspx.vb" Inherits="srmOnApp.Material_3DFiles" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

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
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
        .item-3d {
	        display: inline-block;
	        border: 1px solid #ddd;	  
	        vertical-align: top;      
        }
    </style>     
    <script type="text/javascript" src="../System/Jscript/jsc3d.js"></script>
    <script type="text/javascript" src="../System/Jscript/jsc3d.webgl.js"></script>
    <script type="text/javascript">
        var toLoad = [];
        function Load3DFile(canvas, url, mtl) {
            toLoad.push({ canvas: canvas, url: url, mtl: mtl });
        }

        window.onload = function () {
            for (var i = 0, len = toLoad.length; i < len; i++) {
                var canvas = toLoad[i].canvas,
                    url = toLoad[i].url,
                    mtl = toLoad[i].mtl;

                setTimeout((function (canvas, url, mtl) {
                    return function () {
                        var viewer = new JSC3D.Viewer(canvas);
                        viewer.setParameter('SceneUrl', url);
                        viewer.setParameter('InitRotationX', 0);
                        viewer.setParameter('InitRotationY', 0);
                        viewer.setParameter('InitRotationZ', 0);
                        viewer.setParameter('ModelColor', '#C5C5C5');
                        viewer.setParameter('BackgroundColor1', '#FFFFFF');
                        viewer.setParameter('BackgroundColor2', '#FFFFFF');
                        viewer.setParameter('RenderMode', 'texturesmooth');
                        viewer.setParameter('MipMapping', JSC3D.PlatformInfo.supportWebGL ? 'off' : 'on');
                        viewer.setParameter('Renderer', 'webgl');
                        viewer.setParameter('MaterialUrl', mtl);
                        viewer.init();
                        viewer.update();

                        viewer.onloadingcomplete = function () {
                            var scene = viewer.getScene();
                            if (scene) {
                                scene.forEachChild(function (mesh) {
                                    mesh.isDoubleSided = true;
                                });
                            }
                        };
                    };
                })(canvas, url, mtl), i * 200);
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnImgSearch">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" CausesValidation="false" Message="NONE" />
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
    <asp:DataList ID="DataList1" runat="server" DataKeyField="MaterialDocumentID" RepeatLayout="Flow" RepeatDirection="Horizontal"
        BackColor="White" BorderColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1px">        
        <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
        <ItemStyle BackColor="White" CssClass="item-3d"></ItemStyle>
        <ItemTemplate>
            <table>
                <tr>
                    <td>
                        <asp:LinkButton ID="btnDownload" runat="Server" CommandName="download" OnClientClick="dont_show_wait_next_time();"></asp:LinkButton></td>
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
                </tr>
            </table>
        </ItemTemplate>        
    </asp:DataList>
    </form>
</body>
</html>
