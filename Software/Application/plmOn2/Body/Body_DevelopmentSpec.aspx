<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_DevelopmentSpec.aspx.vb" Inherits="plmOnApp.Body_DevelopmentSpec" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">


        <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		runat="server">
		    <TR vAlign="middle">
			    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			    <TD>
				    <cc1:confirmedimagebutton id="btnEdit" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
		    </TR>
		</table> 
		<br />
		<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
		<br />
		<asp:PlaceHolder  runat ="server"  ID="plhHeader" ></asp:PlaceHolder>
        <br />
            <table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top" width="400"><asp:datagrid id="DataGrid1" runat="server" Width="400px" AutoGenerateColumns="False" PageSize="100"
							BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderPOM" Text="POM" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblPOM" runat="server" Width="50"></asp:Label></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="left">
											<asp:Label id="lblHeaderPointMeasur" Text="Point of Measurement" runat="server" />
										</div>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblPointMeasur" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderStyle-CssClass="TableHeaderRed">
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderTOL" Text="TOL" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblTOL" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderStyle-CssClass="TableHeaderRed">
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderTOLN" runat="server" ForeColor="Red">TOL
                                                <br/><font style="FONT-WEIGHT: normal; FONT-SIZE: xx-small; COLOR: red; FONT-FAMILY: Arial">
												(NONWASH)</font>											
											</asp:Label>
											</div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblTOLN" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderStyle-CssClass="TableHeaderGreen">
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSampleSize" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
					<td vAlign="top"><asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image></td>
				</tr>
			</table>

    </form>
</body>
</html>
