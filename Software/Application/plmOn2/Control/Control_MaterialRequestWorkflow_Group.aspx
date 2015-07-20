<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_MaterialRequestWorkflow_Group.aspx.vb" Inherits="plmOnApp.Control_MaterialRequestWorkflow_Group" %>

<%@ Register Assembly="YSTab" Namespace="Yunique.WebControls.YSTab" TagPrefix="cc2" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Material Request Workflow</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="80"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"
							></cc1:confirmedimagebutton></td>
					<td width="80">
                        <cc1:confirmedimagebutton id="btnCopyFrom" runat="server" Message="NONE"
							></cc1:confirmedimagebutton></td>	
					<td width="80">
                        <cc1:confirmedimagebutton id="btnRemove" runat="server" Message="NONE"
							></cc1:confirmedimagebutton></td>	
					<td width="80">
                        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
							></cc1:confirmedimagebutton></td>

                    <td></td>
				</TR>
			</TABLE>
        <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	        height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	        <tr>
		        <td width="25" height="50">&nbsp;</td>
		        <td>
                    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
	                    <tr>
		                    <td width="25" height="50">&nbsp;</td>
		                    <td><span class="fontHead">&nbsp;<asp:Label ID="lblHeader" runat="server" ></asp:Label></span></td>
	                    </tr>
                    </table>
		        </td>
	        </tr>
        </table>	
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
                        <cc1:ScrollingGrid ID="sgMaterialWorkflow" runat="server" Height="350px" Width="485px">
						            <asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" 
                                        DataKeyField="MaterialRequestWorkflowGroupID" BorderColor="Silver" 
                                        BorderStyle="Solid" BorderWidth="1px">
							            <AlternatingItemStyle Height="25px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							            <ItemStyle Height="25px" CssClass="ItemTemplate"></ItemStyle>
							            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							            <PagerStyle Visible="False"></PagerStyle>
					                    <Columns>
					                        <asp:TemplateColumn>
					                            <ItemTemplate>
					                                <asp:CheckBox runat="server" ID="chkSelect" />
					                            </ItemTemplate>
					                        </asp:TemplateColumn>
					                    </Columns> 
						            </asp:datagrid>
                        </cc1:ScrollingGrid>

                        <table cellspacing="0" cellpadding="0" border="0" 
                            style="height: 28px; width: 100%">
                            <tr class="TableHeader">
                                <td valign="middle" align="center" width="10">
                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                </td>
                                <td width="50" align="right">
                                    <asp:DropDownList ID="ddlAdd" runat="server" CssClass="fontHead">
                                        <asp:ListItem Text="1" Value="1" Selected="True" />
                                        <asp:ListItem Text="2" Value="2" />
                                        <asp:ListItem Text="3" Value="3" />
                                        <asp:ListItem Text="4" Value="4" />
                                        <asp:ListItem Text="5" Value="5" />
                                    </asp:DropDownList>
                                </td>
                                <td width="50">
                                    <cc1:ConfirmedImageButton ID="btnAdd" runat="server" 
                                        Message="NONE" />
                                </td>
                                 <td>
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="75" align="right"> <asp:label id="lblSortBy" Runat="server" 
                                                    CssClass="font" Font-Bold="True"><b>&nbsp;&nbsp;</b></asp:label></td>
                                            <td><asp:dropdownlist id="ddlSortBy" Runat="server" /></td>
                                            <td>
                                                <cc1:ConfirmedImageButton ID="btnSort" runat="server" 
                                                    Message="NONE" />
                                            </td>                                                            
                                        </tr>
                                    </table>
                                </td>
                                <td></td>
                           </tr>
                        </table>
                        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
