<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_Library_Search.aspx.vb" Inherits="plmOnApp.Color_Library_Search" %>
<%@ Register assembly="YSTab" namespace="Yunique.WebControls.YSTab" tagprefix="cc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title runat="server" id="PageTitle">Palette</title>
        <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
        <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />  
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" encType="multipart/form-data" runat="server" defaultbutton="imgBtnSearch">
            <input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>
			<cc2:YSTabView ID="YSTabView1" runat="server" />
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td valign="top">
						<asp:imagebutton id="btnAdd" runat="server"></asp:imagebutton>
						<asp:imagebutton id="btnAddColor" runat="server" ></asp:imagebutton>
                        <cc1:ConfirmedImageButton ID="btnDelete" runat="server"  />
                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click();"/>
                    </td>
					<td width="75">&nbsp;</td>
					<td align="right"></td>
				</TR>
			</TABLE>	
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<TR><TD><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></TD></TR>
						</table>
					</td>
				</tr>
			</table>            

	        <table id="Table2" border="0" cellpadding="0" cellspacing="0" class="TableHeader" height="20" width="100%">
                <tr valign="middle" class="fontHead">
                    <td align="center" height="25" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                    <td height="25"><asp:CheckBox runat="server" id="chkSelectAll" onclick="CheckAll(this)" EnableViewState=true/></td>
                    <td height="25">
                        <asp:Label ID="lblCurrentIndex" Runat="server" Text="0" Visible="False"></asp:Label>
                        <asp:Label ID="lblPageSize" Runat="server" Text="49" Visible="False"></asp:Label>
                    </td>
                    <td height="25" width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></td>
                    <td height="25" width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></td>
                    <td nowrap height="25" width="125"><asp:Label ID="lblCounts" Runat="server" CssClass="fontHead"></asp:Label></td>
                    <td height="25" width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></td>
                    <td height="25" width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></td>
                    <td height="25">
                        <asp:Label ID="lblRecordCount" Runat="server" Visible="true"></asp:Label>
                        <asp:Label ID="lblRecordsFound" Runat="server" CssClass="fontHead">Records Found</asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td height="25" align="right">
                        <asp:DropDownList ID="ddlSortField" runat="server"></asp:DropDownList>
                        <asp:DropDownList ID="ddlSortBy" runat="server"></asp:DropDownList>
                        <asp:ImageButton ID="btnSort" runat="server" CausesValidation="false" ImageUrl="../System/Icons/icon_sort.gif" />
                    </td>
                </tr>
            </table>
            <table id="dlColors" border="0" bordercolor="gainsboro" cellpadding="0" cellspacing="1">
                <tr>           
                    <td valign="top">
                        <asp:DataList ID="Datalist1" runat="server" RepeatDirection="Horizontal" EnableViewState="False" RepeatLayout="Flow"
                            BorderColor="gainsboro" BorderWidth="0px" CellPadding="2" GridLines="Both">
                            <ItemStyle BackColor="White" BorderColor="Gainsboro" BorderStyle="Solid" 
                                BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Top" />
                            <ItemTemplate>
                                <table width="<%=strColorImageSize %> px">
                                    <tr>
                                        <td>
                                            <div >
                                            <asp:Label align="left" ID="tdImage" runat="server" AssociatedControlID="chkColorSelect" style="display:block;">
                                            <asp:CheckBox runat="server" ID="chkColorSelect" Checked='<%#(strTab = "2") %>' />
                                            </asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr><td><asp:PlaceHolder ID="plhColorInfo" runat="server"></asp:PlaceHolder></td></tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                    </td>
                    <td valign="top">
                        <asp:datagrid id="dgSeasonYear" runat="server"  EnableViewState="False" DataKeyField="SeasonYearID">
                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                            </AlternatingItemStyle>
                            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                            <headerStyle Height="20px" CssClass="TableHeader"></headerStyle>
                            <PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkSelect" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:datagrid>
                    </td>                    
                </tr>
            </table>
		    <script type="text/javascript">
               // $('#infoColor td').each(function () { $(this).attr('title', $(this).text()); });
		        var frm = document.Form1;
		        function CheckAll(checkAllBox) {
		            var actVar = checkAllBox.checked;
		            for (i = 0; i < frm.length; i++) {
		                e = frm.elements[i];
		                if (e.type == 'checkbox' && e.name.indexOf("chkColorSelect") != -1)
		                    e.checked = actVar;
		            }
		        }

                //$("#DataList1 td:has([id*=lbl]):has([id*=hdr])").removeAttr("width");
                //$("#DataList1 [id*=hdr]").removeAttr("width");
		        $(":checkbox[id$='chkColorSelect']").closest('table').click(function (e) {                
		            var chkColorSelect = $(this).find(":checkbox[id$='chkColorSelect']").get(0);
		            if (chkColorSelect && e.target.id != chkColorSelect.id) chkColorSelect.checked = !chkColorSelect.checked;
		        })
                $(":checkbox[id$='chkColorSelect']").parent().click(function (e) {                
		            var chkColorSelect = $(this).find(":checkbox[id$='chkColorSelect']").get(0);
		            if (chkColorSelect && e.target.id != chkColorSelect.id) chkColorSelect.checked = !chkColorSelect.checked;
		        })
                function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
                }
            </script>
		</form>
    </body>
</HTML>
