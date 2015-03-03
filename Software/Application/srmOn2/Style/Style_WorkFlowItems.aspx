<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_WorkFlowItems.aspx.vb" Inherits="srmOnApp.Style_WorkFlowItems" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title>Work Flow Items</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" method="post" runat="server">
    <table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
	    <tr valign="middle">
		    <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		    <td valign="middle" align="left" width="706" >
            <cc1:confirmedimagebutton id="btnEdit" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
		    <cc1:confirmedimagebutton id="btnNewWorkflowItem" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
		    <cc1:confirmedimagebutton id="btnPageCopy" OnClientClick="return NoPostBack()" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
		    <cc1:confirmedimagebutton id="btnPageLink" OnClientClick="return NoLinkPostBack()" visible="false" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
		    <cc1:confirmedimagebutton id="btnImageRemove" runat="server"  />
		    <cc1:bwimagebutton id="btnImageSort" runat="server" ></cc1:bwimagebutton>
		    <cc1:confirmedimagebutton id="btnBreakLink" visible="false" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
		    </td>
		</tr>
	</table>
		<%--<br />--%>
		<uc1:Style_Workflow_Edit ID="Style_Workflow1" runat="server"></uc1:Style_Workflow_Edit>
		<uc2:style_header id="Style_Header1" runat="server">
		</uc2:style_header>
        <br />
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td>
                &nbsp;
                </td>
                <td>
                    <asp:datagrid id="DataGrid1" runat="server" AllowSorting="False" DataKeyField="WorkFlowItemID">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" Wrap="false" CssClass="ItemTemplate"></ItemStyle>
                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                        <Columns>
                            <asp:TemplateColumn HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                <HeaderTemplate >
                                    <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                                </HeaderTemplate> 
                                <ItemStyle Width="20px" CssClass="SelectCheckBox" />
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkSelected" />
                                </ItemTemplate>                                
                                                       
                            </asp:TemplateColumn>               
                            <asp:TemplateColumn >
                            <HeaderTemplate >
                                <asp:Label runat="server" ID="lblAction" Text="Action" />
                            </HeaderTemplate>                            
                            <ItemStyle Width="75" />
                            <ItemTemplate>

                                <table cellspacing="0" cellpadding="0" width="75" border="0" >
                                    <tr>
                                        <td>
                                            <table cellspacing="0" cellpadding="0" width="25" border="0">
                                                <tr>
                                                    <td>
                                                    
<%--                                                        <cc1:confirmedimagebutton id="btnView" runat="server" OnCommand="ViewItemPage"  Message="NONE" Visible="true" />
                                                    </td>
                                                    <td>&nbsp;&nbsp;</td>
                                                    <td>
						                                <cc1:confirmedimagebutton id="btnEdit" runat="server" OnCommand="EditItemPage"  Message="NONE" Visible="true" />--%>
						                                <asp:DropDownList ID="dpAction"  OnSelectedIndexChanged="DoAction" runat="server" CssClass="font" DataTextField="Value" DataValueField="ID"  AutoPostBack="true" />
						                            </td>	                                                    
                                                    
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>                  

                            </ItemTemplate>
                        </asp:TemplateColumn>     
                    </Columns>
                    </asp:datagrid>   
                </td>
            </tr>
        </table>
        <br />
    	<table height="24" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr valign="middle">
				<td valign="middle" align="center" width="7"><img src="../System/Images/table_bar_left.gif" /></td>
				<td class="TableBar" valign="middle" align="center" width="20"><img src="../System/icons/icon_changeobject.gif"></td>
				<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				<td valign="middle" align="center" width="7"><img src="../System/Images/table_bar_right.gif" /></td>
			</tr>
		</table>		
	
		
    </form>
    <script type="text/javascript" language="javascript">
        var frm = document.forms['form1'];
	    function SelectAll(checkAllBox) {
	        var actVar = checkAllBox.checked;
	        for (i = 0; i < frm.length; i++) {
	            e = frm.elements[i];
	            if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
	                e.checked = actVar;
	        }
	    }

	    
	    
	</script>   
</body>
</html>
