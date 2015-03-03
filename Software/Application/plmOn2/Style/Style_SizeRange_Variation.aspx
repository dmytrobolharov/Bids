<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_SizeRange_Variation.aspx.vb"
    Inherits="plmOnApp.Style_SizeRange_Variation" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title>Select...</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <style type="text/css">
        .BOMColorwayList
        {
        	width: 200px;
        }
    </style>
</head>
<body>
 <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnVariation" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSaveMeasurements" runat="server" Message="NONE" />
                <cc1:ConfirmedImageButton ID="btnLink" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td width="100%">
            </td>
        </tr>
    </table>
    <table width="100%" bgcolor="#ffffff" border="0" class="CodeBlockGreen">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Label ID="lblOptions" runat="server" CssClass="fontHead">Please select options...</asp:Label>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td>
                <asp:RadioButtonList ID="rbSizeVariation" runat="server" CssClass="fontHead" AutoPostBack="True">
                </asp:RadioButtonList>
            </td>
            <td width="50">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table id="tbSizeRange" width="100%" bgcolor="#ffffff" border="0" runat="server"
        class="CodeBlockBlue">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Label ID="lblCopyFromSize" runat="server" CssClass="fontHead">Select size to copy from...</asp:Label><br>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td width="400">
                <asp:RadioButtonList ID="rbSizeCopyFrom" runat="server" CssClass="fontHead" AutoPostBack="True">
                </asp:RadioButtonList>
            </td>
            <td width="50">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table id="tbMeasPageSelect" width="100%" bgcolor="#ffffff" border="0" runat="server" class="CodeBlockBlue" visible="false">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Label ID="lblSelectMeasPage" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td width="400">
                <asp:RadioButtonList ID="rbMeasPageList" runat="server" CssClass="fontHead" AutoPostBack="True">
                </asp:RadioButtonList>
            </td>
            <td width="50">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table id="tbStyleNew" width="100%" bgcolor="#ffffff" border="0" runat="server" class="CodeBlockBlue">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Label ID="Label1" runat="server" CssClass="fontHead">Select new size class...</asp:Label>&nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td>
                <asp:RadioButtonList ID="rbSizeClass" runat="server" CssClass="fontHead" AutoPostBack="True">
                </asp:RadioButtonList>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table id="tbStyleNewSizeRange" width="100%" bgcolor="#ffffff" border="0" runat="server"
        class="CodeBlockBlue">
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td>
                <asp:Label ID="lblOptionSizerange" runat="server" CssClass="fontHead">Select new size range...</asp:Label><br />
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td>
                <asp:DataList runat="server" ID="dlStyleSets" DataKeyField="StyleSet">
                    <AlternatingItemStyle CssClass="AlternateItemTemplate" BorderWidth="0px"></AlternatingItemStyle>
                    <ItemStyle CssClass="ItemTemplate" BorderWidth="0px"></ItemStyle>
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td width="75">
                                    <asp:Label runat="server" ID="lblStyleSet" CssClass="fontHead" Width="75"></asp:Label>
                                </td>
                                <td align="left" width="350">
                                    <asp:RadioButtonList ID="rbSR" runat="server" CssClass="fontHead" RepeatDirection="Vertical" Width="350">
                                    </asp:RadioButtonList>
                                </td>
                                <td width="100%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trSizeList" runat="server" visible="false">
                                <td colspan="3">

                                        <table cellspacing="1" cellpadding="1" width="100%">
                                            <tr ID="selectAllPanell" visible = "false" runat="server">
                                                <td>
                                                    <div class="TableHeader">
                                                        <asp:CheckBox runat="server" ID="chbSelectAllSR" Visible="true" Checked="false"
                                                        onclick="SelectAllSizeRange(this)"/>
                                                        <asp:Label runat="server" ID="lblDim1Name" class="fontHead"></asp:Label>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:DataList ID="dlSizeCols" DataKeyField="SizeName" runat="server" RepeatDirection="Horizontal" CellPadding="0" CellSpacing="0">
                                                        <ItemTemplate>
                                                            <table cellpadding="0" cellspacing="0" style="border: 1px solid gainsboro;">
                                                                <thead>
                                                                    <tr class="TableHeader" style="height: 20px;">
                                                                        <th>
                                                                            <asp:Label ID="lblSizeLabel" runat="server"><%# DataBinder.Eval(Container.DataItem, "Sizename").ToString() %></asp:Label>
                                                                        </th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="height: 20px;">
                                                                            <asp:CheckBox class="selectSize" ID="chbSelectSize" runat="server" Width="100" />
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                </td>
                                            </tr>
                                        </table>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table id="tbStyle" width="100%" bgcolor="#ffffff" border="0" runat="server" class="CodeBlockBlue">
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td>
                &nbsp;
                <asp:Label ID="lblOptionStyle" runat="server" CssClass="fontHead">Please select a size...</asp:Label><br>
                <asp:RadioButtonList ID="rbStyle" runat="server" CssClass="fontHead" AutoPostBack="True">
                </asp:RadioButtonList>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:DataGrid ID="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid"
        BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" Width="100%">
        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
        <Columns>
            <asp:TemplateColumn HeaderText=" Select ">
                <HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                <ItemTemplate>
                    <asp:Label ID="lblRadio" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Select Spec From...">
                <ItemTemplate>
                    <asp:Label ID="lblSpec" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <table id="tbSeasonYear" width="400" bgcolor="#ffffff" border="0" runat="server"
        class="CodeBlockYellow">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Label ID="lblSeasonYear" runat="server" CssClass="fontHead">Select Season & Year...</asp:Label>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td>
                &nbsp;&nbsp;<asp:DropDownList ID="ddlSeasonYear" runat="server" AutoPostBack="True">
                </asp:DropDownList>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>

    <table id="tbDimBoms" width="400" bgcolor="#ffffff" border="0" runat="server" visible="false"
        class="CodeBlockYellow">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Label ID="lblDimBoms" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td>
                <asp:DataList ID="dlDimBoms" runat="server" RepeatDirection="Vertical" CssClass="font" DataKeyField="StyleBOMDimensionID">
                    <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chbDimBom" Text='<%# Eval("WorkFlowItemName") %>' CssClass="fontHead" onclick="ShowBOMColorways(this);"/>
                            <asp:DataList ID="dlBomColorway" runat="server" DataKeyField="StyleColorID" BorderColor="Silver" 
                                RepeatDirection="Horizontal" CellPadding="0" CellSpacing="0" style="display:none;">
                                <ItemStyle CssClass="BOMColorway" />
                                <AlternatingItemStyle CssClass="BOMColorway" />
                                <ItemTemplate>
                                    <table cellspacing="0" style="border: 1px solid gainsboro;" width="100%">
                                        <thead>
                                            <tr class="TableHeader" height="20">
                                                <th colspan="2">
                                                    <asp:Label ID="lblColorwayName" runat="server" CssClass="fontHead"><%# Eval("ColorName")%></asp:Label>
                                                    <asp:HiddenField ID="hdnColorwayName" runat="server" Value='<%# Eval("ColorName")%>' />
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="font">
                                                <td colspan="2">
                                                    <asp:CheckBox ID="chbColorwaySelected" runat="server" Checked="true"/>
                                                </td>
                                            </tr>
                                            <tr class="font">
                                                <td width="20">
                                                    <asp:Image ID="imgColorway" runat="server" Width="20" Height="20" ImageUrl='<%# GetColorStreamPath("20", Eval("ColorFolderID").ToString(), Eval("ColorPaletteID").ToString()) %>' />
                                                </td>
                                                <td style="text-align: left;" width="95%">
                                                    <asp:Label ID="lblColorwayCode" runat="server"><%# Eval("ColorCode") %></asp:Label>
                                                    <asp:HiddenField ID="hdnColorwayCode" runat="server" Value='<%# Eval("ColorCode")%>' />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                    </ItemTemplate>
                </asp:DataList>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>

    <table id="tbStyleColorway" width="400" bgcolor="#ffffff" border="0" runat="server"
        class="CodeBlockYellow">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Label ID="Label2" runat="server" CssClass="fontHead">Select Colorway...</asp:Label>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td>
                <asp:DataGrid ID="dgStyleColorway" runat="server" DataKeyField="StyleColorwaySeasonYearID"
                    AutoGenerateColumns="False" EnableViewState="true" BorderWidth="0px" CssClass="fontHead"
                    GridLines="None" ShowHeader="False">
                    <AlternatingItemStyle Height="20px"></AlternatingItemStyle>
                    <ItemStyle Height="20px"></ItemStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chkSelect" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <ItemTemplate>
                                <asp:Label ID="lblColorName" runat="server" Text='<%#Container.DataItem("ColorName")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>

    <table id="tbBOMWorkflowItems" width="400" bgcolor="#ffffff" border="0" runat="server"
        class="CodeBlockYellow">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Label ID="lblBOMWorkflowItems" runat="server" CssClass="fontHead">Select BOMs...</asp:Label>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td>
                <asp:DataList ID="dlBOMWorkflowItems" runat="server" DataKeyField="WorkflowItemMasterID"
                    EnableViewState="true" BorderWidth="0px" CssClass="fontHead" RepeatDirection="Vertical">
                    <ItemTemplate>
                        <div>
                            <label><input type="checkbox" runat="server" id="chbWorkflowItemSelect" onclick="ShowBOMSeasonYears(this);" /> <%# Eval("WorkflowItemName") %></label>
                        </div>
                        <asp:DataList ID="dlWorkflowBOMs" runat="server" DataKeyField="StyleBOMDimensionID" RepeatDirection="Horizontal" 
                            EnableViewState="true" CellPadding="5" CellSpacing="5" style="display:none;">
                            <ItemStyle VerticalAlign="Top" CssClass="BOMColorwayList" />
                            <AlternatingItemStyle VerticalAlign="Top" CssClass="BOMColorwayList" />
                            <ItemTemplate>
                                <table width="100%" cellspacing="0" cellpadding="3">
                                    <tr class="TableHeader" style="height:20px;">
                                        <td width="30"><input type="checkbox" id="selectAllBOMColorway" runat="server" onclick="SelectAllBOMColorways(this);" checked="checked" /></td>
                                        <td><asp:Label runat="server" ID="lblSeasonYearID" CssClass="fontHead"><%# Eval("Season") & " " & Eval("Year") %></asp:Label></td>
                                    </tr>
                                </table>
                                <asp:DataList ID="dlBOMColorways" runat="server" DataKeyField="StyleColorID" RepeatDirection="Vertical">
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td style='width: 30px; height: 30px; text-align: left; vertical-align: top;
                                                    background-image:url(<%# GetColorStreamPath("30", Eval("ColorFolderID").ToString(), Eval("ColorPaletteID").ToString()) %>)'>
                                                    <label style="width: 30px; height: 30px; position: absolute;">
                                                        <input type="checkbox" ID="chbBOMColorwaySelected" runat="server" checked="checked" />
                                                    </label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblColorwayCode" runat="server" CssClass="font"><%# Eval("ColorCode") %></asp:Label>
                                                    <asp:HiddenField ID="hdnColorCode" runat="server" Value='<%# Eval("ColorCode") %>' />
                                                    <br />
                                                    <asp:Label ID="lblColorwayName" runat="server" CssClass="font"><%# Eval("ColorName") %></asp:Label>
                                                    <asp:HiddenField ID="hdnColorName" runat="server" Value='<%# Eval("ColorName") %>' />
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                            </ItemTemplate>
                        </asp:DataList>
                    </ItemTemplate>
                </asp:DataList>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>

    <table id="tbLinePlan" width="400" bgcolor="#ffffff" border="0" runat="server" class="CodeBlockRed">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr runat="server" id="trLPAdd">
            <td width="10">
                &nbsp;
            </td>
            <td>
                &nbsp;&nbsp;<asp:CheckBox ID="cbLinePlanSelect" runat="server" CssClass="fontHead"
                    Text="AddStytleToLinePlan" />
            </td>
            <td width="50">
                &nbsp;
            </td>
        </tr>
        <tr runat="server" id="trLPSelect">
            <td width="10">
                &nbsp;
            </td>
            <td>
                &nbsp;&nbsp;<asp:RadioButtonList ID="rbLinePlan" runat="server" CssClass="fontHead" />
            </td>
            <td width="50">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    </form>
</body>

<script type="text/javascript">
    function ShowBOMColorways(sender) {
        if (sender.checked) {
            $(sender).closest("td").find("table[id*='dlBomColorway']").show();
        } else {
            $(sender).closest("td").find("table[id*='dlBomColorway']").hide();
        }
    }

    function ShowBOMSeasonYears(sender) {
        if (sender.checked) {
            $(sender).closest("td").find("table[id*='dlWorkflowBOMs']").show();
        } else {
            $(sender).closest("td").find("table[id*='dlWorkflowBOMs']").hide();
        }
    }

    function SelectAllBOMColorways(sender) {
        $(sender).closest("td.BOMColorwayList").find("input[type='checkbox'][id*='chbBOMColorwaySelected']").each(function () {
            $(this)[0].checked = sender.checked;
        });
    }

    // This is the function which unchecks 'Select All' checkbox near the Season/Year name.
    // Add it as 'onclick' action of the chbBOMColorwaySelected, if you want this to be done.
    // Though this may be confusing, as there's no 'Select All' label near the checkbox, and customer MAY think he's unselecting the whole season/year by unselecting 
    // just one particular colorway.
    function CheckColorwaysSelection(sender) {
        var checkedAll = true;
        var dataListItem = $(sender).closest("td.BOMColorwayList");

        if (!sender.checked) {
            checkedAll = false;
        } else {
            $(dataListItem).find("input[type='checkbox'][id*='chbBOMColorwaySelected']").each(function () {
                if (!$(this)[0].checked) {
                    checkedAll = false;
                    return false;
                }
            });
        }
        $(dataListItem).find("input[type='checkbox'][id*='selectAllBOMColorway']")[0].checked = checkedAll;
    }

    $(document).ready(function () {
        $(document).find("input[id*='chbDimBom']").each(function () {
            ShowBOMColorways($(this)[0]);
        });

        $(document).find("input[id*='chbWorkflowItemSelect']").each(function () {
            ShowBOMSeasonYears($(this)[0]);
        });
    });

    function SelectAllSizeRange(sender) {
        var setChecked = sender.checked;
        var base = $(sender).attr("id").split("_chbSelectAllSR")
        var dlStyleSetsId = base[0] + "_trSizeList"
        var dlSizeColsId = base[0] + "_dlSizeCols"
        var allCheckBoxes = $("#" + dlStyleSetsId + " #" + dlSizeColsId + " input[type='checkbox']")
        $(allCheckBoxes).attr("checked", setChecked)
    }
</script>
<script language="javascript">
	function btnClose_Click() {
		<%= strExitScript %>
        return false;
    }
</script>
</html>