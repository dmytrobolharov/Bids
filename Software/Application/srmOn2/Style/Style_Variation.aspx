<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Variation.aspx.vb" Inherits="srmOnApp.Style_Variation" %>
<%@ Register TagPrefix="uc1" TagName="Style_Variation" Src="Style_Variation.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Variation</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		
		
			<asp:datalist id="dlVariation" runat="server" RepeatDirection="Horizontal" Width="300px">
				<ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<TABLE class="TableHeader" height="24" cellSpacing="0" cellPadding="0" width="100%" border="0">
						<TR vAlign="middle">
							<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<TD>
								<asp:Label id=lblVariation runat="server" Text='<%# string.Concat("Variation " + DataBinder.Eval(Container.DataItem, "Variation").ToString) %>' CssClass="fontHead">
								</asp:Label></TD>
						</TR>
					</TABLE>
					<uc1:Style_Variation id=Style_Variation1 runat="server" StyleVariation='<%# string.Concat(DataBinder.Eval(Container.DataItem, "Variation").ToString) %>' StyleDevelopmentID='<%# string.Concat(DataBinder.Eval(Container.DataItem, "StyleDevelopmentID").ToString) %>'>
					</uc1:Style_Variation>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist>
			
		</form>
	</body>
</HTML>
