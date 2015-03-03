<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_ExchangeRate_Edit.aspx.vb" Inherits="plmOnApp.Control_ExchangeRate_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />    
    <link href="../System/CSS/jquery.tablescroll.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="../System/Jscript/jquery.tablescroll.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <style type="text/css">
        .RightAlign input
        {
        	text-align:right;
        }
        .CenterAlign
        {
            text-align:center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    
            <table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSaveClose" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnSave" runat="server" Message="NONE"  style="height: 24px"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnRemove" runat="server" Message="NONE" CausesValidation="false"  style="height: 24px"></cc1:confirmedimagebutton><cc1:bwimagebutton 
					id="btnCopy" runat="server" ></cc1:bwimagebutton><cc1:bwimagebutton 
					id="btnSizeSort" runat="server" ></cc1:bwimagebutton><cc1:confirmedimagebutton 
					id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"></td>
				</tr>
			</table>
			<br/>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top">
							<asp:datagrid id="DataGrid1" runat="server" DataKeyField="ExchangeRateItemID" AllowSorting="True" AutoGenerateColumns="False">
							<ItemStyle CssClass="font"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
							<Columns>
							    <asp:TemplateColumn ItemStyle-BorderWidth="1">
							        <HeaderTemplate>
							            <asp:Image ID="Image1" runat="server" ImageUrl ="../System/Icons/icon_delete.gif" />
							        </HeaderTemplate>
							        <ItemTemplate>
							            <asp:CheckBox runat ="server" ID="chkDelete"  />
							        </ItemTemplate>
							    </asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
                        <asp:HiddenField ID="hdnCurrencyCodes" runat="server" />
                        <asp:HiddenField ID="hdnCurrencyNames" runat="server" />
                        <asp:HiddenField ID="hdnBaseCurrency" runat="server" />
						<table cellSpacing="2" cellPadding="0" width="500" border="0">
							<tr class="fontHead">
								<td width="10">&nbsp;</td>
								<td noWrap width="85"><asp:Label ID="lblNumOfRows" runat="server"></asp:Label></td>
								<td width="35"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
										<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
										<asp:ListItem Value="2">2</asp:ListItem>
										<asp:ListItem Value="3">3</asp:ListItem>
										<asp:ListItem Value="4">4</asp:ListItem>
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
									</asp:dropdownlist></td>
								<td width="300"><cc1:confirmedimagebutton id="btnAddRow" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
							</tr>
						</table>
						<asp:label id="SortOrder" runat="server" Visible="False"></asp:label></td>
				</tr>
			</table>
			<br/>
    </form>

		<script type="text/javascript" language="javascript">
		    var frm = document.form1;
		    var selected = [];

            function getSelectedList() {
                selected = [];
                for (i = 0; i < frm.length; i++) {
                    var e = frm.elements[i];
                    if (e.name.indexOf("drlCurrencyType") != -1) {
                        selected.push(e.options[e.selectedIndex].value)
                    }
                }	        
		    };

		    function disableSelected() {
		        var strSelected = selected.join(",");
		        for (i = 0; i < frm.length; i++) {
		            var e = frm.elements[i];
		            if (e.name.indexOf("drlCurrencyType") != -1)
		                for (j = 0; j < e.options.length; j++) {
		                    if (strSelected.indexOf(e.options[j].value) != -1 && j != e.selectedIndex)
		                        e.options[j].disabled = true
		                }
		        }

		    };

		    function enableAll() {		        
		        for (i = 0; i < frm.length; i++) {
		            var e = frm.elements[i];
		            if (e.name.indexOf("drlCurrencyType") != -1) {
		                for (j = 0; j < e.options.length; j++) {
		                    e.options[j].disabled = false
		                }
		            }
		        }

		        getSelectedList();
		    }

		    function setCurrency(drl) {
		        var txtCode = document.getElementById(drl.id.replace('drlCurrencyType', 'txtCode'));
		        txtCode.value = drl.value;
		        var txtCurrency = document.getElementById(drl.id.replace('drlCurrencyType', 'txtCurrency'));
		        txtCurrency.value = masCurr[drl.value];
		    }

		    getSelectedList();
		    disableSelected();

        </script>

        <script type="text/javascript" src="../System/Jscript/jquery.tablescroll.js"></script>
        <script type="text/javascript">

            $.fn.tableScroll.defaults =
            {
                flush: false, // makes the last thead and tbody column flush with the scrollbar
                width: null, // width of the table (head, body and foot), null defaults to the tables natural width
                height: 100, // height of the scrollable area
                containerClass: 'tablescroll' // the plugin wraps the table in a div with this css class
            };

            jQuery(document).ready(function ($) {

                var table = $('#DataGrid1');
                // Creating <thead> element for the first row
                var head = document.createElement("thead");
                var body = table.find("tbody");
                head.appendChild(table[0].rows[0]);
                var hdnBase = $("#hdnBaseCurrency").val();
                if (hdnBase != "") {
                    $(table[0].rows[0]).find("input").each(function () {
                        $(this).width($(this).width() - 2);
                    });
                    head.appendChild(table[0].rows[0]);
                }
                body.before(head);
                // Adding the scrollbar
                var tableWidth = table.width();
                var tableHeight = $(window).height() - $("#form1").height() + table.height() - $(head).height() - 15;
                table.tableScroll({ height: tableHeight });

            });
        </script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
</body>
</html>
