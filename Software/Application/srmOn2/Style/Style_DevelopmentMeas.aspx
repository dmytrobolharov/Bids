<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DevelopmentMeas.aspx.vb" Inherits="srmOnApp.Style_DevelopmentMeas" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc3" TagName="Style_WorkflowItem" Src="Style_WorkFlowItem.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style Development Spec</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch" style="margin:0px;">		    
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow>			
			<uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'></uc2:style_header>
			<uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment>
			<uc3:Style_WorkflowItem id="Style_WorkflowItem1" runat="server" />
            <table>
                <tr>
                    <td height="3"></td>
                </tr>
            </table>
			<cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview>
			<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:label id="lblMeasHeader" runat="server">Worksheet Information</asp:label></td>
				</tr>
			</table>				
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="100%" bgColor="#ffffff">					    
						
							<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>						
					</td>
				</tr>
			</table>	
			<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<TR vAlign="top">
					<TD>	
			        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
				        <tr>
					        <td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					        <td><asp:label id="Label1" runat="server">PoM Search</asp:label></td>
				        </tr>
			        </table>					
					<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
						<tr>
							<td><asp:CheckBox ID="ChbShowHide" width="100" CssClass="fontHead" autopostback="true" runat="server" 
                                    Text="Show Sort ID" /></td>
							<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>								
							<td vAlign="top" width="100%">
								<table height="45">
									<tr>
										<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>											
									</tr>
								</table>
							</td>																
						</tr>
					</table>														
			        <table class="TableHeader" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				        border="0">
				        <TR vAlign="middle">
					        <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					        <TD class="fontHead" width="10"></TD>
					        <TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"  ImageUrl="../System/Icons/icon_first_disable.gif"></asp:imagebutton></TD>
					        <TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"  ImageUrl="../System/Icons/icon_Previous_disable.gif"></asp:imagebutton></TD>
					        <TD noWrap align="center" width="100"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					        <TD width="20"><asp:imagebutton id="btnImgNext" runat="server"  ImageUrl="../System/Icons/icon_next_disable.gif"></asp:imagebutton></TD>
					        <TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last_disable.gif"></asp:imagebutton></TD>
					        <TD width="10">&nbsp;</TD>
					        <TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
					        <TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
					        <TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							        <asp:ListItem Value="5">5</asp:ListItem>
							        <asp:ListItem Value="10">10</asp:ListItem>
							        <asp:ListItem Value="15">15</asp:ListItem>
							        <asp:ListItem Value="20">20</asp:ListItem>
							        <asp:ListItem Value="25">25</asp:ListItem>
							        <asp:ListItem Value="30">30</asp:ListItem>
							        <asp:ListItem Value="40">40</asp:ListItem>
							        <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
						        </asp:dropdownlist></TD>
					        <TD width="10"><asp:button id="btnRepage" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></TD>
				        </TR>
			        </table>												
						        
			        <asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" 
                        BorderStyle="Solid" BorderWidth="1px"
					        PageSize="100" AutoGenerateColumns="False" AllowPaging="true" PagerStyle-Visible="false">
					        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle></asp:datagrid>						        
					        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
					        <td valign="top"><asp:image id="imgDesign" style="display:none" runat="server" BorderColor="Transparent"></asp:image></td>
				</TD>				        
			    </TR>   
			</TABLE>
		</form>
	</body>
</html>
