<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_SampleRequest_StyleList_View.ascx.vb" Inherits="plmOnApp.Line_List_Folder_SampleRequest_StyleList_View" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<style type="text/css">
    .dim-non-empty, .dim-non-empty  .rcbCheckAllItems {
    	background-image: none;
    	background-color: Yellow !important;
    }
    
    .rcbAutoWidth.RadComboBoxDropDown {
    	min-width: 110px;
    }
</style>
<script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
<script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
<script type="text/javascript">

    var frm = document.forms['Form1'];
    function selectAll(checkAllBox) {
        var actVar = checkAllBox.checked;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];
            if (e.type == 'checkbox' && e.name.indexOf("chbSelect") != -1)
                e.checked = actVar;
        }
    }

    
    $(document).ready(function () {
        $("select[id*=ddlBOM]").each(function () {
            
            $(this).css("width", "90px");
        });
    });
</script>

<table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server" style="vertical-align:middle;display:none;">
    <tr style="white-space:nowrap;">
        <td valign="middle" align="center" width="10">
            <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
        </td>
        <td nowrap>
            <asp:Label id="lblQNT" runat="server">Quantity</asp:Label>:&nbsp;&nbsp;
            <asp:TextBox ID="txtQNT" runat="server" Width="40"></asp:TextBox>
            <asp:RegularExpressionValidator ID="QNTvalid" ControlToValidate="txtQNT" runat="server" Display="Dynamic" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>" EnableClientScript="True" ValidationExpression="[0-9]*"></asp:RegularExpressionValidator>
        </td>
        <td>
            &nbsp;&nbsp;<cc1:confirmedimagebutton id="btnQNT" runat="server"  Message="NONE"></cc1:confirmedimagebutton>&nbsp;&nbsp;
        </td>
        <td nowrap>
            <asp:Label id="lblCost" runat="server">Costing Type</asp:Label>:&nbsp;&nbsp;
            <asp:DropDownList ID="drlCost" runat="server" Width="60"></asp:DropDownList>
        </td>
        <td>
            &nbsp;&nbsp;<cc1:confirmedimagebutton id="btnCost" runat="server"  Message="NONE" style="padding:0px;"></cc1:confirmedimagebutton>&nbsp;&nbsp;
        </td>
        <td width="100%">
            &nbsp;
        </td>
    </tr>
</table>

<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="top">
		<TD>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="16"><asp:checkbox id="cbThumbnail" AutoPostBack="True" runat="server"></asp:checkbox></TD>
					<TD class="fontHead" width="100">
                        <asp:Label ID="lblThumbnail" runat="server" ></asp:Label></TD>
					<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
					<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
					<TD width="10">&nbsp;</TD>
					<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>

					<TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
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
					<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead"></asp:button></TD>
				</TR>
			</TABLE>

			<asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleID" EnableViewState="False">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
	</TR>
</TABLE>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">&nbsp;&nbsp;
<script type="text/javascript">
    function validateBOM(src, args) {
        var checked = $(src).closest('tr').find('[id$=chbSelect]').get(0).checked;        

        if (checked) {
            args.IsValid = args.Value != '';
        } else {
            args.IsValid = true;
        }
    }

    

    
</script>
