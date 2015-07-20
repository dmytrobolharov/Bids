<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Folder.aspx.vb" Inherits="plmOnApp.Control_Folder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
        
        <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>
        
	</HEAD>

	<FRAMESET cols="250,*" bordercolor="#dbd7d0">
		<frame SRC="<%=URLMenu%>" name="menuC" SCROLLING=yes marginheight=0 marginwidth=0 >
		<frame src="<%=URLMain%>" name="mainC" id="mainF" scrolling="auto" marginheight=0 marginwidth=0 ">
	</FRAMESET>

    

</HTML>
