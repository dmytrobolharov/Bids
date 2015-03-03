<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Planning_FlashEdit_Material_MaterialList.ascx.vb" Inherits="plmOnApp.Planning_FlashEdit_Material_MaterialList" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="white">
    <tr>
        <td>
            <asp:placeholder id="plhMaterialsControls" runat="server" EnableViewState="False"></asp:placeholder>
        </td>
        <td>
            <asp:imagebutton id="imgBtnSearch" runat="server" CausesValidation="false"></asp:imagebutton>
        </td>
    </tr>
</table>

<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr valign="top">
		<td>
            <table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
	            border="0">
	            <tr valign="middle">
		            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td width="16"><asp:checkbox id="cbThumbnail" runat="server" AutoPostBack="True"></asp:checkbox></td>
		            <td class="fontHead" width="85"><asp:Label ID="lblThumbnail" runat="server" Text="Thumbnail?"></asp:Label></td>
		            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
		            <td nowrap align="center" width="110"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
		            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></td>
		            <td width="10">&nbsp;</td>
		            <td nowrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
                    <td width="110" align="right"><span id="Span1" class="fontHead">Records per Page:</span></td>
                    <td width="25">
                        <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                            <asp:ListItem Value="5">5</asp:ListItem>
                            <asp:ListItem Value="10">10</asp:ListItem>
                            <asp:ListItem Value="15">15</asp:ListItem>
                            <asp:ListItem Value="20">20</asp:ListItem>
                            <asp:ListItem Value="25" Selected="true">25</asp:ListItem>
                            <asp:ListItem Value="30">30</asp:ListItem>
                            <asp:ListItem Value="40">40</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td width="10">
                        <asp:Button ID="btnRepage" runat="server" CssClass="fontHead"></asp:Button>
                    </td>

	            </tr>
            </table>
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="MaterialID" AllowSorting="true" AllowPaging="true">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate <%#draggableClass%>"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate <%#draggableClass%>"></ItemStyle>
							<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkSelectAll" runat="server" onclick="CheckAllMaterials(this);" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelectMaterial" runat="server" />
                                        <asp:HiddenField ID="hdnMaterialID" runat="server" />
                                        <asp:HiddenField ID="hdnMaterialImageURL" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <HeaderTemplate><%#GetSystemText("Image")%></HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Image ID="imgMaterialImageID" runat="server" ImageUrl='<%# GetImageStreamPath("50", Eval("MaterialImageVersion").ToString, Eval("MaterialImageID").ToString) %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False" Text="MDate desc"></asp:label>
		</td>
	</tr>
</table>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">&nbsp;&nbsp;
