<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_DimViewTree.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_DimViewTree" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    		 <script type="text/javascript">
    		     //var s = top.document.getElementById('frContainer').cols;
    		     //var s = document.getElementById
    		     //alert(s);
    		     //document.getElementById('frameContainer').cols = '150,*';
		 </script>

</head>
<body>
    <form id="form1" runat="server">    
        <cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
    </form>    
</body>

</html>
