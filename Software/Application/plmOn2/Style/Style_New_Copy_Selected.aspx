<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_New_Copy_Selected.aspx.vb" Inherits="plmOnApp.Style_New_Copy_Selected" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSaveSet" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" 
							></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Copy Style...</asp:Label></td>
				</tr>
			</table>
			<table height="100" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr valign="top">
					<td width="10">&nbsp;</td>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
					<td><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
				</tr>
			</table>
			<asp:panel id="Panel1" runat="server">
				<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left">&nbsp;
							<asp:Label id="Label1" runat="server">Label</asp:Label>&nbsp;</td>
					</tr>
				</table>
				<asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
					PageSize="100" AutoGenerateColumns="False" Width="800px">
					<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					<Columns>
						<asp:TemplateColumn>
							<HeaderTemplate>
								<INPUT id="cbSelect1" onclick="CheckAll1(this);" type="checkbox" name="checkAll" runat="server">
							</HeaderTemplate>
							<ItemTemplate>
								<asp:CheckBox id="cbSelected1" runat="server" ForeColor="Red"></asp:CheckBox>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
							<ItemTemplate>
								<asp:Image id="imgStatus" runat="server"></asp:Image>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Workflow")%> 
							</HeaderTemplate>
							<ItemTemplate>
								<asp:Label id="lblWorkflow" runat="server"></asp:Label>
								<INPUT id="txtWorkflow" type="hidden" runat="server" NAME="txtWorkflow">
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Status")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:Label id="lblStatus" runat="server"></asp:Label><INPUT id="Hidden1" type="hidden" runat="server" NAME="txtWorkflow">
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Assigned To")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:DropDownList id="dlAssignedTo" runat="server"></asp:DropDownList>
								<asp:RequiredFieldValidator id="rvAssignedTo" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select User...")%>' ControlToValidate="dlAssignedTo"
									ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Start Date")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:TextBox id="txtStartDate" runat="server" Width="75px" MaxLength="10"></asp:TextBox><A id="aStartDate" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A>
								<asp:RegularExpressionValidator id="rvStartDay" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Between 0 to 999 Days")%>'
									ValidationExpression="^(?:(?:0?[13578]|1[02])|(?:0?[469]|11)(?!\/31)|(?:0?2)(?:(?!\/3[01]|\/29\/(?:(?:0[^48]|[13579][^26]|[2468][^048])00|(?:\d{2}(?:0[^48]|[13579][^26]|[2468][^048]))))))\/(?:0?[1-9]|[12][0-9]|3[01])\/\d{4}$"
									ControlToValidate="txtStartDate" ErrorMessage="*" CssClass="fontHead"></asp:RegularExpressionValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Due Date")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:TextBox id="txtDueDate" runat="server" Width="75px" MaxLength="10"></asp:TextBox><A id="aDueDate" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A>
								<asp:RegularExpressionValidator id="rvDueDate" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Between 0 to 999 Days")%>'
									ValidationExpression="^(?:(?:0?[13578]|1[02])|(?:0?[469]|11)(?!\/31)|(?:0?2)(?:(?!\/3[01]|\/29\/(?:(?:0[^48]|[13579][^26]|[2468][^048])00|(?:\d{2}(?:0[^48]|[13579][^26]|[2468][^048]))))))\/(?:0?[1-9]|[12][0-9]|3[01])\/\d{4}$"
									ControlToValidate="txtDueDate" ErrorMessage="*" CssClass="fontHead"></asp:RegularExpressionValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:datagrid>
			</asp:panel><asp:panel id="Panel2" runat="server">
				<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left">&nbsp;
							<asp:Label id="Label2" runat="server">Label</asp:Label>&nbsp;</td>
					</tr>
				</table>
				<asp:datagrid id="Datagrid2" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
					PageSize="100" AutoGenerateColumns="False" Width="800px">
					<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					<Columns>
						<asp:TemplateColumn>
							<HeaderTemplate>
								<INPUT id="cbSelect2" onclick="CheckAll2(this);" type="checkbox" name="checkAll" runat="server">
							</HeaderTemplate>
							<ItemTemplate>
								<asp:CheckBox id="cbSelected2" runat="server" ForeColor="Red"></asp:CheckBox>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
							<ItemTemplate>
								<asp:Image id="imgStatus2" runat="server"></asp:Image>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Workflow")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:Label id="lblWorkflow2" runat="server"></asp:Label><INPUT id="txtWorkflow2" type="hidden" runat="server" NAME="txtWorkflow2">
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Status")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:Label id="lblStatus2" runat="server"></asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Assigned To")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:DropDownList id="dlAssignedTo2" runat="server"></asp:DropDownList>
								<asp:RequiredFieldValidator id="rvAssignedTo2" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select User...")%>' ControlToValidate="dlAssignedTo2"
									ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Start Date")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:TextBox id="txtStartDate2" runat="server" Width="75px" MaxLength="10"></asp:TextBox><A id="aStartDate2" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A>
								<asp:RegularExpressionValidator id="rvStartDate2" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Between 0 to 999 Days")%>'
									ValidationExpression="^(?:(?:0?[13578]|1[02])|(?:0?[469]|11)(?!\/31)|(?:0?2)(?:(?!\/3[01]|\/29\/(?:(?:0[^48]|[13579][^26]|[2468][^048])00|(?:\d{2}(?:0[^48]|[13579][^26]|[2468][^048]))))))\/(?:0?[1-9]|[12][0-9]|3[01])\/\d{4}$"
									ControlToValidate="txtStartDate2" ErrorMessage="*" CssClass="fontHead"></asp:RegularExpressionValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Due Date")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:TextBox id="txtDueDate2" runat="server" Width="75px" MaxLength="10"></asp:TextBox><A id="aDueDate2" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A>
								<asp:RegularExpressionValidator id="rvDueDate2" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Between 0 to 999 Days")%>'
									ValidationExpression="^(?:(?:0?[13578]|1[02])|(?:0?[469]|11)(?!\/31)|(?:0?2)(?:(?!\/3[01]|\/29\/(?:(?:0[^48]|[13579][^26]|[2468][^048])00|(?:\d{2}(?:0[^48]|[13579][^26]|[2468][^048]))))))\/(?:0?[1-9]|[12][0-9]|3[01])\/\d{4}$"
									ControlToValidate="txtDueDate2" ErrorMessage="*" CssClass="fontHead"></asp:RegularExpressionValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:datagrid>
			</asp:panel><asp:panel id="Panel3" runat="server">
				<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left">&nbsp;
							<asp:Label id="Label3" runat="server">Label</asp:Label>&nbsp;</td>
					</tr>
				</table>
				<asp:datagrid id="Datagrid3" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
					PageSize="100" AutoGenerateColumns="False" Width="800px">
					<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					<Columns>
						<asp:TemplateColumn>
							<HeaderTemplate>
								<INPUT id="cbSelect3" onclick="CheckAll3(this);" type="checkbox" name="checkAll" runat="server">
							</HeaderTemplate>
							<ItemTemplate>
								<asp:CheckBox id="cbSelected3" runat="server" ForeColor="Red"></asp:CheckBox>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
							<ItemTemplate>
								<asp:Image id="imgStatus3" runat="server"></asp:Image>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Workflow")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:Label id="lblWorkflow3" runat="server"></asp:Label><INPUT id="txtWorkflow3" type="hidden" runat="server" NAME="txtWorkflow3">
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Status")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:Label id="lblStatus3" runat="server"></asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Assigned To")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:DropDownList id="dlAssignedTo3" runat="server"></asp:DropDownList>
								<asp:RequiredFieldValidator id="rvAssignedTo3" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select User...")%>' ControlToValidate="dlAssignedTo3"
									ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Start Date")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:TextBox id="txtStartDate3" runat="server" Width="75px" MaxLength="10"></asp:TextBox><A id="aStartDate3" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A>
								<asp:RegularExpressionValidator id="rvStartDate3" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Between 0 to 999 Days")%>'
									ValidationExpression="^(?:(?:0?[13578]|1[02])|(?:0?[469]|11)(?!\/31)|(?:0?2)(?:(?!\/3[01]|\/29\/(?:(?:0[^48]|[13579][^26]|[2468][^048])00|(?:\d{2}(?:0[^48]|[13579][^26]|[2468][^048]))))))\/(?:0?[1-9]|[12][0-9]|3[01])\/\d{4}$"
									ControlToValidate="txtStartDate3" ErrorMessage="*" CssClass="fontHead"></asp:RegularExpressionValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Due Date")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:TextBox id="txtDueDate3" runat="server" Width="75px" MaxLength="10"></asp:TextBox><A id="aDueDate3" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A>
								<asp:RegularExpressionValidator id="rvDueDate3" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Between 0 to 999 Days")%>'
									ValidationExpression="^(?:(?:0?[13578]|1[02])|(?:0?[469]|11)(?!\/31)|(?:0?2)(?:(?!\/3[01]|\/29\/(?:(?:0[^48]|[13579][^26]|[2468][^048])00|(?:\d{2}(?:0[^48]|[13579][^26]|[2468][^048]))))))\/(?:0?[1-9]|[12][0-9]|3[01])\/\d{4}$"
									ControlToValidate="txtDueDate3" ErrorMessage="*" CssClass="fontHead"></asp:RegularExpressionValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:datagrid>
			</asp:panel><asp:panel id="Panel4" runat="server">
				<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left">&nbsp;
							<asp:Label id="Label4" runat="server">Label</asp:Label>&nbsp;</td>
					</tr>
				</table>
				<asp:datagrid id="Datagrid4" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
					PageSize="100" AutoGenerateColumns="False" Width="800px">
					<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					<Columns>
						<asp:TemplateColumn>
							<HeaderTemplate>
								<INPUT id="cbSelect4" onclick="CheckAll4(this);" type="checkbox" name="checkAll" runat="server">
							</HeaderTemplate>
							<ItemTemplate>
								<asp:CheckBox id="cbSelected4" runat="server" ForeColor="Red"></asp:CheckBox>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
							<ItemTemplate>
								<asp:Image id="imgStatus4" runat="server"></asp:Image>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Workflow")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:Label id="lblWorkflow4" runat="server"></asp:Label><INPUT id="txtWorkflow4" type="hidden" runat="server" NAME="txtWorkflow4">
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Status")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:Label id="lblStatus4" runat="server"></asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Assigned To")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:DropDownList id="dlAssignedTo4" runat="server"></asp:DropDownList>
								<asp:RequiredFieldValidator id="rvAssignedTo4" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select User...")%>' ControlToValidate="dlAssignedTo4"
									ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Start Date")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:TextBox id="txtStartDate4" runat="server" Width="75px" MaxLength="10"></asp:TextBox><A id="aStartDate4" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A>
								<asp:RegularExpressionValidator id="rvStartDate4" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Between 0 to 999 Days")%>'
									ValidationExpression="^(?:(?:0?[13578]|1[02])|(?:0?[469]|11)(?!\/31)|(?:0?2)(?:(?!\/3[01]|\/29\/(?:(?:0[^48]|[13579][^26]|[2468][^048])00|(?:\d{2}(?:0[^48]|[13579][^26]|[2468][^048]))))))\/(?:0?[1-9]|[12][0-9]|3[01])\/\d{4}$"
									ControlToValidate="txtStartDate4" ErrorMessage="*" CssClass="fontHead"></asp:RegularExpressionValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
							<HeaderTemplate>
								<%#GetSystemText("Due Date")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:TextBox id="txtDueDate4" runat="server" Width="75px" MaxLength="10"></asp:TextBox><A id="aDueDate4" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A>
								<asp:RegularExpressionValidator id="rvDueDate4" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Between 0 to 999 Days")%>'
									ValidationExpression="^(?:(?:0?[13578]|1[02])|(?:0?[469]|11)(?!\/31)|(?:0?2)(?:(?!\/3[01]|\/29\/(?:(?:0[^48]|[13579][^26]|[2468][^048])00|(?:\d{2}(?:0[^48]|[13579][^26]|[2468][^048]))))))\/(?:0?[1-9]|[12][0-9]|3[01])\/\d{4}$"
									ControlToValidate="txtDueDate4" ErrorMessage="*" CssClass="fontHead"></asp:RegularExpressionValidator>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:datagrid>
			</asp:panel></form>
		<SCRIPT language="javascript">
				var frm = document.Form1 ;
				function CheckAll1( checkAllBox )
				{
				var actVar = checkAllBox.checked ;
				for(i=0;i< frm.length;i++)
				{
					e=frm.elements[i];
					if ( e.type=='checkbox' && e.name.indexOf("cbSelected1") != -1 )
					e.checked= actVar ;
				}
				}
				function CheckAll2( checkAllBox )
				{
				var actVar = checkAllBox.checked ;
				for(i=0;i< frm.length;i++)
				{
					e=frm.elements[i];
					if ( e.type=='checkbox' && e.name.indexOf("cbSelected2") != -1 )
					e.checked= actVar ;
				}
				}
				function CheckAll3( checkAllBox )
				{
				var actVar = checkAllBox.checked ;
				for(i=0;i< frm.length;i++)
				{
					e=frm.elements[i];
					if ( e.type=='checkbox' && e.name.indexOf("cbSelected3") != -1 )
					e.checked= actVar ;
				}
				}
				function CheckAll4( checkAllBox )
				{
				var actVar = checkAllBox.checked ;
				for(i=0;i< frm.length;i++)
				{
					e=frm.elements[i];
					if ( e.type=='checkbox' && e.name.indexOf("cbSelected4") != -1 )
					e.checked= actVar ;
				}
				}
		</SCRIPT>
	</body>
</html>
