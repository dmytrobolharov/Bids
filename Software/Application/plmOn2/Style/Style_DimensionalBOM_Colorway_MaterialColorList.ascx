<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOM_Colorway_MaterialColorList.ascx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOM_Colorway_MaterialColorList" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<asp:DataList runat="server" ID="dtlColors" DataKeyField="ColorPaletteID" RepeatLayout="Table" RepeatDirection="Horizontal" RepeatColumns="7"
    CssClass="material-colors">
    <ItemStyle BorderWidth="0" BorderStyle="None" />
    <ItemTemplate>
        <asp:Image runat="server" ID="imgColor" ImageUrl='<%# GetColorStreamPath("20", Eval("ColorFolderId").ToString, Eval("ColorPaletteID").ToString) %>' />
        <div runat="server" id="ColorDetails" class="color-details">
            <table cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td>
                        <asp:Image runat="server" ID="Image1" ImageUrl='<%# GetColorStreamPath("40", Eval("ColorFolderId").ToString, Eval("ColorPaletteID").ToString) %>'/>
                    </td>
                    <td valign="top">
                        <asp:Label runat="server" ID="lblColorCode" Text='<%# Eval("ColorCode") %>' Width="100"></asp:Label><br />
                        <asp:Label runat="server" ID="lblColorName" Text='<%# Eval("ColorName") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" valign="top">
                        <asp:DataList runat="server" ID="dtlStyleColorways" RepeatLayout="Table" RepeatDirection="Vertical" DataKeyField="DtlID" Width="100%" ShowHeader="true">
                            <HeaderTemplate>
                                <input type="checkbox" id="chbSelectAllColorways" onclick="checkAllColorways(this);" />
                                <label for="chbSelectAllColorways"><%# GetSystemText("Select All") %></label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chbColorway" runat="server" Text='<%# Eval("DimName") %>' Width="100%"/>
                            </ItemTemplate>
                        </asp:DataList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:HiddenField ID="hdnMaterialColorID" runat="server" Value='<%# Eval("MaterialColorID") %>' />
                        <asp:HiddenField id="hdnColorFolderID" runat="server" Value='<%# Eval("ColorFolderID") %>' />
                        <asp:HiddenField ID="hdnColorCode" runat="server" Value='<%# Eval("ColorCode") %>' />
                        <asp:HiddenField ID="hdnColorName" runat="server" Value='<%# Eval("ColorName") %>' />
                        <cc1:ConfirmedImageButton runat="server" ID="btnApplyColors" Message="NONE" CommandName="ApplyColorways" CommandArgument='<%# Eval("ColorPaletteID") %>'
                            ImageUrl='<%# GetImagePath("btn_apply_colorways.gif", Me.UserProperties.PrefLang) %>'/>
                    </td>
                </tr>
            </table>
        </div>
    </ItemTemplate>
</asp:DataList>