<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_Component_Multimaterial_Main.ascx.vb" Inherits="plmOn2Report.Style_Component_Multimaterial_Main" %>

<asp:panel id="Panel2" runat="server">
    
<table width="100%"  style="border-collapse:collapse;" border="0" bordercolor="black" cellspacing="1"><tr><td>
&nbsp;&nbsp;&nbsp;<FONT face="Tahoma" size="1"><asp:label ID="lblMainMaterial"  runat ="server" ></asp:label></FONT>
</td></tr>
<tr><td>    
    <asp:datagrid id="dgMainMaterial" runat="server" Width="100%" GridLines="None" EnableViewState="False" BorderColor="black" >
	    <AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma"  ></AlternatingItemStyle>
        <ItemStyle Font-Size="6pt" Font-Names="Tahoma"  ></ItemStyle>
        <HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black" ></HeaderStyle>
	    <Columns>
		    <asp:TemplateColumn>
		        <ItemStyle Width="75" />
			    <HeaderStyle Width="75"></HeaderStyle>
			    <ItemTemplate>
				    <table cellspacing="0" cellpadding="0" width="25" border="0">
					    <tr>
						    <td>
							    <asp:Image  id="imgDesign" runat="server"></asp:Image></td>
					    </tr>
				    </table>
			    </ItemTemplate>
		    </asp:TemplateColumn>
	    </Columns>
    </asp:datagrid>
</td></tr></table>
<!-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->				

<table width="100%"  style="border-collapse:collapse;" border="0" bordercolor="black" >
<tr><td><asp:datagrid id="dgComponentType" runat="server" Width="100%" ShowHeader="false" 
                    AutoGenerateColumns="false" GridLines="None" BackColor="White" EnableViewState="False"  
                    borderwidth="0px" BorderColor="black"  
                    CellPadding="0" CellSpacing="0">
	                <Columns>
	                    <asp:TemplateColumn HeaderStyle-Width="75">
	                        <ItemTemplate>
	                            <table runat="server" id="tbGrid" cellspacing="0" cellpadding="0"  border="1"  bordercolor="black"
	                                width="100%"  style="border-collapse:collapse;"   >
	                            <tr><td >
                	            
                <!--------------------------------------------------------->
                                    <asp:datagrid id="DataGrid1" runat="server" Width="100%"  
                                        AutoGenerateColumns="false" GridLines="None" BackColor="white" EnableViewState="False" 
                                        >
                                        
	                                    <AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma" ></AlternatingItemStyle>
                                        <ItemStyle Font-Size="6pt" Font-Names="Tahoma" ForeColor="Black" ></ItemStyle>
                                        <HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black"  ></HeaderStyle>

	                                    <Columns>
		                                    <asp:TemplateColumn >
		                                        <HeaderTemplate>Image</HeaderTemplate>
		                                        <ItemStyle Width="75" />
			                                    <ItemTemplate><asp:Image id="imgDesign" runat="server"></asp:Image></ItemTemplate>
		                                    </asp:TemplateColumn>
	                                    </Columns>
                                    </asp:datagrid>
                <!--------------------------------------------------------->	            
	                            </td></tr>
                                <tr runat="server" id="rowSubMaterial" ><td><table  
                                    border="0" bordercolor="black"  cellpadding="0" cellspacing="0"  
                                        style="border-collapse:collapse;"  width="100%"  >
                                        <tr>
                                            <td width="75px">&nbsp;&nbsp;</td>
                                            <td ><asp:PlaceHolder ID="phComponent" runat ="server" ></asp:PlaceHolder></td>
                                         </tr></table>
                                    
                                 </td></tr></table>
	                        </ItemTemplate>
	                    </asp:TemplateColumn>
	                </Columns>
                </asp:datagrid>
</table>
                
</asp:panel>                
<!-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->				
<asp:panel id="Panel1" runat="server">
	<table borderColor="gold" height="75" cellSpacing="0" cellPadding="0" width="800" bgColor="#ffff99"
		border="1">
		<TR>
			<TD>
				<table id="TB_MainMaterial" cellSpacing="0" cellPadding="0" width="600" border="0">
					<TR>
						<TD width="10" height="50">&nbsp;</TD>
						<TD width="50" height="50" rowSpan="2"><IMG src="../System/Icons/icon_warning_32.gif"></TD>
						<TD width="200"><SPAN  style="FONT-WEIGHT: bold; COLOR: #e60000"><asp:Label ID="lblMaterialNotFound" runat="server"></asp:Label></SPAN><BR>
							<asp:Label ID="lblAddMaterial" runat="server"></asp:Label></TD>
						<TD height="50"></TD>
					</TR>
				</table>
			</TD>
		</TR>
	</table>
</asp:panel>