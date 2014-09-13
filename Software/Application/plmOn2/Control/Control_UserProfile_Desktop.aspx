<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_UserProfile_Desktop.aspx.vb" Inherits="plmOnApp.Control_UserProfile_Desktop" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Desktop Settings</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1">
    </telerik:RadScriptManager>
    <telerik:RadScriptBlock runat="Server" ID="RadScriptBlock1">

        <script type="text/javascript">
            /* <![CDATA[ */
            function BindMouseOverImage(elem, Path) {
                elem.src = Path
            }
            
            var gridId = "desktopGridContainer";
            function isMouseOverGrid(target) {
                parentNode = target;
                while (parentNode != null) {
                    if (parentNode.id == gridId) {
                        return parentNode;
                    }
                    parentNode = parentNode.parentNode;
                }

                return null;
            }

            function droppedOnGrid(args) {
                var target = args.get_htmlElement();

                while (target) {
                    if (target.id == gridId || target.id.indexOf("imgDeskTopItem_") > -1) {
                        args.set_htmlElement(target);
                        return;
                    }

                    target = target.parentNode;
                }
                args.set_cancel(true);
            }

            function onNodeDropping(sender, args) {
                var dest = args.get_destNode();

                if (!dest) {
                    droppedOnGrid(args);
                }
            }            
            /* ]]> */
        </script>

    </telerik:RadScriptBlock>
    <telerik:RadAjaxManager ID="radAjaxManager" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="radDeskMenuTree">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="radDeskMenuTree" />
                    <telerik:AjaxUpdatedControl ControlID="radDesktopGrid" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="radDesktopGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="radDeskMenuTree" />
                    <telerik:AjaxUpdatedControl ControlID="radDesktopGrid" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnReset">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="radDeskMenuTree" />
                    <telerik:AjaxUpdatedControl ControlID="radDesktopGrid" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    
    <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1" MinDisplayTime="500" EnableSkinTransparency="false">
    </telerik:RadAjaxLoadingPanel>
        
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:confirmedimagebutton id="btnReset" runat="server" message="NONE"></cc1:confirmedimagebutton>
            </td>
            <td class="FontHead" align="right" width="75">
                &nbsp;
            </td>
            <td width="40">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <div id="desktopGridContainer">
        <telerik:RadListView runat="server" ID="radDesktopGrid" DataKeyNames="DeskTopID" ItemPlaceholderID="DeskTopContainer">
            <LayoutTemplate>
                <table cellpadding="2" cellspacing="0">
                    <tbody>
                        <tr runat="server" id="DeskTopContainer"></tr>
                    </tbody>
                </table>
            </LayoutTemplate>
            <EmptyDataTemplate>
                Drop items here
            </EmptyDataTemplate>
            <ItemTemplate>
                <td class="rlvI">
                    <span class="rlvDrag">                                                
                        <img id="imgDeskTopItem_<%# Eval("DeskTopID") %>" src='<%# GetImagePath(Eval("DeskButtonName"), UserProperties.PrefLang) %>'
                            alt="" onmousedown='<%# String.Format("Telerik.Web.UI.RadListView.HandleDrag(event, &#39;{0}&#39;, {1})", Container.OwnerListView.ClientID, Container.DisplayIndex) %>'
                            onmouseover='<%# String.Format("BindMouseOverImage(this, &#39;{0}&#39;)", GetImagePath(Eval("DeskButtonName").Replace(".", "_over."), UserProperties.PrefLang)) %>'
                            onmouseout='<%# String.Format("BindMouseOverImage(this, &#39;{0}&#39;)", GetImagePath(Eval("DeskButtonName"), UserProperties.PrefLang)) %>'
                            title="<%# GetSystemText(Eval("DeskLabel1") & " " & Eval("DeskLabel2")) %>" />
                    </span>
                </td>
            </ItemTemplate>
            <ClientSettings AllowItemsDragDrop="true">                
            </ClientSettings>
        </telerik:RadListView>
    </div>
    
    <telerik:RadTreeView ID="radDeskMenuTree" runat="server" EnableDragAndDrop="true" EnableDragAndDropBetweenNodes="true"
        OnClientNodeDropping="onNodeDropping" Width="300px">
    </telerik:RadTreeView>
    </form>
</body>
</html>
