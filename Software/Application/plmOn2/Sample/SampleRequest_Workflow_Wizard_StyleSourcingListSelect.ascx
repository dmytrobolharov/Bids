<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Wizard_StyleSourcingListSelect.ascx.vb"
    Inherits="plmOnApp.SampleRequest_Workflow_Wizard_StyleSourcingListSelect" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<p></p>
<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
    border="0" runat="server">
    <tr valign="middle">
        <td valign="middle" align="center" width="10">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
        </td>
        <td>
            <asp:ImageButton ID="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif">
            </asp:ImageButton><cc1:ConfirmedImageButton ID="imgBtnClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
        </td>
    </tr>
</table>
<table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
    <tr>
        <td>
            &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                Font-Names="Tahoma,Verdana"></asp:Label>
        </td>
    </tr>
</table>
<table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
    <tr>
        <td>
            <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
        </td>
        <td valign="top" width="100%">
            <table id="Table3" height="45">
                <tr>
                    <td>
                        <asp:ImageButton ID="imgBtnSearch" runat="server">
                        </asp:ImageButton>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table id="Table1" cellspacing="1" cellpadding="0" width="100%" border="0">
    <tr>
        <td valign="top">
            <table class="ToolbarShort" id="Table2" height="25" cellspacing="0" cellpadding="0"
                width="100%" border="0">
                <tr class="fontHead">
                    <td align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td>
                        <div align="left">
                            &nbsp;
                            <asp:Label ID="lblCurrentIndex" Visible="False" runat="server" Text="0"></asp:Label><asp:Label
                                ID="lblPageSize" Visible="False" runat="server" Text="24"></asp:Label></div>
                    </td>
                    <td width="20">
                        <div align="center">
                            <asp:ImageButton ID="btnFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"
                                Height="16"></asp:ImageButton></div>
                    </td>
                    <td width="20">
                        <div align="center">
                            <asp:ImageButton ID="btnPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"
                                Height="16"></asp:ImageButton></div>
                    </td>
                    <td width="125">
                        <div align="center">
                            <asp:Label ID="lblCounts" runat="server" CssClass="plaintable"></asp:Label></div>
                    </td>
                    <td width="20">
                        <div align="center">
                            <asp:ImageButton ID="btnNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"
                                Height="16"></asp:ImageButton></div>
                    </td>
                    <td width="20">
                        <div align="center">
                            <asp:ImageButton runat="server" ImageUrl="../System/Icons/icon_last.gif" Height="16"
                                ID="btnLast"></asp:ImageButton></div>
                    </td>
                    <td>
                        <div align="left">
                            <b>
                                <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;<asp:Label
                                    ID="lblRecordsFoundText" runat="server"></asp:Label>
                            </b>
                        </div>
                    </td>
                </tr>
            </table>
            <asp:DataList ID="DataList1" runat="server" Width="100%" OnItemDataBound="DataList1_ItemDataBound"
                EnableViewState="True" RepeatDirection="Horizontal" OnItemCommand="DataList1_ItemCommand"
                RepeatColumns="6" DataKeyField="StyleID">
                <ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
                    VerticalAlign="Top" BackColor="White"></ItemStyle>
                <ItemTemplate>
                    <table bordercolor="silver" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                        border="0">
                        <tr>
                            <td>
                                <cc1:ConfirmedImageButton ID="imgBtnEditImage" runat="server" Message="NONE" CommandName="Edit" ToolTip="Select Style..."></cc1:ConfirmedImageButton>&nbsp;
                                <input type="hidden" runat="server" id="hdnSYID" />
                                <input type="hidden" runat="server" id="hdnVariation" value='<%# Eval("VariationId") %>'  />
                            </td>
                        </tr>
                        <!--
						<TR>
							<TD>
								<asp:Label id="txtTechPack" runat="server"></asp:Label></TD>
						</TR>
						-->
                        <tr>
                            <td valign="top" width="200" bgcolor="#ffffff" height="150">
                                <img alt="" id="ImgWorkFlowStyleSourcing" runat="server"  />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <br />
                    <asp:PlaceHolder ID="plhStyleItem" runat="server"></asp:PlaceHolder>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            </asp:DataList>
        </td>
    </tr>
</table>
