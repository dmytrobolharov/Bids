<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Image_View" Src="Style_Image_View.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DesignDetail.aspx.vb" Inherits="srmOnApp.Style_DesignDetail" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">LineView_Group_Sort</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td noWrap width="650">
					<!--<cc1:confirmedimagebutton id="btnEdit" runat="server"  Message="NONE"></cc1:confirmedimagebutton>-->
                    <cc1:bwimagebutton id="btnPrint" runat="server" ></cc1:bwimagebutton>
					</td>					
				</tr>
			</table>
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" Width="800px" BorderStyle="Solid"
				BorderWidth="1px" AutoGenerateColumns="False" PageSize="100">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Feature Detail")%></asp:Label>
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
							<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Meas.")%></asp:Label>
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
							<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Stitch Type")%></asp:Label>
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
							<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Comments")%></asp:Label>
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
			</asp:datagrid><asp:datalist id="DataList1" runat="server" DataKeyField="ImageID" RepeatColumns="4" RepeatDirection="Horizontal"
				EnableViewState="True" Width="900px">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<TABLE borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
						border="0">
						<TR>
							<TD vAlign="top" width="200" bgColor="#ffffff" height="150">
								<cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton></TD>
						</TR>
						<TR>
							<TD>
								<INPUT id=txtImageVersion type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageVersion") %>' runat="server">
								<INPUT id=txtImageID type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server"></TD>
						</TR>
					</TABLE>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
	</body>
</HTML>
