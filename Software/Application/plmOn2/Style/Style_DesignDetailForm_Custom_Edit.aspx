<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DesignDetailForm_Custom_Edit.aspx.vb" Inherits="plmOnApp.Style.DesignDetailCustom.Style_DesignDetailForm_Custom_Edit" %>

<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc3" TagName="Style_WorkflowItem" Src="Style_WorkFlowItem.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style</title>	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>

					<td noWrap width="650"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnImageNew" runat="server" ></cc1:bwimagebutton><cc1:bwimagebutton id="btnImageSelect" runat="server" ></cc1:bwimagebutton><cc1:bwimagebutton id="btnImageSort" runat="server" ></cc1:bwimagebutton><cc1:confirmedimagebutton id="btnCopy" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnImageRemove" runat="server" ></cc1:bwimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
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
		    <uc3:Style_WorkflowItem id="Style_WorkflowItem1" runat="server" />			
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td id="TD_Detail" valign="top" width="800" runat="server">
						&nbsp;
					</td>
					<td valign="top" bgColor="#ffffff"></td>
				</tr>
			</table>
			<asp:datalist id="DataList1" runat="server" Width="100%" OnItemCommand="DataList1_ItemCommand"
				OnItemDataBound="DataList1_ItemDataBound" DataKeyField="StyleDetailFormCustomID" RepeatColumns="1"
				RepeatDirection="Horizontal" EnableViewState="True">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="White">
				</ItemStyle>
				<AlternatingItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="AliceBlue">
				</AlternatingItemStyle>	
				<ItemTemplate>
					<table style="border-color:silver" cellspacing="2" cellpadding="2" width="100%" border="0">
						<tr>
							<td align="left" valign="top">
								<cc1:BWImageButton id="btnImageEdit" runat="server" 
									CommandName="Window"></cc1:BWImageButton>
								<cc1:confirmedimagebutton id="btnImageBreak" runat="server" Message='<%# GetSystemText("Break image link from all size class?") %>'
									 CommandName="Break"></cc1:confirmedimagebutton></td>
						
							<td valign="top" style="height:150;" rowspan="2">
							    <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" MaxLength="2000" BorderColor="Silver" BorderWidth="1" Width="100%" Height="100%" Text="Test" />
								<%--<asp:Label ID="Label1" runat="server" BorderColor="Silver" BorderWidth="1" Width="100%" Height="100%">test</asp:Label>--%>							
								<input id="txtImageVersion" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageVersion") %>' runat="server" />
								<input id="txtImageID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server" />
							</td>						
						
						
						</tr>
						<tr>
							<td style=" height:150; width:350px">
								<cc1:BWImageButton id="btnImgNewWindow" runat="server" 
									CommandName="Window"></cc1:BWImageButton>
							</td>

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
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>

