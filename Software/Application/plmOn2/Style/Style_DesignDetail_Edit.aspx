<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DesignDetail_Edit.aspx.vb" Inherits="plmOnApp.Style.DesignDetail.Style_DesignDetail_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style</title>	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
<%--					<td width="125">

					<%=GetSystemText("Display Grid")%>:
						<asp:dropdownlist id="ddlDisplayGrid" runat="server">
							<asp:ListItem Value="1">Yes</asp:ListItem>
							<asp:ListItem Value="0">No</asp:ListItem>
						</asp:dropdownlist></td>--%>
					<td noWrap width="900"><cc1:confirmedimagebutton 
					    id="btnSave" runat="server" CausesValidation="True" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnShowGrid" CausesValidation="False" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnHideGrid"  CausesValidation="False" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:bwimagebutton id="btnImageNew" runat="server" ></cc1:bwimagebutton>
					    <cc1:bwimagebutton id="btnImageSelect" runat="server" ></cc1:bwimagebutton>
					    <cc1:bwimagebutton id="btnImageSort" runat="server" ></cc1:bwimagebutton>
					    <cc1:confirmedimagebutton id="btnCopy" CausesValidation="False" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:bwimagebutton 
					    id="btnImageRemove" runat="server" ></cc1:bwimagebutton><cc1:confirmedimagebutton 
					    id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
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
								<td width="795">
								    <cc1:confirmedimagebutton id="imgBtnTemplate" CausesValidation="False" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
								    <cc1:confirmedimagebutton id="btnDeleteTemplate" CausesValidation="False" runat="server"  />
								</td>
							</tr>
							<tr>
							<td colspan="2">
								
							    <asp:DataGrid ID="DataGrid2" runat="server" DataKeyField="StyleDesignDetailID" BorderColor="#E0E0E0"
                                    BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="False" PageSize="1000000000"
                                    Width="350px">
									<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
									<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
									<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                    <PagerStyle Visible="false" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                            <HeaderTemplate >
                                                <input type="checkbox" onclick="CheckAll(this)" id="chkSelectAll" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chbStyleDesignDetailID" runat="server" />
                                            </ItemTemplate>                        
                                        </asp:TemplateColumn>  
<%--                                        <asp:TemplateColumn> 
                                            <HeaderTemplate> 
                                                <input type="checkbox" onclick="CheckAll(this)" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="selected"  />
                                            </ItemTemplate>
                                        </asp:TemplateColumn>--%>
                                    </Columns>
                                </asp:DataGrid>
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
								<td width="100"><cc1:confirmedimagebutton id="imgBtnAdd" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
							</tr>
						</table>
						&nbsp;
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
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("StyleDesignDetailID") != -1)
		                e.checked = actVar;
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
