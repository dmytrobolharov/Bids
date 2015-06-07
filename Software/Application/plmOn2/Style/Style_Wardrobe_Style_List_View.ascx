<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Wardrobe_Style_List_View.ascx.vb" Inherits="plmOnApp.Style.Wardrobe.Style_Wardrobe_Style_List_View" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<script type="text/javascript">

    var frm = document.forms['form1'];
    function selectAll(checkAllBox) {
        var actVar = checkAllBox.checked;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];
            if (e.type == 'checkbox' && e.name.indexOf("chbSelect") != -1)
                e.checked = actVar;
        }
    }

</script>

<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="top">
		<TD>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="0">
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
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="chbSelectAll" onclick="selectAll(this);" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chbSelect" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <%# GetSystemText("Image")%>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Image runat="server" ID="imgDesignImageID" ImageUrl='<%# GetImageStreamPath("50", Eval("DesignSketchVersion").ToString, Eval("DesignSketchID").ToString) %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
	</TR>
</TABLE>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">&nbsp;&nbsp;
