<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_QuotationEdit_Menu.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_QuotationEdit_Menu" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sourcing Menu</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" /> 
    <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>

    <style type="text/css">
    html, body , form {height:100%;}
    .wrapper {height:auto !important;min-height:100%;height:100%;}
    /*.guarantor {height:240px;} */
    .footer {position:relative;margin-top:50px;height:230px;}
    
    </style>   
    <style type="text/css">
             #imgContainer
            {
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

    <script type="text/javascript">
        $(document).ready(function () {
           // $(".footer").hide();
        });

        function showImage(src, name) {
            $("#lblImage").html(name);
            $("#styleImage").attr("src", src);
            $(".footer").show();
        }

        function hideImage() {
         //   $(".footer").hide();
        }

        window.onload = SetHoverEffects;

        function SetHoverEffects() {
            var width = 0;
            var height = 0;

            var intervalHandler;

            var hasDesignBack = false;

            hasDesignBack = $("#styleImageBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1;

            if (hasDesignBack) {
                width = Math.max($("#styleImage").width(), $("#styleImageBack").width());
                height = Math.max($("#styleImage").height(), $("#styleImageBack").height());
                
            }

            else {
                width = $("#styleImage").width();
                height = $("#styleImage").height();
            }

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

            if ($("#styleImageBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1) {
                $("#imgDesignBackContainer").css("visibility", "visible");
            }
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="wrapper">
    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="middle" align="left">
                <div>
                    &nbsp;
                    <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="../System/icons/icon_search.gif" OnClientClick="window.parent.location.href = 'Sourcing_Page_Folder.aspx'; return false;"></asp:ImageButton>
                    &nbsp;
                    <asp:ImageButton ID="btnRefresh" runat="server" ImageUrl="../System/icons/icon_refresh.gif"></asp:ImageButton></div>
            </td>
        </tr>
    </table>

    <cc1:YsTreeView ID="YSTreeView1" runat="server"></cc1:YsTreeView>
    <BR>
    <%--<div class="guarantor"></div>
    

    <div id="styleImageDiv" class="footer">--%>
   <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%" align="center">
               <asp:Label id="lblImage" runat="server">Quote Edit</asp:Label>&nbsp;&nbsp;
            </td>
        </tr>
        </table>
        <table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td align="center">
                    <div id="imgContainer">
                        <div id="imgDesignBackContainer">
                            <asp:Image runat="server" ID="styleImageBack" />
                        </div>
                        <div id="imgDesignContainer">
                            <asp:Image runat="server" ID="styleImage" />
                        </div>
                    </div>
                </td>
			</tr>
            <tr>
                <td align="center">
                    <asp:placeholder id="plhStyleDescriptionControl" runat="server"></asp:placeholder>
                </td>
            </tr>
		</table>
        <%--<div align="center">
            <div id="imgContainer">
                <div id="imgDesignBackContainer">
                    <asp:Image runat="server" ID="styleImageBack" />
                </div>
                <div id="imgDesignContainer">
                    <asp:Image runat="server" ID="styleImage" />
                </div>
            </div>
        </div>--%>
             
            <%--</div>
            </div>--%>
    </form>
</body>
</html>
