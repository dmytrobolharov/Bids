<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Page_SampleRequests_QuickNew.aspx.vb" Inherits="plmOnApp.Sourcing_Page_SampleRequests_QuickNew" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<%@ Register src="Sourcing_Header.ascx" tagname="Sourcing_Header" tagprefix="hc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title runat="server" id="pgTitle">Quick Sample</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/RadComboBox.YPLM.css" type="text/css" rel="stylesheet" />
        <style type="text/css">
            .slider-container {
            	position: relative;
            	overflow: hidden;
            }
            
            .slider-static {
            	padding-right: 20px;
            }
            
            #SliderHead {
            	-moz-transform: rotate(90deg); 
            	-webkit-transform: rotate(90deg);
                -o-transform: rotate(90deg); 
                transform: rotate(90deg); 
                writing-mode: tb-rl; 
                white-space: nowrap; 
                padding: 4px 4px 0px 3px;
                font-size: 12px; 
                font-family: Arial; 
                font-weight: bold; 
                color: White; 
                display: block;
            }
            
            #FloatDG {
            	z-index: 500; 
            	width: 620px; 
            	position: absolute; 
            	right: -600px; 
            	top: 0; 
            	background-color: #fff;
            }
            
            #FloatDGControl {
            	float: left; 
            	width: 20px; 
            	cursor: pointer; 
            	background-color: #6699FF;
            	height: 100%;
            }
            
            #FloatDGMain {
            	float: left; 
            	width: 600px; 
            	height: 100%;
            	overflow: auto;
            }
        </style>
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
       
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
            border="0" runat="server">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc1:confirmedimagebutton id="btnGenerate" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnShare" runat="server" Message="NONE" CausesValidation="true" ValidationGroup="TechPack"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="100%" cellspacing="0" cellpadding="0" width="100%"  style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="25"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                    <tr>
                        <td valign="top" colspan="2" height="30">
                            <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                                ForeColor="#E0E0E0"></asp:Label>&nbsp;
                        </td>
                        <td valign="top" height="30">
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        </table>

    <hc1:Sourcing_Header id="Sourcing_Header" runat="server" ></hc1:Sourcing_Header>
        <div class="slider-container">
            <div class="slider-static" style="overflow: auto; height: 100%;">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 48%" align="left" valign="top">
                            <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td valign="middle" align="center" width="10">
                                        <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                                    </td>
                                    <td width="100%">
                                        <asp:Label ID="lblBOM" runat="server">Select Styles</asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
                                <tr>
                                    <td>
                                        <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
                                    </td>
                                    <td width="100%" valign="top">
                                        <table id="Table3" height="45">
                                            <tr>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <asp:PlaceHolder ID="phStyleGrid" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="FloatDG" runat="server">
                <div id="FloatDGControl">
                    <span id="SliderHead" runat="server"><%= GetSystemText("Select Trade Partner")%></span>
                </div>
                <div id="FloatDGMain">
                    <asp:UpdatePanel ID="upTradePartners" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <table style="background-color: #69F;" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td class="fontHead" width="100%" style="color: #fff; padding-left: 10px;">
                                        <asp:Label ID="Label1" runat="server">Select Agent Vendor</asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
                                <tr>
                                    <td>
                                        <asp:PlaceHolder ID="plhControlsHolder2" runat="server" EnableViewState="False"></asp:PlaceHolder>
                                    </td>
                                    <td width="100%" valign="top">
                                        <table id="Table1" height="45">
                                            <tr>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnSearch2" runat="server"></asp:ImageButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr valign="top">
                                    <td>
                                        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                                            border="0">
                                            <tr valign="middle">
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                </td>
                                                <td width="16">
                                                </td>
                                                <td class="fontHead" width="100">
                                                    <asp:Label ID="lblThumbnail" runat="server"></asp:Label>
                                                </td>
                                                <td width="20">
                                                    <asp:ImageButton ID="btnImgFirst" runat="server"></asp:ImageButton>
                                                </td>
                                                <td width="20">
                                                    <asp:ImageButton ID="btnImgPrevious" runat="server"></asp:ImageButton>
                                                </td>
                                                <td nowrap align="center" width="125">
                                                    <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                                                </td>
                                                <td width="20">
                                                    <asp:ImageButton ID="btnImgNext" runat="server"></asp:ImageButton>
                                                </td>
                                                <td width="20">
                                                    <asp:ImageButton ID="btnImgLast" runat="server" ToolTip="Last"></asp:ImageButton>
                                                </td>
                                                <td width="10">
                                                    &nbsp;
                                                </td>
                                                <td nowrap>
                                                    <asp:Label ID="RecordCount" runat="server" CssClass="font"></asp:Label>
                                                </td>
                                                <td class="fontHead" align="right" width="110">
                                                    <asp:Label ID="lblRecordsPerPage" runat="server"></asp:Label>
                                                </td>
                                                <td width="25">
                                                    <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                                                        <asp:ListItem Value="5">5</asp:ListItem>
                                                        <asp:ListItem Value="10">10</asp:ListItem>
                                                        <asp:ListItem Value="15">15</asp:ListItem>
                                                        <asp:ListItem Value="20">20</asp:ListItem>
                                                        <asp:ListItem Value="25">25</asp:ListItem>
                                                        <asp:ListItem Value="30">30</asp:ListItem>
                                                        <asp:ListItem Value="40">40</asp:ListItem>
                                                        <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td width="10">
                                                    <asp:Button ID="Button1" OnClick="RePage" runat="server" CssClass="fontHead"></asp:Button>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:DataGrid ID="DataGrid1" runat="server" DataKeyField="SourcingTradePartnerID" BorderStyle="Solid"
                                            BorderWidth="1px">
                                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                                            <PagerStyle Visible="False"></PagerStyle>
                                            <Columns>
                                                <asp:TemplateColumn>
                                                    <HeaderTemplate>
                                                        <input type="checkbox" id="checkAll" onclick="CheckAllV(this);" runat="server" name="checkAll">
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelected" runat="server"></asp:CheckBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <input id="hiddenCurrentPage2" type="hidden" value="0" name="hiddenCurrentPage2" runat="server" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

    </form>
    <script type="text/javascript" language="javascript">
        var frm = document.forms['Form1'];
        function CheckAllV(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
                    e.checked = actVar;
            }
        }

        $(".slider-container").height($(document).height() - $(".slider-container").offset().top - 10);
        $("#FloatDG, #FloatDGMain").height($(document).height() - $(".slider-container").offset().top - 10);

        $("#FloatDGControl").click(function () {
            if (parseInt($("#FloatDG").css("right"), 10) == 0) {
                $("#FloatDG").animate({ right: $("#FloatDGControl").width() - $("#FloatDG").width() }, 200);
            } else {
                $("#FloatDG").animate({ right: 0 }, 200);
            }
        });
    </script>
    <script type="text/javascript" src="../System/Jscript/jquery.tablescroll.js"></script>
    <script type="text/javascript">

        $.fn.tableScroll.defaults =
        {
            flush: true, // makes the last thead and tbody column flush with the scrollbar
            width: null, // width of the table (head, body and foot), null defaults to the tables natural width
            height: 50, // height of the scrollable area
            containerClass: 'tablescroll' // the plugin wraps the table in a div with this css class
        };

        function addScrollToTable() {
            var table = $("#DataGrid1");
            var head = document.createElement("thead");
            var body = table.find("tbody");
            head.appendChild(table[0].rows[0]);
            body.before(head);
            var tableHeight = $("#FloatDGMain").height() - 160;
            table.tableScroll({
                height: tableHeight,
                width: (tableHeight < table.height() ? table.width() - 16 : null)
            });
        };

        addScrollToTable();


    </script>
</body>
</html>
