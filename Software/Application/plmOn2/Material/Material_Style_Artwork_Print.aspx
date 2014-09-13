<%@ Page CodeBehind="Material_Style_Artwork_Print.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="plmOnApp.Material_Style_Artwork_Print" %>
<HTML>
	<HEAD>
	</HEAD>
	<body>
		<asp:datalist id="DataList1" RepeatColumns="3" RepeatDirection="Horizontal" runat="server" CssClass="none"
			GridLines="Both" EnableViewState="False">
			<ItemStyle Height=290 Width=225></ItemStyle>
			<ItemTemplate>
				<IMG width="215" src="<%# Run(Container.DataItem("MaterialImageID").ToString,Container.DataItem("MaterialImageVersion").ToString) %>">
				<BR>
				&nbsp;<%#GetSystemText("Material No")%>:<%#Container.DataItem("MaterialNo")%>
				<BR>
				&nbsp;<%#GetSystemText("Description")%>: <%#Container.DataItem("MaterialName")%>
				<BR>
				&nbsp;<%#GetSystemText("Placement")%>: <%#Container.DataItem("MaterialPlacementDetail")%>
				<BR>
				&nbsp;
			</ItemTemplate>
		</asp:datalist>
	</body>
</HTML>
