<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_WorkFlow_Submit_DesignSample_MeasShowHideSize.aspx.vb" Inherits="srmOnApp.SampleRequest_WorkFlow_Submit_DesignSample_MeasShowHideSize" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Sample Size</title>
		<META http-equiv="Content-Type" content="text/html; charset=windows-1252">	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body onblur="this.focus();" onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnSynchronize" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="middle">&nbsp;
					<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Show Hide Sizes</asp:label>
				    </td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
			    <tr><td valign="top" width="450">
				<asp:datagrid id="DataGrid1" runat="server" OnItemDataBound="itemDataBound" DataKeyField = "SampleRequestAMLMeasLblId" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							PageSize="100" AutoGenerateColumns="False"  Width="300px">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>							
							<Columns>								    				        
								<asp:TemplateColumn>
								    <HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize" Text='<%#GetSystemText("Size Labels")%>' runat="server" /></div>
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
										    <asp:Checkbox id="chkSelectAll"  runat="server" AutoPostBack="true" Text='<%#GetSystemText("Size")%>' OnCheckedChanged="CheckUncheckSizes" ></asp:Checkbox>
										</div>
								    </HeaderTemplate>
								    <ItemTemplate>	
									    <DIV align="center">
									        <asp:Checkbox id="chkSelected" runat="server"></asp:Checkbox>
                                            <asp:HiddenField ID="hdnSelected" runat="server" />
								        </DIV>
								    </ItemTemplate>
								</asp:TemplateColumn>								
							</Columns>
				</asp:datagrid>			
				</td></tr></table>			
		</form>			
	</body>
</html>
