<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Vendor_Folder_Menu.aspx.vb" Inherits="plmOnApp.Vendor_Folder_Menu" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		
	        <script type="text/javascript">

            function test() {
                alert(0);

            }
 
		</script>		
		
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
		</form>
	</body>
</HTML>
