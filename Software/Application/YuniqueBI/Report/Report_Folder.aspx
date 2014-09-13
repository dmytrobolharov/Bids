<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Report_Folder.aspx.vb" Inherits="YuniqueBI.Report_Folder"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE id="htmlHeader" runat="server" ></TITLE>
		<script language="JavaScript">
			<!--

			if (window.screen) {
				var aw = screen.availWidth;
				var ah = screen.availHeight;
				window.moveTo(0, 0);
				window.resizeTo(aw, ah);
			}

			if (self != top) top.location.replace(self.location);	

			self.focus();

			//-->
		</script>
	</HEAD>
	<FRAMESET cols="200,*" bordercolor="#ebebeb">
		<FRAME SRC="<%=URLMenu%>" NAME="menu" SCROLLING="auto" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
