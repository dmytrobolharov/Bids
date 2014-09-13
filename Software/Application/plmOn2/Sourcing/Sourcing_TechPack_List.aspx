<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_TechPack_List.aspx.vb" Inherits="plmOnApp.Sourcing_TechPack_List" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <form id="form1" runat="server">

			<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle" height="25">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:bwimagebutton 
					id="btnNew" runat="server" Message="NONE" ></cc1:bwimagebutton></TD>
				</TR>
			</TABLE>
		   <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD>&nbsp;
						<asp:label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="Silver">Tech Pack</asp:label></TD>
				</TR>
			</table>  
			<table id="Table1" cellSpacing="1" cellpadding="1" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:placeholder id="plhHeaderControl" runat="server"></asp:placeholder></td>
				</tr>
			</table>
            <asp:Panel ID="pnlSeasonYear"  runat="server" >
                <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                    border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                        <td nowrap="nowrap">
                            <asp:Label runat="server" ID="lblSeasonYearLabel" class="fontHead" ></asp:Label>&nbsp;
                            <asp:Label ID="lblStyleSeasonYear" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel> 
    		<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<td width="900">
						<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder><BR>
					</td>
				</TR>
			</TABLE>
            <table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
			    <tr>
				    <td valign="top">
				            <asp:DataGrid id="dlTechPack" runat="server" ShowHeader="True" AutoGenerateColumns="False" Width="825px"
								BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver">
								<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
								<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
								<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn ItemStyle-Width="25">
										<HeaderStyle  Width="25px" CssClass="TableHeader"></HeaderStyle>
										<ItemTemplate>
											<div align="center">
												<asp:Image id="imgPdf" runat="server" ImageUrl="../System/Icons/icon_pdf.gif"></asp:Image>
											</div>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderStyle  Width="200px" CssClass="TableHeader"></HeaderStyle>
										<ItemTemplate>
											<asp:Label id="lblTechPack" runat="server" />
										</ItemTemplate>
									</asp:TemplateColumn>

									<asp:TemplateColumn >
										<HeaderStyle  Width="300px" CssClass="TableHeader"></HeaderStyle>
										<HeaderTemplate><asp:Label Runat="server" ID="lblCommentsHeader" CssClass="fontHead"><%#GetSystemText("Comments")%></asp:Label></HeaderTemplate>
										<ItemTemplate><asp:Label Runat="server" ID="lblComments" CssClass="font"></asp:Label></ItemTemplate>
									</asp:TemplateColumn>

									<asp:TemplateColumn >
										<HeaderStyle  Width="150px" CssClass="TableHeader"></HeaderStyle>
										<HeaderTemplate><asp:Label Runat="server" ID="lblCUserHeader" CssClass="fontHead"><%#GetSystemText("Created By")%></asp:Label></HeaderTemplate>
										<ItemTemplate><asp:Label Runat="server" ID="lblCUser" CssClass="font"></asp:Label></ItemTemplate>
									</asp:TemplateColumn>																	
									<asp:TemplateColumn >
										<HeaderStyle  Width="150px" CssClass="TableHeader"></HeaderStyle>
										<HeaderTemplate><asp:Label Runat="server" ID="lblCDateHeader" CssClass="fontHead"><%#GetSystemText("Created Date")%></asp:Label></HeaderTemplate>
										<ItemTemplate><asp:Label Runat="server" ID="lblCDate" CssClass="font"></asp:Label></ItemTemplate>
									</asp:TemplateColumn>									
								</Columns>
							</asp:DataGrid>
				    </td>
			    </tr>
		    </table>


    </form>
</body>
</html>
