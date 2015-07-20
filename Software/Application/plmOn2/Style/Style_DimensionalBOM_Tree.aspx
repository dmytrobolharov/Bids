<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_Tree.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_Tree" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    		 <script type="text/javascript">
    		     //var s = top.document.getElementById('frContainer').cols;
    		     //var s = document.getElementById
    		     //alert(s);
    		     //document.getElementById('frameContainer').cols = '150,*';
		 </script>

</head>
<body onload="try{top.resizeFrame('1,*', null, 0);}catch(e){}">

    <form id="form1" runat="server">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
    <tr>
    <td id="tdOpenCloseImage" style="text-align:right;">
        <img id="SHFrame" width="52px" height="25px" style="cursor:hand;" onclick="try{parent.parent.resizeFrame('0,*', this)}catch(e){}" alt="" src="../System/Icons/FrameOpen.png" />
    </td>
    </tr>
    </table>
    <cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>

    </form>
    
</body>

</html>
