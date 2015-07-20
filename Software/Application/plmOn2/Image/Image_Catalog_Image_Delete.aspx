<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Image_Catalog_Image_Delete.aspx.vb" Inherits="plmOnApp.Image_Catalog_Image_Delete" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Image Catalog</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">
        function doProcess() {
            var objParent = window.opener.parent.opener;
            if (objParent == null || objParent == 'undefined') {
                window.opener.location.href = window.opener.location.href;
            }
            else {
                objParent.location.reload(true);
            }
            opener.parent.close();
            window.close();
        }
    </script>
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">

		<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<tr vAlign="middle">
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td><cc1:confirmedimagebutton id="btnDelete" runat="server"  ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="btnClose_Click()"
						></cc1:confirmedimagebutton></td>
				<td>&nbsp;</td>
			</tr>
		</TABLE>

    
        <TABLE cellSpacing="1" cellPadding="1" width="100%" border="0" height="35" bgcolor="#ffffff">
	        <TR>
		        <TD>
			        <asp:CheckBox id="cbDeleteAll" runat="server" CssClass="fontRed" ></asp:CheckBox></TD>
	        </TR>
        </TABLE>
        <asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
	        PageSize="100" AutoGenerateColumns="False" Width="470px" DataKeyField="ImageCatalogItemID">
	        <AlternatingItemStyle Height="20px" BackColor="AliceBlue" VerticalAlign="Middle" HorizontalAlign="Center"></AlternatingItemStyle>
	        <ItemStyle Height="20px" CssClass="font" BackColor="White" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
	        <HeaderStyle Height="20px" CssClass="TableHeader" HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>
	        <Columns>
		        <asp:TemplateColumn>
			        <HeaderTemplate>
				        <input type="checkbox" id="chkAll" onClick="CheckAll(this);" name="chkAll">
			        </HeaderTemplate>
			        <ItemTemplate>
				        <asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
			        </ItemTemplate>
		        </asp:TemplateColumn>
		        <asp:TemplateColumn >
		            <HeaderTemplate>
		                <asp:Label id="lblImageHdr" runat="server"><%#GetSystemText("Image")%></asp:Label> 
		            </HeaderTemplate>
			        <ItemTemplate>
				        <asp:Image id="imgFile"  runat="server">
				        </asp:Image>
			        </ItemTemplate>
		        </asp:TemplateColumn>
		        <asp:TemplateColumn>
		            <HeaderTemplate>
		                <asp:Label id="lblImageNoHdr" runat="server"><%#GetSystemText("ImageNo")%></asp:Label> 
		            </HeaderTemplate>
			        <ItemTemplate>
				        <asp:Label ID="lblImageNo" runat="Server"  >
				        </asp:Label>
			        </ItemTemplate>
		        </asp:TemplateColumn>
		        <asp:TemplateColumn >
		            <HeaderTemplate>
		                <asp:Label id="lblDescriptionHdr" runat="server"><%#GetSystemText("Description")%></asp:Label> 
		            </HeaderTemplate>		        
			        <ItemTemplate>
				        <asp:Label ID="lblDescription" runat="Server" >
				        </asp:Label>
			        </ItemTemplate>
		        </asp:TemplateColumn>
	        </Columns>
        </asp:datagrid>


    </form>
    
    <script language="javascript">
		var frm = document.form1 ;
		function CheckAll( checkAllBox ){
		    var actVar = checkAllBox.checked ;
		    for(i=0;i< frm.length;i++){
			    e=frm.elements[i];
			    if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			        e.checked= actVar ;
		    }
        }
        function btnClose_Click() {
                        <%= strExitScript %>;
                        return false;
                    }
	</script>
		
		    
</body>
</html>
