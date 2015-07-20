<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Main.ascx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Main" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<style type="text/css">.style1 {
	FONT-WEIGHT: bold; COLOR: #e60000
}
</style>

<asp:panel id="Panel2" runat="server">
	<TABLE borderColor="gold" height="75" cellspacing="0" cellPadding="0" width="100%" border="2">
		<TR>
			<TD>
				<asp:datagrid id="dgMainMaterial" runat="server" Width="100%">
					<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
					<ItemStyle CssClass="ItemTemplate"></ItemStyle>
					<HeaderStyle Height="25px" Width="25px" CssClass="TableHeaderOver"></HeaderStyle>
					<Columns>
						<asp:TemplateColumn>
						    <ItemStyle Width="75" />
							<HeaderStyle Width="75"></HeaderStyle>
							<ItemTemplate>
								<TABLE cellspacing="0" cellPadding="0" width="25" border="0">
									<TR>
										<TD>
											<asp:Image id=ImgConflict runat="server" ImageUrl="../System/Icons/icon_conflict.gif" Visible='<%# DisplayMaterialVersion(DataBinder.Eval(Container.DataItem,"StyleMaterialID").tostring) %>' ToolTip='<%#GetSystemText("New Version Available") & "..." %>'>
											</asp:Image></TD>
										<TD>
											<asp:Image id="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" Visible='<%# DisplayLinkedVisible(Container.DataItem("MaterialLinked")) %>' ToolTip='<%#GetSystemText("Material Linked") & "..." %>'>
											</asp:Image></TD>
										<TD>
											<asp:Image id=ImgArtwork runat="server" ImageUrl="../System/Icons/icon_image.gif" Visible='<%# DisplayArtworkVisible(Container.DataItem("Artwork")) %>' ToolTip='<%#GetSystemText("Artwork Material") & "..." %>'>
											</asp:Image></TD>
											
										<TD>
											<asp:Image id="ImgComment" runat="server" ImageUrl="../System/Icons/icon_comment.gif" ToolTip='<%#GetSystemText("Material Comments") & "..." %>'></asp:Image></TD>
										<TD><cc1:BWImageButton id="ImgMMaterial" runat="server" ImageUrl="../System/Icons/icon_folder_group.gif" ToolTip='<%#GetSystemText("Multi-Material") & "..." %>' 
							                MenuBar="False"  Status="False" ToolBar="False" Location="False"></cc1:BWImageButton></TD>											
											
											
									</TR>
								</TABLE>
								<TABLE cellspacing="0" cellPadding="0" width="25" border="0">
									<TR>
										<td>
											<cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton></td>
									</TR>
								</TABLE>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:datagrid>
				
<!-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->				

                <asp:datagrid id="dgComponentType" runat="server" Width="100%" AutoGenerateColumns="false" ShowHeader="false">
	            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	            <ItemStyle CssClass="ItemTemplate"></ItemStyle>
	            <HeaderStyle Height="25px" CssClass="TableHeaderOver"></HeaderStyle>
	            <Columns>
	                <asp:TemplateColumn HeaderStyle-Width="75">
	                    <ItemTemplate>
	                        <table runat="server" id="tbGrid" cellspacing="0" cellpadding="0"  border="0"   width="100%">
	                        <tr><td >
            	            
                                 <!--------------------------------------------------------->
                                <asp:datagrid id="DataGrid1" runat="server" Width="100%">
	                                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	                                <ItemStyle CssClass="ItemTemplate"></ItemStyle>
	                                <HeaderStyle Height="25px" CssClass="TableHeaderOver"></HeaderStyle>
	                                <Columns>
		                                <asp:TemplateColumn >
		                                    <ItemStyle Width="75" />
			                                <ItemTemplate>
			                                    <table cellspacing="0" cellPadding="0" width="75" border="0" >
			                                    <tr><td><table cellspacing="0" cellPadding="0" width="25" border="0">
					                                    <TR>
            					                        
					                                       <td>
							                                    <asp:Image id="imgExpSubCom" runat="server" ImageUrl="../System/Icons/icon_folderSelected.gif" ToolTip="..."/>
							                                    <asp:Image  id="imgExpColCom" ImageUrl="../System/Icons/icon_folderDown.gif" runat="server" />
							                                    </TD>
						                                    <td>
							                                    <cc1:BWImageButton id="ImgMMaterial" runat="server" ImageUrl="../System/Icons/icon_folderFiles.gif" ToolTip='<%#Getsystemtext("Multi-Material") & "..." %>' 
							                                     MenuBar="False"  Status="False" ToolBar="False" Location="False"></cc1:BWImageButton>
						                                    </TD>																		
            						                        					                        
						                                    <TD>
							                                    <asp:Image id=ImgConflict runat="server" ImageUrl="../System/Icons/icon_conflict.gif" Visible='<%# DisplayMaterialVersion(DataBinder.Eval(Container.DataItem,"StyleMaterialID").tostring) %>' ToolTip='<%#GetSystemText("New Version Available") & "..." %>'>
							                                    </asp:Image></TD>
						                                    <TD>
							                                    <asp:Image id="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" Visible='<%# DisplayLinkedVisible(Container.DataItem("MaterialLinked")) %>' ToolTip='<%#GetSystemText("Material Linked") & "..." %>'>
							                                    </asp:Image></TD>
						                                    <TD>
							                                    <asp:Image id=ImgArtwork runat="server" ImageUrl="../System/Icons/icon_image.gif" Visible='<%# DisplayArtworkVisible(Container.DataItem("Artwork")) %>' ToolTip='<%#GetSystemText("Artwork Material") & "..." %>'>
							                                    </asp:Image></TD>
						                                    <TD>
							                                    <asp:Image id="ImgComment" runat="server" ImageUrl="../System/Icons/icon_comment.gif" ToolTip='<%#GetSystemText("Material Comments") & "..." %>'></asp:Image></TD>							
					                                    </TR>
				                                    </table>
				                                    <table cellspacing="0" cellPadding="0" width="25" border="0">
					                                    <TR>
						                                    <td>
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
                                    <table  border="0"  cellpadding="0" cellspacing="0" ><tr><td width="75px">&nbsp;&nbsp;</td><td ><asp:PlaceHolder ID="phComponent" runat ="server" ></asp:PlaceHolder></td></tr></table>
                                </div>
                             </td></tr></table>
	                    </ItemTemplate>
	                </asp:TemplateColumn>
	            </Columns>
            </asp:datagrid>

<!-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->				

			</TD>
		</TR>
	</TABLE>
</asp:panel><asp:panel id="Panel1" runat="server">
	<TABLE borderColor="gold" height="75" cellspacing="0" cellPadding="0" width="800" bgColor="#ffff99"
		border="1">
		<TR>
			<TD>
				<TABLE id="TB_MainMaterial" cellspacing="0" cellPadding="0" width="600" border="0">
					<TR>
						<TD width="10" height="50">&nbsp;</TD>
						<TD width="50" height="50" rowSpan="2"><IMG src="../System/Icons/icon_warning_32.gif"></TD>
						<TD class="fontHead" width="200"><SPAN class="style1"><asp:label id="lblMainMaterial" runat="server">Main Material Not Found...</asp:label></SPAN><BR>
							<asp:label id="lblAddMaterial" runat="server">Please add a main material.</asp:label></TD>												
						<TD class="fontHead" height="50"></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</TABLE>
</asp:panel>
