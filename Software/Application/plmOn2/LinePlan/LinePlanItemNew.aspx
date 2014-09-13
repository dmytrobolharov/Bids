<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlanItemNew.aspx.vb" Inherits="plmOnApp.LinePlanItemNew" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<HTML>
	<HEAD runat="server">
		<title></title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	    <script language="javascript" src="../System/Jscript/Custom.js"></script>
        <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>	
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
	    </HEAD>
	<body>
		<form id="form1" method="post" runat="server">
			<table class="tableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						    <asp:ImageButton 
						        id="btnSaveStyle" runat="server" ></asp:ImageButton><cc1:confirmedimagebutton 
						        id="btnMultiCloth" runat="server" Visible = "true" CausesValidation="False" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
						        id="btnCopy" runat="server" Message="NONE"  CausesValidation="False"></cc1:confirmedimagebutton><cc1:BWImageButton  
						        id="btnAddMaterial" runat="server"  CausesValidation="False" /><cc1:BWImageButton  
						        id="btnAddColor" runat="server" CausesValidation="False" /><cc1:BWImageButton  
						        id="btnSummary" runat="server"  CausesValidation="False" /><cc1:confirmedimagebutton 
						        id="btnClose" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					</td>
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
				    <td>&nbsp;</td>
					
				</tr>
			</table>

		
			<table height="100" cellSpacing="0" cellPadding="0" border="0" width="100%" bgcolor="White">
	    	    <tr vAlign="top" runat="server" id="trAttribute" >
				    <td width="10">&nbsp;</td>
					<td width="900" align="right">
					    <table border="0" width="100%" cellSpacing="0" cellPadding="0" >
					        <tr><td width="33%">&nbsp;</td>
					            <td width="33%">&nbsp;</td>
					            <td width="33%"><asp:Label ID="lblAttribute" runat="server" CssClass="fontHead">Group: Nova</asp:Label></td>
					    </tr></table>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr vAlign="top">
				    <td width="10">&nbsp;</td>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<br /><br />
			
		    <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
                <tr>
                    <td width="10">&nbsp;</td>
                    <td align="left" valign="top"  bgcolor="White" >
                        <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
                            <tr height="25px" class="tableHeader">
                               <td ><asp:Label ID="lblSelColor" runat="server" Text="Select Colorway"></asp:Label></td>
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
                    <td align="left" valign="top" bgcolor="White">
                    <asp:Panel runat="server" ID="pnlMaterial" >
                        <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
                            <tr height="25px" class="tableHeader">
                                <td width="5">&nbsp;</td>
                                <td><asp:Label ID="lblSelMain" runat="server" Text="Select Main Material"></asp:Label></td>
                                <td>&nbsp;</td>
                            </tr>
                        </table> 
                        
                        <asp:datagrid id="dgMaterial" runat="server" DataKeyField="LinePlanMaterialItemID"
                            AllowPaging="false" >
                            <AlternatingItemStyle BackColor="AliceBlue" Height="20px" />
                            <ItemStyle BackColor="White" CssClass="font" Height="20px" />
		                    <HeaderStyle CssClass="tableHeader" Height="25px"></HeaderStyle>
		                    <PagerStyle Visible="False"></PagerStyle>
	                    </asp:datagrid>
	                    
	                    <br>
		            </asp:Panel>    
		            <asp:Panel runat="server" ID="pnlBody" >
		                <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
                            <tr height="25px" class="tableHeader">
                                <td width="5">&nbsp;</td>
                                <td><asp:Label ID="lblSelBody" runat="server" Text="Select Body"></asp:Label></td>
                                <td>&nbsp;</td>
                            </tr>
                        </table> 
		                <asp:datagrid id="dgBody" runat="server" DataKeyField="BodyID">
                                <AlternatingItemStyle BackColor="AliceBlue" Height="20px" />
                                <ItemStyle BackColor="White" CssClass="font" Height="20px" />
			                    <HeaderStyle CssClass="tableHeader" Height="25px"></HeaderStyle>
			                    <PagerStyle Visible="False"></PagerStyle>
		                </asp:datagrid>
		            </asp:Panel>
		           </td>
		           <td>&nbsp;</td>
                </tr>
            </table>
		</form>

		 <script language="javascript" type="text/javascript">
		     var frm = document.form1;
		     function CheckAll(checkAllBox, id) {
		         var actVar = checkAllBox.checked, i, e;
		         for (i = 0; i < frm.length; i++) {
		             e = frm.elements[i];
		             if (e.type == 'checkbox' && e.name.indexOf(id) != -1)
		                 e.checked = actVar;
		         }
		     }

		     function DelCheckAll(checkAllBox, id) {
		         var actVar = checkAllBox.checked, i, len, e;
		         for (i = 0, len = frm.length; i < len; i++) {
		             e = frm.elements[i];
		             if (e.id.indexOf(id) != -1 && !e.disabled) {
		                 e.checked = actVar;
		             }
		         }
		     }

	    
		</script>				

	
	</body>
</HTML>
