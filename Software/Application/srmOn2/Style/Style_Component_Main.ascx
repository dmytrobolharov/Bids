<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Main.ascx.vb" Inherits="srmOnApp.Style_Component_Main" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<style type="text/css"> .style1 { FONT-WEIGHT: bold; COLOR: #e60000 } </style>

<asp:panel id="Panel2" runat="server">
	<TABLE borderColor="gold" height="75" cellSpacing="0" cellPadding="0" width="100%" border="2">
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
								<TABLE cellSpacing="0" cellPadding="0" width="25" border="0">
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
			                                    <table cellSpacing="0" cellPadding="0" width="75" border="0" >
			                                    <tr><td><table cellSpacing="0" cellPadding="0" width="25" border="0">
					                                    <TR>
            					                        
					                                       <td>
							                                    <asp:Image id="imgExpSubCom" runat="server" ImageUrl="../System/Icons/icon_folderSelected.gif" ToolTip="..."/>
							                                    <asp:Image  id="imgExpColCom" ImageUrl="../System/Icons/icon_folderDown.gif" runat="server" />
						                                    </td>
					                                    </TR>
				                                    </table>
				                                    <table cellSpacing="0" cellPadding="0" width="25" border="0">
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
	<TABLE borderColor="gold" height="75" cellSpacing="0" cellPadding="0" width="800" bgColor="#ffff99"
		border="1">
		<TR>
			<TD>
				<TABLE id="TB_MainMaterial" cellSpacing="0" cellPadding="0" width="600" border="0">
					<TR>
						<TD width="10" height="50">&nbsp;</TD>
						<TD width="50" height="50" rowSpan="2"><IMG src="../System/Icons/icon_warning_32.gif"></TD>
						<TD class="fontHead" width="200"><SPAN class="style1"><asp:label id="lblWarn1" runat="server">Main Material Not Found...</asp:label></SPAN><BR>
							<asp:label id="lblWarns2" runat="server">Please add a main material.</asp:label></TD>
						<TD class="fontHead" height="50"></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</TABLE>
</asp:panel>
