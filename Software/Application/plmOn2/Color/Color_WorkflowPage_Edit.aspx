<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_WorkflowPage_Edit.aspx.vb" Inherits="plmOnApp.Color_WorkflowPage_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Color_Header" Src="Color_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style_Revision</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
					<td>
						<asp:ImageButton ID="btnSave" runat="server" ></asp:ImageButton>
						<asp:ImageButton ID="btnClose" runat="server" CausesValidation="false"></asp:ImageButton></td>
				</tr>
			</table>            
            <table style="border-bottom: orange thin solid; border-left-style: none; height: 24px; background-color: white"
				 cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="24">&nbsp;<asp:label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"><%= GetSystemText("Color Palette") %>&nbsp;<%= GetSystemText("Status") %></asp:label></td>
				</tr>
			</table>
			<uc1:Color_Header id="Color_Header1" runat="server" IsCollapsible="true" IsCollapsed="true"></uc1:Color_Header>
			<table width="100%" border="1" cellpadding="0" cellspacing="0" style="border-color:#ccc; background-color:#fff;">
				<tr>
					<td valign="top" width="400">
						<table class="TableHeaderOver" height="24" cellspacing="0" cellpadding="0" width="100%"
							border="0">
							<tr>
								<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
								<td class="fontHead">
									<div><asp:label id="lblSchedule" runat="server" CssClass="fontHead">Schedule...</asp:label></div>
								</td>
							</tr>
						</table>
						<asp:PlaceHolder runat="server" ID="plhWorkflowEdit"></asp:PlaceHolder>
					</td>
					<td valign="top">
						<table class="TableHeaderOver" height="24" cellspacing="0" cellpadding="0" width="100%"
							border="0">
							<tr>
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead">
									<div><asp:label id="lblNotes" runat="server" CssClass="fontHead">Notes...</asp:label>
									</div>
								</td>
							</tr>
						</table>
						<table cellspacing="0" cellpadding="0" width="100%" bgColor="#cccccc" border="0">
							<tr bordercolor="#cddeee" bgColor="#f2f2f9">
								<td width="10" height="25">&nbsp;</td>
								<td>&nbsp;
									<asp:CheckBox id="cbAddToComment" runat="server" Visible="false" CssClass="fontHead" Text="Add to Comment Page"></asp:CheckBox></td>
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
			<br />
			<table width="100%" height="300" border="1" cellpadding="0" cellspacing="0" bordercolor="#cccccc">
				<tr>
					<td width="400" valign="top">
						<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td></td>
							</tr>
						</table>
						<asp:Panel id="pnlEmail" runat="server">						
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr><td align="left">
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                <tr>                                    
                                    <td align="left" width="5" height="21"><img src="../System/icons/tb_left_sel.gif" width="5" height="21" border="0" id="img11" alt="" /></td>
                                    <td style="background-image:url(../System/Icons/tb_center_snl.gif)" align="left" height="21" class="TreeView" bgcolor="#adadad" 
                                        nowrap onclick="ShowGrid(1);"  id="tdUsers"><asp:label id="LblUsers" runat="server">Users</asp:label>&nbsp;&nbsp;</td>
                                    <td align="left" width="5" height="21"><img src="../System/icons/tb_right_sel.gif" width="5" height="21" border="0" id="img12"></td>

                            

                                    <td align="left" width="5" height="21"><img src="../System/icons/tb_left_ns.gif" width="5" height="21" border="0" id="img21" alt="" /></td>
                                    <td background='../System/Icons/tb_center_ns.gif' align="left" height="21" class="TreeView" bgcolor="#FFFFFF" 
                                        nowrap onclick="ShowGrid(2);"  id="tdGroups"><asp:label id="LblGroups" runat="server">Groups</asp:label>&nbsp;&nbsp;</td>
                                    <td align="left" width="5" height="21"><img src="../System/icons/tb_right.gif" width="5" height="21" border="0" id="img22"></td>                                     
                                 </tr>
                                 </table>
                                 </td>
                                 <td align="left" height="21" valign="bottom" width="100%"><img src="../System/icons/tb_rule.gif" width="100%" height="1" border="0"></td>
                            </tr>
                            </table>
						
						    <br /><br />
						    <div runat="server" id="divUser" >
						        <asp:datalist id="dlTeam" runat="server" BorderWidth="0" BackColor="White" Width="100%" RepeatColumns="2"
							        Datakeyfield="TeamID" ShowFooter="False" BorderStyle="None" cellspacing="1" CellPadding="0">
							        <AlternatingItemStyle Height="20px" CssClass="font" BackColor="White"></AlternatingItemStyle>
							        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							        <ItemTemplate>
								        <asp:CheckBox id="chkTeam" runat="server" Text='<%# Eval("FullName")%>'></asp:CheckBox>
						                <input id="hdnMail" type="hidden" value='<%# Eval("Email")%>' name="Mail" runat="server" />
								        <input id="hdnTo" type="hidden" value='<%#Eval("FullName")%>' name="To" runat="server" />
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
								        <asp:CheckBox id="chkTeamGroup" runat="server"></asp:CheckBox>&nbsp;<%# Eval("GroupName")%>
							        </ItemTemplate>
							        <HeaderStyle Height="24px" CssClass="Header_small"></HeaderStyle>
						        </asp:datalist>
						    </div>							
						</asp:Panel>
					</td>
					<td valign="top"><table class="TableHeaderOver" height="24" cellspacing="0" cellpadding="0" width="100%"
							border="0">
							<tr>
								<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
								<td class="fontHead">
									<asp:label id="lblStatusLog" runat="server" CssClass="fontHead">Status Log...</asp:label>
								</td>
							</tr>
						</table>
						<asp:DataGrid id="DataGrid1" runat="server" DataKeyField="ColorFolderChangeID" BorderColor="#E0E0E0"
							BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="False">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
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