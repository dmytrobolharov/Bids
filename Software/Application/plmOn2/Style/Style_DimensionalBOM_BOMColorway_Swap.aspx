<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_BOMColorway_Swap.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_BOMColorway_Swap" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />    
    <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
    <script language="javascript" src="../system/jscript/underscore-min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null; if (window.radWindow)
                oWindow = window.radWindow; else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow; return oWindow;
        }

        function closeWindow() {
            GetRadWindow().close();
            return false;
        }

        function refreshAndCloseWindow() {
            GetRadWindow().BrowserWindow.location.href = GetRadWindow().BrowserWindow.location.href;
            GetRadWindow().close();
        }
    </script>
    <style type="text/css">
        .color-chip {            
            vertical-align: middle;
        }

        #dgColors td {
            padding: 3px;
        }
    </style>
</head>
<body style="background-color: #ffffff;">
    <form id="Form1" method="post" runat="server">
    
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
            <asp:ScriptReference Path="../System/Jscript/jquery-ui-1.10.3.custom.min.js" />
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
        <StyleSheets>            
            <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />            
        </StyleSheets>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadStyleSheetManager>

    <div id="divStyleColors" style="overflow: auto; height: 430px; border-bottom: 1px solid gainsboro;">
        <asp:DataGrid ID="dgColors" runat="server" AutoGenerateColumns="false" DataKeyField="DimId">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
            <Columns>
                <asp:TemplateColumn>
                    <HeaderStyle HorizontalAlign="Center" />
                    <HeaderTemplate>
                        <%# GetSystemText("Existing Colorway")%>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Image runat="server" ID="imgColor" ImageUrl='<%#GetColorStreamPath("25", Eval("ColorFolderID").ToString, Eval("ColorPaletteID").ToString) %>' 
                            ImageAlign="Left" CssClass="color-chip" />
                        <asp:Label runat="server" ID="lblColorName" Text='<%# String.Format("{0} - {1}", Eval("ColorName"), Eval("ColorCode")) %>'></asp:Label>
                        <asp:HiddenField runat="server" ID="hdnColorPaletteID" Value='<%# Eval("ColorPaletteID") %>' />
                    </ItemTemplate>
                </asp:TemplateColumn>                    
                <asp:TemplateColumn>
                    <HeaderStyle HorizontalAlign="Center" />
                    <HeaderTemplate>
                        <%# GetSystemText("Replacement Colorway")%>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Image runat="server" ID="imgColorReplacement" ImageUrl='<%#GetColorStreamPath("25", Guid.Empty.ToString, Guid.Empty.ToString) %>'
                            ImageAlign="Left" CssClass="color-chip" />
                        <telerik:RadComboBox ID="rcbColorReplacement" runat="server" Width="200" EnableLoadOnDemand="true" EnableEmbeddedSkins="false"
                            Skin="YPLM" ShowMoreResultsBox="true" EnableVirtualScrolling="true" AutoPostBack="false" OnItemsRequested="rcbColorReplacement_ItemsRequested"
                            HighlightTemplatedItems="true" OnClientSelectedIndexChanged="rcbSelectionChanged">
                        </telerik:RadComboBox>                        
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
    </div>
    <div style="width: 100%; text-align: right;">
        <asp:Button ID="btnSave" runat="server" OnClientClick="return checkDuplicates();" />
        <asp:Button ID="btnCancel" runat="server" OnClientClick="return closeWindow();" />
    </div>
    </form>
    <script type="text/javascript">
        $("#btnSave, #btnCancel").button().css("color", "#000000");
        
        function rcbSelectionChanged(sender, args) {
            var value = args.get_item().get_value(),
                $img = $("#" + sender.get_id())
                        .siblings("img[id*=imgColorReplacement]")
                        .eq(0);

            if (value.indexOf(":") != -1) {
                var colorInfo = value.split(":");
                $img.attr("src", GetClientColorStreamPath(colorInfo[0], colorInfo[1]));
            } else {
                $img.attr("src", GetClientColorStreamPath('<%= Guid.Empty.ToString %>', '<%= Guid.Empty.ToString %>'));
            }
        }

        function GetClientColorStreamPath(ColorFolderID, ColorPaletteID) {
            return '<%=GetColorStreamPath("25", "{{ColorFolderID}}", "{{ColorPaletteID}}") %>'.replace("{{ColorFolderID}}", ColorFolderID).replace("{{ColorPaletteID}}", ColorPaletteID);
        }

        function allComboBoxes() {            
            return _.map($("[id$='rcbColorReplacement']"), function (item) {
                return $find(item.id);
            });
        }

        function allComboBoxesValues() {
            return _.invoke(allComboBoxes(), 'get_value');
        }

        function hasDuplicates(xs) {
            return _.any(xs, function (x, i) {                
                return _.contains(_.drop(xs, i + 1), x);
            });
        }        

        function checkDuplicates() {
            if (hasDuplicates(_.compact(allComboBoxesValues()))) {
                alert('<%=GetSystemText("There are duplicate colors") %>');
                return false;
            } else {
                return confirm('<%=GetSystemText("Are you sure you want to continue?") %>');
            }
        }
    </script>
</body>
</html>
