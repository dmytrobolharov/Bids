<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Copy_DesignDetail.aspx.vb" Inherits="plmOnApp.Style_Copy_DesignDetail" %>
<%@ Register TagPrefix="uc1" TagName="Style_Copy_Workflow" Src="Style_Copy_Workflow.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Design Detail Copy</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25" border="0">
				<tr>
					<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnCopy" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnLink" runat="server" Visible="false" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<uc1:Style_Copy_Workflow id="Style_Copy_Workflow1" runat="server"></uc1:Style_Copy_Workflow>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
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
							<input type="checkbox" id="Checkbox1" onClick="CheckAllDatagrid(this);" runat="server"
								name="checkAll">
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox ID="cbDetail" runat="server"></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>					
					    <HeaderTemplate>
							<asp:Label id="lblHdrFeatureDetail" runat="server"><%#GetSystemText("Feature Detail")%></asp:Label>
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
							<asp:Label id="lblHdrMeas" runat="server"><%#GetSystemText("Meas.")%></asp:Label>
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
							<asp:Label id="lblHdrStitch" runat="server"><%#GetSystemText("Stitch Type")%></asp:Label>
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
							<asp:Label id="lblHdrComments" runat="server"><%#GetSystemText("Comments")%></asp:Label>
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
			</asp:datagrid>
			<table class="TableHeaderOver" cellspacing="0" cellpadding="0" width="100%" height="25"
				border="0">
				<tr>
					<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="18"><input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll"></td>
					<td><asp:Label id="lbl_CheckallDesignDetailImage" runat="server" CssClass="fontHead">Click here to select all Design Detail...</asp:Label></td>
				</tr>
			</table>
			<asp:datalist id="DataList1" runat="server" DataKeyField="StyleImageItemID" RepeatColumns="4"
				RepeatDirection="Horizontal" EnableViewState="True" Width="100%">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<table borderColor="silver" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
						border="0">
						<tr>
							<td>
								<asp:CheckBox id="cbSelectStyle" runat="server" Text='<%#Getsystemtext("Click here to select style")%>' CssClass="font"></asp:CheckBox></td>
						</tr>
						<tr>
						<tr>
							<td valign="top" width="200" bgColor="#ffffff" height="150">
								<cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton></td>
						</tr>
						<tr>
							<td>
								<INPUT id=txtImageVersion type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageVersion") %>' runat="server">
								<INPUT id=txtImageID type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server">
								<INPUT id="txtImageType" type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageFileType") %>' runat="server" ></td>
						</tr>
					</table>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
		<SCRIPT language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("cbSelectStyle") != -1)
		                e.checked = actVar;
		        }
		    }
		</SCRIPT>
		<SCRIPT language="javascript">
		    var frm = document.Form1;
		    function CheckAllDatagrid(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("cbDetail") != -1)
		                e.checked = actVar;
		        }
		    }
		</SCRIPT>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
