<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Material_Edit.ascx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_Material_Edit" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="SampleRequest_Workflow_Submit_Comment" Src="SampleRequest_Workflow_Submit_Comment.ascx" %>
<table borderColor="blue" cellSpacing="0" cellPadding="0" border="0">
	<tr>
		<td vAlign="top"><cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:placeholder id="phlStatus" runat="server"></asp:placeholder>
		
		
    		<TABLE height="26" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="bottom"><cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview></TD>
				</TR>
			</TABLE>

            <asp:Panel ID="pnlMaterial" runat="server" >
			    <TABLE height="25" cellSpacing="0" cellPadding="0" width="600" border="0">
				    <TR class="TableHeader">
					    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					    <TD width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></TD>
					    <TD class="fontHead"><asp:label id="lblHeaderSpec" runat="server"></asp:label></TD>
				    </TR>
			    </TABLE>
			    <asp:panel id="Panel1" runat="server" ForeColor="White">
				    <TABLE id="Table1" cellSpacing="1" cellPadding="1" width="600" border="0">
					    <TR>
						    <TD vAlign="top" width="100%" bgColor="#ffffff">
							    <TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
								    <TR class="TableHeader">
									    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									   
								    </TR>
							    </TABLE>
							    <asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
								    PageSize="100" AutoGenerateColumns="False"
								    Width="100%">
								    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
								    <ItemStyle Height="20px" CssClass="font" VerticalAlign="Top" BackColor="White"></ItemStyle>
								    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
								    <Columns>
									    <asp:TemplateColumn>
										    <HeaderTemplate>
										    </HeaderTemplate>
										    <ItemTemplate>
											    <cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton>
										    </ItemTemplate>
									    </asp:TemplateColumn>
									    <%--<asp:TemplateColumn>
										    <HeaderStyle Width="200px" CssClass="TableHeader"></HeaderStyle>
										    <HeaderTemplate>
											    <div align="left">
												    <asp:Label id="lblHeaderMaterial" runat="server"><%#GetSystemText("Material")%></asp:Label>
											    </div>
										    </HeaderTemplate>
										    <ItemTemplate>
											    <div align="left">
												    <asp:Label id="txtMaterial" runat="server"><%#GetSystemText("Material")%></asp:Label>
											    </div>
										    </ItemTemplate>
									    </asp:TemplateColumn>
									    <asp:TemplateColumn>
										    <HeaderStyle CssClass="TableHeader"></HeaderStyle>
										    <HeaderTemplate>
											    <asp:Label id="lblHeaderEndDate" runat="server"><%#GetSystemText("Status")%></asp:Label>
										    </HeaderTemplate>
										    <ItemTemplate>
											    <asp:Label id="clblStatus" runat="server"></asp:Label>
										    </ItemTemplate>
									    </asp:TemplateColumn>--%>
								    </Columns>
							    </asp:datagrid></TD>
					    </TR>
				    </TABLE>
			    </asp:panel>
			    <br/>
			</asp:Panel>
			<asp:Panel ID="pnlImages" runat="server">
                <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr class="TableHeader">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td class="fontHead">
                            <cc1:ConfirmedImageButton ID="btnAttachMultipleFile" runat="server" Message="NONE" CausesValidation="False">
                            </cc1:ConfirmedImageButton>
                            <cc1:ConfirmedImageButton ID="btnDeleteImage" runat="server"></cc1:ConfirmedImageButton>
                        </td>
                    </tr>
                </table>
                <asp:DataGrid ID="dgFitImage" runat="server" AutoGenerateColumns="False" PageSize="100" BorderWidth="1px"
                    BorderStyle="Solid" BorderColor="Silver" Width="100%" DataKeyField="SampleRequestSubmitImageID">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl="../System/Icons/icon_delete.gif"></asp:Image>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="cbSpecImageDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>'>
                                </asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
			
			</asp:Panel>
			<asp:Panel ID="pnlSourcingTab" runat="server"  >
						
			    <TABLE height="25" cellSpacing="0" cellPadding="0" width="600" border="0" id="tbSourcing">
			        <TR  class="TableHeader" >
				        <TD vAlign="middle" align="center" width="10" ><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				        <TD width="20"><asp:imagebutton id="imbBtnExpand2" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse2" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></TD>
				        <TD class="fontHead"><asp:label id="lblHeaderSourcing" runat="server">Sourcing</asp:label></TD>
			        </TR>
		        </TABLE>
    			    
			    <asp:Panel ID="pnlSourcing" runat="server">
			        <asp:datagrid id="dgSourcing" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
					    PageSize="100" AutoGenerateColumns="False" Width="100%" DataKeyField="SampleRequestMaterialID">
					    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					    <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					    <HeaderStyle Height="20" CssClass="TableHeader"></HeaderStyle>
					    <Columns>
					        <asp:TemplateColumn>
						        <HeaderTemplate>
						        </HeaderTemplate>
						        <ItemTemplate>
							        <cc1:BWImageButton id="imgSourcing" runat="server"></cc1:BWImageButton>
						        </ItemTemplate>
					        </asp:TemplateColumn>
        					
                            <asp:TemplateColumn>
						        <HeaderStyle Width="200px" CssClass="TableHeader"></HeaderStyle>
						        <HeaderTemplate>
							        <div align="left">
								        <asp:Label id="lblHeaderMaterial" runat="server"><%#GetSystemText("Material")%></asp:Label>
							        </div>
						        </HeaderTemplate>
						        <ItemTemplate>
							        <div align="left">
								        <asp:Label id="lblMaterial" runat="server"><%#GetSystemText("Material")%></asp:Label>
							        </div>
						        </ItemTemplate>
					        </asp:TemplateColumn>
        					
					        <asp:TemplateColumn>
						        <HeaderStyle CssClass="TableHeader"></HeaderStyle>
						        <HeaderTemplate>
							        <asp:Label id="lblHeaderSource" runat="server"><%#GetSystemText("Source")%></asp:Label>
						        </HeaderTemplate>
						        <ItemTemplate>
							        <asp:DropDownList ID="ddlVendors" runat="server"  Width="250"></asp:DropDownList>
						        </ItemTemplate>
					        </asp:TemplateColumn>
    																		
					    </Columns>
				    </asp:datagrid>
    			
			    </asp:Panel>
			    <br/><br/>
			 </asp:Panel>
			 <table id="TB_FitPhotos" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                    <tr>
                        <td>
                            <table id="TB_UpDelPhoto" height="25" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                                <tr class="TableHeader">
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                    </td>
                                    <td class="fontHead">
                                        <cc1:confirmedimagebutton id="btnSaveSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                                        <cc1:ConfirmedImageButton ID="btnUploadFile" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_upload.gif&PL=EN-US" Message="NONE"></cc1:ConfirmedImageButton>
                                        <cc1:ConfirmedImageButton ID="btnDeleteFitPhotos" runat="server" Message="Are you sure you want to remove this photo?"></cc1:ConfirmedImageButton>
                                    </td>
                                </tr>
                            </table>
                            <table id="TB_UpldPhoto" runat="server">
                                <tr>
                                    <td class="fontHead" width="100">
                                        <asp:Label ID="lblUpload" runat="server"></asp:Label>:
                                    </td>
                                    <td>
                                        <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <asp:DataGrid ID="dgFitPhotos" runat="server" AutoGenerateColumns="False" PageSize="100" BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver" Width="100%" DataKeyField="FitPhotoId">
                                 <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                 <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                 <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                 <Columns>
                                     <asp:TemplateColumn>
                                         <HeaderTemplate>
                                             <asp:Image ID="Image2" runat="server" ImageUrl="../System/Icons/icon_delete.gif">
                                             </asp:Image>
                                         </HeaderTemplate>
                                         <ItemTemplate>
                                             <asp:CheckBox ID="cbFitPhotosDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>'>
                                             </asp:CheckBox>
                                         </ItemTemplate>
                                      </asp:TemplateColumn>
                                </Columns>
                            </asp:DataGrid>
                        </td>
                    </tr>
                </table>
			</td>
		<td vAlign="top"><cc2:ystabview id="Ystabview3" runat="server"></cc2:ystabview><asp:panel id="pnlComment" runat="server">
				<uc1:SampleRequest_Workflow_Submit_Comment id="SampleRequest_Workflow_Submit_Comment2" runat="server"></uc1:SampleRequest_Workflow_Submit_Comment>
			</asp:panel><asp:panel id="pnlFitComment" runat="server">
				<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="400" border="0" runat="server">
					<TR>
						<TD bgColor="#ffffff"><BR>
							<asp:Label id="txt_FitComment" runat="server" CssClass="font"></asp:Label><BR>
							<BR>
						</TD>
					</TR>
				</TABLE>
			</asp:panel></td>
	</tr>
</table>
