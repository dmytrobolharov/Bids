<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Custom_Edit.ascx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_Custom_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="SampleRequest_Workflow_Submit_Comment" Src="SampleRequest_Workflow_Submit_Comment.ascx" %>


<table borderColor="blue" cellSpacing="0" cellPadding="0" border="0">
	<tr>
		<td vAlign="top"><cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:placeholder id="phlStatus" runat="server"></asp:placeholder>
		
		
    		<table height="26" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="bottom"><cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview></TD>
				</TR>
			</table>

            <asp:Panel ID="pnlMaterial" runat="server" >
			    <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				    <TR class="TableHeader">
					    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					    <TD width="20"><asp:imagebutton 
					        id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton 
					        id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></TD>
					    <TD class="fontHead"><asp:label id="lblHeaderSpec" runat="server"></asp:label></TD>
				    </TR>
			    </table>
			    <asp:panel id="Panel1" runat="server" ForeColor="White">
				    <table id="Table1" cellSpacing="1" cellPadding="1" width="600" border="0">
					    <TR>
						    <TD vAlign="top" width="100%" bgColor="#ffffff">
							    <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
								    <TR class="TableHeader">
									    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									     </TR>
							    </table>
							    
                                <cc2:YSTabView ID="YSTabLab" runat="server"></cc2:YSTabView>
                                <br />
                                <asp:PlaceHolder runat="server" ID="phlGroupInfo" ></asp:PlaceHolder>    
                                <br />

							    <asp:datagrid id="dgCustom" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
								    PageSize="100" Width="100%"  AutoGenerateColumns="false">
								    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
								    <ItemStyle Height="20px" CssClass="font" VerticalAlign="Top" BackColor="White"></ItemStyle>
								    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							    </asp:datagrid></TD>
					    </TR>
				    </table>
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
    		<td vAlign="top"><cc2:ystabview id="Ystabview3" runat="server"></cc2:ystabview>
    		<asp:panel id="pnlComment" runat="server">
			    <uc1:SampleRequest_Workflow_Submit_Comment id="SampleRequest_Workflow_Submit_Comment2" runat="server"></uc1:SampleRequest_Workflow_Submit_Comment>
			</asp:panel>
			<asp:panel id="pnlFitComment" runat="server">
				<table id="Table2" cellSpacing="0" cellPadding="0" width="400" border="0" runat="server">
					<TR>
						<TD bgColor="#ffffff"><BR>
							<asp:Label id="txt_FitComment" runat="server" CssClass="font"></asp:Label><br />
							<br />
						</TD>
					</TR>
				</table>
			</asp:panel></td>
	</tr>
</table>
