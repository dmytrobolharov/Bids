<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_NBOL_Exceptions_Popup.aspx.vb" Inherits="plmOnApp.Style.BOLNew.Style_NBOL_Exceptions_Popup" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title id="tlExceptions" runat="server">BOL Exceptions</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <table  class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr>
                <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                <td align="left">
                   <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE" />
                   <cc1:confirmedimagebutton id="btnSaveClose" runat="server"  Message="NONE" />
                   <cc1:confirmedimagebutton id="btnRemove" runat="server"  Message="NONE" />
                   <cc1:confirmedimagebutton id="btnClose" runat="server" CausesValidation="false" Message="NONE" OnClientClick="return btnClose_Click()" />
                </td>
            </tr>
        </table>  
	    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45" width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
		    <tr>
			    <td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
		    </tr>
	    </table>
		<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
			<TR bgColor="#ffffff">
				<TD vAlign="top"><asp:datagrid id="DataGrid1" runat="server" PageSize="100" AllowSorting="True"
						DataKeyField="ExceptionID">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
						<PagerStyle Visible="False"></PagerStyle>
                        <Columns>
                            <asp:TemplateColumn>
                            	<HeaderStyle CssClass="TableHeaderRed" Width="20"></HeaderStyle>
					            <ItemStyle></ItemStyle>
                                <HeaderTemplate>
                                    <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
					</asp:datagrid>
					<TABLE cellSpacing="2" cellPadding="0" width="500" border="0">
						<TR class="fontHead">
							<TD width="10">&nbsp;</TD>
							<TD noWrap width="85"><asp:Label ID="lblNumOfRows" runat="server"></asp:Label></TD>
							<TD width="35"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
									<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
									<asp:ListItem Value="2">2</asp:ListItem>
									<asp:ListItem Value="3">3</asp:ListItem>
									<asp:ListItem Value="4">4</asp:ListItem>
									<asp:ListItem Value="5">5</asp:ListItem>
									<asp:ListItem Value="10">10</asp:ListItem>
									<asp:ListItem Value="15">15</asp:ListItem>
									<asp:ListItem Value="20">20</asp:ListItem>
								</asp:dropdownlist></TD>
							<TD width="300"><cc1:confirmedimagebutton id="btnAddRow" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
						</TR>
					</TABLE>
					<asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
			</TR>
		</TABLE>	    
	    
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
    </script>    
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
