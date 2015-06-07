<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Revision.aspx.vb" Inherits="srmOnApp.Style_Revision" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style_Revision</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<script language="javascript">
				function calendar(sTxtBoxName)
				{
				windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
				windowDatePicker.focus();
				}
			</script>
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						<asp:imagebutton id="imgBtnSave" runat="server" ></asp:imagebutton>
						<asp:imagebutton id="btnClose" runat="server" ></asp:imagebutton></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; HEIGHT: 24px; BACKGROUND-COLOR: white"
				height="24" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"> Status...</asp:label></td>
				</tr>
			</table>
			<uc1:Style_Header id="Style_Header1" runat="server"></uc1:Style_Header>
			<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#cccccc" bgcolor="#ffffff">
				<tr>
					<td valign="top" width="400">
						<table class="TableHeaderOver" height="24" cellSpacing="0" cellpadding="0" width="100%"
							border="0">
							<tr>
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead">
									<div><asp:label id="lblSchedule" runat="server" CssClass="fontHead">Schedule...</asp:label>
									</div>
								</td>
							</tr>
						</table>
						<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#cccccc" border="0">
							<tr bgColor="#ffffff">
								<td width="10" height="25">&nbsp;</td>
								<td width="100" bgcolor="#ffffff" class="fontHead"><asp:label id="lblStartDate" runat="server" CssClass="fontHead">Start Date:</asp:label></td>
								<td bgcolor="#ffffff">
									<asp:textbox id="txtStartDate" runat="server" CssClass="font" Columns="10" MaxLength="10"></asp:textbox>
									<A href="javascript:calendar('txtStartDate')"><IMG height="17" src="../System/icons/icon_calendar.gif" width="18" border="0"></A></td>
							</tr>
							<tr bgColor="#f2f2f9">
								<td width="10" height="25">&nbsp;</td>
								<td width="100" bgcolor="#f2f2f9" class="fontHead"><asp:label id="lblDueDate" runat="server" CssClass="fontHead">Due Date:</asp:label>
								</td>
								<td bgColor="#f2f2f9">
									<asp:textbox id="txtDueDate" runat="server" CssClass="font" Columns="10" MaxLength="10"></asp:textbox>
									<A href="javascript:calendar('txtDueDate')"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A></td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="10" height="25" style="HEIGHT: 12px">&nbsp;</td>
								<td width="100" bgcolor="#ffffff" class="fontHead" style="HEIGHT: 12px"><asp:label id="lblAssignedTo" runat="server" CssClass="fontHead">Assigned To:</asp:label></td>
								<td bgcolor="#ffffff" style="HEIGHT: 12px">
									<asp:DropDownList id="dpAssignedTo" runat="server" Width="104px"></asp:DropDownList></td>
							</tr>
							<tr bgColor="#f2f2f9">
								<td width="10" height="25">&nbsp;</td>
								<td width="100" bgcolor="#f2f2f9" class="fontHead"><asp:label id="lblStatus" runat="server" CssClass="fontHead">Status:</asp:label></td>
								<td bgcolor="#f2f2f9">
									<asp:DropDownList id="dpStyleStatus" runat="server" Width="104px"></asp:DropDownList></td>
							</tr>
						</table>
					</td>
					<td valign="top">
						<table class="TableHeaderOver" height="24" cellSpacing="0" cellpadding="0" width="100%"
							border="0">
							<tr>
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead">
									<div><asp:label id="lblNotes" runat="server" CssClass="fontHead">Notes...</asp:label>
									</div>
								</td>
							</tr>
						</table>
						<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#cccccc" border="0">
							<tr bordercolor="#cddeee" bgColor="#f2f2f9">
								<td width="10" height="25">&nbsp;</td>
								<td>&nbsp;
									<asp:CheckBox id="cbAddToComment" runat="server" CssClass="fontHead" Text="Add to Comment Page"></asp:CheckBox></td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="10" height="75">&nbsp;</td>
								<td><asp:textbox id="txtChangeDescription" runat="server" MaxLength="4000" Columns="50" TextMode="MultiLine"
										Rows="4"></asp:textbox></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table width="100%" height="300" border="1" cellpadding="0" cellspacing="0" bordercolor="#cccccc">
				<tr>
					<td width="400" valign="top">
						<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td></td>
							</tr>
						</table>
						<asp:Panel id="pnlEmail" runat="server" Visible="false">
						
                            <table width=100% cellpadding=0 cellspacing=0 border=0 >
                            <tr><td align=left >
                                <table width=100% cellpadding=0 cellspacing=0 border=0 >
                                <tr>
                                    
                                    <td align=left width=5 height=21 ><img src="../System/icons/tb_left_sel.gif" width=5 height=21 border=0 id="img11" ></td>
                                    <td background='../System/Icons/tb_center_snl.gif' align=left height=21  class="TreeView" bgcolor="#adadad" 
                                        nowrap onclick="ShowGrid(1);"  id="tdUsers"><asp:label id="LblUsers" runat="server">Users</asp:label>&nbsp;&nbsp;</td>
                                    <td align=left width=5 height=21 ><img src="../System/icons/tb_right_sel.gif" width=5 height=21 border=0 id="img12"></td>

                            

                                    <td align=left width=5 height=21  ><img src="../System/icons/tb_left_ns.gif" width=5 height=21 border=0 id="img21"></td>
                                    <td background='../System/Icons/tb_center_ns.gif' align=left height=21  class="TreeView" bgcolor="#FFFFFF" 
                                        nowrap onclick="ShowGrid(2);"  id="tdGroups"><asp:label id="LblGroups" runat="server">Groups</asp:label>&nbsp;&nbsp;</td>
                                    <td align=left width=5 height=21 ><img src="../System/icons/tb_right.gif" width=5 height=21 border=0 id="img22"></td>
                                     
                                     
                                     
                                 </tr>
                                 </table>
                                 <td align=left height=21 valign=bottom width=100%><img src="../System/icons/tb_rule.gif" width=100% height=1 border=0></td>
                            </tr>
                            </table>
						
						    <br /><br />
						    <div runat="server" id="divUser" >
						        <asp:datalist id="dlTeam" runat="server" BorderWidth="0" BackColor="White" Width="100%" RepeatColumns="2"
							        Datakeyfield="TeamID" ShowFooter="False" BorderStyle="None" cellspacing="1" CellPadding="0">
							        <AlternatingItemStyle Height="20px" CssClass="font" BackColor="White"></AlternatingItemStyle>
							        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							        <ItemTemplate>
								        <asp:CheckBox id="chkTeam" runat="server"></asp:CheckBox>&nbsp;<%# DataBinder.Eval(Container.DataItem, "FirstName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "LastName")%>
								        <asp:TextBox id="txtEmail" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container.DataItem, "Email")%>'>
								        </asp:TextBox>
								        <INPUT id=Mail type=hidden value='<%# Container.DataItem("Email")%>' name=Mail runat="server" />
								        <INPUT id=To type=hidden value='<%#Container.DataItem("FirstName") &amp; " " &amp; Container.DataItem("LastName")%>' name=To runat="server" />
							        </ItemTemplate>
							        <HeaderStyle Height="24px" CssClass="Header_small"></HeaderStyle>
						        </asp:datalist>						    
						    </div>
						    
						    <div runat="server" id="divGroup" >
						        <asp:datalist id="dlTeamGroup" runat="server" BorderWidth="0" BackColor="White" Width="100%" RepeatColumns="2"
							        Datakeyfield="GroupID" ShowFooter="False" BorderStyle="None" cellspacing="1" CellPadding="0">
							        <AlternatingItemStyle Height="20px" CssClass="font" BackColor="White"></AlternatingItemStyle>
							        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							        <ItemTemplate>
								        <asp:CheckBox id="chkTeamGroup" runat="server"></asp:CheckBox>&nbsp;<%# DataBinder.Eval(Container.DataItem, "GroupName")%>&nbsp 
    									
							        </ItemTemplate>
							        <HeaderStyle Height="24px" CssClass="Header_small"></HeaderStyle>
						        </asp:datalist>
						    </div>
							
						</asp:Panel>
					</td>
					<td valign="top"><table class="TableHeaderOver" height="24" cellSpacing="0" cellpadding="0" width="100%"
							border="0">
							<tr>
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead">
									<asp:label id="lblStatusLog" runat="server" CssClass="fontHead">Status Log...</asp:label>
								</td>
							</tr>
						</table>
						<asp:DataGrid id="DataGrid1" runat="server" DataKeyField="StyleChangeID" BorderColor="#E0E0E0"
							BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="False">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<ItemStyle Width="35px"></ItemStyle>
									<HeaderTemplate>
										<%#GetSystemText("ID")%>
									</HeaderTemplate>
									<ItemTemplate>
										<%#Container.DataItem("StyleChangeNo")%>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemStyle Width="75px"></ItemStyle>
									<HeaderTemplate>
										<%#GetSystemText("Status")%>
									</HeaderTemplate>
									<ItemTemplate>
										<%#Container.DataItem("StyleChangeType")%>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemStyle Width="250px"></ItemStyle>
									<HeaderTemplate>
										<%#GetSystemText("Notes")%>
									</HeaderTemplate>
									<ItemTemplate>
										<%#Container.DataItem("StyleChangeDescription")%>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemStyle Width="150px"></ItemStyle>
									<HeaderTemplate>
										<%#GetSystemText("Sent To")%>
									</HeaderTemplate>
									<ItemTemplate>
										<%#Container.DataItem("StyleChangeNotifyTo")%>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid>
					</td>
				</tr>
			</table>
		</form>		
			<script language="javascript"  type="text/javascript">
			    function ShowGrid(opt) {
			        var dv1, dv2;
			        var tdU, tdG;
			        var i11, i12, i21, i22

			        dv1 = document.getElementById('divUser');
			        dv2 = document.getElementById('divGroup');

			        tdU = document.getElementById('tdUsers');
			        tdG = document.getElementById('tdGroups');

			        i11 = document.getElementById('img11'); ;
			        i12 = document.getElementById('img12');
			        i21 = document.getElementById('img21');
			        i22 = document.getElementById('img22');


			        if (opt == 1) {
			            dv1.style.display = 'block';
			            dv2.style.display = 'none';

			            tdU.style.background = "url('../System/Icons/tb_center_snl.gif')";
			            tdU.style.backgroundColor = '#adadad';
			            i11.src = "../System/icons/tb_left_sel.gif";
			            i12.src = "../System/icons/tb_right_sel.gif";

			            tdG.style.background = "url('../System/Icons/tb_center_ns.gif')";
			            tdG.style.backgroundColor = '#ffffff';
			            i21.src = "../System/icons/tb_left_ns.gif";
			            i22.src = "../System/icons/tb_right.gif";

			        } else {

			            dv1.style.display = 'none';
			            dv2.style.display = 'block';

			            tdG.style.background = "url(../System/Icons/tb_center_snl.gif)";
			            tdG.style.backgroundColor = '#adadad';

			            i21.src = "../System/icons/tb_left_sel.gif";
			            i22.src = "../System/icons/tb_right_sel.gif";

			            tdU.style.background = "url(../System/Icons/tb_center_ns.gif)";
			            tdU.style.backgroundColor = '#ffffff';
			            i11.src = "../System/icons/tb_left_ns.gif";
			            i12.src = "../System/icons/tb_right.gif";

			        }

			    }

		</script>
		
	</body>
</html>
