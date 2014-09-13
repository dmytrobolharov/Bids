<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_ColorwaySeasonal_Image.aspx.vb" Inherits="plmOnApp.Style.ColorwayImages.Style_ColorwaySeasonal_Image" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style</title>	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>

					<td noWrap width="650">
					<cc1:confirmedimagebutton id="btnEdit" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
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
<%--		   <asp:Panel ID="pnlSeasonYear"  runat="server"  >		
			<table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                    <td width="125" align="right" nowrap="nowrap">
                        <asp:Label runat="server" ID="lblStyleSeasonYear" class="fontHead" >Select Season / Year:</asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                    </td>
                </tr>
            </table>
            </asp:Panel>--%>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td id="TD_Detail" valign="top" width="800" runat="server">
						&nbsp;
					</td>
					<td valign="top" bgColor="#ffffff"></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
			<td>
			<asp:datalist id="DataList1" runat="server" OnItemCommand="DataList1_ItemCommand"
				OnItemDataBound="DataList1_ItemDataBound" DataKeyField="StyleDetailFormID" RepeatColumns="1"
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
					     <td>
					        <asp:label id="lblHeader" runat="server" CssClass="fontHead"></asp:label>
					     </td>
					     </tr>
						<tr>
							<td align="left" valign="top">							
					                  <cc1:bwimagebutton id="btnImageNew" runat="server" ></cc1:bwimagebutton>
					                  <cc1:bwimagebutton id="btnImageSelect" runat="server" ></cc1:bwimagebutton>	
								      <cc1:BWImageButton id="btnImageEdit" runat="server" CommandName="Window"></cc1:BWImageButton>
								      <cc1:ConfirmedImageButton id="btnImageCopy" runat="server" CommandName="Copy" Message="NONE"></cc1:ConfirmedImageButton>
								</td>						
							<td valign="top" style="height:150;" rowspan="2">	
							    <input id="txtRecID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "Rec_Id") %>' runat="server" />						   							
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
			</asp:datalist>
			</td>
			<td>
			<%--<asp:Panel ScrollBars="Both" runat="server" Height="100%" Width="100%">--%>
			 <asp:datalist id="DataList2" runat="server"  OnItemCommand="DataList2_ItemCommand"
				OnItemDataBound="DataList2_ItemDataBound" DataKeyField="StyleDetailFormID" 
				RepeatDirection="Vertical" EnableViewState="True">
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
					        <asp:label id="lblHeader" runat="server" CssClass="fontHead"></asp:label>
					     </td>
					     </tr>
						<tr>
							<td align="left" valign="top">							
					                  <cc1:bwimagebutton id="btnImageNew" runat="server" ></cc1:bwimagebutton>
					                  <cc1:bwimagebutton id="btnImageSelect" runat="server" ></cc1:bwimagebutton>	
								      <cc1:BWImageButton id="btnImageEdit" runat="server" CommandName="Window"></cc1:BWImageButton>
								 </td>						
							<td valign="top" style="height:150;" rowspan="2">	
							    <input id="txtRecID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "Rec_Id") %>' runat="server" />						   							
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
			</asp:datalist>
			<%--</asp:Panel>--%>
			</td>
			</tr>
			</table>
			</form>
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





