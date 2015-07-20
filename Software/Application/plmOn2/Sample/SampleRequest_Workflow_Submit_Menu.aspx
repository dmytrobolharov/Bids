<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Menu.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		 <title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>
        <style type="text/css">
             #imgContainer
            {
            	width: 120px;
            	height: 120px;
                position:relative;
            }
            #imgContainer div 
            {
                position:absolute;
                left:0;
                background-color: White;
                visibility: hidden;
            }
            #imgContainer div img
            {
                width: 100%;
                max-height: 100%;
            }
        </style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" height="27" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="center">
                            <asp:Label ID="lblSampleRequestH" runat="server" ></asp:Label>&nbsp;
						</div>
					</td>
				</tr>
			</TABLE>
			<cc1:ystreeview id="YSTreeView1" runat="server"></cc1:ystreeview><br>
			<table class="TableHeaderOver" height="24" cellSpacing="0" cellPadding="0" width="100%"
				border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="center">
                            <asp:Label ID="lblStyleH" runat="server"></asp:Label>
						</div>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center">
                        <div id="imgContainer">
                            <div id="imgDesignBackContainer">
                                <cc2:bwimagebutton id="imgDesignBack" runat="server"></cc2:bwimagebutton>
                            </div>
                            <div id="imgDesignContainer">
                                <cc2:bwimagebutton id="imgDesign" runat="server"></cc2:bwimagebutton>
                            </div>
                        </div>
                    </td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center">
						<asp:Label id="lblStyleNo" runat="server" CssClass="fonthead"></asp:Label></td>
				</tr>
				<TR>
					<TD align="center">
						<asp:Label id="lblStyleDescription" runat="server" CssClass="fonthead"></asp:Label></TD>
				</TR>
				<TR>
					<TD align="center">
						<asp:Label id="lblStyleColor" runat="server" CssClass="fonthead"></asp:Label></TD>
				</TR>
				<TR>
					<TD align="center">
						<asp:Label id="lblDIM1" runat="server" CssClass="fonthead"></asp:Label></TD>
				</TR>
				<TR>
					<TD align="center">
						<asp:Label id="lblDIM2" runat="server" CssClass="fonthead"></asp:Label></TD>
				</TR>
				<TR>
					<TD align="center">
						<asp:Label id="lblDIM3" runat="server" CssClass="fonthead"></asp:Label></TD>
				</TR>
			</table>
		</form>
        <script type="text/javascript" language="javascript">
            $(window).load(function () {
                var width = 0;
                var height = 0;

                var intervalHandler;

                var hasDesignBack = false;

                hasDesignBack = $("#imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1;

                if (hasDesignBack) {
                    width = Math.max($("#imgDesign").get(0).width, $("#imgDesignBack").get(0).width);
                    height = Math.max($("#imgDesign").get(0).height, $("#imgDesignBack").get(0).height);
                }
                else {
                    width = $("#imgDesign").get(0).width;
                    height = $("#imgDesign").get(0).height;
                }

                if (width == null || width == 0)
                    width = 100;
                if (height == null || height == 0)
                    height = 100;

                $("#imgContainer")
                    .mouseover(function () {
                        if (hasDesignBack) {
                            $("#imgDesignContainer").fadeOut();
                            clearInterval(intervalHandler);
                            var elementToToggle = $("#imgDesignContainer");
                            intervalHandler = setInterval(function () {
                                elementToToggle.fadeToggle()
                            }, 1200);
                        }
                    })
                    .mouseleave(function () {
                        if (hasDesignBack) {
                            clearInterval(intervalHandler);
                            $("#imgDesignContainer").fadeIn();
                        }
                    });


                $("#imgContainer").css({
                    "width": width,
                    "height": height
                });

                $("#imgDesignBackContainer").css({
                    "width": width,
                    "height": height
                });

                $("#imgDesignContainer").css({
                    "width": width,
                    "height": height
                });

                $("#imgDesignContainer").css("visibility", "visible");

                if ($("#imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1) {
                    $("#imgDesignBackContainer").css("visibility", "visible");
                }
            });
        </script>
	</body>
</HTML>
