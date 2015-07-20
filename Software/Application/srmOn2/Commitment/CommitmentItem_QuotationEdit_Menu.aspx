<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CommitmentItem_QuotationEdit_Menu.aspx.vb" Inherits="srmOnApp.CommitmentItem_QuotationEdit_Menu" %>
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
    .guarantor {height:240px;} 
    .footer {position:relative;margin-top:-500px;height:230px;}
    
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
                    <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="../System/icons/icon_search.gif" OnClientClick="window.parent.location.href = 'Commitment_Grid.aspx?CL=H'; return false;"></asp:ImageButton>
                    &nbsp;
                    <asp:ImageButton ID="btnRefresh" runat="server" ImageUrl="../System/icons/icon_refresh.gif"></asp:ImageButton></div>
            </td>
        </tr>
    </table>

    <cc1:YsTreeView ID="YSTreeView1" runat="server"></cc1:YsTreeView>
    <div class="guarantor"></div>
    </div>

  <!--  <div id="styleImageDiv" class="footer">
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
        <div align="center">
            <img id="styleImage" src="" width="100%" alt="" />
            </div>
             <asp:placeholder id="plhStyleDescriptionControl" runat="server"></asp:placeholder>
            </div>-->
    </form>
</body>
</html>
