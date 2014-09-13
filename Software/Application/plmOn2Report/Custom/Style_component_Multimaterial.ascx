<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_Component_Multimaterial.ascx.vb" Inherits="plmOn2Report.Style_Component_Multimaterial1" %>
<table cellspacing="0" cellpadding="0" width="100%"  style="border-collapse:collapse;" border="1" bordercolor="black" >
<tr runat="server" id="trNoMM" >
    <td><asp:datagrid id="dgNoMultiLinkMaterials" GridLines="None"
	    BackColor="White" runat="server" EnableViewState="False" Width="100%"  CellPadding="0" CellSpacing="0">
    	
	    <AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma" ></AlternatingItemStyle>
	    <ItemStyle Font-Size="6pt" Font-Names="Tahoma" ></ItemStyle>
	    <HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black"  ></HeaderStyle>

	    <Columns>
		    <asp:TemplateColumn  >
		        <HeaderTemplate><asp:Label runat="server" ID="lblImage" Font-Bold="true" ><%#GetSystemText("Image")%></asp:Label></HeaderTemplate>
			    <ItemTemplate>
				    <table cellSpacing="0" cellPadding="0" width="25" border="0">
					    <tr>
						    <td><asp:image id="imgDesign" runat="server"></asp:image></td>
					    </TR>
				    </table>
			    </ItemTemplate>
                <ItemStyle Width="75px" />
		    </asp:TemplateColumn>
	    </Columns>
    </asp:datagrid></td>
</tr>
<tr runat="server" id="trMultiMaterial" >
    <td><asp:datagrid id="dgComponentType" runat="server" Width="100%" AutoGenerateColumns="false" ShowHeader="false" 
        CellPadding="0" CellSpacing="0"  >
	<HeaderStyle ></HeaderStyle>
	<Columns>
	    <asp:TemplateColumn>
	        <ItemTemplate>
	            <table runat="server" id="tbGrid" cellspacing="0" cellpadding="0"  border="0"  width="100%"  
	                style="border-collapse:collapse;"  >
	            <tr> <td >
                    <asp:datagrid id="DataGrid1" runat="server" Width="100%" GridLines="None"
	                        BackColor="White" EnableViewState="False"  CellPadding="0" CellSpacing="0" >
                    
                    	<AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma"></AlternatingItemStyle>
	                    <ItemStyle Font-Size="6pt" Font-Names="Tahoma" ></ItemStyle>
	                    <HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ></HeaderStyle>
	                    
	                    <Columns>
		                    <asp:TemplateColumn >
		                        <ItemStyle Width="75" />
		                        <HeaderTemplate>
		                            <asp:Label runat="server" ID="lblImage" Font-Bold="true" >Image</asp:Label>
		                        </HeaderTemplate>
			                    <ItemTemplate>
			                        <table cellSpacing="0" cellPadding="0" width="75" border="0" style="border-collapse:collapse;"   >
			                            <tr><td><asp:image id="imgDesign" runat="server"></asp:image></td></TR>
				                    </table>
			                    </ItemTemplate>
		                    </asp:TemplateColumn>
	                    </Columns>
                    </asp:datagrid></td></tr>
<!--------------------------------------------------------->	            	            
                <tr runat="server" id="rowSubMaterial" ><td><table  border="0"  
                        cellpadding="0" cellspacing="0" style="border-collapse:collapse;" >
                            <tr><td width="75px">&nbsp;</td>
                                <td ><asp:PlaceHolder ID="phComponent" runat ="server"  ></asp:PlaceHolder></td>
                            </tr></table>
                </td>
                </tr></table>
	        </ItemTemplate>
	    </asp:TemplateColumn>
	</Columns>
</asp:datagrid>
</td>
</tr>
</table>