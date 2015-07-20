<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_3D_File.aspx.vb" Inherits="plmOnApp.SampleRequest_3D_File" %>
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
        window.resizeBy(screen.height, screen.width);
        window.onload = function () {
            
            var canvas = $("#imageCanvas");
            canvas.attr("height", $(document).height() - 80);
            canvas.attr("width", $(document).width());

            var viewer = new JSC3D.Viewer(document.getElementById('imageCanvas'));
            viewer.setParameter('SceneUrl', '<%=urlOBJ %>');
            viewer.setParameter('InitRotationX', 0);
            viewer.setParameter('InitRotationY', 0);
            viewer.setParameter('InitRotationZ', 0);
            viewer.setParameter('ModelColor', '#C5C5C5');
            viewer.setParameter('BackgroundColor1', '#FFFFFF');
            viewer.setParameter('BackgroundColor2', '#FFFFFF');
            viewer.setParameter('RenderMode', 'texturesmooth');
            viewer.setParameter('Definition', 'high');
            viewer.setParameter('MipMapping', JSC3D.PlatformInfo.supportWebGL ? 'off' : 'on');
            viewer.setParameter('Renderer', 'webgl');
            viewer.setParameter('MaterialUrl', '<%=urlMTL %>');
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
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
	    <tr valign="middle">
		    <td valign="middle" align="left">
                <cc1:ConfirmedImageButton ID="btnDownload" runat="server" CausesValidation="false" Message="NONE" OnClientClick="dont_show_wait_next_time();" />
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" CausesValidation="false" Message="NONE" OnClientClick="return btnClose_Click()"/>
            </td>
            <td></td>
	    </tr>
    </table>
    <uc2:style_header id=Style_Header1 runat="server"></uc2:style_header>
    <span align="center" width="100%" style="display:inline-block;width:100%">
    <canvas id="imageCanvas" runat="server"></canvas><br/>
    
    <a id="dl" download="3d.png" class="screenshot" allign="center" style="align:center">Save to Fit Photo</a>
    </span>
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
