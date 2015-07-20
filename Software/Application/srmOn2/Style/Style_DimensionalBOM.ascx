<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_DimensionalBOM.ascx.vb" Inherits="srmOnApp.Style_DimensionalBOM2" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>


<table cellspacing="0" cellpadding="0" width="100%" border="0" >
<tr><td>


<asp:datagrid id="dgComponentType" runat="server" Width="100%" AutoGenerateColumns="false" ShowHeader="false" >

	<HeaderStyle CssClass="TableHeaderOver"></HeaderStyle>
	<Columns>
	    <asp:TemplateColumn>
	        <ItemTemplate>
	            <table runat="server" id="tbGrid" cellspacing="0" cellpadding="0"  border="0"  width="100%" >
	            <tr> <td >
                    <asp:datagrid id="DataGrid1" runat="server" Width="100%">
	                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	                    <HeaderStyle Height="25px" CssClass="TableHeaderOver"></HeaderStyle>
	                    
	                    <Columns>
		                    <asp:TemplateColumn >
		                        <ItemStyle Width="50" />
		                        <HeaderStyle CssClass="TableHeaderOver" />
		                        <HeaderTemplate>
		                        <table><tr><td>&nbsp;</td></tr></table>
		                        </HeaderTemplate>
			                    <ItemTemplate>
			                        <table cellspacing="0" cellpadding="0" width="50" border="0" >
			                        <tr><td><table cellspacing="0" cellpadding="0" width="50" border="0">
			                        		<tr>
					                           <td>
							                        <asp:Image id="imgExpSubCom" runat="server" ImageUrl="../System/Icons/icon_folderSelected.gif" ToolTip="..."/>
							                        <asp:Image  id="imgExpColCom" ImageUrl="../System/Icons/icon_folderDown.gif" runat="server" />
							                        </TD>
						                        <td>
							                        <cc1:BWImageButton id="ImgMMaterial" runat="server" ImageUrl="../System/Icons/icon_folderFiles.gif" ToolTip='<%#GetsystemText("Multi-Material")%>' 
							                         MenuBar="False"  Status="False" ToolBar="False" Location="False"></cc1:BWImageButton>
						                        </TD>																		
						                        <TD>
							                        <asp:Image id="ImgConflict" runat="server" ImageUrl="../System/Icons/icon_conflict.gif" Visible='<%# DisplayMaterialVersion(DataBinder.Eval(Container.DataItem,"StyleMaterialID").tostring) %>' ToolTip='<%#GetsystemText("New Version Available")%>'>
							                        </asp:Image></TD>
						                        <TD>
							                        <asp:Image id="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" Visible='<%# DisplayLinkedVisible(Container.DataItem("MaterialLinked")) %>' ToolTip='<%#GetsystemText("Material Linked")%>'>
							                        </asp:Image></TD>
						                        <TD>
							                        <asp:Image id="ImgArtwork" runat="server" ImageUrl="../System/Icons/icon_image.gif" Visible='<%# DisplayArtworkVisible(Container.DataItem("Artwork")) %>' ToolTip='<%#GetsystemText("Artwork Material")%>'>
							                        </asp:Image></TD>
						                        <TD>
							                        <asp:Image id="ImgComment" runat="server" ImageUrl="../System/Icons/icon_comment.gif" ToolTip='<%#GetsystemText("Material Comments")%>'></asp:Image></TD>							
						                        																		
					                        </TR>
				                        </table>
				                        <table cellspacing="0" cellpadding="0" width="50" border="0">
					                        <tr>
					                        <td style="width:17px">&nbsp;</td>
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






