<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Copy_DesignDetailForm.aspx.vb" Inherits="plmOnApp.Style_Copy_DesignDetailForm" %>
<%@ Register TagPrefix="uc1" TagName="Style_Copy_Workflow" Src="Style_Copy_Workflow.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<title></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25" border="0">
				<tr>
					<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnCopy" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnLink" runat="server" Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<uc1:Style_Copy_Workflow id="Style_Copy_Workflow1" runat="server"></uc1:Style_Copy_Workflow>
			<uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			

			<asp:datalist id="DataList1" runat="server" DataKeyField="StyleDetailFormID" RepeatColumns="1" RepeatDirection="Horizontal" EnableViewState="True" Width="100%">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="White">
				</ItemStyle>
				<AlternatingItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="AliceBlue">
				</AlternatingItemStyle>	
				<ItemTemplate>
					<table style="border-color:silver" cellspacing="2" cellpadding="2" width="100%" border="0">
						<tr>
							<td>
								<asp:CheckBox id="cbSelectStyle" runat="server" Text='<%#Getsystemtext("Click here to select style")%>' CssClass="font"></asp:CheckBox>
							</td>
							<td valign="top" style="height:150;" rowspan="2">
								<asp:Label ID="lblComment" runat="server" Width="100%" Height="100%" />
							</td>
						</tr>
						<tr>
							<td style=" height:150; width:350px">
							    <cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton>
							    <asp:HiddenField runat="server" ID="txtComment" Value='<%# DataBinder.Eval(Container.DataItem, "Comments") %>' />
								<input id="txtImageVersion" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageVersion") %>' runat="server" />
								<input id="txtImageID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server" />
								<input id="txtImageType" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageFileType") %>' runat="server" /></td>
						</tr>
					</table>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
		<SCRIPT language="javascript">
			var frm = document.Form1 ;
			function CheckAll( checkAllBox )
			{
			var actVar = checkAllBox.checked ;
			for(i=0;i< frm.length;i++)
			{
				e=frm.elements[i];
				if ( e.type=='checkbox' && e.name.indexOf("cbSelectStyle") != -1 )
				e.checked= actVar ;
			}
			}
		</SCRIPT>
		<SCRIPT language="javascript">
			var frm = document.Form1 ;
			function CheckAllDatagrid( checkAllBox )
			{
			var actVar = checkAllBox.checked ;
			for(i=0;i< frm.length;i++)
			{
				e=frm.elements[i];
				if ( e.type=='checkbox' && e.name.indexOf("cbDetail") != -1 )
				e.checked= actVar ;
			}
			}
		</SCRIPT>
	</body>
</html>
