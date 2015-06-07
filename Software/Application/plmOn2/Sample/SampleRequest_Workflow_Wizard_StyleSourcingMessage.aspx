<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Wizard_StyleSourcingMessage.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_StyleSourcingMessage" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		 <title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
	</HEAD>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td><cc1:confirmedimagebutton id="btnSend" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"> </asp:label></td>
				</tr>
			</table>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD width="800" bgColor="#ffffff"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></TD>
				</TR>
			</TABLE>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
			<table id="Table8" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top">
					    <asp:label runat="server" ID="lblTitle" CssClass="fontHead" ></asp:label> 
						<asp:datagrid id="dgSourcing" runat="server" AllowSorting="True" AutoGenerateColumns="False">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
							<Columns>
							    <asp:TemplateColumn>
							        <HeaderTemplate>
							            <input type="checkbox" id="chkSelectHeader" onclick="CheckAll(this,'chkSelect'  );" name="checkAll" />
							        </HeaderTemplate>
							        <ItemTemplate>
							            <asp:CheckBox id="chkSelect" runat="server"></asp:CheckBox>
							            <input type="hidden" id="hdnTradePartnerVendorID" runat="server"/>
							            <input type="hidden" id="hdnTradePartnerID" runat="server" />
							            <input type="hidden" id="hdnStyleColorID" runat="server" />
							            <input type="hidden" id="hdnStyleSourcingID" runat="server" />
							        </ItemTemplate>
							    </asp:TemplateColumn>
						    
							
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label Runat="server" ID="lbHeaderPartner"><%#GetSystemText("Trade Partner")%></asp:Label>
									</HeaderTemplate>
									<ItemStyle Width="150"></ItemStyle>
									<ItemTemplate>
										<asp:Label Runat="server" ID="lblPartner" ></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label Runat="server" ID="lblHeaderVendor"><%#GetSystemText("Vendor")%></asp:Label>
									</HeaderTemplate>
									<ItemStyle Width="150"></ItemStyle>
									<ItemTemplate>
										<asp:Label Runat="server" ID="lblVendor" ></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label Runat="server" ID="lblHeaderColorway" Text='<%# strColorway %>'>
										</asp:Label>
									</HeaderTemplate>
									<ItemStyle Width="150"></ItemStyle>
									<ItemTemplate>
										<asp:Label Runat="server" ID="lblColorway" ></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
					</td>
				</tr>
			</table>
			<BR>
			<BR>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD class="TableHeader" height="25" width="400">
						<DIV align="center">Schedule</DIV>
					</TD>
				</TR>
				<TR>
					<TD vAlign="top" width="400">
						<TABLE cellSpacing="1" cellPadding="1" width="448" border="0" class="font">
							<TR>
								<TD></TD>
								<TD><asp:label id="lblStartDate" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD><asp:label id="lblEndDate" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD><asp:label id="lblTemplate" runat="server" CssClass="fontHead"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD><asp:label id="txtStartDate" runat="server" Width="75px"></asp:label></TD>
								<TD><asp:label id="txtEndDate" runat="server" Width="75px"></asp:label></TD>
								<TD><asp:label id="txtTemplate" runat="server"></asp:label></TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing="1" cellPadding="1" width="500" border="0">
							<TR>
								<TD class="fontHead" width="75">
                                    <asp:Label ID="lblScheduleBy" runat="server" ></asp:Label>
								</TD>
								<TD><asp:radiobuttonlist id="rbSubmitType" runat="server" CssClass="fontHead" RepeatDirection="Horizontal"
										Enabled="False">
										
									</asp:radiobuttonlist></TD>
							</TR>
						</TABLE>
						
						<asp:datagrid id="DataGrid1" runat="server" Width="600px" BorderStyle="Solid" AutoGenerateColumns="False"
							PageSize="100" BorderWidth="1px" BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblProcess" runat="server" ><%#GetSystemText("Process")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflow" runat="server" CssClass="font"><%#GetSystemText("Workflow")%></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="50px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label id="lblSubmitDaysH" runat="server" ><%#GetSystemText("Submit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtSubmitDays" runat="server" Width="50px" MaxLength="5" ReadOnly="True" Enabled="false" ></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label id="lblResubmitDaysH" runat="server" ><%#GetSystemText("Resubmit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtResubmitDays" runat="server" Width="50px" MaxLength="5" ReadOnly="True" Enabled="false"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
									<asp:Label id="lblAssignedToH" runat="server" ><%#GetSystemText("Assigned To")%></asp:Label>
										
									</HeaderTemplate>
									<ItemTemplate>
										<asp:label id="lbAssignedTo" runat="server" CssClass="font"><%#GetSystemText("assigned To")%></asp:label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label id="lblDueDateH" runat="server" ><%#GetSystemText("Due Date")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtDueDate" runat="server" Width="75px" MaxLength="10" ReadOnly="True" Enabled="false"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label id="lblFinalDateH" runat="server" ><%#GetSystemText("Final Date")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtFinalDate" runat="server" Width="75px" MaxLength="10" ReadOnly="True" Enabled="false"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
																
							</Columns>
						</asp:datagrid></TD>
				</TR>
			</TABLE>
		</form>
		
		<script language="javascript">
		    var frm = document.Form1 ;
		    function CheckAll( checkAllBox, objName ){
		        var actVar = checkAllBox.checked ;
		        for(i=0;i< frm.length;i++){
			        e=frm.elements[i];
			        if ( e.type=='checkbox' && e.name.indexOf( objName ) != -1 )
			            e.checked= actVar ;
		        }
		    }
		</script>		
		
	</body>
</HTML>
