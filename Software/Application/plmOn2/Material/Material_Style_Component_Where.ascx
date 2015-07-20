<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Material_Style_Component_Where.ascx.vb" Inherits="plmOnApp.Material_Style_Component_Where" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc3" TagName="Material_Style_Custom_Where" Src="Material_Style_Custom_Where.ascx" %>
<asp:datalist id="DataList1" GridLines="Both" RepeatDirection="Horizontal" RepeatColumns="4" BackColor="White"
	BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="100%" CssClass="font" runat="server"
	DataKeyField="StyleID">
	<ItemStyle Height="100px" Width="200px"></ItemStyle>
	<ItemTemplate>
		<div align="center">
			<cc1:BWImageButton id="imgStyleFile" runat="server" >
			</cc1:BWImageButton></div>
		
		<br />
		
		<asp:PlaceHolder ID="plhHeaderItem" runat="server" ></asp:PlaceHolder>

		<br />
		<table width="100%" bgcolor="#ffffff" border="0" cellspacing="1" cellpadding="0">
		<tr valign="top">
		<td width="8%" />
		<td ><uc3:Material_Style_Custom_Where id="Material_Style_Custom_Where1" runat="server" CustomStoredProc='<%# DataBinder.Eval(Container.DataItem, "CustomStoredProc")%>' CustomSchema='<%# DataBinder.Eval(Container.DataItem, "CustomSchema") %>' StyleID='<%# DataBinder.Eval(Container.DataItem, "StyleID") %>' StyleSet='<%# DataBinder.Eval(Container.DataItem, "StyleSet") %>' MaterialVersion='<%# DataBinder.Eval(Container.DataItem, "MChange") %>' CustomMaterialID='<%# DataBinder.Eval(Container.DataItem, "MaterialID") %>' /></td>
        </tr>
        </table>
		
	</ItemTemplate>
</asp:datalist>
