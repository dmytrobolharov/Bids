<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="sw1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_DimensionalBOM" Src="Style_DimensionalBOM.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc4" TagName="Style_MQE" Src="Style_DimensionalBOMMaterial_QuickSearchAdd.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc3" TagName="Style_WorkflowItem" Src="Style_WorkFlowItem.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Style</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />

    <script language="javascript" src="../System/Jscript/Custom.js"></script>
    
    <script language="JavaScript1.2">        
        top.window.moveTo(0,0);
        if (document.all) {
        top.window.resizeTo(screen.availWidth,screen.availHeight);
        }
        else if (document.layers||document.getElementById) {
        if (top.window.outerHeight<screen.availHeight||top.window.outerWidth<screen.availWidth){
        top.window.outerHeight = screen.availHeight;
        top.window.outerWidth = screen.availWidth;
        }
        }       
    </script>    
</head>
<body>
    <form id="Form1" method="post" runat="server" >
     <wc1:Color_Wait ID="Color_Wait" runat="server" />
        <telerik:radscriptmanager ID="RadScriptManager1" runat="server" >
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
            </Scripts>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:radscriptmanager>
        <telerik:radstylesheetmanager ID="RadStyleSheetManager1" Runat="server">
            <StyleSheets>
                <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
            </StyleSheets>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:radstylesheetmanager>
        <telerik:radajaxmanager runat="server" ID="RadAjaxManager1" />

    <sw1:Style_Workflow ID="Style_Workflow1" runat="server"></sw1:Style_Workflow>
    <asp:Panel ID="pnlChange" runat="server">
        <uc1:Style_Change_Alert ID="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
    </asp:Panel>
    <uc2:Style_Header ID="Style_Header1" runat="server" StyleId='<%Request("SID")%>'>
    </uc2:Style_Header>
    <uc1:Style_Comment ID="Style_Comment1" runat="server"></uc1:Style_Comment>
    <uc3:Style_WorkflowItem ID="Style_WorkflowItem1" runat="server" />
    <table id="tblTemplate" style="display: none" height="24" cellspacing="0" cellpadding="0"
        width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_left.gif">
            </td>
            <td class="TableBar" valign="middle" align="center" width="20">
                <img src="../System/icons/icon_template.gif">
            </td>
            <td class="TableBar">
                <cc1:BWHyperLink ID="lnkTemplate" runat="server" WindowName="PackLabelTemplate"></cc1:BWHyperLink>
            </td>
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_right.gif">
            </td>
        </tr>
    </table>
    <cc2:YSTabView ID="YSTabView2" runat="server"></cc2:YSTabView>
   
    <input id="hidBOMDimensionId" type="hidden" name="hidBOMDimensionId" width="20" runat="server" />

    <asp:Panel ID="pnlDimType" runat="server">
        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr>
                <td>                    
                    <cc1:ConfirmedImageButton ID="btnSave" Message="NONE" runat="server"></cc1:ConfirmedImageButton>&nbsp;                    
                    <cc1:ConfirmedImageButton ID="btnSaveAll" Visible="false" Message="NONE" runat="server">
                    </cc1:ConfirmedImageButton>&nbsp;&nbsp;
                </td>
            </tr>
        </table>
        <table cellspacing="1" width="80%">            
            <tr>
                <td>
                    <asp:Label runat="server" ID="lblDim1" class="fontHead">Dimension1:</asp:Label>&nbsp;
                    <asp:DropDownList ID="ddlDim1" runat="server">
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:ImageButton ID="imgBtnDim1" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lblDim2" class="fontHead">Dimension2:</asp:Label>&nbsp;
                    <asp:DropDownList ID="ddlDim2" runat="server">
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:ImageButton ID="imgBtnDim2" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lblDim3" class="fontHead">Dimension3:</asp:Label>&nbsp;
                    <asp:DropDownList ID="ddlDim3" runat="server">
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:ImageButton ID="imgBtnDim3" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
        </table>
        <br />      
        <table cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:Label runat="server" ID="lblDim1Name" class="fontHead"></asp:Label>&nbsp;
                    <asp:ImageButton ID="btnImageDim1" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DataGrid ID="DataGridDim1" runat="server" Datakeys="DimID" BorderColor="Silver"
                        BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="false"
                        AllowPaging="true" PagerStyle-Visible="false">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
        <br />
        <table cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:Label runat="server" ID="lblDim2Name" class="fontHead"></asp:Label>&nbsp;
                    <asp:ImageButton ID="btnImageDim2" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DataGrid ID="DataGridDim2" runat="server" Datakeys="DimID" BorderColor="Silver"
                        BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="false"
                        AllowPaging="true" PagerStyle-Visible="false">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
        <br />
        <table cellspacing="1" cellpadding="1" width="100%">
            <tr class="TableHeader">
                <td>
                    <asp:Label runat="server" ID="lblDim3Name" class="fontHead"></asp:Label>&nbsp;
                    <asp:ImageButton ID="btnImageDim3" Visible="false" runat="server"></asp:ImageButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DataGrid ID="DataGridDim3" runat="server" Datakeys="DimID" BorderColor="Silver"
                        BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="false"
                        AllowPaging="true" PagerStyle-Visible="false">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
    </asp:Panel>

    <asp:Panel ID="pnlMaterial" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr>
                <td>
                    <cc1:BWImageButton ID="btnAddBOMMaterial" runat="server"></cc1:BWImageButton>
                </td>
            </tr>
        </table>
        <div style="display: inline; overflow: auto; width: 98%; position: absolute; height: 65%"
            ms_positioning="FlowLayout">
            <asp:PlaceHolder ID="plhMainMaterial" runat="server"></asp:PlaceHolder>
            <table cellspacing="0" cellpadding="0" border="0" width="100%">
                <tr bgcolor="#ffffff">
                    <td valign="top">
                        <asp:DataGrid ID="dgComponent" runat="server" ShowHeader="False" AutoGenerateColumns="false"
                            BorderColor="Silver" Width="100%">
                            <Columns>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr class="TableHeader">
                                                <td width="10" bgcolor="white" height="24">
                                                </td>
                                                <td class="fontHead" bgcolor="white">
                                                    <%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %>
                                                </td>
                                            </tr>
                                        </table>
                                        <uc1:Style_DimensionalBOM ID="Style_DimensionalBOM1" runat="server" CTID='<%# DataBinder.Eval(Container.DataItem, "ComponentTypeID") %>'
                                            WFID='<%# Request.Querystring("WFID") %>' SDID='<%# Request.Querystring("SDID") %>'
                                            DBID='<%# StyleBOMDimensionId %>' WFIID='<%# Request.Querystring("WFIID") %>'
                                            TB1='<%# Request.Querystring("TB1") %>' SID='<%# Request.Querystring("SID") %>'
                                            SN='<%# Request.Querystring("SN") %>'></uc1:Style_DimensionalBOM>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlMaterialsummary" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSaveSummary" Visible="false" Message="NONE" runat="server">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnaddMatMgmt" Visible="true" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnCopy" Visible="false" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnRemove" Visible="false" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnReplace" Visible="false" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnUpdate" Visible="true" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnAutoColor" runat="server" Visible="false"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnManageDim" Visible="false" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    
                </td>
            </tr>
        </table>
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
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
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr class="TableHeader">
	            <td valign="middle" align="center" width="10px"><img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3"></td>
	            <td width="20px">
	                <img id="imgBtnExpMQE" runat="server" onclick="return ShowHideMQEGrid(this, true)" style="cursor:pointer;" src="../System/Icons/icon_Next.gif" alt="" />
	                <img id="imgBtnColMQE" runat="server" onclick="return ShowHideMQEGrid(this, false)" style="cursor:pointer; display:none;" src="../System/Icons/icon_Down.gif" alt="" />
	            </td>
	            <td class="fontHead">
		            <asp:label id="lblMaterialQuickSearchAdd" runat="server"></asp:label>
	            </td>
            </tr>
        </table>
        <div id="divMaterialQuickSearchAdd" style="display:none;">
            <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelStyleMQE">
                <table cellspacing="0" cellpadding="1" rules="all" border="1" id="dgMaterialtbl"
                    style="background-color: White; border-color: Gainsboro; border-width: 1px; border-style: Solid;
                    border-collapse: collapse;">
                    <tr class="font" valign="bottom" style="height: 20px;">
                        <td valign="bottom" style="border-color: Gainsboro; border-width: 1px; border-style: Solid;">
                            <asp:label ID="lblMQECode" Text="Material Code" class="fontHead" runat="server" ></asp:label>
                            <telerik:RadComboBox ID="cboMQECode" runat="server" Width="120px" Height="150px"
                                EmptyMessage="" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                EnableVirtualScrolling="true" OnItemsRequested="cboMQECode_ItemsRequested"
                                AllowCustomText="true"   MarkFirstMatch="true" 
                                OnSelectedIndexChanged="cboMQECode_SelectedIndexChanged" OnClientKeyPressing="cboMQECode_HandleKeyPress"
                                EnableEmbeddedSkins="false" Skin="YPLM"
                                AutoPostBack="true">
                            </telerik:RadComboBox>
                            <cc1:ConfirmedImageButton ID="btnMaterialQuickSearchAddSave" runat="server" Message="NONE" OnClientClick="SaveMQE();return false;" />
                        </td>
                    </tr>
                </table>
                <asp:DataGrid ID="dgMaterialQuickSearchAdd" runat="server" AutoGenerateColumns="false" DataKeyField="StyleMaterialID">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                    <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
                </asp:DataGrid>
            </telerik:RadAjaxPanel>
            <cc1:ConfirmedImageButton ID="btnMaterialQuickSearchAddSaveHidden" runat="server" Message="NONE" Width="0" Height="0" />
        </div>
        <br />
    </asp:Panel>
    <asp:PlaceHolder ID="PlaceHolderSummary" runat="server"></asp:PlaceHolder>
    <table cellspacing="0" cellpadding="0" width="98%" border="0">
        <tr>
            <td align="right">
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

    <asp:Panel ID="pnlColorMgmt" runat="server">
        <table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td>
                    <cc1:ConfirmedImageButton ID="btnColorSave" runat="server" Visible="false" Message="NONE" />
                    <cc1:ConfirmedImageButton ID="btnCMAutoColor" runat="server" Visible="false" Message="NONE" />                    
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:PlaceHolder ID="PlaceHolderColorMgmt" runat="server"></asp:PlaceHolder>

    <asp:Panel ID="pnlQtyMgmt" runat="server">
        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td>
                    <cc1:ConfirmedImageButton ID="btnQtySave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>&nbsp;
                    <asp:Label ID="lblQtyApply" runat="server" CssClass="fontHead"></asp:Label>&nbsp;
                    <asp:TextBox ID="txtApplyQty" runat="server" border="1" Width='50' CssClass="fontHead"></asp:TextBox>&nbsp;
                    <cc1:ConfirmedImageButton ID="btnQtyApplyAll" runat="server"></cc1:ConfirmedImageButton>&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:PlaceHolder ID="PlaceHolderQtyMgmt" runat="server"></asp:PlaceHolder>

    <asp:PlaceHolder ID="PlaceHolderTSGMgmt" runat="server"></asp:PlaceHolder>

    <asp:Panel ID="pnlCreated" runat="server">
        <div id="div-dc" style="display: inline; width: 90%; position: absolute; height: 24px">
            <table height="24" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="7">
                        <img src="../System/Images/table_bar_left.gif" />
                    </td>
                    <td class="TableBar" valign="middle" align="center" width="20">
                        <img src="../System/icons/icon_changeobject.gif">
                    </td>
                    <td class="TableBar">
                        <asp:Label ID="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:Label>&nbsp;/
                        <asp:Label ID="lblModifiedBy" runat="server" CssClass="fontHead"></asp:Label>
                    </td>
                    <td valign="middle" align="center" width="7">
                        <img src="../System/Images/table_bar_right.gif" />
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>

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
</form>

    <script language="javascript" type="text/javascript">

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
            var frm = document.Form1;
            var actVar = obj.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chbDimQRow") != -1 && !e.disabled) {
                    e.checked = actVar;
                }
            }
        }

        function CheckAllAutoColor(checkAllBox) {
            var frm = document.Form1;
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];

                if (e.type == 'checkbox' && e.name.indexOf("chbAutoColor") != -1 && !e.disabled) {
                    e.checked = actVar;
                }
            }
        }

        function CheckAllDelete(checkAllBox) {
            var frm = document.Form1;
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];

                if (e.type == 'checkbox' && e.name.indexOf("chbMaterialDEL") != -1) {
                    e.checked = actVar;
                }
            }
        }
        
        function CheckMaterialQEDelete(obj) {
            var frm = document.Form1;
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
        function cboMQECode_HandleKeyPress(sender, eventArgs) {
            var keyCode = eventArgs.get_domEvent().keyCode;
            if (keyCode == 13) {
                var item = sender.findItemByText(sender.get_text());
                if (item) item.select();
            }
        } 
        
    </script>

</body>
</html>
