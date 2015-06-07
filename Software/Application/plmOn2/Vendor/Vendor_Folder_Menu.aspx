<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Vendor_Folder_Menu.aspx.vb" Inherits="plmOnApp.Vendor_Folder_Menu" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
