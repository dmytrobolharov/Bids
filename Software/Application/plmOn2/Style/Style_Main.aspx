<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Main.aspx.vb" Inherits="plmOnApp.Style_Main" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Variation" Src="Style_Variation.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Variation</title>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">		
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style type="text/css">
             .imgContainer
            {
                position:relative;
            }
            .imgContainer div 
            {
                position:absolute;
                left:0;
                background-color: White;
                visibility: hidden;
            }
            .imgContainer div img
            {
                width: 100%;
                max-height: 100%;
            }
            
        </style>
	</head>
	<BODY>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="100%">&nbsp;
						<cc1:confirmedimagebutton id="btnEdit" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:BWImageButton id="btnCopy" runat="server"  Message="NONE"></cc1:BWImageButton>
                    </td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="10" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="top"><asp:datalist id="dlVariation" runat="server" RepeatDirection="Horizontal">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
									<tr valign="middle">
										<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td>
											<asp:Label id=lblVariation runat="server" CssClass="fontHead">
											</asp:Label></td>
									</tr>
								</table>
								<uc1:Style_Variation id="Style_Variation1" runat="server" StyleDevelopmentID='<%# string.Concat(DataBinder.Eval(Container.DataItem, "StyleDevelopmentID").ToString) %>' StyleVariation='<%# string.Concat(DataBinder.Eval(Container.DataItem, "Variation").ToString) %>'>
								</uc1:Style_Variation>
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist></td>
				</tr>
			</table>
		</form>
        <script type="text/javascript" language="javascript">
            $(window).load(function () {
                    var width = 0;
                    var height = 0;

                    var intervalHandlers = new Array();

                    $(".imgContainer").each(function (index) {
                        $(this).attr("id", index);

                        var hasDesignBack = false;

                        hasDesignBack = $(this).find(".imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1;

                        if (hasDesignBack) {
                            width = Math.max(width, Math.max($(this).find(".imgDesign").get(0).width, $(this).find(".imgDesignBack").get(0).width));
                            height = Math.max(height, Math.max($(this).find(".imgDesign").get(0).height, $(this).find(".imgDesignBack").get(0).height));
                        }

                        else {
                            width = Math.max(width, $(this).find(".imgDesign").get(0).width);
                            height = Math.max(height, $(this).find(".imgDesign").get(0).height);
                        }

                        $(this)
                        .mouseover(function () {
                            if (hasDesignBack) {
                                $(this).find(".imgDesignContainer").fadeOut();
                                clearInterval(intervalHandlers[$(this).attr("id")]);
                                var elementToToggle = $(this).find(".imgDesignContainer");
                                intervalHandlers[$(this).attr("id")] = setInterval(function () {
                                    elementToToggle.fadeToggle()
                                }, 1200);
                            }
                        })
                        .mouseleave(function () {
                            if (hasDesignBack) {
                                clearInterval(intervalHandlers[$(this).attr("id")]);
                                $(this).find(".imgDesignContainer").fadeIn();
                            }
                        });

                    });

                    $(".imgContainer").css({
                        "width": width,
                        "height": height
                    });

                    $(".imgDesignBackContainer").css({
                        "width": width,
                        "height": height
                    });

                    $(".imgDesignContainer").css({
                        "width": width,
                        "height": height
                    });

                    $(".imgContainer").each(function (index) {
                        $(this).find(".imgDesignContainer").css("visibility", "visible");

                        if ($(this).find(".imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1) {
                            $(this).find(".imgDesignBackContainer").css("visibility", "visible");
                        }
                    });
                });

        </script>
	</BODY>
</html>
