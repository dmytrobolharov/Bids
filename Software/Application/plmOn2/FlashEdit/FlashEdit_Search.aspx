<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FlashEdit_Search.aspx.vb" Inherits="plmOnApp.FlashEdit_Search" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<html>
	<head>
		<title>Flash Edit</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
		
        <script type="text/javascript">

            function stopRKey(evt) {
                var evt = (evt) ? evt : ((event) ? event : null);
                var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
                if ((evt.keyCode == 13) && (node.type == "text")) { return false; }
            }

            document.onkeypress = stopRKey; 

        </script>		
        
	</head>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td width="200">
					    <asp:imagebutton 
					        id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" /><cc1:confirmedimagebutton 
					        id="btnSave" visible="false" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					        id="btnBatchUpdate"  visible="false" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					        id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>     
					<td>
			            <table width="200" border="0" cellspacing="0" cellpadding="0" >
				            <tr>
				                <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					            <td><asp:CheckBox valign="top" align="center" ID="chbBatchUpdate" autopostback="true" runat="server" Text="BatchUpdate" CssClass="fontHead" /></td>
				            </tr>
			            </table>	
					</td>
                    <td></td>
					
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
				</tr>
			</table>			
			<table class="TableHeaderBlue" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr valign="middle">
				    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:Label id="LabelSearch" runat="server" Font-Names="Tahoma,Verdana" ></asp:Label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder><br /></td>
					<td width="100%" valign="top">
						<table>
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" CausesValidation="false"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<asp:Panel  ID="pnlBatchUpdate" Visible="false" runat="server">
			    <table class="TableHeaderYellow" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				    <tr valign="middle">
				        <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					    <td><asp:Label id="LabelEdit" runat="server" Font-Names="Tahoma,Verdana"  ></asp:Label></td>
				    </tr>
			    </table>
			    <table cellSpacing="0" cellpadding="0" width="100%" bgcolor="#EEEB9F" border="0">
				    <tr>
					    <td><asp:placeholder id="plhEditControlsHolder" runat="server" 
                                EnableViewState="False" ></asp:placeholder></td>					
				    </tr>
			    </table>
			</asp:Panel>
			
			
            <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	            <TR vAlign="top">
		            <TD>
			            <TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <TR vAlign="middle">
					            <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					            <TD width="16"></TD>
					            <TD class="fontHead" width="25">
                                    </TD>
					            <TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
					            <TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
					            <TD noWrap align="center" width="200"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					            <TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
					            <TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
					            <TD width="10">&nbsp;</TD>
					            <TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
					            <TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
					            <TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							            <asp:ListItem Value="5">5</asp:ListItem>
							            <asp:ListItem Value="10">10</asp:ListItem>
							            <asp:ListItem Value="15">15</asp:ListItem>
							            <asp:ListItem Value="20">20</asp:ListItem>
							            <asp:ListItem Value="25">25</asp:ListItem>
							            <asp:ListItem Value="30">30</asp:ListItem>
							            <asp:ListItem Value="40">40</asp:ListItem>
							            <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
						            </asp:dropdownlist></TD>
					            <TD width="10"><asp:button id="Button1" runat="server" CssClass="fontHead" CausesValidation="false"></asp:button></TD>
				            </TR>
			            </TABLE>
			            <asp:datagrid id="DataGrid1" runat="server" AllowSorting="true" DataKeyField='<%#FlashEditTablePki()%>' >
				            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				            <ItemStyle CssClass="ItemTemplate"></ItemStyle>
				            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				            <PagerStyle Visible="False"></PagerStyle>				
				            <Columns>
				                <asp:TemplateColumn Visible="false">
				                    <ItemTemplate>
				                        <input type="hidden" runat="server" id="dummy" />
				                    </ItemTemplate>
				                </asp:TemplateColumn>
				            </Columns>
				            
			            </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="false"></asp:label>
			            <asp:label id="CurrentPageIndex" runat="server" Visible="false" Text="0"></asp:label>
			            </TD>
			            
	            </TR>
            </TABLE>			
            
			<asp:PlaceHolder id="phStyleGrid" runat="server" EnableViewState="False"></asp:PlaceHolder>		
    </form>
    <script language="javascript" type="text/javascript"  >
        var frm = document.Form1;
        function SelectAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf('<%= strFlashEditTablePKI%>') != -1)
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
