<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Frame.aspx.vb" Inherits="plmOnApp.Style_Frame" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<TITLE id="htmlHeader" runat="server" ></TITLE>
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../System/Jscript/Frameset.js"></script>
        <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

		<script type="text/javascript">
			if (window.screen) {
				var aw = screen.availWidth;
				var ah = screen.availHeight;
				window.moveTo(0, 0);
				window.resizeTo(aw, ah);
			}

            self.focus();

		</script>
	</HEAD>

    <script type="text/javascript">

        function changeTableHeader() {
            $(function () {
                $(document.getElementById("mainF")).load(function () {
                    $(document.getElementById("mainF").contentWindow.document.body).find("tr.TableHeader, table.TableHeader").removeClass("TableHeader").addClass("TableHeaderYellow");
                });
            });
        }

        if (<%= IsSilhouette %>) {
            changeTableHeader();
        }

    </script>


	<FRAMESET cols="<%=FrameSize%>,*" bordercolor="#ebebeb" onload="">
     
		<FRAME SRC="<%=URLMenu%>" NAME="menu" scrolling="yes" marginheight=0 marginwidth=0 >
		<frame name="main" id="mainF" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>

</HTML>
