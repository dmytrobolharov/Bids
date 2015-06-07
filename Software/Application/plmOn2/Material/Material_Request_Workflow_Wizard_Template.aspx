<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_Request_Workflow_Wizard_Template.aspx.vb" Inherits="plmOnApp.Material_Request_Workflow_Wizard_Template" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title></title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />    
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
 <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif" ToolTip="Show Material Header..."></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" ToolTip="Hide Material Header..." Visible="false"></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:label id="lblMaterialDetail" runat="server"></asp:label></td>
				</tr>
			</table>
			<asp:panel id="Panel1" runat="server" CssClass="font" BorderWidth="0" BackColor="#ffffff" Width="100%" Visible="false">
				<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc2:Material_Header id="Material_Header1" runat="server"></uc2:Material_Header></td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</asp:panel>    
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="Gray">Material Request</asp:label></td>
				</tr>
			</table>

			
			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
                <tr>
                    <td class="fontHead"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
                </tr>
            </table>
			<br />
	       <table  style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	            height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	            <TR>
		            <TD align="center" width="50">&nbsp;</TD>
		            <TD align="center" width="500">
			            <asp:imagebutton id="btnBack" runat="server" CausesValidation="false" ></asp:imagebutton>
			            <asp:imagebutton id="btnSave" runat="server" ></asp:imagebutton>
                        <asp:imagebutton id="btnGenerate" runat="server" ></asp:imagebutton>
                        <asp:imagebutton id="btnShare" runat="server" ></asp:imagebutton>
			            <asp:imagebutton id="btnNext" runat="server" 
                             Visible="False"></asp:imagebutton>
		            </TD>
		            <TD align="center">&nbsp;</TD>
	            </TR>
            </table>
            <table>
                <tr>
                    <td>
                        <asp:HiddenField runat="server" ID="hdnMaterialRequestGroupID" />
                        <asp:Panel ID="pnlWorkflow" runat="server">
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td class="fontHead" width="75">
                                        <asp:Label ID="lblScheduleBy" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:RadioButtonList ID="rbSubmitType" runat="server" CssClass="fontHead" RepeatDirection="Horizontal">
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                            </table>
                            <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
                            <asp:DataGrid ID="dgWorkflow" runat="server" DataKeyField="MaterialRequestTempWorkflowID"
                                AllowSorting="false">
                                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                                <PagerStyle Visible="False"></PagerStyle>
                                <Columns>
									<asp:TemplateColumn ItemStyle-BorderWidth="1" ItemStyle-BorderColor="Gainsboro">
										<ItemTemplate>
                                            <asp:HiddenField runat="server" ID="hdnTACalTemplateTaskExists" Value='<%#Eval("TACalTemplateTaskExists") %>' />
                                            <asp:HiddenField runat="server" ID="hdnTACalTaskPlanStart" Value='<%#Eval("TaskPlanStart")%>' />
										</ItemTemplate>
									</asp:TemplateColumn>
                                    <%--				    	                    <asp:TemplateColumn>
							                <headerStyle Height="20px" Width="20px" CssClass="TableHeader"></headerStyle>
							                <ItemTemplate>
								                <%# string.Concat(DataBinder.Eval(Container.DataItem,"StatusUrl").tostring) %>								     
							                </ItemTemplate>
						                </asp:TemplateColumn>
                                    --%>
                                </Columns>
                            </asp:DataGrid>
                        </asp:Panel>
                    </td>
                </tr>
            </table>

            <asp:HiddenField ID="hdnXMLFile" runat="server" />
    </form>
</body>
</html>
