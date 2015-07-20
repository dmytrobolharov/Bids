<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_QA.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_QA" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview>
<%--<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="middle">
		<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
		<TD><asp:Label ID="lblQAWorksheetH" runat="server"></asp:Label></TD>
		<TD></TD>
	</TR>
</TABLE>--%>
<asp:label id="lblFitComment" runat="server"></asp:label>
<asp:PlaceHolder ID="phComment" runat="server" ></asp:PlaceHolder>
<asp:datagrid id="DataGrid1" runat="server" AutoGenerateColumns="False" PageSize="200" 
 >
<AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
<ItemStyle CssClass="ItemTemplate"></ItemStyle>
<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
<Columns>
	<asp:TemplateColumn>
		<HeaderTemplate>
				<asp:Label id="lblHeaderPOM" runat="server" Width="50"><%#GetSystemText("POM")%></asp:Label>
		</HeaderTemplate>
		<ItemTemplate>
			    <asp:Label id="txtPOM" runat="Server"></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderTemplate>
			<asp:Label id="lblHeaderPointMeasur" runat="server" Width="150"><%#GetSystemText("Point of Measurement")%></asp:Label>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtPointMeasur" runat="Server"></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblHeaderTol" runat="server" ForeColor="Red"><%#GetSystemText("TOL")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtTOL" runat="server"></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblHeaderTolN" runat="server" ForeColor="Red"><%#GetSystemText("TOL")%></asp:Label> &nbsp;<FONT style="FONT-WEIGHT: normal; FONT-SIZE: xx-small; COLOR: red; FONT-FAMILY: Arial"><asp:Label
                    ID="lblNoWash" runat="server"><%#GetSystemText("(NONWASH)")%></asp:Label></FONT></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtTOLN" runat="server" ForeColor="#C00000"  
				  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked000" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk000" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec000" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec000" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec001" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec001" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec002" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec002" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec003" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec003" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec004" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec004" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec005" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec005" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec006" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec006" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec007" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec007" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec008" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec008" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec009" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec009" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked001" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk001" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec010" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec010" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec011" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec011" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec012" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec012" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec013" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec013" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec014" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec014" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec015" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec015" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec016" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec016" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec017" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec017" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec018" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec018" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec019" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec019" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked002" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk002" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec020" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec020" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec021" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec021" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec022" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec022" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec023" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec023" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec024" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec024" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec025" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec025" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec026" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec026" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec027" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec027" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec028" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec028" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec029" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec029" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked003" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk003" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec030" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec030" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec031" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec031" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec032" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec032" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec033" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec033" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec034" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec034" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec035" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec035" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec036" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec036" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec037" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec037" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec038" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec038" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec039" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec039" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked004" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk004" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec040" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec040" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec041" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec041" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec042" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec042" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec043" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec043" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec044" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec044" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec045" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec045" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec046" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec046" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec047" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec047" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec048" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec048" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec049" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec049" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked005" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk005" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec050" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec050" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec051" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec051" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec052" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec052" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec053" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec053" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec054" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec054" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec055" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec055" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec056" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec056" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec057" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec057" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec058" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec058" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec059" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec059" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked006" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk006" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec060" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec060" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec061" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec061" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec062" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec062" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec063" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec063" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec064" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec064" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec065" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec065" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec066" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec066" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec067" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec067" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec068" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec068" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec069" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec069" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked007" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk007" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec070" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec070" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec071" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec071" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec072" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec072" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec073" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec073" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec074" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec074" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec075" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec075" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec076" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec076" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec077" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec077" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec078" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec078" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec079" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec079" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked008" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk008" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec080" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec080" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec081" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec081" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec082" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec082" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec083" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec083" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec084" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec084" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec085" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec085" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec086" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec086" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec087" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec087" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec088" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec088" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec089" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec089" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked009" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk009" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec090" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec090" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec091" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec091" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec092" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec092" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec093" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec093" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec094" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec094" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec095" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec095" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec096" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec096" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec097" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec097" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec098" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec098" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec099" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec099" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked010" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk010" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec100" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec100" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec101" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec101" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec102" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec102" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec103" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec103" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec104" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec104" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec105" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec105" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec106" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec106" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec107" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec107" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec108" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec108" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec109" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec109" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked011" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk011" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec110" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec110" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec111" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec111" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec112" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec112" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec113" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec113" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec114" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec114" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec115" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec115" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec116" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec116" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec117" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec117" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec118" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec118" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec119" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec119" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked012" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk012" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec120" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec120" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec121" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec121" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec122" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec122" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec123" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec123" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec124" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec124" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec125" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec125" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec126" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec126" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec127" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec127" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec128" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec128" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec129" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec129" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked013" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk013" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec130" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec130" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec131" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec131" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec132" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec132" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec133" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec133" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec134" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec134" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec135" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec135" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec136" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec136" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec137" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec137" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec138" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec138" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec139" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec139" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked014" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk014" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec140" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec140" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec141" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec141" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec142" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec142" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec143" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec143" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec144" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec144" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec145" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec145" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec146" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec146" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec147" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec147" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec148" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec148" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec149" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec149" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked015" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk015" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec150" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec150" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec151" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec151" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec152" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec152" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec153" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec153" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec154" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec154" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec155" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec155" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec156" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec156" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec157" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec157" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec158" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec158" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec159" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec159" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked016" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk016" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec160" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec160" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec161" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec161" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec162" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec162" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec163" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec163" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec164" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec164" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec165" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec165" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec166" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec166" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec167" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec167" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec168" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec168" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec169" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec169" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked017" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk017" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec170" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec170" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec171" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec171" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec172" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec172" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec173" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec173" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec174" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec174" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec175" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec175" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec176" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec176" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec177" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec177" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec178" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec178" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec179" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec179" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked018" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk018" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec180" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec180" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec181" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec181" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec182" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec182" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec183" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec183" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec184" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec184" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec185" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec185" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec186" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec186" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec187" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec187" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec188" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec188" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec189" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec189" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center">
				<asp:Label id="lblAsked019" runat="server" Width="50"><%#GetSystemText("Asked")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			<asp:Label id="txtAsk019" runat="server"   
				ForeColor="RoyalBlue"   />
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:label id="lblSpec190" runat="server" Width="50"><%#GetSystemText("Smp 1")%></asp:label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
			
				<asp:Label id="txtSpec190" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec191" runat="server" Width="50"><%#GetSystemText("Smp 2")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec191" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec192" runat="server" Width="50"><%#GetSystemText("Smp 3")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec192" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec193" runat="server" Width="50"><%#GetSystemText("Smp 4")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec193" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec194" runat="server" Width="50"><%#GetSystemText("Smp 5")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec194" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec195" runat="server" Width="50"><%#GetSystemText("Smp 6")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec195" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec196" runat="server" Width="50"><%#GetSystemText("Smp 7")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec196" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec197" runat="server" Width="50"><%#GetSystemText("Smp 8")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec197" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec198" runat="server" Width="50"><%#GetSystemText("Smp 9")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec198" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>
	<asp:TemplateColumn>
		<HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
		<HeaderTemplate>
			<DIV align="center" style='width:50px;'>
				<asp:Label id="lblSpec199" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></DIV>
		</HeaderTemplate>
		<ItemTemplate>
				<asp:Label id="txtSpec199" runat="Server"   
				ForeColor="Black"  ></asp:Label>
		</ItemTemplate>
	</asp:TemplateColumn>

	
</Columns>

</asp:datagrid>

