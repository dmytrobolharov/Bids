<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Division_Edit.aspx.vb" Inherits="plmOnApp.Control_Division_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Control Panel</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
    .rightAlign 
    {
    	text-align:right;
    }
    
    </style>
</head>
<body style="background-color: white">
    <form id="form1" runat="server">

    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" >
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
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
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSaveOnly" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSaveNew" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnDelete" runat="server" CausesValidation="false"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                </td>
            </tr>
        </table>
        <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
            cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td width="10">&nbsp;</td>
                <td>&nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
            </tr>
        </table>
        <table cellspacing="2" cellpadding="0"  border="0" style="background-color: white">
            <tr valign="top">
                <td width="25">&nbsp;</td>
                <td><asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder></td>
                <td width="300">
                    <asp:HiddenField ID="hdnImageID" runat="server"></asp:HiddenField>
                    <table cellspacing="0" cellpadding="0" width="100%" border="0" style="background-color:White">
                        <tr><td><table cellspacing="0" cellpadding="0" runat="server" id="tblUpload">
                            <tr>
                                <td class="fontHead" valign="top"><asp:Label ID="lblImageFile" runat="server"></asp:Label>&nbsp;</td>
                                <td class="font"><input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" /></td>
                            </tr>
                        </table></td></tr>
                        <tr><td class="font" width="50"><br /><asp:Image id="imgFeature" runat="server"/></td></tr>
                        <tr><td><br /><cc1:ConfirmedImageButton ID="btnImageRemove" runat="server" ToolTip="Delete Image File..." visible="false" /></td></tr>
                    </table>                
                </td>
            </tr>
        </table>
    </div>

    <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" height="30" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <asp:Label ID="lblDivisionalConfig" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <cc2:YSTabView ID="YSTabView" runat="server"></cc2:YSTabView>
    <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" DataKeyField="StyleCategoryID" AutoGenerateColumns="false">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
        <Columns>
            <asp:TemplateColumn>
                <HeaderStyle Width="130" />
                <ItemStyle CssClass="names" />
                <ItemTemplate>
                    <img runat="server" id="imgToggler" onclick='<%# String.Format("toggleRows(this, &#39;{0}&#39;)", Eval("StyleTypeID").ToString)%>'
                        style="cursor: pointer" src="../System/Icons/icon_Down.gif" alt="" />
                    <asp:Label runat="server" ID="lblName" Text='<%# Eval("Name") %>'></asp:Label>
                    <asp:HiddenField runat="server" ID="hdnStyleTypeID" Value='<%# Eval("StyleTypeID") %>' />
                    <asp:HiddenField runat="server" ID="hdnStyleCategoryID" Value='<%# Eval("StyleCategoryID") %>' />
                    <asp:HiddenField runat="server" ID="hdnRowName" Value='<%# Convert.ToString(Eval("StyleTypeDescription")) & "/" & Convert.ToString(Eval("StyleCategory")) %>'/>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblDimBOM" runat="server" Text='<%# GetSystemText("Dimensional BOM") %>' ToolTip='<%# GetSystemText("BOM will have dimensional functionality") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkDimBOM" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" Checked='<%# Eval("DimBOM") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblDimBOM" runat="server" Text='<%# GetSystemText("Default BOM Page") %>'  ToolTip='<%# GetSystemText("BOM will default to the BOM page. Otherwise default to the Colorway page") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkDefaultBOMPage" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" Checked='<%# Eval("DefaultBOMPage") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblDimBOM" runat="server" Text='<%# GetSystemText("Click-to-Fill Colorway") %>' ToolTip='<%# GetSystemText("Pitch colorways using any colors saved in the Color folder") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkFillColorway" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" Checked='<%# Eval("FillColorway") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblDimBOM" runat="server" Text='<%# GetSystemText("Default Active Color") %>' ToolTip='<%# GetSystemText("Defaults Active Color selection") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkActiveColor" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" Checked='<%# Eval("ActiveColor") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblDimensionOptions" runat="server" Text='<%# GetSystemText("Dimension Options") %>' ToolTip='<%# GetSystemText("Enable Dimension Options page") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkDimensionOptions" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" Checked='<%# Eval("DimensionOptions") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblDimension1" runat="server" Text='<%# GetSystemText("Dimension 1") %>' ToolTip='<%# GetSystemText("Default BOM Dimension") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="ddlItemDim1TypeId" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" AppendDataBoundItems="true"
                            DataTextField="DimTypeName" DataValueField="DimTypeId" DataSource='<%# DimTypeDataSource %>'>
                        <%--<asp:ListItem Value="00000000-0000-0000-0000-000000000000" Text='<%# "<" & GetSystemText("not used") & ">" %>'></asp:ListItem>--%>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblDimension2" runat="server" Text='<%# GetSystemText("Dimension 2") %>' ToolTip='<%# GetSystemText("Default BOM Dimension") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="ddlItemDim2TypeId" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" AppendDataBoundItems="true"
                            DataTextField="DimTypeName" DataValueField="DimTypeId" DataSource='<%# DimTypeDataSource %>'>
                        <%--<asp:ListItem Value="00000000-0000-0000-0000-000000000000" Text='<%# "<" & GetSystemText("not used") & ">" %>'></asp:ListItem>--%>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblDimension3" runat="server" Text='<%# GetSystemText("Dimension 3") %>' ToolTip='<%# GetSystemText("Default BOM Dimension") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="ddlItemDim3TypeId" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" AppendDataBoundItems="true"
                            DataTextField="DimTypeName" DataValueField="DimTypeId" DataSource='<%# DimTypeDataSource %>'>
                        <%--<asp:ListItem Value="00000000-0000-0000-0000-000000000000" Text='<%# "<" & GetSystemText("not used") & ">" %>'></asp:ListItem>--%>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblAutoSetSize" runat="server" Text='<%# GetSystemText("Auto Set Size") %>' ToolTip='<%# GetSystemText("Enable Auto Set Size") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkAutoSetSize" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" Checked='<%# Eval("AutoSetSize") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblShowLinePlanColors" runat="server" Text='<%# GetSystemText("Show Line Plan Colors") %>' ToolTip='<%# GetSystemText("Allow only colors that are the part of Line Plan") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkShowLinePlanColors" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" Checked='<%# Eval("ShowLinePlanColors") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>

    <asp:DataGrid ID="DataGrid2" runat="server" AllowSorting="True" DataKeyField="StyleCategoryID" AutoGenerateColumns="false">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
        <Columns>
            <asp:TemplateColumn>
                <HeaderStyle Width="130" />
                <ItemStyle CssClass="names" />
                <ItemTemplate>
                    <img runat="server" id="imgToggler" onclick='<%# String.Format("toggleRows(this, &#39;{0}&#39;)", Eval("StyleTypeID").ToString)%>'
                        style="cursor: pointer" src="../System/Icons/icon_Down.gif" alt="" />
                    <asp:Label runat="server" ID="lblName" Text='<%# Eval("Name") %>'></asp:Label>
                    <asp:HiddenField runat="server" ID="hdnStyleTypeID" Value='<%# Eval("StyleTypeID") %>' />
                    <asp:HiddenField runat="server" ID="hdnStyleCategoryID" Value='<%# Eval("StyleCategoryID") %>' />
                    <asp:HiddenField runat="server" ID="hdnRowName" Value='<%# Convert.ToString(Eval("StyleTypeDescription")) & "/" & Convert.ToString(Eval("StyleCategory")) %>'/>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblRestrictSize" runat="server" Text='<%# GetSystemText("Restrict Sizes") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkRestrictSize" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" Checked='<%# Eval("RestrictSize") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>

    <asp:DataGrid ID="DataGrid3" runat="server" AllowSorting="True" DataKeyField="LineListConfigID" AutoGenerateColumns="false">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
        <Columns>
            <asp:TemplateColumn>
                <HeaderStyle Width="130" />
                <ItemStyle CssClass="names" />
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblName" Text='<%# GetSystemText(Eval("LineListConfigName").ToString) %>'></asp:Label>
                    <asp:HiddenField runat="server" ID="hdnRowName" Value='<%# Convert.ToString(Eval("LineListConfigName")) %>'/>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblLockColorPalette" runat="server" Text='<%# GetSystemText("Planning Lock for Color Palette") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkLockColorPalette" runat="server" Checked='<%# Eval("PlanningLockColorPalette") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblLockMaterialPalette" runat="server" Text='<%# GetSystemText("Planning Lock for Material Palette") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkLockMaterialPalette" runat="server" Checked='<%# Eval("PlanningLockMaterialPalette") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>

    <asp:DataGrid ID="DataGrid4" runat="server" AllowSorting="True" DataKeyField="ReportTechPackFolderID" AutoGenerateColumns="false">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
        <Columns>
            <asp:TemplateColumn>
                <HeaderStyle Width="130" />
                <ItemStyle CssClass="names" />
                <ItemTemplate>
                    <img runat="server" id="imgToggler" onclick='<%# String.Format("toggleRows(this, &#39;{0}&#39;)", Eval("StyleTypeID").ToString)%>'
                        style="cursor: pointer" src="../System/Icons/icon_Down.gif" alt="" />
                    <asp:Label runat="server" ID="lblName" Text='<%# Eval("Name") %>'></asp:Label>
                    <asp:HiddenField runat="server" ID="hdnStyleTypeID" Value='<%# Eval("StyleTypeID") %>' />
                    <asp:HiddenField runat="server" ID="hdnReportTechPackFolderID" Value='<%# Eval("ReportTechPackFolderID") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="120" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <HeaderTemplate><asp:Label ID="lblAvailible" runat="server" Text='<%# GetSystemText("Predefined Tech Pack") %>' ></asp:Label></HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkAvailible" styletypeid='<%# Eval("StyleTypeID") %>' runat="server" Checked='<%# Eval("Availible") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>

    <%--<asp:datagrid id="DataGrid2" runat="server" AllowSorting="true" >
	<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
	<PagerStyle Visible="False"></PagerStyle>
    <Columns><asp:TemplateColumn Visible="false"></asp:TemplateColumn></Columns>
    </asp:datagrid>--%>

    </form>

    <script type="text/javascript" language="javascript">
        $("#DataGrid1 td:first").css({ border: 'none', visibility: 'hidden' });
        $(".TableHeader input[id*=chkDimBOM]").change(function () { $("span[styletypeid='" + $(this).parent().attr("styletypeid") + "'] input[id*=chkDimBOM]").prop('checked', this.checked); })
        $(".TableHeader input[id*=chkDefaultBOMPage]").change(function () { $("span[styletypeid='" + $(this).parent().attr("styletypeid") + "'] input[id*=chkDefaultBOMPage]").prop('checked', this.checked); })
        $(".TableHeader input[id*=chkFillColorway]").change(function () { $("span[styletypeid='" + $(this).parent().attr("styletypeid") + "'] input[id*=chkFillColorway]").prop('checked', this.checked); })
        $(".TableHeader input[id*=chkActiveColor]").change(function () { $("span[styletypeid='" + $(this).parent().attr("styletypeid") + "'] input[id*=chkActiveColor]").prop('checked', this.checked); })
        $(".TableHeader input[id*=chkDimensionOptions]").change(function () { $("span[styletypeid='" + $(this).parent().attr("styletypeid") + "'] input[id*=chkDimensionOptions]").prop('checked', this.checked); })
        $(".TableHeader input[id*=chkAutoSetSize]").change(function () { $("span[styletypeid='" + $(this).parent().attr("styletypeid") + "'] input[id*=chkAutoSetSize]").prop('checked', this.checked); })
        $(".TableHeader input[id*=chkShowLinePlanColors]").change(function () { $("span[styletypeid='" + $(this).parent().attr("styletypeid") + "'] input[id*=chkShowLinePlanColors]").prop('checked', this.checked); })

        $("#DataGrid2 td:first").css({ border: 'none', visibility: 'hidden' });
        $(".TableHeader input[id*=chkRestrictSize]").change(function () { $("span[styletypeid='" + $(this).parent().attr("styletypeid") + "'] input[id*=chkRestrictSize]").prop('checked', this.checked); })

        $("#DataGrid3 td:first").css({ border: 'none', visibility: 'hidden' });
        $(".TableHeader input[id*=chkLockColorPalette]").change(function () { $("input[id*=chkLockColorPalette]").prop('checked', this.checked); })
        $(".TableHeader input[id*=chkLockMaterialPalette]").change(function () { $("input[id*=chkLockMaterialPalette]").prop('checked', this.checked); })

        $("#DataGrid4 td:first").css({ border: 'none', visibility: 'hidden' });
        $(".TableHeader input[id*=chkAvailible]").change(function () { $("span[styletypeid='" + $(this).parent().attr("styletypeid") + "'] input[id*=chkAvailible]").prop('checked', this.checked); })

        function toggleRows(img, style_category) {
            if ($(img).closest("tr").nextUntil(".TableHeader").toggle().is(":visible")) {
                img.src = "../System/Icons/icon_Down.gif";
            } else {
                img.src = "../System/Icons/icon_Next.gif";
            }
        }
    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
