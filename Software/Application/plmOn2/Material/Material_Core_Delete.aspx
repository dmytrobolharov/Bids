<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_Core_Delete.aspx.vb" Inherits="plmOnApp.Material_Core_Delete" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

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

	    <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <tr valign="middle">
			    <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><cc1:confirmedimagebutton id="btnDelete" runat="server"  ></cc1:confirmedimagebutton>
				    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
					    ></cc1:confirmedimagebutton></td>
		    </tr>
	    </table>

			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0" height="35" bgcolor="#ffffff">
				<TR>
					<TD>
						<asp:CheckBox id="cbDeleteAll" runat="server" CssClass="fontRed" ></asp:CheckBox></TD>
				</TR>
			</TABLE>
	    
	    
            <asp:datagrid id="dgMaterial" runat="server"  EnableViewState="False" DataKeyField="MaterialCoreItemID">
                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                </AlternatingItemStyle>
                <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                <headerStyle Height="25px" CssClass="tableheader"></headerStyle>
                <PagerStyle Visible="False"></PagerStyle>
                <Columns>
                    <asp:TemplateColumn>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chkDelete" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:datagrid>
                                    
            	    
			
    </form>
    
	<script language="javascript">
	    var frm = document.form1;
	    function CheckAll(checkAllBox) {
	        var actVar = checkAllBox.checked;
	        for (i = 0; i < frm.length; i++) {
	            e = frm.elements[i];
	            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
	                e.checked = actVar;
	        }
	    }
        function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
        }
	</script>
	
</body>
</html>
