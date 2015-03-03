<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlanLinkedItemCarry.aspx.vb" Inherits="plmOnApp.LinePlanLinkedItemCarry" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>

            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr>
		            <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td> 
		            <td ><cc1:confirmedimagebutton 
		                id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><asp:ImageButton 
		                id="btnClose"  runat ="server" OnClientClick="return btnClose_Click()"  /></td>
	            </tr>
            </table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td><br />&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Styles Linked</asp:Label><br /></td>
				</tr>
			</table>
            
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr valign="top">
		            <td>
			            <table  class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <tr valign="middle">
					            <td><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>				
				            </tr>
			            </table>
            			
			            <table width="100%" >
			            <tr>
			                <td>
                                <asp:datagrid id="DataGrid1" runat="server"  DataKeyField="StyleID">
                                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                                    </AlternatingItemStyle>
                                    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                                    <headerStyle Height="25px" CssClass="tableheader"></headerStyle>
                                    <PagerStyle Visible="False"></PagerStyle>
                                    <Columns>
                                        <asp:TemplateColumn>
                                            <HeaderTemplate>
                                                <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkSelected" />
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:datagrid>
                                <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			                    <input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>
			                </td>
			            </tr>
			            </table>
            			
		            </td>
	            </tr>
            </table>
            
                
    </div>
    </form>

		<script language="javascript" type="text/javascript"  >
		var frm = document.form1 ;
		function SelectAll(checkAllBox) {
		    var actVar = checkAllBox.checked ;
		    for(i=0;i< frm.length;i++) {
			    e=frm.elements[i];
			    if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
			        e.checked= actVar ;
		    }
		}
		</script>    
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
