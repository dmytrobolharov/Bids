<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Material_Template_Remove.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Material_Template_Remove" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>

        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td> 
            <td ><cc1:confirmedimagebutton 
                id="btnRemove" runat="server" Message="NONE"></cc1:confirmedimagebutton><asp:ImageButton 
                id="btnClose"  runat ="server" />
            </td>

        </tr>
        </table>

        <table width="100%" >
        <tr>
            <td>
                <cc1:ScrollingGrid ID="sgGrid" runat="server" Width="800" ScrollBars="Auto" Height="600">
                    <asp:datagrid id="DataGrid1" runat="server" >
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                        </AlternatingItemStyle>
                        <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                        <headerStyle Height="25px" CssClass="tableheader"></headerStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                        <Columns>
                            <asp:TemplateColumn>
                                <HeaderTemplate>
                                    <input type="checkbox" onclick="SelectAll(this)" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkDelete" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:datagrid>
                </cc1:ScrollingGrid>
                <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
            </td>
        </tr>
        </table>        
    
    </div>
    </form>
    
		<script language="javascript" type="text/javascript"  >
		    var frm = document.form1;
		
		    function SelectAll(checkAllBox) {
		        var actVar = checkAllBox.checked ;
		        for(i=0;i< frm.length;i++) {
			        e=frm.elements[i];
			        if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
			            e.checked= actVar ;
		        }
		    }
		</script>
		    
</body>
</html>
