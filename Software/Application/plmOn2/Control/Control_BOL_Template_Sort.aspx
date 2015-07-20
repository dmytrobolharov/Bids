<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_BOL_Template_Sort.aspx.vb" Inherits="plmOnApp.Control_BOL_Template_Sort" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />    
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>

	    <TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
		    <TBODY>
			    <TR vAlign="middle">
				    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></TD>
				    <TD vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
				    <cc1:confirmedimagebutton id="imgBtnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></TD>
				    <TD></TD>
			    </TR>
		    </TBODY>
	    </TABLE>

	    <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
		    height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
		    <tr>
			    <td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Bla Bla</asp:label></td>
		    </tr>
	    </table>

		<table border="0">
		<tr>
			<td width="100">&nbsp;</td>
			<td>
            <!---------------------->					
            <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
                <tr vAlign="middle">
                <td ><span class="fontHead" ><asp:Label ID="lblSortBy" runat="server" 
                        Text="Sort by"></asp:Label>:
            &nbsp;</span><asp:DropDownList runat="server" ID="ddlSortBy" CssClass="font" ></asp:DropDownList><cc1:confirmedimagebutton id="btnSort" 
                runat="server"  Message="NONE"></cc1:confirmedimagebutton><br></td>
                </tr>
	            <TR vAlign="top">
		            <TD>
			            <asp:datagrid id="DataGrid1" runat="server" EnableViewState="true" AutoGenerateColumns="False"
										BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" DataKeyField="TemplateEntryId"> 
				            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				            <PagerStyle Visible="False"></PagerStyle>
			            </asp:datagrid>
			            <asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
	            </TR>
            </TABLE>
            <input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server" />						
				
        </td>
		</tr>
	</table>
			
						    
    </div>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
