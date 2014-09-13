<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DesignDetail_Grid.aspx.vb" Inherits="plmOnApp.Style.DesignDetail.Style_DesignDetail_Grid" %>
<%@ Register TagPrefix="uc1" TagName="Style_Image_View" Src="Style_Image_View.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>LineView_Group_Sort</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#ffffff">
					<td width="550" valign="top" id="TD_Detail" runat="server">
						<asp:DataGrid id="DataGrid1" runat="server" AutoGenerateColumns="False" PageSize="100" BorderWidth="1px"
							BorderStyle="Solid" BorderColor="Silver" Width="500px">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
								     <HeaderTemplate>
					                    <asp:Label id="lblHeaderFeature" runat="server"><%#GetSystemText("Feature Detail")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblFeatureDetail" runat="server" Text='<%# Container.DataItem("FeatureDetail") %>' Width="150">
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox id = "txtFeatureDetail" maxlength="100" columns="60" runat = "Server" Text ='<%# DataBinder.Eval(Container.DataItem, "FeatureDetail")%>'/>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
								     <HeaderTemplate>
					                    <asp:Label id="lblHeaderMeas" runat="server"><%#GetSystemText("Meas") & "." %></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblMeasurement" runat="server" Text='<%# Container.DataItem("Measurement") %>' Width="75">
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox id = "txtMeasurement" maxlength="100" columns="60" runat = "Server" Text ='<%# DataBinder.Eval(Container.DataItem, "Measurement")%>'/>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
								    <HeaderTemplate>
					                    <asp:Label id="lblHeaderStitchType" runat="server"><%#GetSystemText("Stitch Type")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStitchType" runat="server" Text='<%# Container.DataItem("StitchType") %>' Width="125">
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox id = "txtStitchType" maxlength="100" columns="60" runat = "Server" Text ='<%# DataBinder.Eval(Container.DataItem, "FeatureDetail")%>'/>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
								    <HeaderTemplate>
					                    <asp:Label id="lblHeaderComments" runat="server"><%#GetSystemText("Comments")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblComments" runat="server" Text='<%# Container.DataItem("Comments") %>' Width="150">
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox id = "txtComments" maxlength="200" columns="60" runat = "Server" Text ='<%# DataBinder.Eval(Container.DataItem, "Comments")%>'/>
									</EditItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid></td>
					<td valign="top"><asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#ffffff">
					<td valign="top">
						<asp:image id="imgDesign1" runat="server" BorderColor="Transparent"></asp:image>
						<asp:image id="imgDesign2" runat="server" BorderColor="Transparent"></asp:image></td>
				</tr>
			</table>
		</form>
	</body>
</html>
