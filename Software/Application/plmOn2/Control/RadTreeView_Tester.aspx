<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RadTreeView_Tester.aspx.vb" Inherits="plmOnApp.RadTreeView_Tester" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Measurement Panel</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

    <script type="text/javascript">
        function onNodeClicked(sender, args)
	    {
	        if (args.get_node().get_text() == "NavigateUrl")
	        {
	            var url = args.get_node().get_navigateUrl();
	            var if1 = document.getElementById("measmain"); 
	            if1.src = url; 
	            var prevNode = node.get_nextNode();
	            prevNode.get_parent().expand();
	            node.select(); 
	        }
	    }  
    </script>
</head>

<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" style="height: 25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td valign="middle" align="left">
                <div>
                    <asp:ImageButton ID="btnRefresh" runat="server" ImageUrl="../System/icons/icon_refresh.gif">
                    </asp:ImageButton>
                </div>
            </td>
        </tr>
    </table>
    
    <%--<cc1:YSTreeView id="YSTreeView1" runat="server" ></cc1:YSTreeView>--%>

    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    
    <%-- 
    <telerik:RadTreeView ID="RadTreeView1" runat="server" OnClientNodeClicked="onNodeClicked"
        Font-Bold="True">
    </telerik:RadTreeView>
    --%>

	<telerik:RadTreeView ID="RadTreeView1" runat="server" Font-Bold="True">
        <WebServiceSettings Path="RadTreeView_Tester.aspx" Method="LoadNodes" />
	</telerik:RadTreeView>

    </form>
</body>
</html>
