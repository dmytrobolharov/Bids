<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlanItemNewVersion.aspx.vb" Inherits="plmOnApp.LinePlanItemNewVersion" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<HTML>
	<HEAD>
		<title>New</title>
        <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>	
	    </HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="tableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						<asp:ImageButton 
						id="btnSaveStyle" runat="server" ></asp:ImageButton><cc1:confirmedimagebutton 
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

                        <table id="tblChannel" cellSpacing="1" cellPadding="1" border="0"  visible="false"
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
				<tr vAlign="top">
				    <td width="10">&nbsp;</td>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td>&nbsp;</td>
				</tr>
			</table>
		    <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
                <tr>
                    
                    <td align="left" valign="top"  bgcolor="White" width="400">
                        <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%" class="tableHeader">
                        <tr height="25px" class="tableHeader">
                            <td width="5">&nbsp;</td>
                            <td width="300"><asp:label runat="server" ID="lblColorway1" >Select Colorway</asp:label>&nbsp;</td>
                        </tr>
                        <tr><td align="left" valign="top"  bgcolor="White" colspan="2">
                        	<asp:datagrid id="dgColorway" runat="server" DataKeyField="ColorPaletteID" AutoGenerateColumns="False" 
                                BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				                <PagerStyle />
				                <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				                <ItemStyle Height="20px" CssClass="font"></ItemStyle>
				                <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			                </asp:datagrid>				
                        </td>
                     </tr>
                     <tr>
                        <td align="left" valign="top"  bgcolor="White" colspan="2">
                        </td>
                     </tr>
                    </table>
                        
                    </td>
                    <td  width="5"></td>
                    <td align="left" valign="top" bgcolor="White">
                        <asp:Panel ID="pnlMainMaterial" runat="server" BorderColor="#CC0000" BorderStyle="Solid" 
                                                BorderWidth="1px" Visible ="false">
                           <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
                            <tr height="25px" class="tableHeader">
                                <td width="5">&nbsp;</td>
                                <td><asp:Label ID="lblSelMain" runat="server" Text="Select Main Material"></asp:Label></td>
                                <td>&nbsp;</td>
                            </tr>
                            </table> 
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" visible = "false">
                            <tr>
                                <td width="20">&nbsp;&nbsp;&nbsp;</td>
                                <td align="center" width="300" height="25">
                                    <asp:Label CssClass="fontHead" ID="lblReplaceMainMaterial" runat="server" 
                                        Text="Do you want to replace main material?" ForeColor="#CC0000"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                             </tr>
                             <tr>  
                                <td>&nbsp;</td>
                                <td align="center" width="300" height="25">
                                    <cc1:BWHyperLink ID="hlkMainMaterial" runat="server" CssClass="fontHead" 
                                        ForeColor="#3333CC"></cc1:BWHyperLink>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                             <tr>  
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td align="center" width="300">
                                    <asp:RadioButtonList ID="rblReplaceMainMaterial" runat="server" 
                                        RepeatDirection="Horizontal" CssClass="fontHead" AutoPostBack="True">
                                        <asp:ListItem Selected="True" Value="YES" >Yes</asp:ListItem>
                                        <asp:ListItem Value="NO">No</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlMaterialGrid" runat="server">
                       
                        <asp:datagrid id="dgMaterial2" runat="server" DataKeyField="LinePlanMaterialItemID">
                            <AlternatingItemStyle BackColor="AliceBlue" Height="20px" />
                            <ItemStyle BackColor="White" CssClass="font" Height="20px" />
			                <HeaderStyle CssClass="tableHeader" Height="25px"></HeaderStyle>
			                <PagerStyle Visible="False"></PagerStyle>
		                </asp:datagrid> </asp:Panel>
		                <br>
                    <asp:Panel id="pnlBody" runat="server"> 
    		               <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
                            <tr height="25px" class="tableHeader">
                                <td width="5">&nbsp;</td>
                                <td<asp:Label ID="lblSelBody" runat="server" Text="Select Body"></asp:Label></td>
                                <td>&nbsp;</td>
                            </tr>
                        </table> 

                        <asp:Panel ID="pnlMainBody" runat="server" BorderColor="#CC0000" BorderStyle="Solid" 
                                                    BorderWidth="1px">
                               <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="20">&nbsp;&nbsp;&nbsp;</td>
                                    <td align="center" width="300" height="25">
                                        <asp:Label CssClass="fontHead" ID="Label1" runat="server" 
                                            Text="Do you want to select a body?" ForeColor="#CC0000"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                 </tr>

                                 <tr>  
                                    <td>&nbsp;&nbsp;&nbsp;</td>
                                    <td align="center" width="300">
                                        <asp:RadioButtonList ID="rblMainBody" runat="server" 
                                            RepeatDirection="Horizontal" CssClass="fontHead" AutoPostBack="True">
                                            <asp:ListItem Selected="True" Value="YES">Yes</asp:ListItem>
                                            <asp:ListItem Value="NO">No</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                            </table>
                            </asp:Panel><asp:Panel ID="pnlBodyGrid" runat="server">
		                    <asp:datagrid id="dgBody" runat="server" DataKeyField="LinePlanBodyItemID">
                                <AlternatingItemStyle BackColor="AliceBlue" Height="20px" />
                                <ItemStyle BackColor="White" CssClass="font" Height="20px" />
			                    <HeaderStyle CssClass="tableHeader" Height="25px"></HeaderStyle>
			                    <PagerStyle Visible="False"></PagerStyle>
		                    </asp:datagrid>
                            </asp:Panel>
                    </asp:Panel>                        
		           </td>
		           		           
                </tr>
            </table>
		</form>
		
		 <script language="javascript" type="text/javascript">
		     var frm = document.Form1;
		     function CheckAll(checkAllBox, id) {
		         var actVar = checkAllBox.checked;
		         for (i = 0; i < frm.length; i++) {
		             e = frm.elements[i];
		             if (e.type == 'checkbox' && e.name.indexOf(id) != -1)
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
</HTML>
