<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_WorkFlow_Submit_MeasQASampleSize.aspx.vb" Inherits="plmOnApp.SampleRequest_WorkFlow_Submit_MeasQASampleSize" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Sample Size</title>
		<META http-equiv="Content-Type" content="text/html; charset=windows-1252">	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="middle">&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Sample Size</asp:label>
						<asp:label id="lblSampleRequired" runat="server" ForeColor="Red" CssClass="FontHead"></asp:label></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
			    <tr><td valign="top" width="450">
			    <asp:datagrid id="DataGrid1" runat="server" DataKeyField = "AMLMeasLblId" OnItemDataBound="itemDataBound" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							PageSize="100" AutoGenerateColumns="False"  Width="300px">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>							
							<Columns>						        
								<asp:TemplateColumn>
								    <HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize" Text='<%#GetSystemText("Size")%>' runat="server" /></div>
									</HeaderTemplate>									
									<ItemTemplate>
										<DIV align="center">
											<asp:label id="lblSizeName" runat="Server"></asp:label>
										</DIV>
									</ItemTemplate>									
								</asp:TemplateColumn>
								<asp:TemplateColumn>																		
									    <HeaderTemplate>
										    <div align="center">
											    <asp:Label id="lblSample" Text='<%#GetSystemText("Sample")%>' runat="server" /></div>
									    </HeaderTemplate>									    
									    <ItemTemplate>	
									        <div align="center">										     										                                                       										        
										        <asp:TextBox id="txtSampleNo" runat="server" Width="40px" MaxLength="2" ></asp:TextBox>										        									      
										        <asp:RegularExpressionValidator ID="rvSampleNo" runat="server" CssClass="fontHead" ErrorMessage='<%#GetSystemText("Enter whole number between 1 to 12!") %>' ControlToValidate="txtSampleNo" ValidationExpression="^[0-9]+[0-9]{0,1}$" Display="Static" 
                                                     ToolTip='<%#GetSystemText("Between 1 to 12") %>'></asp:RegularExpressionValidator>
                                             </div>
									    </ItemTemplate>									    
								</asp:TemplateColumn>								
							</Columns>
				</asp:datagrid>			
				</td></tr></table>			
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>		
</html>
