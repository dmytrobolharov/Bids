<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Schedule.aspx.vb" Inherits="plmOnApp.Style_Schedule" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">


<html>
	<head>
		<title>Style_Schedule</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0" >
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSaveSet" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnStyleWorkflow" runat="server" 
							Message="Are you sure you want to edit workflow?" ToolTip="Edit Style Workflow..." Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnNewTask" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnNewIssue" runat="server"  Message="NONE"
							CausesValidation="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<br>
           

			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			
			<asp:PlaceHolder ID="plhWorkflowControls" runat="server" ></asp:PlaceHolder>

			
			
			<asp:panel id="Panel1" runat="server">
				<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left">&nbsp;
							<asp:Label id="Label1" runat="server">Label</asp:Label>&nbsp;<asp:Label ID="lblSch1" runat="server" Text="Schedule..."></asp:Label></td>
					</tr>
				</table>
				
				<asp:datagrid id="dgWorkflowSet1" runat="server" DataKeyField="StyleWorkflowID" AllowSorting="False">
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				    <PagerStyle Visible="False"></PagerStyle>
				    <Columns>
				    	<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
							<ItemTemplate>
								<asp:Image id="imgStatus" runat="server"
								     ImageUrl='<%# string.Concat("../System/Icons/"  + DataBinder.Eval(Container.DataItem,"WorkflowStatusImage").tostring ) %>' 
								     ></asp:Image>
							</ItemTemplate>
						</asp:TemplateColumn>
				    </Columns>
                </asp:datagrid>
			</asp:panel>
			
			<asp:panel id="Panel2" runat="server">
				<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left">&nbsp;
							<asp:Label id="Label2" runat="server">Label</asp:Label>&nbsp;<asp:Label ID="lblSch2" runat="server" Text="Schedule..."></asp:Label></td>
					</tr>
				</table>
				<asp:datagrid id="dgWorkflowSet2" runat="server" DataKeyField="StyleWorkflowID" AllowSorting="False">
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				    <PagerStyle Visible="False"></PagerStyle>
				    <Columns>
				    	<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
							<ItemTemplate>
								<asp:Image id="imgStatus" runat="server"
								     ImageUrl='<%# string.Concat("../System/Icons/"  + DataBinder.Eval(Container.DataItem,"WorkflowStatusImage").tostring ) %>' 
								     ></asp:Image>
							</ItemTemplate>
						</asp:TemplateColumn>
				    </Columns>
                </asp:datagrid>				
			</asp:panel>
			<asp:panel id="Panel3" runat="server">
				<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left">&nbsp;
							<asp:Label id="Label3" runat="server">Label</asp:Label>&nbsp;<asp:Label ID="lblSch3" runat="server" Text="Schedule..."></asp:Label></td>
					</tr>
				</table>
				<asp:datagrid id="dgWorkflowSet3" runat="server" DataKeyField="StyleWorkflowID" AllowSorting="False">
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				    <PagerStyle Visible="False"></PagerStyle>
				    <Columns>
				    	<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
							<ItemTemplate>
								<asp:Image id="imgStatus" runat="server"
								     ImageUrl='<%# string.Concat("../System/Icons/"  + DataBinder.Eval(Container.DataItem,"WorkflowStatusImage").tostring ) %>' 
								     ></asp:Image>
							</ItemTemplate>
						</asp:TemplateColumn>
				    </Columns>
                </asp:datagrid>				
			
			</asp:panel>
			<asp:panel id="Panel4" runat="server">
				<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left">&nbsp;
							<asp:Label id="Label4" runat="server">Label</asp:Label>&nbsp;<asp:Label ID="lblSch4" runat="server" Text="Schedule..."></asp:Label></td>
					</tr>
				</table>
				<asp:datagrid id="dgWorkflowSet4" runat="server" DataKeyField="StyleWorkflowID" AllowSorting="False">
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				    <PagerStyle Visible="False"></PagerStyle>
				    <Columns>
				    	<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
							<ItemTemplate>
								<asp:Image id="imgStatus" runat="server"
								     ImageUrl='<%# string.Concat("../System/Icons/"  + DataBinder.Eval(Container.DataItem,"WorkflowStatusImage").tostring ) %>' 
								     ></asp:Image>
							</ItemTemplate>
						</asp:TemplateColumn>
				    </Columns>
                </asp:datagrid>				
				
			</asp:panel>
			
			</form>
	</body>
</html>
