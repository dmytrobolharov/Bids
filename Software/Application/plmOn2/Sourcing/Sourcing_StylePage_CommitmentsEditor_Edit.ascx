<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Sourcing_StylePage_CommitmentsEditor_Edit.ascx.vb" Inherits="plmOnApp.Sourcing_StylePage_CommitmentsEditor_Edit" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<table id="tSearch" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
	<tr>
		<td><asp:PlaceHolder ID="plhSearchControl" runat="server" EnableViewState="False"></asp:PlaceHolder></td>
        <td><asp:PlaceHolder ID="plhSearchControl2" runat="server" EnableViewState="False"></asp:PlaceHolder></td>
		<td width="100%" valign="top" style="padding-top: 13px;"><asp:imagebutton id="imgBtnSearch" runat="server" /></td>
	</tr>
    <tr><td colspan="3">&nbsp;</td></tr>
</table>
<table id="tBatchHeader" class="TableHeaderYellow" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr valign="middle">
        <td valign="middle" align="center" width="10">
            <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
        </td>
        <td width="100%">
            <asp:Label id="lblBatch" runat="server">&nbsp;</asp:Label>
        </td>
    </tr>
</table>
<asp:PlaceHolder ID="plhBatchControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
<table id="tSellAll" class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr valign="middle">
        <td valign="middle" align="center" width="10">
            <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
        </td>
        <td width="100%">
            <asp:checkbox runat="server" ID="chbSelectDgAll" />
            <asp:Label id="lblSelect" runat="server">&nbsp;</asp:Label>
        </td>
    </tr>
</table>
<div id="dtList" style="overflow-y: auto; overflow-x:hidden;">
<asp:DataList ID="DataList1" runat="server" DataKeyField="SourcingCommitmentItemID" Width="100%">
    <ItemTemplate>
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr style="height:20px; vertical-align:middle;">
                <td colspan="2">
                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td>
                                <asp:PlaceHolder ID="plhCommitmentDetailsForm" runat="server"></asp:PlaceHolder>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="background-color: White;">
                <td align="center" style="width:150px;">
                    <img src="<%# GetImageStreamPath("150",Eval("DesignSketchVersion").ToString,Eval("DesignSketchID").ToString)%>" style="padding:5px 5px 5px 5px;" /><br />
                    <cc1:BWImageButton ID="btnGoToStyle" runat="server" style="padding:5px 5px 5px 5px;" />
                </td>
                <td align="left" style="vertical-align:top; width:100%;">
        	        <asp:datagrid id="DataGrid1" runat="server" DataKeyField="SourcingCommitmentBOMDetailsID">
				        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				        <ItemStyle CssClass="ItemTemplate"></ItemStyle>
				        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				        <PagerStyle Visible="False"></PagerStyle>
				        <Columns>
				            <asp:TemplateColumn Visible="True">
				                <HeaderTemplate>
				                    <asp:CheckBox ID="chbSelectAll" AutoPostBack="False" runat="server"></asp:CheckBox>
				                </HeaderTemplate> 
				                <ItemTemplate>
				                    <asp:CheckBox ID="chbItem" name="chbItem" runat="server"></asp:CheckBox>				            
				                </ItemTemplate>
				            </asp:TemplateColumn>
				        </Columns> 						
			        </asp:datagrid>
                </td>
            </tr>
        </table>
    </ItemTemplate>

</asp:DataList>
</div>
<script type="text/javascript">
    $(":text[id^=ctrCommitsEdit_DataList1]").change(function () { $(this).css("color", "red"); });
    jQuery(document).ready(function ($) {
        $('#ctrCommitsEdit_lblQuantity').parent()[0].setAttribute('valign', 'top')
        $('#ctrCommitsEdit_lblCost').parent()[0].setAttribute('valign', 'top')
    $("#dtList").height($("#DimBOMEdit").height() - $("#tBatch").height() - $("#tBatchHeader").height() - $("#tSellAll").height() - $("#tSearch").height() - 10); });
</script>
