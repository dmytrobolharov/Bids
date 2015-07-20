<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Quote_QuotationsEditor_Quotes.ascx.vb" Inherits="srmOnApp.Quote_QuotationsEditor_Quotes" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="top">
		<TD>
            <table id="tButtons" style="background-color: #6699FF;" height="25" cellspacing="0" cellpadding="2px" width="100%" border="0">
                <tr valign="middle">
                    <td width="100%">
                       <cc1:confirmedimagebutton id="btnUpdate" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                    </td>
                </tr>
            </table>
			<TABLE id="tNavigate" class="TableHeader" width="100%" height="25" border="0" cellPadding="0" cellSpacing="0"
				bgcolor="#ffffff">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="16"></TD>
					<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></TD>
					<TD align="center" width="125" nowrap><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></TD>
					<TD width="10">&nbsp;</TD>
					<TD nowrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
					<TD align="right" class="fontHead"><asp:label id="lblRecordsPerPage" runat="server" CssClass="fontHead">Records per Page:</asp:label></TD>
					<TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							<asp:ListItem Value="5">5</asp:ListItem>
							<asp:ListItem Value="10">10</asp:ListItem>
							<asp:ListItem Value="15">15</asp:ListItem>
							<asp:ListItem Value="20">20</asp:ListItem>
							<asp:ListItem Value="25">25</asp:ListItem>
							<asp:ListItem Value="30">30</asp:ListItem>
							<asp:ListItem Value="40">40</asp:ListItem>
							<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
						</asp:dropdownlist></TD>
					<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
				</TR>
			</TABLE>
			<table id="tPlh" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
					<td width="100%" valign="top" style="padding-top: 13px;"><asp:imagebutton id="imgBtnSearch" runat="server" /></td>
				</tr>
			</table>
			<asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleQuoteItemID" width="100%">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
				<Columns>
				    <asp:TemplateColumn Visible="True">
				        <HeaderTemplate>
				            <asp:CheckBox ID="chbSelectAll" OnClick='<%# String.Format("CheckAll(this, &#39;{0}&#39;)", DataGrid1.ClientID) %>' AutoPostBack="False" runat="server"></asp:CheckBox>
				        </HeaderTemplate> 
				        <ItemTemplate>
				            <asp:CheckBox ID="chbItem" name="chbItem" runat="server" Enabled='<%# Eval("isBOMDetail") > 0 AndAlso Eval("StyleQuoteItemStatusId") <> 3  %>'></asp:CheckBox>
				        </ItemTemplate>
				    </asp:TemplateColumn>
				</Columns> 						
			</asp:datagrid>
            <asp:HiddenField id="hdnCurrentIndex" runat="server" Value="0" />
            <asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
	</TR>
</TABLE>

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
        var table = $(<%= DataGrid1.ClientID %>);
        // Creating <thead> element for the first row
        var head = document.createElement("thead");
        var body = table.find("tbody");
        head.appendChild(table[0].rows[0]);
        body.before(head);
        // Adding the scrollbar
        //var tableWidth = table.width();
        var tableHeight = $("#FloatDG").height() - $("#tButtons").height() -$("#tNavigate").height() - $("#tPlh").height() - $(head).height()-15;
        table.tableScroll({ height: tableHeight });
        $("#FloatDG").width($(".tablescroll").width()+20);
        $(".tablescroll_wrapper").width($(".tablescroll_wrapper").width() + 2);
    };


</script>