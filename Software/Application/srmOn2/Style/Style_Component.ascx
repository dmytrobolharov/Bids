<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Component.ascx.vb" Inherits="srmOnApp.Style_Component2" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<table cellSpacing="0" cellPadding="0" width="100%" border="0" >
<tr><td>


<asp:datagrid id="dgComponentType" runat="server" Width="100%" AutoGenerateColumns="false" ShowHeader="false" >

	<HeaderStyle CssClass="TableHeaderOver"></HeaderStyle>
	<Columns>
	    <asp:TemplateColumn>
	        <ItemTemplate>
	            <table runat="server" id="tbGrid" cellspacing="0" cellpadding="0"  border="0"  width="100%" >
	            <tr> <td >
                    <asp:datagrid id="DataGrid1" runat="server" Width="100%">
	                    <AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	                    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
	                    <HeaderStyle Height="25px" CssClass="TableHeaderOver"></HeaderStyle>
	                    
	                    <Columns>
		                    <asp:TemplateColumn >
		                        <ItemStyle Width="75" />
		                        <HeaderStyle CssClass="TableHeaderOver" />
		                        <HeaderTemplate>
		                        <table><tr><td>&nbsp;</td></tr></table>
		                        </HeaderTemplate>
			                    <ItemTemplate>
			                        <table cellSpacing="0" cellPadding="0" width="75" border="0" >
			                        <tr><td><table cellSpacing="0" cellPadding="0" width="75" border="0">
			                        		<tr>
					                           <td>
							                        <asp:Image id="imgExpSubCom" runat="server" ImageUrl="../System/Icons/icon_folderSelected.gif" ToolTip="..."/>
							                        <asp:Image id="imgExpColCom" ImageUrl="../System/Icons/icon_folderDown.gif" runat="server" />
						                        </td>
					                        </tr>
				                        </table>
				                        <table cellSpacing="0" cellPadding="0" width="50" border="0">
					                        <tr>
					                        <td style="width=17px">&nbsp;</td>
						                     <td align="center">
							                        <cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton></td>
					                        </TR>
				                        </table>
			                        </td></tr>
			                        </table>
			                    </ItemTemplate>
		                    </asp:TemplateColumn>
	                    </Columns>
                    </asp:datagrid>

	            
<!--------------------------------------------------------->	            
	            </td></tr>
	            
                <tr runat="server" id="rowSubMaterial" ><td>
                    
                    <div runat="server" id="divSubMaterials"  >
                        <table  border="0"  cellpadding="0" cellspacing="0" ><tr><td width="25px">&nbsp;</td><td ><asp:PlaceHolder ID="phComponent" runat ="server" ></asp:PlaceHolder></td></tr></table>
                    </div>
                 </td></tr></table>
	        </ItemTemplate>
	    </asp:TemplateColumn>
	</Columns>
</asp:datagrid>
</td>
</tr>
</table>






