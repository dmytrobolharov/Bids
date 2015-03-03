<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_Edit.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc4" TagName="Style_MQE" Src="Style_DimensionalBOMMaterial_QuickSearchAdd.ascx" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet" href="../System/CSS/jquery-ui.css" />
    <script type="text/javascript" src="../System/Jscript/Custom.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <!--[if IE]>
    <style type="text/css">
        #RadGridsummary thead th {
        	padding: 2px 4px !important;
        }
        
        #RadGridsummary_GridData td {
        	padding: 2px 4px !important;
        }

        #RadGridsummary_GridData { padding-right: 15px; }
        
        .rgMasterTable { table-layout: fixed !important; }

        #RadGridsummary_GridHeader { margin-right: 0 !important; }
    </style>
    <![endif]-->        
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />
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
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" ClientEvents-OnRequestStart="showWait()" ClientEvents-OnResponseEnd="hideWait()" />
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow ID="ConfigBOM" runat="server" Title="Configure BOM" Height="250px" 
                Width="600px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                NavigateUrl="Style_DimensionalBOM_Configure.aspx"
                Behaviors="Close" 
                IconUrl="../System/Icons/icon_table.gif" 
                KeepInScreenBounds="true" Modal="true" />

            <telerik:RadWindow ID="SortMaterials" runat="server" Title="Sort Materials" Height="600px"
                Width="800px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                NavigateUrl="Style_DimensionalBOM_BOMColorway_Material_Sort.aspx"
                Behaviors="Close"
                IconUrl="../System/Icons/icon_table.gif"
                KeepInScreenBounds="true" Modal="true" />
        </Windows>
    </telerik:RadWindowManager>

    <asp:Panel ID="pnlMaterialsummary" runat="server">
        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10px"><img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                <td>  
                    <cc1:ConfirmedImageButton ID="btnSaveSummary" Visible="false" Message="NONE" runat="server">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnaddMatMgmt" Visible="true" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnCopy" Visible="true" OnClientClick="return NoPostBack()" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnRemove" Visible="false" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnReplace" Visible="true" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnUpdate" Visible="true" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnAutoColor" runat="server" Visible="false"></cc1:ConfirmedImageButton>
                    <asp:ImageButton ID="btnSortMaterials" runat="server" />
                    <asp:ImageButton ID="btnConfigure" runat="server" />
                    <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;">
                    </cc1:BWImageButton>
                    <cc1:ConfirmedImageButton ID="btnReplacePrev" runat="server" Visible="true" Message="NONE" OnClientClick="return ShowSelectionDialog()">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" Message="NONE" runat="server" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                </td>
            </tr>
        </table>
        <table id="tbHeader" runat="server" style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
            cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td>
                    &nbsp;<asp:Label ID="lblBigHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
                </td>
            </tr>
        </table>
        <table id="tbDimensions" runat="server" class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr class="TableHeader">
                <td>
                    <asp:Label ID="lblSummary1" runat="server" Text="Label"></asp:Label>&nbsp;
                    <asp:DropDownList ID="drDimensionlist1" runat="server" CssClass="fontHead">
                    </asp:DropDownList>
                    &nbsp&nbsp;
                    <asp:Label ID="lblSummary2" runat="server" Text="Label"></asp:Label>&nbsp;
                    <asp:DropDownList ID="drDimensionlist2" runat="server" CssClass="fontHead">
                    </asp:DropDownList>
                    &nbsp&nbsp;
                    <asp:Label ID="lblSummary3" runat="server" Text="Label"></asp:Label>&nbsp;
                    <asp:DropDownList ID="drDimensionlist3" runat="server" CssClass="fontHead">
                    </asp:DropDownList>
                    &nbsp;
                    <asp:ImageButton ID="imgDimensionlist" Visible="false" runat="server"></asp:ImageButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:CheckBox ID="chbIsAverage" Visible="true" runat="server" Text="Avg Cost" CssClass="fontHead" />
                </td>
            </tr>
        </table>
        <uc2:Style_Header ID="Style_Header1" runat="server"></uc2:Style_Header>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr class="TableHeader">
	            <td valign="middle" align="center" width="10px"><img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3"></td>
	            <td width="20px">
	                <img id="imgBtnExpMQE" runat="server" onclick="return ShowHideMQEGrid(this, true)" style="cursor:pointer;" src="../System/Icons/icon_Next.gif" alt="" />
	                <img id="imgBtnColMQE" runat="server" onclick="return ShowHideMQEGrid(this, false)" style="cursor:pointer; display:none;" src="../System/Icons/icon_Down.gif" alt="" />
	            </td>
	            <td class="fontHead">
		            <asp:label id="lblMaterialQuickSearchAdd" class="font" runat="server"></asp:label>
	            </td>
            </tr>
        </table>
        <asp:Panel ID="pnlExchangeRate"  runat="server" >
            <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                border="0">
                <tr valign="middle" align="left">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/>
                    </td>
                    <td width="200">
                        <asp:Label runat="server" ID="lblExchangeRate" class="fontHead" style="white-space: nowrap; padding-left: 10px;">Select Currency Conversion:</asp:Label>
                    </td>
                    <td width="150">
                        <asp:DropDownList  ID="ddlExchangeRate" runat="server" AutoPostBack="true" ></asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
            </table>
        </asp:Panel>
        <div id="divMaterialQuickSearchAdd" >
            <cc2:YSTabView ID="YSTabView2" runat="server"></cc2:YSTabView>
            <asp:Panel ID="pnlQuickSearch" visible="false" runat="server">
                <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelStyleMQE">
                    <table cellspacing="0" cellpadding="1" rules="all" border="0" id="dgMaterialtbl"
                        style="background-color: White; border-color: Gainsboro;
                        border-collapse: collapse;">
                        <tr class="font" valign="bottom">
                            <td valign="bottom" style="border-color: Gainsboro;">
                                <asp:label ID="lblMQECode" Text="Material Code" class="fontHead" runat="server" ></asp:label>
                                <telerik:RadComboBox ID="cboMQECode" runat="server" Width="200px" Height="150px"
                                    EmptyMessage="" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" OnItemsRequested="cboMQECode_ItemsRequested"
                                    AllowCustomText="true"   MarkFirstMatch="true" 
                                    OnSelectedIndexChanged="cboMQECode_SelectedIndexChanged" OnClientKeyPressing="cboMQECode_HandleKeyPress"
                                    EnableEmbeddedSkins="false" Skin="YPLM"
                                    AutoPostBack="true">
                                </telerik:RadComboBox>                            
                            </td>
                            <td width="5"></td>                                              
                            <td><cc1:ConfirmedImageButton ID="btnMaterialQuickSearchAddSave" runat="server" Message="NONE" OnClientClick="SaveMQE();return false;" /></td>
                        </tr>
                    </table>
                    <asp:DataGrid ID="dgMaterialQuickSearchAdd" runat="server" AutoGenerateColumns="false" DataKeyField="StyleMaterialID">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                        <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
                    </asp:DataGrid>
                </telerik:RadAjaxPanel>
                <cc1:ConfirmedImageButton ID="btnMaterialQuickSearchAddSaveHidden" runat="server" Message="NONE" Width="0" Height="0" />
            </asp:Panel>
            <asp:Panel ID="pnlquickadd" visible="false" runat="server">
            <cc1:ConfirmedImageButton ID="btnQuickAdd" runat="server" Message="NONE" /> 
            <asp:DataGrid ID="dgQuickAdd" runat="server" AutoGenerateColumns="false" DataKeyField="StyleMaterialID">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                    <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
                </asp:DataGrid>           
            </asp:Panel>    
          </div>
        <br />
    </asp:Panel>
    <asp:PlaceHolder ID="PlaceHolderSummary" runat="server"></asp:PlaceHolder>
    <table cellspacing="0" cellpadding="0" width="98%" border="0" runat="server" id="tblCost">
        <tr>
            <td align="left">
                <asp:DataGrid ID="dgMaterialCost" runat="server" BorderStyle="NotSet" BorderWidth="1"
                    BorderColor="#CCCCCC" CellPadding="1" BackColor="White" CellSpacing="0" ShowHeader="False">
                    <PagerStyle />
                    <AlternatingItemStyle Height="20px" CssClass="fontHead"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="fontHead"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeaderGreen"></HeaderStyle>
                </asp:DataGrid>
            </td>
        </tr> 
    </table>
  <asp:Panel runat="server" ID="pnlPerm" Visible="false">
    <table style="height:50;" cellspacing="0" cellpadding="0" width="100%"  bgColor="#990000" border="1" borderColor="red">
        <tr>
            <td>
                <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                        <td>
                              <asp:Label ID="lblPerm" runat="server" 
                            Text="You might not have permission to access this tab using your credentials." 
                            CssClass="fontHead" ForeColor="White"></asp:Label>                         
                        
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </asp:Panel>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            // If all the 'Select Auto Color' checkboxes are disabled, 'Select All Auto Color' should be disabled too
            var frm = document.form1;
            var chbSelectAll = document.getElementById("cbSelectAll")
            var disableSelectAll = true;

            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chbAutoColor") != -1 && !e.disabled) {
                    disableSelectAll = false;
                    break;
                }
            }
            if (chbSelectAll != undefined) {
                chbSelectAll.disabled = disableSelectAll;
            }

            // fix width for non ie browsers
            Sys.Application.add_load(function () {
                if ($.support.cssFloat) {
                    $("#RadGridsummary textarea, #RadGridsummary :text, #RadGridsummary select").each(function () {
                        $(this).width($(this).width() - 10)
                    })
                }
            });
        </script>
    </telerik:RadScriptBlock>
    <div id="dialog" style="display: none;">
        <asp:RadioButtonList runat="server" ID="rblWFISeasonYears" DataTextField="SeasonYear" DataValueField="WorkflowItemID">
        </asp:RadioButtonList>
    </div>
    </form>

        <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
        <script language="javascript" type="text/javascript">
            var allRadios = document.getElementsByName('rdbMaterialLining');
            var booRadio;
            var x = 0;
            for(x = 0; x < allRadios.length; x++){

                allRadios[x].onclick = function() {
                    if(booRadio == this){
                        this.checked = false;
                        booRadio = null;
                    }else{
                        booRadio = this;
                    }
                };
            }
            function SaveMQE() {
                document.getElementById('btnMaterialQuickSearchAddSaveHidden').click();
            }

            function showItem(icName, ieName, dName) {
                var oIc, oIe, oD;

                try {
                    oIc = document.getElementById(icName);
                    oIe = document.getElementById(ieName);
                    oD = document.getElementById(dName);
                    oD.style.display = 'block';
                    oIe.style.display = 'none';
                    oIc.style.display = 'block';
                } catch (e) {
                    alert(e.description);
                }

                oIc = document.getElementById(icName);
                oIe = document.getElementById(ieName);
                oD = document.getElementById(dName);
                oD.style.display = 'block';
                oIe.style.display = 'none';
                oIc.style.display = 'block';
            }

            function hideItem(icName, ieName, dName) {
                var oIc, oIe, oD;
                oIc = document.getElementById(icName);
                oIe = document.getElementById(ieName);
                oD = document.getElementById(dName);
                oD.style.display = 'none';
                oIe.style.display = 'block';
                oIc.style.display = 'none';
            }

            function expandall(opt) {
                var e, s;
                var coll = document.getElementsByTagName("DIV");
                var ele;

                if (coll != null) {
                    for (i = 0; i < coll.length; i++) {
                        if (coll[i].id.indexOf("divSubMaterials") != -1) {
                            s = coll[i].id.indexOf("divSubMaterials");
                            ele = coll[i].id.substring(0, s);
                            if (opt == 1)
                                showItem(ele + 'DataGrid1_ctl02_imgExpColCom', ele + 'DataGrid1_ctl02_imgExpSubCom', ele + 'divSubMaterials');
                            else
                                hideItem(ele + 'DataGrid1_ctl02_imgExpColCom', ele + 'DataGrid1_ctl02_imgExpSubCom', ele + 'divSubMaterials');
                        }
                    }
                }

                if (opt == 1) {
                    var img1, img2;
                    img1 = document.getElementById('btnExpandAll');
                    img2 = document.getElementById('btnCollapseAll');
                    img1.style.display = 'none';
                    img2.style.display = 'block';
                }
                else {
                    var img1, img2;
                    img1 = document.getElementById('btnExpandAll');
                    img2 = document.getElementById('btnCollapseAll');
                    img1.style.display = 'block';
                    img2.style.display = 'none';
                }

            }

            function CheckAllMaterialQty(obj) {
                var frm = document.getElementById("form1");
                var actVar = obj.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox' && e.name.indexOf("chbDimQRow") != -1 && !e.disabled) {
                        e.checked = actVar;
                    }
                }
            }

            function CheckAllAutoColor(checkAllBox) {
                var frm = document.getElementById("form1");
                var actVar = checkAllBox.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];

                    if (e.type == 'checkbox' && e.name.indexOf("chbAutoColor") != -1 && !e.disabled) {
                        e.checked = actVar;
                    }
                }
            }

            function CheckAllDelete(checkAllBox) {
                var frm = document.getElementById("form1");
                var actVar = checkAllBox.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];

                    if (e.type == 'checkbox' && e.name.indexOf("chbMaterialDEL") != -1) {
                        e.checked = actVar;
                    }
                }
            }

            function CheckMaterialQEDelete(obj) {
                var frm = document.getElementById("form1");
                var actVar = obj.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox' && e.name.indexOf("dgMaterialQuickSearchAdd") != -1) {
                        if (e.name.indexOf("chbMaterialDEL") != -1) {
                            e.checked = actVar;
                        }
                    }
                }
            }
            function CheckMaterialQADelete(obj) {
                var frm = document.getElementById("form1");
                var actVar = obj.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox' && e.name.indexOf("dgQuickAdd") != -1) {
                        if (e.name.indexOf("ChbMaterialDel") != -1) {
                            e.checked = actVar;
                        }
                    }
                }
            }
            function CheckMaterialQALink(obj) {
                var frm = document.getElementById("form1");
                var actVar = obj.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox' && e.name.indexOf("dgQuickAdd") != -1) {
                        if (e.name.indexOf("ChbMaterialLinked") != -1) {
                            e.checked = actVar;
                        }
                    }
                }
            }
            function cboMQECode_HandleKeyPress(sender, eventArgs) {
                var keyCode = eventArgs.get_domEvent().keyCode;
                if (keyCode == 13) {
                    var item = sender.findItemByText(sender.get_text());
                    if (item) item.select();
                }
                if (keyCode == 27) {
                    sender.clearSelection();
                }
            } 
            
            $(document).ready(function () {
            if (!$.browser.msie) {
                $("#RadGridsummary_ctl00_Header .rgHeaderYPLME , #RadGridsummary_ctl00_Header .rgHeaderYPLMGreenE").each(function (i) {
                    var textWidth = getStringSize($(this)[0], $(this).text());
                    if (textWidth > $(this).innerWidth()) {
                        while (textWidth > $(this).innerWidth()) {
                            if ($(this).text().length > 2) {
                                $(this).text($(this).text().substring(0, $(this).text().length - 1));
                                textWidth = getStringSize($(this)[0], $(this).text());
                            }
                            else {break;}
                        }
                        if ($(this).text().length < 3) {
                            $(this).text($(this).text() + "...");
                        }
                        else {
                            $(this).text($(this).text().substring(0, $(this).text().length - 1) + "...");
                        }
                    }
                });
            }
        });

        function getStringSize(obj, str) {
            var s = document.createElement("span")
            s.innerHTML = str;
            s.style.visibility = "hidden";
            s.style.whiteSpace = "nowrap";
            obj.appendChild(s);
            var res = s.offsetWidth;
            obj.removeChild(s);
            return res;
        }

        /** Resizing BOM Grid to take all the free height on the screen **/
        Sys.Application.add_load(function () {

            var changeGrid = $("#RadGridsummary");
            var windowHeight = $(window).height();
            var formHeight = $("#form1").height();
            var minHeight = 100;

            // Calculating, how much free space we have on the window for grid area
            var diff = windowHeight - (formHeight - changeGrid.height());

            if (diff > minHeight) {
                changeGrid.height(diff);
            } else {
                changeGrid.height(minHeight);
            }

            var grid = $find("RadGridsummary");
            if (grid) {
                grid.GridDataDiv.style.height = (changeGrid.height() - 67) + "px";
            }
        })();

        (function ($) {

            window.ShowSelectionDialog = function () {
                $("#dialog").dialog({
                    modal: true,
                    resizable: false,
                    draggable: false,
                    appendTo: "#form1",
                    title: '<%= GetSystemText("Replace with previous...") %>',
                    buttons: {
                        '<%= GetSystemText("Yes") %>': function() { <%= Page.ClientScript.GetPostBackEventReference(btnReplacePrev, "", False) %>; },
                        '<%= GetSystemText("No") %>': function () { $(this).dialog("close"); } 
                    }
                });

                return false;
            };

        })(jQuery)

        function showConfigureBOM(strStyleBOMDimensionID) {
            window.radopen("Style_DimensionalBOM_Configure.aspx?SBDID=" + strStyleBOMDimensionID, "ConfigBOM");
        }

        function showMaterialSort(strStyleBOMDimensionID) {
            window.radopen("Style_DimensionalBOM_BOMColorway_Material_Sort.aspx?SBDID=" + strStyleBOMDimensionID, "SortMaterials");
        }
		
		function btnClose_Click() {
            <%= strExitScript %>
            return false;
        }

        function reloadPage() {
            var grid = $find("RadGridsummary");
            if (grid) {
                grid.get_masterTableView().rebind();
            }
        }

        function showWait() {
            show_wait_text(); busyBox.Show();
        }

        function hideWait() {
            busyBox.Hide(); hide_wait_text();
        }


        function GridCreated(sender, eventArgs) {
        //gets the main table scrollArea HTLM element  
        var scrollArea = document.getElementById(sender.get_element().id + "_GridData");
        var row = sender.get_masterTableView().get_selectedItems()[0];

        //if the position of the selected row is below the viewable grid area  
        if (row) {
            if ((row.get_element().offsetTop - scrollArea.scrollTop) + row.get_element().offsetHeight + 20 > scrollArea.offsetHeight) {
                //scroll down to selected row  
                scrollArea.scrollTop = scrollArea.scrollTop + ((row.get_element().offsetTop - scrollArea.scrollTop) +
                row.get_element().offsetHeight - scrollArea.offsetHeight) + row.get_element().offsetHeight;
            }
            //if the position of the the selected row is above the viewable grid area  
            else if ((row.get_element().offsetTop - scrollArea.scrollTop) < 0) {
                //scroll the selected row to the top  
                scrollArea.scrollTop = row.get_element().offsetTop;
            }
        }
    }

        </script>           
    
</body>
</html>
