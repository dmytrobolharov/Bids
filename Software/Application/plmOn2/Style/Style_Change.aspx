<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Change.aspx.vb" Inherits="plmOnApp.Style.Change.Style_Change" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title runat="server" id="PageTitle"></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">

			<table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
					<td><asp:imagebutton id="btnSave" runat="server" style="height: 24px"></asp:imagebutton>
                        <asp:imagebutton id="imgBtnSave" runat="server" >
					</asp:imagebutton><asp:imagebutton id="btnClose" runat="server" OnClientClick="return btnClose_Click()">
					</asp:imagebutton></td>
				</tr>
			</table>
			<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; HEIGHT: 24px; BACKGROUND-COLOR: white"
				height="24" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lbHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"> Status...</asp:label></td>
				</tr>
			</table>
			<table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif" ToolTip="Show Style Header..."></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" ToolTip="Hide Material Header..."></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:label id="lblStyleHeader" runat="server"></asp:label></td>
				</tr>
			</table>
			<asp:panel id="pnlStyleHeader" runat="server" CssClass="font" Width="100%" BackColor="#ffffff"
				BorderWidth="0">
				<table height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</asp:panel>
			<table borderColor="#cccccc" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
				border="1">
				<tr>
					<td vAlign="top" width="400">
						<table class="TableHeaderOver" height="24" cellspacing="0" cellpadding="0" width="100%"
							border="0">
							<tr>
								<td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
								<td class="fontHead">
									<div><asp:label id="lblChangeNotes" runat="server">Change Notes...</asp:label>
									</div>
								</td>
							</tr>
						</table>
						<table cellspacing="0" cellpadding="0" width="100%" bgColor="#cccccc" border="0">
						
                        	<tr bgColor="#ffffff">
								<td width="10">&nbsp;</td>
								<td><asp:CheckBox runat ="server"  ID="chkAddComment" Text="Add to Comment Page" CssClass ="fontHead"  /></td>
							</tr>
						
						
							<tr bgColor="#ffffff">
								<td width="10" height="75">&nbsp;</td>
								<td><asp:textbox id="txtChangeDescription" runat="server" TextMode="MultiLine" Rows="8" Columns="70"
										MaxLength="4000" AutoPostBack="false"></asp:textbox></td>
							</tr>
						</table>
						<BR/>
						<table id="Table2" height="5" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td>
								</td>
							</tr>
						</table>
						<asp:Panel id="pnlEmail" runat="server">
						
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
								        <asp:CheckBox id="chkTeam" runat="server"></asp:CheckBox>&nbsp;<%# DataBinder.Eval(Container.DataItem, "FirstName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "LastName")%><asp:TextBox id="txtEmail" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container.DataItem, "Email")%>'>
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
					<td vAlign="top">
						<table class="TableHeaderOver" height="24" cellspacing="0" cellpadding="0" width="100%"
							border="0">
							<tr>
								<td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
								<td class="fontHead">
									<div><asp:label id="lblChangeLog" runat="server">Change Log...</asp:label>
									</div>
								</td>
							</tr>
						</table>
						<table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<tr vAlign="middle">
								<td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
								<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
								<td noWrap align="center" width="100"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
								<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
								<td width="10">&nbsp;</td>
								<td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
								<td class="fontHead" align="right" width="110"><asp:label id="lblRecordsperPage" runat="server">Records per Page:</asp:label></td>
								<td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
									</asp:dropdownlist></td>
								<td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></td>
							</tr>
						</table>
						<asp:datagrid id="Datagrid1" runat="server" BorderStyle="Solid" BorderWidth="1px" PageSize="100"
							DataKeyField="StyleChangeID" BorderColor="#E0E0E0" AutoGenerateColumns="False">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label><input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server" />
					</td>
				</tr>
			</table>
			<table height="5" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
		</form>
		
		<script language="javascript"  type="text/javascript">
		    function ShowGrid(opt){
		        var dv1, dv2;
		        var tdU, tdG ; 
		        var i11,i12,i21,i22
		        
		        dv1 = document.getElementById('divUser') ;
		        dv2 = document.getElementById('divGroup') ;
		        
		        tdU = document.getElementById('tdUsers');
		        tdG = document.getElementById('tdGroups');
		        
		        i11 =  document.getElementById('img11'); ; 
		        i12 = document.getElementById('img12'); 
		        i21 = document.getElementById('img21');
		        i22 = document.getElementById('img22');
		        		        
		        
		        if (opt==1){
		            dv1.style.display = 'block';
		            dv2.style.display = 'none';	
		            
		            tdU.style.background= "url('../System/Icons/tb_center_snl.gif')" ;
		            tdU.style.backgroundColor = '#adadad' ;
		            i11.src = "../System/icons/tb_left_sel.gif" ; 
		            i12.src = "../System/icons/tb_right_sel.gif" ; 
		            
		            tdG.style.background= "url('../System/Icons/tb_center_ns.gif')" ;
		            tdG.style.backgroundColor = '#ffffff' ;
		            i21.src = "../System/icons/tb_left_ns.gif" ; 
		            i22.src = "../System/icons/tb_right.gif" ; 
		            
		        }else {
		        
		            dv1.style.display = 'none';		        
		            dv2.style.display = 'block';
		            
		            tdG.style.background= "url(../System/Icons/tb_center_snl.gif)";
		            tdG.style.backgroundColor = '#adadad' ;
		            
		            i21.src = "../System/icons/tb_left_sel.gif" ; 
		            i22.src = "../System/icons/tb_right_sel.gif" ; 
                          
                    tdU.style.background="url(../System/Icons/tb_center_ns.gif)";
		            tdU.style.backgroundColor = '#ffffff' ;
		            i11.src = "../System/icons/tb_left_ns.gif" ; 
		            i12.src = "../System/icons/tb_right.gif" ; 
		            
		       }

		    }

		</script>
		<script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
                                    
                                     		
	</body>
</html>
