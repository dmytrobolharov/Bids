<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlanItemNewCopy.aspx.vb" Inherits="plmOnApp.LinePlanItemNewCopy" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
		<title>New</title>
        <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>	
		<script language="JavaScript">
		<!--
		    if (window.screen) {
		        var aw = screen.availWidth;
		        var ah = screen.availHeight;
		        window.moveTo(0, 0);
		        window.resizeTo(aw, ah);
		    }

		    if (self != top) top.location.replace(self.location);				
			
		//-->
		</script>

</head>
<body>
    <form id="form1" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						<asp:ImageButton 
						        id="btnSaveStyle" runat="server" ></asp:ImageButton><cc1:BWImageButton  
						        id="btnAddColor" runat="server" CausesValidation="False" /><cc1:confirmedimagebutton 
						        id="btnClose" runat="server" Message="NONE" CausesValidation="False" ></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server" id="tbNoCopies" bgcolor="White">
				<tr>
				    <td width="10" height="100">&nbsp;</td>
				    <td width="195">
                        <table cellSpacing="0" cellPadding="0" border="0">
                            <tr>
                                <td class="fontHead" style="font-size: 14px; color: #CC0000">
                                    <asp:Label ID="lblNumberStyle" runat="server" Text="Number of Style(s):"></asp:Label>&nbsp;</td>
                                <td>
                                    <asp:DropDownList ID="ddlNewStyle" runat="server" Font-Size="16pt" 
                                        ForeColor="#CC0000" Font-Bold="True">
				                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
					<td width="20">&nbsp;</td>
					<td width="20">&nbsp;</td>
				    <td width="150">

                        <table id="tblChannel" cellSpacing="1" cellPadding="1" border="0" 
                            style="border: thin #CCCCCC;" bgcolor="#CCCCCC" runat="server" >
                            <tr class="TableheaderBlue">
                                <td colspan="4" style="text-align: center" height="20">
                                    <asp:Label ID="lblChannel" runat="server" Text="Channel"></asp:Label></td>
                            </tr>
                            <tr bgcolor="White">
                                <td class="fontHead" align="center" Width="50px">
                                    WHS</td>
                                <td class="fontHead" align="center" Width="50px">
                                    RTL</td>
                                <td class="fontHead" align="center" Width="50px">
                                    INT</td>
                                <td class="fontHead" align="center" Width="50px">
                                    CAT</td>
                            </tr>
                            <tr bgcolor="White">
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlanCh1" runat="server" Checked="True" />
                                </td>
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlanCh2" runat="server" Checked="True" />
                                </td>
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlanCh3" runat="server" Checked="True" />
                                </td>
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlanCh4" runat="server" Checked="True" />
                                </td>
                            </tr>
                        </table>
                    </td>
					
				    <td>&nbsp;</td>
					
				</tr>
			</table>
			<table height="100" cellSpacing="0" cellPadding="0" border="0" width="100%" bgcolor="White">
	    	    <tr vAlign="top" runat="server" id="trAttribute" >
				    <td width="10">&nbsp;</td>
					<td width="900" align="right">
					    <table border="0" width="100%" cellspacing="0" cellpadding="0" >
					        <tr><td width="33%">&nbsp;</td>
					            <td width="33%">&nbsp;</td>
					            <td width="33%" align="left"><asp:Label ID="lblAttribute" runat="server" CssClass="fontHead">Group: Nova</asp:Label></td>
					    </tr></table>
					</td>
					<td>&nbsp;</td>
				</tr>			
				<tr vAlign="top">
				    <td width="10">&nbsp;</td>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<TD><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></TD>
				</tr>
			</table>
		    <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
                <tr>
                    <td width="10">&nbsp;</td>
                    <td align="left" valign="top"  bgcolor="White" >
                        <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="600px">
                            <tr height="25px" class="TableHeader">
                                <td width="5" >&nbsp;</td>
                                <td ><asp:Label ID="lblSelColor" runat="server" Text="Select Colorway"></asp:Label></td>
                                <td>&nbsp;</td>
                            </tr>
                        </table> 

        	            <asp:datagrid id="dgColorway" runat="server" DataKeyField="ColorPaletteID" AutoGenerateColumns="False" 
                             BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				            <PagerStyle />
				            <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				            <ItemStyle Height="20px" CssClass="font"></ItemStyle>
				            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				            <Columns>
				                <asp:TemplateColumn>
				                    <HeaderTemplate>
				                        <asp:CheckBox ID="chkSelectAll" runat="server" onclick="CheckAll(this,'chkSelect')" />
				                    </HeaderTemplate>
				                    <ItemTemplate>
				                        <asp:CheckBox ID="chkSelect" runat="server" EnableViewState="true" />
				                    </ItemTemplate>
				                </asp:TemplateColumn>
				            </Columns>
			            </asp:datagrid>		
            			                        
                    </td>
                    <td align="left" valign="top" bgcolor="White">&nbsp;</td>
		           <td>&nbsp;</td>
                </tr>
            </table>
    </form>
    
    		<script language="javascript" type="text/javascript">
    		    var frm = document.form1;
    		    function CheckAll(checkAllBox,objId) {
    		        var actVar = checkAllBox.checked;
    		        for (i = 0; i < frm.length; i++) {
    		            e = frm.elements[i];
    		            if (e.type == 'checkbox' && e.name.indexOf(objId) != -1)
    		                e.checked = actVar;
    		        }
    		    }

    		    function DelCheckAll(checkAllBox, id, grp) {
    		        var actVar = checkAllBox.checked;
    		        for (i = 0; i < frm.length; i++) {
    		            e = frm.elements[i];

    		            if (e.type == 'radio' && e.id.indexOf(id) != -1) {
    		                e.checked = actVar;
    		                //e.disabled = !actVar ;
    		            }

    		            if (e.type == 'checkbox' && e.name.indexOf(grp) != -1 && e.name != checkAllBox.name) {
    		                e.checked = false;
    		            }
    		        }
    		    }	
    		    
    		    
		</script>		
</body>
</html>
