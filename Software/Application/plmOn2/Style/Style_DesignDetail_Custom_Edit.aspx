<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DesignDetail_Custom_Edit.aspx.vb" Inherits="plmOnApp.Style.DesignDetailCustom.Style_DesignDetail_Custom_Edit" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style</title>	
		 <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	     <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
         <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="125"><%=GetSystemText("Display Grid")%>:
						<asp:dropdownlist id="ddlDisplayGrid" runat="server">
							<asp:ListItem Value="1">Yes</asp:ListItem>
							<asp:ListItem Value="0">No</asp:ListItem>
						</asp:dropdownlist></td>
					<td noWrap width="750">
                    <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnShowGrid" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnHideGrid" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:bwimagebutton id="btnImageNew" runat="server"></cc1:bwimagebutton>
                    <cc1:bwimagebutton id="btnImageSelect" runat="server" ></cc1:bwimagebutton>
                    <cc1:bwimagebutton id="btnImageSort" runat="server" ></cc1:bwimagebutton>
                    <cc1:confirmedimagebutton id="btnCopy" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:bwimagebutton id="btnImageRemove" runat="server" ></cc1:bwimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                    </td>
					<td class="FontHead" align="right" width="75">&nbsp;<%=GetSystemText("Select Set")%>:</td>
					<td width="40"><asp:dropdownlist id="dpStyleSet" runat="server" CssClass="font" DataTextField="Value" DataValueField="ID"
							AutoPostBack="true"></asp:dropdownlist></td>
					<td><asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton></td>
				</tr>
			</table>
			<uc1:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc1:style_workflow_edit><asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			</asp:panel><uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td id="TD_Detail" valign="top" width="800" runat="server">
						<table class="TableHeader" cellspacing="0" cellpadding="0" width="800" border="0">
							<tr>
								<td valign="middle"  width="5"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td width="795"><cc1:confirmedimagebutton id="imgBtnTemplate" visible="false" runat="server" 
										Message="NONE"></cc1:confirmedimagebutton></td>
							</tr>
							<tr>
							<td colspan="2">
							        <asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" PageSize="100" AllowSorting="False"
							        DataKeyField="StyleDetailGridID" BackColor="White">
							        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							        <ItemStyle CssClass="ItemTemplate"></ItemStyle>
							        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							         <Columns>
                                       <asp:TemplateColumn ItemStyle-BackColor="red">
										    <HeaderTemplate >
												<input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll">
											</HeaderTemplate>
											<ItemTemplate>
												<asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
											</ItemTemplate>
										</asp:TemplateColumn>
                                    </Columns>
							        <PagerStyle Visible="False"></PagerStyle>
						            </asp:datagrid>
									<%--<asp:datagrid id="DataGrid1" runat="server" Width="800px" OnItemCommand="DisplayBoundColumnValues"
									OnItemDataBound="ItemDataBoundEventHandler" AutoGenerateColumns="False" PageSize="100" BorderWidth="1px"
									BorderStyle="Solid" BorderColor="Silver">
									<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
									<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
									<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
									<Columns>
										<asp:TemplateColumn ItemStyle-BackColor="red">
										    <HeaderTemplate >
												<input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll">
											</HeaderTemplate>
											<ItemTemplate>
												<asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
										    <HeaderTemplate>
					                            <asp:Label id="lblHeaderFeature" runat="server"><%#GetSystemText("Feature Detail")%></asp:Label>
						                    </HeaderTemplate>
											<ItemTemplate>
												<asp:TextBox ID=txtFeatureDetail runat="Server" Text='<%# DataBinder.Eval(Container.DataItem, "FeatureDetail")%>' Columns="20" MaxLength="100">
												</asp:TextBox>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
										     <HeaderTemplate>
					                            <asp:Label id="lblHeaderMeas" runat="server"><%#GetSystemText("Meas") & "." %></asp:Label>
						                    </HeaderTemplate>
											<ItemTemplate>
												<asp:TextBox ID=txtMeasurement runat="Server" Text='<%# DataBinder.Eval(Container.DataItem, "Measurement")%>' Columns="5" MaxLength="100">
												</asp:TextBox>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
										    <HeaderTemplate>
					                            <asp:Label id="lblHeaderStitchType" runat="server"><%#GetSystemText("Stitch Type")%></asp:Label>
						                    </HeaderTemplate>
											<ItemTemplate>
												<asp:DropDownList id="dpStitchType" runat="server" CssClass="font" Width="200px"></asp:DropDownList>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
										    <HeaderTemplate>
					                            <asp:Label id="lblHeaderComments" runat="server"><%#GetSystemText("Comments")%></asp:Label>
						                    </HeaderTemplate>										    										    										    
											<ItemTemplate>
												<asp:TextBox id=txtComments runat="Server" MaxLength="300" Columns="80" Text='<%# (DataBinder.Eval(Container.DataItem, "Comments"))%>'>
												</asp:TextBox>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
										    <HeaderTemplate>
					                            <asp:Label id="lblHeaderSort" runat="server"><%#GetSystemText("Sort")%></asp:Label>
						                    </HeaderTemplate>	
											<ItemTemplate>
												<asp:TextBox id="txtSort" runat="Server" MaxLength="3" Columns="4" Text='<%# (DataBinder.Eval(Container.DataItem, "Sort"))%>'>
												</asp:TextBox>
											</ItemTemplate>
										</asp:TemplateColumn>
									</Columns>
								</asp:datagrid>--%>
							</td>
							</tr>
						</table>

						<table cellspacing="2" cellpadding="0" width="550" border="0">
							<tr class="fontHead">
								<td>&nbsp;</td>
								<td noWrap width="85"><%=GetSystemText("No. of Row(s)")%>:</td>
								<td width="35"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
										<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
										<asp:ListItem Value="2">2</asp:ListItem>
										<asp:ListItem Value="3">3</asp:ListItem>
										<asp:ListItem Value="4">4</asp:ListItem>
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
									</asp:dropdownlist></td>
								<td width="100"><cc1:confirmedimagebutton id="btnAddRow" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
							</tr>
						</table>
						&nbsp;
						<asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
					</td>
					<td valign="top" bgColor="#ffffff"></td>
				</tr>
			</table>
			<asp:datalist id="DataList1" runat="server" Width="900px" OnItemCommand="DataList1_ItemCommand"
				OnItemDataBound="DataList1_ItemDataBound" DataKeyField="StyleImageItemId" RepeatColumns="4"
				RepeatDirection="Horizontal" EnableViewState="True">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<table borderColor="silver" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
						border="0">
						<tr>
							<td>
								<cc1:BWImageButton id="btnImageEdit" runat="server" 
									CommandName="Window"></cc1:BWImageButton>
								<cc1:confirmedimagebutton id="btnImageBreak" runat="server" Message='<%# GetSystemText("Break image link from all size class?") %>'
									 CommandName="Break"></cc1:confirmedimagebutton></td>
						</tr>
						<tr>
							<td>
								<cc1:BWImageButton id="btnImgNewWindow" runat="server" 
									CommandName="Window"></cc1:BWImageButton></td>
						</tr>
						<tr>
							<td><INPUT id=txtImageVersion type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageVersion") %>' runat="server">
								<INPUT id=txtImageID type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server"></td>
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
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		</SCRIPT>
		<table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
				<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
				<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
			</tr>
		</table>
	</body>
</html>

