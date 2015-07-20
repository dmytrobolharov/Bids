<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_GRMeasurements_Template_SampleSize.aspx.vb" Inherits="plmOnApp.Control_GRMeasurements_Template_SampleSize" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Template Sample Size</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	</head>
	<body onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
					<td>
                     <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                     <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="middle">&nbsp;
                        <asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"><%#GetSystemText("Template Sample Size")%></asp:label>
					    <asp:label id="lblSampleRequired" runat="server" ForeColor="Red" CssClass="FontHead"></asp:label>
                    </td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
			    <tr><td valign="top" width="450">
				<asp:datagrid id="SizeDataGrid" runat="server" DataKeyField = "SizeRowId" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							  PageSize="100" AutoGenerateColumns="False"  Width="300px">
					<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>							
					<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<Columns>						        
								<asp:TemplateColumn>
								    <HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSize" Text='<%#GetSystemText("Size")%>' runat="server" /></div>
									</HeaderTemplate>									
									<ItemTemplate>
										<div align="center">
											<asp:label id="lblSizeName" runat="Server"><%#DataBinder.Eval(Container.DataItem, "SizeName").ToString%></asp:label>
										</div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>																		
									    <HeaderTemplate>
										    <div align="center">
											    <asp:Label id="lblSample" Text='<%#GetSystemText("Sample")%>' runat="server"/>
                                            </div>
									    </HeaderTemplate>
									    <ItemTemplate>	
										    <div align="center">
                                                <asp:radiobutton id="rbSample" Checked='<%#DataBinder.Eval(Container.DataItem, "IsSampleSize").ToString%>' 
                                                                 AutoPostBack="true" OnCheckedChanged="SetSample" runat="server"></asp:radiobutton>
									        </div>
									    </ItemTemplate>
								</asp:TemplateColumn>								
							</Columns>
				</asp:datagrid>			
				</td></tr></table>			
		</form>
        <script type="text/javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
