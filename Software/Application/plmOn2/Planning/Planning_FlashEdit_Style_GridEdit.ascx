<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Planning_FlashEdit_Style_GridEdit.ascx.vb" Inherits="plmOnApp.Planning_FlashEdit_Style_GridEdit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="top">
		<TD>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD class="fontHead" nowrap>
                        <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
                        <cc1:BWImageButton id="btnDelete" runat="server" CausesValidation="false"></cc1:BWImageButton>
                        <asp:HiddenField ID="hdnReasonComment" runat="server" />
                        <asp:HiddenField ID="hdnReasonCode" runat="server" />
                    </TD>
                    <TD nowrap width="30">&nbsp;</TD>
					<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server" CausesValidation="false"> </asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server" CausesValidation="false"></asp:imagebutton></TD>
					<TD noWrap align="center" width="200"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD width="20"><asp:imagebutton id="btnImgNext" runat="server" CausesValidation="false"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last" CausesValidation="false"></asp:imagebutton></TD>
					<TD width="10">&nbsp;</TD>
					<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
                    <td width="100%"></td>
					<TD class="fontHead" align="right" width="110" nowrap><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
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
					<TD width="10"><asp:button id="Button1" runat="server" onclick="RePage" CssClass="fontHead" CausesValidation="false"></asp:button></TD>
				</TR>
			</TABLE>
			<asp:datagrid id="DataGrid1" runat="server" AllowSorting="true" DataKeyField='<%#FlashEditTablePki()%>'>
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>	
				<Columns>
				    <asp:TemplateColumn Visible="True">
				        <HeaderTemplate>
				            <asp:CheckBox ID="cbSelectAll" OnClick="CheckAll(this);" AutoPostBack="False" runat="server"></asp:CheckBox>
				        </HeaderTemplate> 
				        <ItemTemplate>
				            <asp:CheckBox ID="chbSelectRow" name="<%#FlashEditTablePki()%>" runat="server"></asp:CheckBox>				            
				        </ItemTemplate>
				    </asp:TemplateColumn>
				</Columns> 						
			</asp:datagrid><asp:HiddenField id="SortOrder" runat="server"></asp:HiddenField></TD>
	</TR>
</TABLE>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">
<input id="hiddenRecordPerPage" type="hidden" value="" name="hiddenRecordPerPage" runat="server">&nbsp;&nbsp;
    <script language="javascript" type="text/javascript"  >
		var frm = document.Form1 ;
		function CheckAll(checkAllBox) {
		    var actVar = checkAllBox.checked;
		    for (i = 0; i < frm.length; i++) {
		        e = frm.elements[i];
		        if (e.type == 'checkbox' && e.name.indexOf('<%#FlashEditTablePki()%>') != -1) {
		            if (e.disabled != true && e.name != 'chbBatchUpdate') {
		                e.checked = actVar;
		            }
		        }
		    }
		}

		function confirmRemoval(strReasonCode, strReasonComment) {
		    document.getElementById('<%= hdnReasonCode.ClientID %>').value = strReasonCode;
		    document.getElementById('<%= hdnReasonComment.ClientID %>').value = strReasonComment;
            <%= Me.Page.ClientScript.GetPostBackEventReference(New PostBackOptions(btnDelete) With {.PerformValidation = False}) %>;
        }
	</script>
