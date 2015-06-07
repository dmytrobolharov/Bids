<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Group_LinePlanFolder.aspx.vb" Inherits="plmOnApp.Control_Group_LinePlanFolder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>User Access</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form onkeypress="if(event.keyCode==13) {document.getElementById('btnImgSearch').click(); return false}"
			id="Form1" method="post" runat="server">
			<asp:ScriptManager ID="scriptMgr" runat="server" EnablePartialRendering="true"/>
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:imagebutton id="btnInvSearch" tabIndex="0" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:BWImageButton id="btnLockFolder" runat="server" ></cc1:BWImageButton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<TD class="FontHead" align="right" width="75"></TD>
					<TD width="40"></TD>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<TD align="right" width="40">
						<asp:Image id="iconLock" runat="server" ImageUrl="../System/Icons/icon_lock32.gif"></asp:Image></TD>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<asp:UpdatePanel ID="updatePnl" runat="server">
            <ContentTemplate>
			<asp:datalist id="dlLinePlanFolder" runat="server" Width="100%" BorderColor="Silver" BorderStyle="Solid"
				BorderWidth="1px">
				<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
				<FooterTemplate>
				</FooterTemplate>
				<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<TABLE width="100%">
						<TR>
							<TD width="20">
								<asp:Image id="iconStatus" runat="server"></asp:Image></TD>
							<TD class="fontHead" width="200"><%#Container.DataItem("Custom")%></TD>
							<TD width="125">
								<asp:RadioButtonList id="rbAccess" runat="server" Width="200px" OnSelectedIndexChanged="SelectedIndexChanged"
									RepeatDirection="Horizontal" AutoPostBack="True" CssClass="fontHead">
								</asp:RadioButtonList>
						    		<!--
									<asp:ListItem Value="3">Full    </asp:ListItem>
									<asp:ListItem Value="2">Partial   </asp:ListItem>
									-->
						    </TD>
							<TD>
								<asp:Panel id="pnlPartial" runat="server">
									<table>
									    <tr>
									        <td>
									            <table>
									                <tr>
									                    <td>
										                    <table border="0" cellpadding="0" cellspacing="0">
										                        <tr class="TableHeaderBlue">
						                                            <td></td>
						                                            <td>
                                                                        <asp:Label ID="lblPlanning" runat="server"><%#GetSystemText("Planning")%></asp:Label></td>
						                                            <td></td>
									                            </tr>
										                        <tr>
										                            <td>
										                                <asp:CheckBox id="cbAccessPlanView" runat="server" CssClass="fontHead" Text='<%#GetSystemText("View") %>'></asp:CheckBox>
										                                <td><asp:CheckBox id="cbAccessPlanNew" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Create") %>'></asp:CheckBox></td>
									                                    <td><asp:CheckBox id="cbAccessPlanDelete" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Delete") %>' ForeColor="Red"></asp:CheckBox></td>
										                            </td>
										                        </tr>
										                    </table>	
										                </td>
									                </tr>
									            </table>								        
									        </td>
									        <td>
									            <table>
									                <tr>
									                    <td>
									                        <table border="0" cellpadding="0" cellspacing="0">
									                            <tr class="TableHeaderRed">
									                                <td></td>
									                                <td><asp:Label ID="lblHierarchy" runat="server" ><%#GetSystemText("Hierarchy")%></asp:Label></td>
									                                <td></td>
									                            </tr>
									                            <tr>
									                                <td><asp:CheckBox id="cbAccessHierView" runat="server" CssClass="fontHead" Text='<%#GetSystemText("View") %>'></asp:CheckBox></td>
									                                <td><asp:CheckBox id="cbAccessHierNew" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Create") %>'></asp:CheckBox></td>
									                                <td><asp:CheckBox id="cbAccessHierDelete" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Delete") %>' ForeColor="Red"></asp:CheckBox></td>
									                            </tr>
									                        </table> 									                
									                    </td>
									                </tr>
									            </table>    
									        
									        </td>
									    </tr>
									</table>
								</asp:Panel></TD>
						</TR>
					</Table>		
					<Table>
					    <tr>
					        <TD width="20"></TD>
                            <td colspan="3">
                                <asp:DataList ID="dlLinePlanFolderTab" runat="server" BorderColor="Silver" 
                                    BorderStyle="Solid" BorderWidth="1px" Width="100%" OnItemDataBound="dlLinePlanFolderTabDataBound">
                                    <AlternatingItemStyle BackColor="AliceBlue" />
                                    <FooterTemplate>
                                    </FooterTemplate>
                                    <ItemStyle BackColor="White" BorderColor="LightGray" BorderStyle="Solid" 
                                        BorderWidth="1px" />
                                    <ItemTemplate>
                                        <table width="100%">
                                            <tr>
                                                <td width="20">
                                                    <asp:Image ID="iconStatusTab" runat="server" />
                                                </td>
                                                <td class="fontHead" width="200">
                                                    <%#Container.DataItem("LinePlanTabName")%></td>
                                                <td width="125">
                                                    <asp:RadioButtonList ID="rbAccessTab" runat="server" AutoPostBack="True" 
                                                        CssClass="fontHead" OnSelectedIndexChanged="SelectedIndexTabChanged" 
                                                        RepeatDirection="Horizontal" Width="200px">
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    <asp:Panel ID="pnlPartialTab" runat="server">
                                                        <asp:CheckBox ID="cbAccessViewTab" runat="server" AutoPostBack="True" CssClass="fontHead" OnCheckedChanged="SelectedIndexTabChanged" Text='<%#GetSystemText("View") %>' />
                                                        <asp:CheckBox ID="cbAccessCreateTab" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Create") %>' />
                                                        <asp:CheckBox ID="cbAccessModifyTab" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Modify") %>' />
                                                        <asp:CheckBox ID="cbAccessRemoveTab" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Remove") %>'  ForeColor="Red" />
                                                        <asp:CheckBox ID="cbAccessDeleteTab" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Delete") %>'  ForeColor="Red" />
                                                        <asp:CheckBox ID="cbAccessPrintTab" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Print") %>' />
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                            </td>
                        </tr>
					</TABLE>
				</ItemTemplate>
			</asp:datalist>
			</ContentTemplate>
        </asp:UpdatePanel>
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
		<asp:Label id="lblWarning" runat="server" CssClass="fontHead"></asp:Label>
	</form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
		</body>
</HTML>
