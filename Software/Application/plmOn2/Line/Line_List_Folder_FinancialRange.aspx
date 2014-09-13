<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="uc1" TagName="Line_List_Folder_ViewStyle" Src="Line_List_Folder_ViewStyle.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_FinancialRange.aspx.vb" Inherits="plmOnApp.Line_List_Folder_FinancialRange" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Line List Folder</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script type="text/javascript" src="../System/Jscript/underscore-min.js"></script>
            <style type="text/css">
                #DataGrid1 {
        	        margin-top: 10px;
        	        margin-left: 10px;
        	        border: none;
                }
        
                #DataGrid1 td {
        	        border: 1px solid #bbb;
                }
        
                #DataGrid1 input {
                    color: #0000ff;
                    background-color: #FFFACD;
                }
        	
                #DataGrid1 input, .numeric,
                #DataGrid1 span.font  {
        	        text-align: right;        	
                }
                
        
                #DataGrid1 .names {
        	        padding: 2px;   
        	        vertical-align: top;     	
                }
        
                #DataGrid1 .names img {        
        	        display: inline-block;
                }
        
                #DataGrid1 .style-category .names {
        	        padding-left: 30px;
                }
        
                .TableHeader .font, .TableHeader .fontRed {
        	        font-weight: bold;
                }
            </style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
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
        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td>
						<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
					</td>
				</TR>
			</TABLE>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Line List Folder...</asp:label></td>
				</tr>
			</table>
            <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	            <tr class="TableHeader">
		            <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td width="20">
		                <img id="imgBtnExp" onclick="return ShowHeaderContent(this)" style="cursor:pointer; display:none;"  src="../System/Icons/icon_Next.gif" />
		                <img id="imgBtnCol" onclick="return HideHeaderContent(this)" style="cursor:pointer" src="../System/Icons/icon_Down.gif" />
		            </td>
		            <td class="fontHead">
			            <asp:label id="lblHeaderDetail" runat="server"></asp:label>
		            </td>
	            </tr>
            </table>
            <div id="divHeaderContent">
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900"><asp:placeholder id="plhHeaderControlsHolder" runat="server"></asp:placeholder></td>
					<td>&nbsp;</td>
				</tr>
			</table>
            </div>
            <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	            <tr class="TableHeader">
		            <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td width="20">
		                <img id="imgBtnExpValues" onclick="return ShowPlanningValues(this)" style="cursor:pointer; display:none;"  src="../System/Icons/icon_Next.gif" />
		                <img id="imgBtnColValues" onclick="return HidePlanningValues(this)" style="cursor:pointer" src="../System/Icons/icon_Down.gif" />
		            </td>
		            <td class="fontHead">
			            <asp:label id="lblPlanningValues" runat="server"></asp:label>
		            </td>
	            </tr>
            </table>
            <div id="divPlanningValues">
                <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" DataKeyField="LineFolderStyleCategoryID" AutoGenerateColumns="false">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>        
                    <Columns>
                        <asp:TemplateColumn>
                            <ItemStyle CssClass="names" />
                            <ItemTemplate>
                                <img runat="server" id="imgToggler" onclick='<%# String.Format("toggleRows(this, &#39;{0}&#39;)", Eval("LineFolderStyleTypeID").ToString)%>'
                                    style="cursor: pointer" src="../System/Icons/icon_Down.gif" alt="" />
                                <asp:Label runat="server" ID="lblName" Text='<%# Eval("Name") %>' CssClass="font"></asp:Label>
                                <asp:HiddenField runat="server" ID="hdnLineFolderDivisionID" Value='<%# Eval("LineFolderDivisionID") %>' />
                                <asp:HiddenField runat="server" ID="hdnLineFolderStyleTypeID" Value='<%# Eval("LineFolderStyleTypeID") %>' />
                                <asp:HiddenField runat="server" ID="hdnLineFolderStyleCategoryID" Value='<%# Eval("LineFolderStyleCategoryID") %>' />
                                <asp:HiddenField runat="server" ID="hdnRowName" Value='<%# Convert.ToString(Eval("LineFolderDivision")) & "/" & Convert.ToString(Eval("LineFolderStyleTypeDescription")) & "/" & Convert.ToString(Eval("LineFolderStyleCategory")) %>'/>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
            </div>
            <br />
            <table id="tblFinPlan" width="100%" border="0" bgcolor="#ffffff" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="20%" valign="top">
                        <table class="TableHeaderOver" id="tblSourcingHeader" runat="server" height="24" cellSpacing="0" cellpadding="0"
				            width="100%" border="0">
				            <tr>
					            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td class="fontHead">
						            <div align="center">
                                        <asp:Label ID="lblMenuHeader" runat="server" ></asp:Label>
                                    </div>
					            </td>
				            </tr>
			            </table>
                        <div id="divMenu" style="overflow: auto;">
                            <cc2:YSTreeView id="YSTreeViewPlanMenu" runat="server"></cc2:YSTreeView>
                        </div>
                    </td>
                    <td width="80%" valign="top">
                       <asp:PlaceHolder runat="server" ID="plhFinancialPlanGrid"></asp:PlaceHolder>
                       &nbsp;
                    </td>
                </tr>
            </table>
			
            <asp:HiddenField ID="hdnXmlFiles" runat="server" />
            <asp:HiddenField ID="hdnSelectedStyleTypes" runat="server" />
            <asp:HiddenField ID="hdnSelectedStyleCategories" runat="server" />
            <asp:HiddenField ID="hdnSelectedCalendars" runat="server" />

            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                <script language="javascript" type="text/javascript">

                    function GetSelectedStyleTypes() {
                        var comboItems = $find('<%= dclStyleType.ClientID %>').get_items();
                        var hdnSelectedStyleTypes = $("#hdnSelectedStyleTypes");

                        var oldSelectedStyleTypes = $(hdnSelectedStyleTypes).val(); 
                        var strSelectedStyleTypes = ""

                        for (var i = 0; i < comboItems.get_count(); i++) {
                            if (comboItems.getItem(i).get_checked()) {

                                if (strSelectedStyleTypes != "") {
                                    strSelectedStyleTypes += ",";
                                }
                                strSelectedStyleTypes += comboItems.getItem(i).get_value();
                            }
                        }
                        $(hdnSelectedStyleTypes).val(strSelectedStyleTypes);
                        return (strSelectedStyleTypes != oldSelectedStyleTypes)
                    }

                    function OnStyleTypesLoad(sender, eventArgs) {
                        GetSelectedStyleTypes();    
                    }

                    function OnStyleTypesSelectionChanged(sender, eventArgs) {
                        var doRefresh = GetSelectedStyleTypes();
                        if (doRefresh) {
                            <%= ClientScript.GetPostBackEventReference(New PostBackOptions(dclStyleType) With {.PerformValidation = False}) %>;
                        }
                    }

                    
                    function GetSelectedStyleCategories(sender, eventArgs) {
                        var comboItems = $find('<%= dclStyleCategory.ClientID %>').get_items();
                        var hdnSelectedStyleCategories = $("#hdnSelectedStyleCategories");

                        var strSelectedStyleCategories = ""

                        for (var i = 0; i < comboItems.get_count(); i++) {
                            if (comboItems.getItem(i).get_checked()) {

                                if (strSelectedStyleCategories != "") {
                                    strSelectedStyleCategories += ",";
                                }
                                strSelectedStyleCategories += comboItems.getItem(i).get_value();
                            }
                        }
                        $(hdnSelectedStyleCategories).val(strSelectedStyleCategories);
                    }

                      function ShowHeaderContent(obj) { 
                            obj.style.display = 'none'; 
                            document.getElementById('imgBtnCol').style.display = 'block'; 
                            document.getElementById('divHeaderContent').style.display = 'block'; 
                            return false;
                      } 

                      function HideHeaderContent(obj) { 
                            obj.style.display = 'none'; 
                            document.getElementById('imgBtnExp').style.display = 'block'; 
                            document.getElementById('divHeaderContent').style.display = 'none'; 
                            return false;
                      }

                      function ShowPlanningValues(obj) { 
                            obj.style.display = 'none'; 
                            document.getElementById('imgBtnColValues').style.display = 'block'; 
                            document.getElementById('divPlanningValues').style.display = 'block'; 
                            return false;
                      } 

                      function HidePlanningValues(obj) { 
                            obj.style.display = 'none'; 
                            document.getElementById('imgBtnExpValues').style.display = 'block'; 
                            document.getElementById('divPlanningValues').style.display = 'none'; 
                            return false;
                      }

                      function GetSelectedCalendars(sender, eventArgs) {
                        var comboItems = $find('<%= dclCalendar.ClientID %>').get_items();
                        var hdnSelectedCalendars = $("#hdnSelectedCalendars");

                        var strSelectedCalendars = ""

                        for (var i = 0; i < comboItems.get_count(); i++) {
                            if (comboItems.getItem(i).get_checked()) {

                                if (strSelectedCalendars != "") {
                                    strSelectedCalendars += ",";
                                }
                                strSelectedCalendars += comboItems.getItem(i).get_value();
                            }
                        }
                        $(hdnSelectedCalendars).val(strSelectedCalendars);
                    }

                    $("#DataGrid1 td:first").css({border: 'none', visibility: 'hidden'});

                    function toggleRows(img, style_category) {
                        if ($(img).closest("tr").nextUntil(".TableHeader").toggle().is(":visible")) {
                            img.src = "../System/Icons/icon_Down.gif";
                        } else {
                            img.src = "../System/Icons/icon_Next.gif";
                        }
                    }

                    function getData(elem) {
                        var row = elem.closest("tr");
                        
                        return {
                            DivisionID: row.find("input[id$=hdnLineFolderDivisionID]").val(),
                            StyleTypeID: row.find("input[id$=hdnLineFolderStyleTypeID]").val(),
                            StyleCategoryID: row.find("input[id$=hdnLineFolderStyleCategoryID]").val(),
                            FinancialID: elem[0].id.slice(-36)
                        };
                    }

                    function findBoxes(info) {
                        return $(":text[id$='" + info["FinancialID"] + "']").filter(function(){
                            var elemInfo = getData($(this));
                            return elemInfo.DivisionID == info.DivisionID && elemInfo.StyleTypeID == info.StyleTypeID && elemInfo.StyleCategoryID != "";
                        });
                    }

                    function findTotal(info) {
                        return $("#DataGrid1 :text[id$='" + info["FinancialID"] + "']").filter(function(){
                            var elemInfo = getData($(this));
                            return elemInfo.DivisionID == info.DivisionID && elemInfo.StyleTypeID == info.StyleTypeID && elemInfo.StyleCategoryID == "";
                        });
                    }

                    function recalculatePercent(total) {
                        return function() {
                            // check totalValue for 0 so we don't get infinity                            
                            this.value = percentFormat(total.value != 0 ? ($(this).siblings(":text").val() / total.value) * 100 : 0);
                        }
                    }

                    function recalculateValue(total) {
                        return function() {
                            this.value = (parseFloat($(this).siblings(":text").val(), 10)/100) * total.value;
                        }
                    }

                    function percentFormat(val) {
                        var value = parseFloat(val).toFixed(2),
                            fixedFactor = /\.00$/.test(value) ? 0 : 2; // do not show trailing zeros after decimal point

                        return parseFloat(val).toFixed(fixedFactor) + " %";
                    }

                    $("#DataGrid1 input.value").change(function(){
                        var $this = $(this),
                            info = getData($(this));
                        
                        if (info["StyleCategoryID"] == "" && info["StyleTypeID"] != "") {                                                        
                            findBoxes(info).filter(".percentbox").each(recalculatePercent(this));
                        } else if($this.is(".percentbox")) {
                            recalculateValue(findTotal(info)[0]).call($(this).siblings(":text")[0]);
                            this.value = percentFormat(this.value);
                        } else {                            
                            recalculatePercent(findTotal(info)[0]).call($(this).siblings(":text")[0]);
                        }                        
                    });

                    $("#DataGrid1 :text").filter(function(){
                        var elemInfo = getData($(this));
                        if (elemInfo.DivisionID != "" && elemInfo.StyleTypeID != "" && elemInfo.StyleCategoryID == "") {
                            $(this).trigger("change");
                        }
                    });

                </script>
            </telerik:RadScriptBlock>
        </form>
	</body>
</HTML>
