<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_QA_Edit.ascx.vb"
    Inherits="plmOnApp.SampleRequest_Workflow_Submit_QA_Edit" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc1" TagName="SampleRequest_Workflow_Submit_Comment" Src="SampleRequest_Workflow_Submit_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<table cellspacing="1" cellpadding="1" width="100%" border="0">
    <tr>
        <td valign="top" width="1%" bgcolor="#ffffff">
            <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
            <asp:PlaceHolder ID="phlStatus" runat="server"></asp:PlaceHolder>
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
                    <td class="fontHead" width="1">
                        &nbsp;
                    </td>
                    <td class="fontHead" width="125">
                        <asp:Label ID="lblSampleSizeH" runat="server"></asp:Label>
                    </td>
                    <td class="fontHead">
                        <asp:DropDownList ID="ddlSampleSize" runat="server" AutoPostBack="True" CssClass="fontHead"
                            Height="29px">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" runat="server">
                <table id="Table1" cellspacing="1" cellpadding="1" border="0">
                    <tr>
                        <td valign="top">
                            <table height="26" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td valign="bottom">
                                        <cc2:YSTabView ID="YSTabView2" runat="server"></cc2:YSTabView>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="pnlSpecGrid" runat="server">
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
                                <table height="30" cellspacing="0" cellpadding="0" border="0">
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="cbTolerance" runat="server" ForeColor="Red" CssClass="fontHead">
                                            </asp:CheckBox>
                                        </td>
                                        <td>
                                            <cc1:BWImageButton ID="btnSpecCreate" runat="server" WindowName="POMTemplate" />
                                            <asp:HiddenField ID="HFSubmitForm" runat="server" Value="0" />
                                            <cc1:BWImageButton ID="btnPOMTemp" runat="server" WindowName="POMTemplate" />
                                            <cc1:BWImageButton ID="btnPomLibraryTop" runat="server" WindowName="POMLibrary" />
                                            <asp:ImageButton ID="btnComment" runat="server" Visible="false"></asp:ImageButton>
                                            <cc1:ConfirmedImageButton ID="btnSpecRemove" runat="server" Message="Are you sure you want to remove this spec?"></cc1:ConfirmedImageButton>
                                            <cc1:BWImageButton ID="btnPOMSort" runat="server" WindowName="POMLibrary" />
                                        </td>
                                    </tr>
                                </table>
                                <asp:DataGrid ID="DataGrid1" runat="server" AutoGenerateColumns="False" PageSize="200"
                                    BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
                                    <AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                    <Columns>
                                        <asp:TemplateColumn>
                                            <HeaderTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblLink" runat="server" CssClass="fontHead"><%#GetSystemText("L") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Image ID="imgLink" runat="server" ImageUrl="../System/Icons/icon_link.gif">
                                                </asp:Image>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblCritical" runat="server" CssClass="fontHead"><%#GetSystemText("C") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Image ID="imgCritical" runat="server" ImageUrl="../System/Icons/icon_warning.gif">
                                                </asp:Image>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblHowTo" runat="server" CssClass="fontHead"><%#GetSystemText("H") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <cc1:BWImageButton ID="imgBtnHowTo" runat="server" ImageUrl="../System/Icons/icon_howto.gif"
                                                    WindowName="POMLibrary"></cc1:BWImageButton>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblHeaderPOM" runat="server"><%#GetSystemText("POM") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <div align="center" nowrap>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:RequiredFieldValidator ID="rvPOM" runat="server" CssClass="fontHead" ToolTip="POM Code Required!"
                                                                    ControlToValidate="txtPOM" ErrorMessage='<%#GetSystemText("POM Code Required!") %>'>*</asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPOM" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                                    BorderWidth="1px" Columns="5" MaxLength="3"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderTemplate>
                                                <asp:Label ID="lblHeaderPointMeasur" runat="server"><%#GetSystemText("Point of Measurement")%></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtPointMeasur" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                                    BorderColor="#E0E0E0" Columns="40" MaxLength="100"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblHeaderTol" runat="server" ForeColor="Red"><%#GetSystemText("TOL")%></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtTOL" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                    BorderWidth="1px" Columns="7" MaxLength="7" ForeColor="#C00000"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblHeaderTolN" runat="server" ForeColor="Red"><%#GetSystemText("TOL")%></asp:Label>
                                                    <asp:Label ID="lblNoWash" runat="server" FONT Style="font-weight: normal; font-size: xx-small;
                                                        color: red; font-family: Arial"><%#GetSystemText("(NONWASH)") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtTOLN" runat="server" ForeColor="#C00000" BorderColor="#E0E0E0"
                                                    BorderStyle="Solid" BorderWidth="1px" MaxLength="7" Columns="7"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle Width="50px" CssClass="TableHeaderBlue"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblAsked" runat="server" Width="50"><%#GetSystemText("Asked") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtAsk" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                    BorderWidth="1px" ForeColor="RoyalBlue" MaxLength="7" Columns="7" />
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center" style='width: 50px;'>
                                                    <asp:Label ID="lblSpec0" runat="server" Width="50"><%#GetSystemText("Smp 1") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <div style="font-weight: bold; color: red">
                                                    <asp:TextBox ID="txtSpec0" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                        BorderWidth="1px" ForeColor="Black" MaxLength="7" Columns="7"></asp:TextBox></div>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center" style='width: 50px;'>
                                                    <asp:Label ID="lblSpec1" runat="server" Width="50"><%#GetSystemText("Smp 2") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpec1" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                    BorderWidth="1px" ForeColor="Black" MaxLength="7" Columns="7"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center" style='width: 50px;'>
                                                    <asp:Label ID="lblSpec2" runat="server" Width="50"><%#GetSystemText("Smp 3") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpec2" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                    BorderWidth="1px" ForeColor="Black" MaxLength="7" Columns="7"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center" style='width: 50px;'>
                                                    <asp:Label ID="lblSpec3" runat="server" Width="50"><%#GetSystemText("Smp 4") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpec3" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                    BorderWidth="1px" ForeColor="Black" MaxLength="7" Columns="7"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center" style='width: 50px;'>
                                                    <asp:Label ID="lblSpec4" runat="server" Width="50"><%#GetSystemText("Smp 5") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpec4" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                    BorderWidth="1px" ForeColor="Black" MaxLength="7" Columns="7"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center" style='width: 50px;'>
                                                    <asp:Label ID="lblSpec5" runat="server" Width="50"><%#GetSystemText("Smp 6") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpec5" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                    BorderWidth="1px" ForeColor="Black" MaxLength="7" Columns="7"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center" style='width: 50px;'>
                                                    <asp:Label ID="lblSpec6" runat="server" Width="50"><%#GetSystemText("Smp 7") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpec6" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                    BorderWidth="1px" ForeColor="Black" MaxLength="7" Columns="7"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center" style='width: 50px;'>
                                                    <asp:Label ID="lblSpec7" runat="server" Width="50"><%#GetSystemText("Smp 8") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpec7" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                    BorderWidth="1px" ForeColor="Black" MaxLength="7" Columns="7"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center" style='width: 50px;'>
                                                    <asp:Label ID="lblSpec8" runat="server" Width="50"><%#GetSystemText("Smp 9") %></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpec8" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                    BorderWidth="1px" ForeColor="Black" MaxLength="7" Columns="7"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderStyle Width="50px" CssClass="TableHeader"></HeaderStyle>
                                            <HeaderTemplate>
                                                <div align="center" style='width: 50px;'>
                                                    <asp:Label ID="lblSpec9" runat="server" Width="50"><%#GetSystemText("Smp 10")%></asp:Label></div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtSpec9" runat="Server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                                    BorderWidth="1px" ForeColor="Black" MaxLength="7" Columns="7"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr class="fontHead">
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td nowrap width="85">
                                            <asp:Label runat="server" ID="lblRows" CssClass="fontHead">
                                                <asp:Label ID="lblNumOfRows" runat="server"></asp:Label></asp:Label>
                                        </td>
                                        <td width="35">
                                            <asp:DropDownList ID="dpNewRow" runat="server" CssClass="fontHead">
                                                <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem>
                                                <asp:ListItem Value="3">3</asp:ListItem>
                                                <asp:ListItem Value="4">4</asp:ListItem>
                                                <asp:ListItem Value="5">5</asp:ListItem>
                                                <asp:ListItem Value="10">10</asp:ListItem>
                                                <asp:ListItem Value="15">15</asp:ListItem>
                                                <asp:ListItem Value="20">20</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <cc1:ConfirmedImageButton ID="imgBtnAdd" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                                            <cc1:BWImageButton ID="btnPomCritical" runat="server" WindowName="POMLibrary"></cc1:BWImageButton>
                                            <cc1:BWImageButton ID="btnPOMLinked" runat="server" WindowName="POMLibrary"></cc1:BWImageButton>
                                            <cc1:BWImageButton ID="btnPOMDelete" runat="server" WindowName="POMLibrary"></cc1:BWImageButton>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Image ID="imgDesign" runat="server" BorderColor="Transparent"></asp:Image>
                            <table id="TB_FitImage" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                                <tr>
                                    <td>
                                        <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr class="TableHeader">
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                </td>
                                                <td class="fontHead">
                                                    <cc1:BWImageButton ID="btnAttachMultipleFile" runat="server" Message="NONE" CausesValidation="False" />
                                                    <cc1:ConfirmedImageButton ID="btnDeleteImage" runat="server" >
                                                    </cc1:ConfirmedImageButton>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:DataGrid ID="dgFitImage" runat="server" AutoGenerateColumns="False" PageSize="100"
                                            BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver" Width="100%">
                                            <AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                            <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                                            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                            <Columns>
                                                <asp:TemplateColumn>
                                                    <HeaderTemplate>
                                                        <asp:Image ID="Image1" runat="server" ImageUrl="../System/Icons/icon_delete.gif">
                                                        </asp:Image>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cbSpecImageDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>'>
                                                        </asp:CheckBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn>
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblImageHeader" runat="server"><%#GetSystemText("Image")%></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <cc1:BWImageButton ID="imgSpec" runat="server"></cc1:BWImageButton>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn>
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblImageHeader" runat="server"><%#GetSystemText("Description")%></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblImageDescription" runat="server" Text='<%# string.Concat( Convert.ToString(DataBinder.Eval(Container.DataItem,"ImageDescription" )))  %>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn >
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lblImageHeader" runat="server"><%#GetSystemText("Modified By")%></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblModifiedBy" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <asp:DataList ID="dlHowToMeasure" runat="server" BorderWidth="1px" BorderStyle="Solid"
                    BorderColor="WhiteSmoke" BackColor="White">
                    <HeaderTemplate>
                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr class="TableHeader">
                                <td class="fonthead" width="75">
                                    <asp:Label ID="lblCode" runat="server"><%#GetSystemText("Code")%></asp:Label>
                                </td>
                                <td class="fonthead" width="200">
                                   <asp:Label ID="lblPointofMeasure" runat="server"><%#GetSystemText("Point of Measure")%></asp:Label> 
                                </td>
                                <td class="fonthead" width="200">
                                    <asp:Label ID="lblHowToMeasure" runat="server"><%#GetSystemText("How To Measure")%></asp:Label> 
                                </td>
                                <td class="fonthead" width="200">
                                  <asp:Label ID="lblHowToImage" runat="server"><%#GetSystemText("How To Image")%></asp:Label>  
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                    <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
                    <FooterTemplate>
                    </FooterTemplate>
                    <ItemStyle BackColor="White"></ItemStyle>
                    <ItemTemplate>
                        <table width="100%">
                            <tr>
                                <td class="font" width="75">
                                    <%#Container.DataItem("POM")%>
                                </td>
                                <td class="font" width="200">
                                    <%#Container.DataItem("PointMeasur")%>
                                </td>
                                <td class="font" width="200">
                                    <%#Container.DataItem("HowTomeasurText")%>
                                </td>
                                <td class="font" width="200">
                                    <cc1:BWImageButton ID="imgHowTo" runat="server"></cc1:BWImageButton>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
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
                                    <cc1:ConfirmedImageButton ID="btnUploadFile" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                                    <cc1:ConfirmedImageButton ID="btnDeleteFitPhotos" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                                    <cc1:BWImageButton ID="btnMarkup" runat="server" Message="NONE" ToolTip="Markup..."></cc1:BWImageButton>
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
                            <AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                            <ItemStyle CssClass="ItemTemplate"></ItemStyle>
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
                            <asp:ImageButton ID="btnComment1" runat="server">
                            </asp:ImageButton>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#ffffff">
                            <br>
                            <asp:Label ID="txt_FitComment" runat="server" CssClass="font"></asp:Label><br>
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
<table height="24" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
    <tr valign="middle">
        <td valign="middle" align="center" width="7">
            <img src="../System/Images/table_bar_left.gif">
        </td>
        <td class="TableBar" valign="middle" align="center" width="20">
            <img src="../System/icons/icon_changeobject.gif">
        </td>
        <td class="TableBar">
            <asp:Label ID="lblCreatedBy" runat="server" ForeColor="Gray" CssClass="fontHead"></asp:Label>&nbsp;/
            <asp:Label ID="lblModifiedBy" runat="server" CssClass="fontHead"></asp:Label>
        </td>
        <td valign="middle" align="center" width="7">
            <img src="../System/Images/table_bar_right.gif">
        </td>
    </tr>
</table>
