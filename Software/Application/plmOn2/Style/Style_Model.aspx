<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Model.aspx.vb" Inherits="plmOnApp.Style.Model.Style_Model" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Style - Model</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true" />
    <script type="text/javascript">
        // fix for ie6, other browsers don't allow selecting disabled options
        var selected = {};
        function saveSelectedIndex(sel) {
            selected[sel.id] = sel.selectedIndex;
        }

        function checkForPost(sel1, sel2, hdn) {
            var $ = function(el) {
                    return document.getElementById(el);
                },
                sel1 = $(sel1), sel2 = $(sel2);

            // fix for ie6, other browsers doesn't allow selecting disabled options
            if (sel1.options[sel1.selectedIndex].disabled) {
                sel1.selectedIndex = selected[sel1.id];
                return false;
            }

            if (sel2.options[sel2.selectedIndex].disabled) {
                sel2.selectedIndex = selected[sel2.id];
                return false;
            }

            if (sel1.selectedIndex != 0 && sel2.selectedIndex != 0) {                
                $(hdn).value = "1";
                $("btnSaveMaterial2Fabric").click();
            }

            selected[sel1.id] = sel1.selectedIndex;
            selected[sel2.id] = sel2.selectedIndex;

            return false;
        }

        function checkAll(checkAllBox) {
            var frm = document.form1,
                actVar = checkAllBox.checked, e;
                
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chbUnlink") != -1) {                    
                    if (e.disabled == false) {
                        e.checked = actVar;
                    }
                }
            }
        }
    </script>
    <!-- Toolbar -->
    
    <uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow><asp:panel id="pnlChange" runat="server">
		</asp:panel><uc2:style_header id=Style_Header1 runat="server">
		</uc2:style_header>
				<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
				<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
			</tr>
		</table><br />
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:bwimagebutton ID="btnCreateModel" runat="server" Message="NONE" ></cc1:bwimagebutton>          	
                <cc1:bwimagebutton ID="btnAdd1" runat="server" Message="NONE"></cc1:bwimagebutton>
                <cc1:bwimagebutton ID="btnRemove" runat="server" Message="NONE"></cc1:bwimagebutton>
                <cc1:bwimagebutton ID="btnAddBF" runat="server" Message="NONE"></cc1:bwimagebutton>&nbsp;&nbsp;&nbsp;
                <asp:CheckBox valign="top" align="center" ID="chbImperial" autopostback="true"  runat="server" Text="Imperial" CssClass="fontHead" />
                <asp:Image id="ImgWFLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" Visible="false"/>
                <asp:Image id="ImgWFParent" runat="server" ImageUrl="../System/Icons/icon_parent_link.gif" Visible="false"/>
            </td>
        </tr>
    </table>
    <br />    
	
  <asp:datagrid id="DataGrid1" runat="server" DataKeyField="ID" AllowSorting="True"
	   AutoGenerateColumns="False">
		<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate" Wrap="True"></AlternatingItemStyle>
		<ItemStyle Height="20px" CssClass="ItemTemplate" Wrap="True"></ItemStyle>
		<headerStyle Height="25px" CssClass="TableHeaderRed" Wrap="True"></headerStyle>
		<PagerStyle Visible="False" Wrap="True"></PagerStyle>		
            <Columns>
		         <asp:TemplateColumn >
                   <ItemStyle Wrap="True" Height="20px" Width="50px" CssClass="ItemTemplate" BorderWidth="1pt" BorderColor="Gainsboro" BorderStyle="Solid"></ItemStyle>
                    <HeaderStyle Wrap="True" CssClass="TableHeader" BorderColor="Gainsboro"  />
                    <HeaderTemplate>
                        <DIV align="center">
									<asp:Label id="lblLink" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></DIV>
					</HeaderTemplate>
                    <ItemTemplate>                 
                        <asp:Image id="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" Visible='<%# DisplayLinkedVisible(Container.DataItem("IsLinked")) %>' ToolTip='<%#GetSystemText("Linked")%>'/>
                    </ItemTemplate>
                 </asp:TemplateColumn>
                 <asp:TemplateColumn >
                   <ItemStyle Wrap="True" Height="20px" Width="50px" CssClass="ItemTemplate" BorderWidth="1pt" BorderColor="Gainsboro" BorderStyle="Solid"></ItemStyle>
                    <HeaderStyle Wrap="True" CssClass="TableHeader" BorderColor="Gainsboro"  />
                    <HeaderTemplate>
                      <DIV align="center">
									<asp:Label id="lblLinkBF" runat="server" CssClass="fontHead"><%#GetSystemText("LBF")%></asp:Label></DIV>
					 </HeaderTemplate>
                    <ItemTemplate>
                     <asp:Image id="ImgLinkedBF" runat="server" ImageUrl="../System/Icons/icon_folderLinked.gif" Visible='<%# DisplayBF(Container.DataItem("IsLinkedBF")) %>' ToolTip='<%#GetSystemText("Linked to Body Folder")%>'/>
                 
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>  
       		
   </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
     
    <br />
    <br />

        
        <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
	        <tr class="TableHeader">
		        <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
		        <td width="20">		    
		            <asp:ImageButton runat="server" ID="imgToggleFabric" />
		        </td>
		        <td class="fontHead">&nbsp;
			    <asp:label id="lblMatAssoc" runat="server"></asp:label></td>
	        </tr>
        </table>
        <asp:Panel runat="server" ID="pnlFabricType">            
            <asp:DataGrid ID="dgMaterialFabricType" runat="server" AutoGenerateColumns="false" DataKeyField="CADModel2BOMId">
                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	            <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderStyle BorderWidth="1pt" BorderColor="Gainsboro" />
                        <HeaderTemplate>
                            <asp:CheckBox ID="chbUnlinkAll" onclick="checkAll(this)" runat="server" />
                        </HeaderTemplate>
                        <ItemStyle CssClass="SelectCheckbox" BorderWidth="1pt" BorderColor="Gainsboro" />
                        <ItemTemplate>
                            <asp:CheckBox ID="chbUnlink" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:BoundColumn DataField="ModelName" HeaderText="Model Name" 
                        ItemStyle-Width="100px" ItemStyle-BorderWidth="1px" ItemStyle-BorderColor="Gainsboro" ItemStyle-BorderStyle="solid"></asp:BoundColumn>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <%#GetSystemText("Fabric Type")%>
                        </HeaderTemplate>
                        <ItemStyle BorderWidth="1px" BorderColor="Gainsboro" BorderStyle="Solid" />
                        <ItemTemplate>
                            <asp:DropDownList ID="selFabricType" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="hdnFabricType" runat="server" />
                            <asp:HiddenField ID="hdnModelName" runat="server" Value='<%# Container.DataItem("ModelName") %>' />
                            <asp:HiddenField ID="hdnIsChanged" runat="server" Value="0" />
                        </ItemTemplate>                    
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <%#GetSystemText("Material Code")%>
                        </HeaderTemplate>
                        <ItemStyle BorderWidth="1px" BorderColor="Gainsboro" BorderStyle="Solid" />
                        <ItemTemplate>
                            <asp:DropDownList ID="selMaterial" runat="server"></asp:DropDownList>
                            <asp:HiddenField ID="hdnMaterial" runat="server" />
                            <asp:HiddenField ID="hdnMaterialName" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>            
            <cc1:ConfirmedImageButton ID="btnUnlinkMF" Message="NONE" runat="server" />
            <asp:Button ID="btnSaveMaterial2Fabric" runat="server" style="display:none;" Text="Save" />            
        </asp:Panel>
         <table height="24" cellspacing="0" cellpadding="0" width="100%" border="0">
		    <tr valign="middle">
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif" /></td>
				<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
				<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif" /></td>
			</tr>
        </table>
    </form>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" language="javascript">
        function jsWorkWhereUsed(StyleWorkflowID, StyleID, ShowParent) {

            PageMethods.WorkflowWhereUsed(StyleWorkflowID, StyleID, ShowParent, function (strHTML) {

                var $confirmDialog = $("<div></div>");
                $confirmDialog.html(strHTML);
                $confirmDialog.dialog({
                    autoOpen: false,
                    modal: true,
                    resizable: false,
                    title: '<%= GetSystemText("Page Where Used") %>',
                    buttons: { '<%= GetSystemText("Close") %>': function () { $(this).dialog("close"); } }
                });

                $confirmDialog.dialog('open');
            }, function () { console.log(arguments) });
        }	    
	</script>       
</body>
</html>
