<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_FolderPage_Relationship_Folder.aspx.vb" Inherits="plmOnApp.Vendor_FolderPage_Relationship_Folder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title runat="server" id="PageTitle"></title>
		 <script type="text/javascript">
		     top.document.getElementById('frameContainer').cols = '155,*'
		 </script>
	</head>

	<frameset rows="30%,70%" bordercolor="#dbd7d0">
		<frame name="topPage" id="topPage" src="<%=URLTop%>" scrolling="yes" marginheight="0" marginwidth="0" />
		<frame name="bottomPage" id="bottomPage" src="<%=URLMain%>" scrolling="yes" marginheight="0" marginwidth="0" />
	</frameset>

</html>
