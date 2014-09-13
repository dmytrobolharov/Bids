<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOMMaterial_QuickSearchAdd.ascx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOMMaterial_QuickSearchAdd" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc2" %>

<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr class="TableHeader">
		<td valign="middle" align="center" width="10px"><img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20px">
		    <img id="imgBtnExp" runat="server" onclick="return ShowHideMQEGrid(this, true)" style="cursor:pointer;" src="../System/Icons/icon_Next.gif" alt="" />
		    <img id="imgBtnCol" runat="server" onclick="return ShowHideMQEGrid(this, false)" style="cursor:pointer; display:none;" src="../System/Icons/icon_Down.gif" alt="" />
		</td>
		<td class="fontHead">
			<asp:label id="lblMaterialQuickSearchAdd" runat="server"></asp:label>
		</td>
	</tr>
</table>

<div id="divMaterialQuickSearchAdd" style="display:none;">
    <table cellspacing="0" cellpadding="1" rules="all" border="1" id="dgMaterialtbl"
        style="background-color: White; border-color: Gainsboro; border-width: 1px; border-style: Solid;
        border-collapse: collapse;">
        <tr class="font" valign="top" style="height: 20px;">
            <td style="border-color: Gainsboro; border-width: 1px; border-style: Solid;">
                <asp:label ID="lblMQECode" Text="Material Code"  class="fontHead" runat="server" ></asp:label>
                <asp:TextBox ID="txtMQECode" Width="120px" runat="server" ></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnMaterialQuickSearchAddSave" runat="server" Message="NONE" /> 
            </td>                                                                                       
            <td>
                <cc2:AutoCompleteExtender BehaviorID="AutoCompleteEx" ID="txtMQE_AutoCompleteExtender" runat="server"
                    DelimiterCharacters="" Enabled="True" ServiceMethod="GetCompletionList" ServicePath=""
                    TargetControlID="txtMQECode" UseContextKey="True" MinimumPrefixLength="1"
                    CompletionInterval="10" EnableCaching="true" CompletionSetCount="12" FirstRowSelected="true"
                    CompletionListCssClass="AutoComplete_List" 
                    CompletionListItemCssClass="AutoComplete_ComplitionList" 
                    CompletionListHighlightedItemCssClass="AutoComplete_HighlightedItem"
                    onclientitemselected="OnMaterialSelected"    
                    OnClientShown="OnClientShown" >           
                </cc2:AutoCompleteExtender>                                
                <asp:hiddenfield id="hdnMQEValue" runat="server"/>                
            </td>                        
        </tr>
    </table>
    <asp:DataGrid ID="dgMaterialQuickSearchAdd" runat="server" AutoGenerateColumns="false" DataKeyField="StyleMaterialID">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>        
    </asp:DataGrid>        
</div>

<script type="text/javascript">
    function OnClientShown(sender, eventArgs) {
        sender._popupBehavior._element.style.top = document.Form1.Style_MQE_txtMQECode.style.top;
   }

   function OnMaterialSelected(source, eventArgs) {
       if (document.getElementById('Style_MQE_hdnMQEValue') != null) {
           document.getElementById('Style_MQE_hdnMQEValue').value = eventArgs.get_value();
           __doPostBack('Style_MQE_hdnMQEValue', "");
        }
    }

    function CheckMaterialQEDelete(obj) {
        var frm = document.Form1;
        var actVar = obj.checked;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];
            if (e.type == 'checkbox' && e.name.indexOf("Style_MQE") != -1) {
                if (e.name.indexOf("chbMaterialDEL") != -1) {
                    e.checked = actVar;
                }
            }
        }
    }

</script>