<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlanItemNew_Summary.aspx.vb" Inherits="plmOnApp.LinePlanItemNew_Summary" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!--DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" -->
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <script language="javascript" src="../System/Jscript/Custom.js"></script>
    <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
	    <table class="tableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td>
				        <asp:ImageButton 
				            id="btnSave" runat="server" ></asp:ImageButton><cc1:confirmedimagebutton 
				            id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
			    </td>
		    </tr>
	    </table>
	    
	    <br /><br />
	    <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
            <tr>
                <td align="left" valign="top"  bgcolor="White" runat="server" id="tdColor" >
                    <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
                        <tr height="25px" class="tableHeader">
                           <td ><asp:Label ID="lblSelColor" runat="server" Text="Select Colorway"></asp:Label></td>
                        </tr>
                    </table> 
		              <asp:datagrid id="dgColorway" runat="server" DataKeyField="ColorPaletteID" >
                        <AlternatingItemStyle BackColor="AliceBlue" Height="20px" />
                        <ItemStyle BackColor="White" CssClass="font" Height="20px" />
                        <HeaderStyle CssClass="tableHeader" Height="25px"></HeaderStyle>
                        <Columns>
                            <asp:TemplateColumn>
                                <HeaderTemplate>
                                    <input ID="checkAll" runat="server" name="checkAll" onclick="CheckAll(this,'chkSelect');" type="checkbox"/>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server"  ID="chkSelect" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:datagrid><asp:label id="ColorSortOrder" runat="server" Visible="False"></asp:label>
                </td>
                <td align="left" valign="top" bgcolor="White">
                    <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
                        <tr height="25px" class="tableHeader">
                            <td width="5">&nbsp;</td>
                            <td><asp:Label ID="lblSelMain" runat="server" Text="Select Main Material"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                    </table> 
                    
                    <asp:datagrid id="dgMaterial" runat="server" DataKeyField="MaterialID" >
                        <AlternatingItemStyle BackColor="AliceBlue" Height="20px" />
                        <ItemStyle BackColor="White" CssClass="font" Height="20px" />
                        <HeaderStyle CssClass="tableHeader" Height="25px"></HeaderStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                        <Columns>
                        
					        <asp:TemplateColumn>
					            <HeaderTemplate>
					                <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
					            </HeaderTemplate>
							    <ItemTemplate>
								    <asp:CheckBox id="chkSelected" runat="server"></asp:CheckBox>
							    </ItemTemplate>							        
					        </asp:TemplateColumn>
    					    
					        <asp:TemplateColumn>
					            <HeaderTemplate>
					                <table><tr><td valign='middle' class='fontHead' ><img alt='' src='../System/Icons/icon_holiday.gif'
                                        onclick="radioButtonClearAll('rdbSelectMatID');"
                                        onmouseover="style.cursor='hand'" />
                                    </td></tr></table>
					            </HeaderTemplate>
							    <ItemTemplate>
								    <asp:Label runat="server" id="lblrdbSelect" ></asp:Label>
							    </ItemTemplate>							        
					        </asp:TemplateColumn>                        
                        </Columns>
                    </asp:datagrid><asp:label id="MaterialSortOrder" runat="server" Visible="False"></asp:label>
                </td>
            </tr>
        </table>
    
    </form>
    <script language="javascript">
        var frm = document.form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
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
