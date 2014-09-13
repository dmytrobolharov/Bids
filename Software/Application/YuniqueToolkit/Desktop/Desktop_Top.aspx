<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Desktop_Top.aspx.vb" Inherits="YuniFace.Desktop_Top" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title></title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />

        <script language="javascript" src="../System/Jscript/System.js"></script>

        <style type="text/css">
            td.off
            {
                background: #eff0f2;
            }
            td.on
            {
                background: #eff0f2;
            }
        </style>

        <script language="javascript" type="text/javascript">
            function BindMouseOverImage(ID, Path) {
                document.getElementById('' + ID + '').src = Path
            }
        
        </script>
    </head>
    <body>
        <form id="form1" runat="server">
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
                <Scripts>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js">
                    </asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js">
                    </asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js">
                    </asp:ScriptReference>
                </Scripts>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadScriptManager>
            <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
                <StyleSheets>
                    <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
                </StyleSheets>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadStyleSheetManager>
            <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

            <div>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr class="ToolbarLtBlue">
                        <td>
                            <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" Height="50" CellPadding="2" CellSpacing="0">
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                                <ItemTemplate>
                                    <table runat="server" id="toolbarButton" cellspacing="0" cellpadding="0" width="65" border="0" style="border: thin solid #eff0f2;">
                                        <tr>
                                            <td class="off" onmouseover="this.className='on'" onmouseout="this.className='off'">
		                                        <table cellspacing="0" cellpadding="0" width="65" border="0">		                            
			                                        <tr>
				                                        <td height="25" align="center"><asp:Image ID="imgIcon" runat="server" ImageAlign="Middle" /></td>
			                                        </tr>                     
			                                    </table>	        
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                        </td>
                        <td align="right">
                            <img alt="" src="../System/Images/company_logo.png" />
                        </td>
                        <td width="10">
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" height="45" border="0">
                    <tr class="TableHeaderLtBlue">
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>
