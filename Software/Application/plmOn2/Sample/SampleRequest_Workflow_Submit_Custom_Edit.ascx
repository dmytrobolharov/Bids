<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Custom_Edit.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Custom_Edit" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="SampleRequest_Workflow_Submit_Comment" Src="SampleRequest_Workflow_Submit_Comment.ascx" %>

<table cellspacing="1" cellpadding="1" width="100%" border="0">
    <tr>
        <td valign="top" bgcolor="#ffffff">
            <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
            
            <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	            <tr class="TableHeader">
		            <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td width="20"><asp:imagebutton 
		            id="imgStatusCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton><asp:imagebutton 
		            id="imgStatusExpand" visible="false"  runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton></td>
		            <td class="fontHead"><asp:Label ID="lblSubmitStatusH" runat="server"></asp:Label></td>
	            </tr>
            </table>
            <asp:panel id="pnlStatus" runat="server">
	            <cc1:confirmedimagebutton id="btnDelete"  runat="server"></cc1:confirmedimagebutton>
	            <asp:PlaceHolder runat="server" ID="phlStatus" ></asp:PlaceHolder>    
            </asp:panel>
            
            
            <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr class="TableHeader">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="20">
                        <asp:ImageButton ID="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif">
                        </asp:ImageButton><asp:ImageButton ID="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif">
                        </asp:ImageButton>
                    </td>
                    <td class="fontHead">
                        <asp:Label ID="lblHeaderSpec" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <table height="26" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                    <td valign="bottom">
                        <cc2:YSTabView ID="YSTabView2" runat="server"></cc2:YSTabView>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" runat="server">
                <script language="javascript" type="text/javascript">
                    function checkSubmit() {
                        if (document.getElementById("<%=HFSubmitForm.ClientID %>").value == 1)
                            return false;
                        else {
                            document.getElementById("<%=HFSubmitForm.ClientID %>").value = 1;
                            return true;
                        }
                    }
                </script>
                <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr class="TableHeader">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td class="fontHead">
                           <cc1:BWImageButton 
                                id="btnVendor" runat="server" Visible="false"/><cc1:BWImageButton 
                                id="btnTemplateAdd" runat="server" /><cc1:confirmedimagebutton 
                                id="btnRemoveVendor" runat="server" Visible="false"/><cc1:BWImageButton 
                                id="btnTemplateDelete" runat="server" />
                            <asp:HiddenField ID="HFSubmitForm" runat="server" Value="0" />
                        </td>
                    </tr>
                </table>
                <br />
                
                <cc2:YSTabView ID="YSTabLab" runat="server"></cc2:YSTabView>
                <br />
                <asp:PlaceHolder runat="server" ID="phlGroupInfo" ></asp:PlaceHolder>    
                <br />
                <table cellspacing="1" cellpadding="1" border="0">
					<tr class="TableHeader">
                        <td>
                            <table>
                                <tr>
						            <td width="10" style="height: 24px">&nbsp;</td>
						            <td noWrap width="85" style="height: 24px"><asp:Label id="lblNoofRows" CssClass="fontHead" runat="server">No. of Row(s):</asp:Label></td>
						            <td width="35" style="height: 24px"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
								            <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
								            <asp:ListItem Value="2">2</asp:ListItem>
								            <asp:ListItem Value="3">3</asp:ListItem>
								            <asp:ListItem Value="4">4</asp:ListItem>
								            <asp:ListItem Value="5">5</asp:ListItem>
								            <asp:ListItem Value="10">10</asp:ListItem>
								            <asp:ListItem Value="15">15</asp:ListItem>
								            <asp:ListItem Value="20">20</asp:ListItem>
							            </asp:dropdownlist>
                                    </td>
						            <td style="height: 24px">
                                        <cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                                    </td>
                                </tr>
                            </table>
                        </td>
					</tr>						
                    <tr>
                        <td valign="top" width="375" bgcolor="#ffffff">
                        
                                <asp:datagrid id="dgCustom" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
	                                PageSize="10000" AutoGenerateColumns="false" Width="375px" DataKeyField="SampleRequestMaterialID">
                                    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                                    <ItemStyle Height="20px" CssClass="font" VerticalAlign="Top" BackColor="White"></ItemStyle>
                                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                </asp:datagrid>

                        </td>
                    </tr>
                </table>
                
            </asp:Panel>
            
            <asp:Panel ID="Panel2" runat="server">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr class="TableHeader">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td>
                            <asp:ImageButton ID="btnComment1" runat="server" >
                            </asp:ImageButton>
                            <asp:CheckBox ID="cbAutoComment" runat="server" CssClass="fontHead" ForeColor="DarkRed"
                                AutoPostBack="True" Visible="False"></asp:CheckBox>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="Panel3" runat="server">
                <table id="TB_FitImage" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                    <tr>
                        <td>
                            <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr class="TableHeader">
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                    </td>
                                    <td class="fontHead">
                                       <%-- <cc1:ConfirmedImageButton ID="btnNewImage" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_add.gif"
                                            Message="NONE"></cc1:ConfirmedImageButton>--%>
                                        <cc1:ConfirmedImageButton ID="btnAttachMultipleFile" runat="server" Message="NONE" CausesValidation="False">
                                        </cc1:ConfirmedImageButton>
                                        <cc1:ConfirmedImageButton ID="btnDeleteImage" runat="server" >
                                        </cc1:ConfirmedImageButton>
                                    </td>
                                </tr>
                            </table>
                            <asp:datagrid id="dgFitImage" runat="server" AutoGenerateColumns="False" PageSize="100" BorderWidth="1px"
								BorderStyle="Solid" BorderColor="Silver" Width="100%" DataKeyField="SampleRequestSubmitImageID">
								<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
								<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
								<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn>
                                        <ItemStyle Width="25" HorizontalAlign="Center" />
                                        <HeaderStyle Width="25" HorizontalAlign="Center" />
										<HeaderTemplate>
											<asp:Image id="Image1" runat="server" ImageUrl="../System/Icons/icon_delete.gif" Width="20"></asp:Image>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:CheckBox id="cbSpecImageDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>' Width="20"></asp:CheckBox>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnlAttachFiles" runat="server">
                <table id="tbl_AttachFiles" cellspacing="0" cellpadding="0" width="100%" border="0"
                    runat="server">
                    <tr>
                        <td>
                            <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr class="TableHeader">
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                    </td>
                                    <td class="fontHead">
                                        <cc1:ConfirmedImageButton ID="btnAttachFiles" runat="server" Message="NONE" CausesValidation="False">
                                        </cc1:ConfirmedImageButton>
                                    </td>
                                </tr>
                            </table>
                            <asp:DataList ID="DataList1" runat="server" Width="100%" OnDeleteCommand="DataList_DeleteCommand"
                                OnCancelCommand="DataList_CancelCommand" OnUpdateCommand="DataList_UpdateCommand"
                                OnEditCommand="DataList_EditCommand" DataKeyField="SampleRequestSubmitImageID"
                                BackColor="White" BorderColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1px">
                                <HeaderTemplate>
                                    <tr>
                                        <td class="fontHead" width="27" height="20">
                                            &nbsp;
                                        </td>
                                        <td class="fontHead" width="200">
                                            <asp:Label ID="lblFName" runat="server"><%#GetSystemText("File Name")%></asp:Label>
                                        </td>
                                        <td class="font" width="10">
                                            &nbsp;
                                        </td>
                                        <td class="fontHead" width="200">
                                            <asp:Label ID="lblFDesc" runat="server"><%#GetSystemText("File Description")%></asp:Label>
                                        </td>
                                        <td class="font" width="10">
                                            &nbsp;
                                        </td>
                                        <td class="fontHead" width="100">
                                            <asp:Label ID="lblFSize" runat="server"><%#GetSystemText("File Size")%></asp:Label>
                                        </td>
                                        <td class="fontHead" width="100">
                                            <asp:Label ID="lblFCreatedBy" runat="server"><%#GetSystemText("File Created By")%></asp:Label>
                                        </td>
                                        <td class="fontHead">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </HeaderTemplate>
                                <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
                                <FooterTemplate>
                                </FooterTemplate>
                                <ItemStyle BackColor="White"></ItemStyle>
                                <ItemTemplate>
                                    <tr>
                                        <td width="20" height="20">
                                            <asp:LinkButton ID="Linkbutton1" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'
                                                CommandName="edit"></asp:LinkButton>
                                        </td>
                                        <td class="font" width="200">
                                            <%#Container.DataItem("ImageFile")%>
                                        </td>
                                        <td class="font" width="10">
                                            &nbsp;
                                        </td>
                                        <td class="font" width="200">
                                            <asp:Label ID="lblDocumentDesc" runat="server">
								                <%#Container.DataItem("ImageDescription")%>
                                            </asp:Label>
                                        </td>
                                        <td class="font" width="10">
                                            &nbsp;
                                        </td>
                                        <td class="font" width="100">
                                            <%#Container.DataItem("ImageSize")%>
                                        </td>
                                        <td class="font" width="100">
                                            <%#Container.DataItem("CUser")%>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <tr>
                                        <td colspan="7">
                                            <br>
                                            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                <tr>
                                                    <td valign="middle" align="center" width="10">
                                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                    </td>
                                                    <td width="500">
                                                        <cc1:ConfirmedImageButton ID="edit_btnSave" runat="server" Message="NONE" CommandName="update">
                                                        </cc1:ConfirmedImageButton>
                                                        <cc1:ConfirmedLinkButton ID="edit_btnDelete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this file?")%>'
                                                            CommandName="delete" NAME="edit_btnDelete">
                                                        </cc1:ConfirmedLinkButton>
                                                        <asp:LinkButton ID="Linkbutton5" runat="Server" CommandName="download"></asp:LinkButton>
                                                        <cc1:ConfirmedImageButton ID="btnEditCancel" runat="server" Message="NONE" CommandName="cancel">
                                                        </cc1:ConfirmedImageButton>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                            <table cellspacing="1" cellpadding="1" width="100%" bgcolor="whitesmoke" border="0">
                                                <tr>
                                                    <td valign="top" width="400">
                                                        <table cellspacing="0" cellpadding="0" width="400" border="0">
                                                            <tr>
                                                                <td style="height: 22px" width="10">
                                                                    &nbsp;
                                                                </td>
                                                                <td class="fontHead" width="100">
                                                                    <asp:Label ID="lblFlName" runat="server"><%#GetSystemText("File Name")%>:</asp:Label>
                                                                </td>
                                                                <td class="font">
                                                                    <asp:Label ID="lblFileName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageFile").ToString  %>'>
                                                                    </asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="10">
                                                                    &nbsp;
                                                                </td>
                                                                <td class="fontHead" valign="top" width="100">
                                                                    <br>
                                                                    <asp:Label ID="lblFlDesc" runat="server"><%#GetSystemText("File Description")%>:</asp:Label>:
                                                                </td>
                                                                <td class="font">
                                                                    <asp:TextBox ID="txtFileDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageDescription").ToString  %>'
                                                                        Width="250" Columns="50" Wrap="false" ToolTip="Enter file description here..."
                                                                        TextMode="MultiLine" Rows="5">
                                                                    </asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td valign="top">
                                                        <table cellspacing="0" cellpadding="0" width="400" border="0">
                                                            <tr>
                                                                <td width="10">
                                                                    &nbsp;
                                                                </td>
                                                                <td class="fontHead" valign="top" width="100">
                                                                    <asp:Label ID="LblFlUp" runat="server"><%#GetSystemText("Upload File")%>:</asp:Label>
                                                                </td>
                                                                <td class="font">
                                                                    <input class="font" id="txtImagePath" type="file" runat="server">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="10">
                                                                    &nbsp;
                                                                </td>
                                                                <td class="fontHead" valign="top" width="100">
                                                                    <asp:Label ID="LblFlSize" runat="server"><%#GetSystemText("File Size")%>:</asp:Label>:
                                                                </td>
                                                                <td class="font">
                                                                    <asp:Label ID="lblFileSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageSize").ToString  %>'>
                                                                    </asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table cellspacing="0" cellpadding="0" width="100%" bgcolor="whitesmoke" border="0">
                                                <tr>
                                                    <td width="20">
                                                        &nbsp;
                                                    </td>
                                                    <td class="font" width="100">
                                                        <asp:Label ID="lblCreatedBy" runat="server"><%#GetSystemText("Created By")%></asp:Label>:
                                                    </td>
                                                    <td class="font">
                                                        <asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; Container.DataItem("CDate").ToString %>'>
                                                        </asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="20" bgcolor="whitesmoke">
                                                        &nbsp;
                                                    </td>
                                                    <td class="font" width="100">
                                                        <asp:Label ID="lblModifiedBy" runat="server"><%#GetSystemText("Modified By")%></asp:Label>:
                                                    </td>
                                                    <td class="font">
                                                        <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; Container.DataItem("MDate").ToString %>'>
                                                        </asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br>
                                        </td>
                                    </tr>
                                </EditItemTemplate>
                            </asp:DataList>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table id="TB_FitPhotos" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                <tr>
                    <td>
                        <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr class="TableHeader">
                                <td valign="middle" align="center" width="10">
                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                </td>
                                <td class="fontHead">
                                    <cc1:confirmedimagebutton id="btnSaveSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                                    <cc1:ConfirmedImageButton ID="btnUploadFile" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_upload.gif&PL=EN-US" Message="NONE"></cc1:ConfirmedImageButton>
                                    <cc1:ConfirmedImageButton ID="btnDeleteFitPhotos" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                                    <cc1:BWImageButton ID="btnMarkup" runat="server" Message="NONE" ToolTip="Markup..."></cc1:BWImageButton>
                                    <cc1:BWImageButton ID="btnSelectImage" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td class="fontHead" width="100">
                                    <asp:Label ID="lblUpload" runat="server"></asp:Label>:
                                </td>
                                <td>
                                    <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <asp:DataGrid ID="dgFitPhotos" runat="server" AutoGenerateColumns="False" PageSize="100"
                                      BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver" Width="100%" DataKeyField="FitPhotoId">
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
        <td valign="top" width="400" bgcolor="#ffffff">
            <cc2:YSTabView ID="Ystabview3" runat="server"></cc2:YSTabView>
            <asp:Panel ID="pnlComment" runat="server">
                <uc1:SampleRequest_Workflow_Submit_Comment ID="SampleRequest_Workflow_Submit_Comment1"
                    runat="server"></uc1:SampleRequest_Workflow_Submit_Comment>
            </asp:Panel>
            <asp:Panel ID="pnlFitComment" runat="server">
                <table id="TB_FitComment" cellspacing="0" cellpadding="0" width="400" border="0"
                    runat="server">
                    <tr class="TableHeader">
                        <td>
                            &nbsp;
                            <asp:ImageButton ID="btnComment" runat="server">
                            </asp:ImageButton>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#ffffff">
                            <br>
                            <asp:Label ID="txt_Comment" runat="server" CssClass="font"></asp:Label><br>
                            <br>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
        <td valign="top" width="98%" bgcolor="#ffffff">
        </td>
    </tr>
</table>
<table id="Table1" height="24" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
    <tr valign="middle">
        <td valign="middle" align="center" width="7">
            <img src="../System/Images/table_bar_left.gif">
        </td>
        <td class="TableBar" valign="middle" align="center" width="20">
            <img src="../System/icons/icon_changeobject.gif">
        </td>
        <td class="TableBar">
            <asp:Label ID="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:Label>&nbsp;/
            <asp:Label ID="lblModifiedBy" runat="server" CssClass="fontHead"></asp:Label>
        </td>
        <td valign="middle" align="center" width="7">
            <img src="../System/Images/table_bar_right.gif">
        </td>
    </tr>
</table>
<input type="hidden" runat="server"  id ="hd_UserName" />
<input type="hidden" runat="server"  id ="hd_UserDate" />
