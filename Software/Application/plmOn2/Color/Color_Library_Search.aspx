<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_Library_Search.aspx.vb" Inherits="plmOnApp.Color_Library_Search" %>
<%@ Register assembly="YSTab" namespace="Yunique.WebControls.YSTab" tagprefix="cc2" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title runat="server" id="PageTitle">Palette</title>
        <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
        <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />  
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" encType="multipart/form-data" runat="server" defaultbutton="imgBtnSearch">

        <uc1:Color_Wait ID="Color_Wait" runat="server" />

			        <input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>

			<table height="10" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td>
                       &nbsp;
                    </td>
				</tr>
			</table>
			 <cc2:YSTabView ID="YSTabView1" runat="server" />
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td valign="top">
									<asp:imagebutton id="btnAdd" runat="server"></asp:imagebutton>
									<asp:imagebutton id="btnAddColor" runat="server" ></asp:imagebutton>
                                    <cc1:ConfirmedImageButton ID="btnDelete" runat="server"  />
                                    <cc1:ConfirmedImageButton ID="btnClose" runat="server"/>
                    </td>
					<td width="75">&nbsp;</td>
					<td align="right"></td>
				</TR>
			</TABLE>	
			<!--		
            <table cellSpacing="0" cellPadding="0" width="100%" border="0" class="TableHeader">
				<tr>
					<td align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>&nbsp;<asp:Label ID="lblColorSearch" runat="server" Text=""></asp:Label></td>
				</tr>
			</table>
			-->
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<TR>
								<TD>
									<asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></TD>
							</TR>
						</table>
					</td>
				</tr>
			</table>            

	        <table id="Table2" border="0" cellpadding="0" cellspacing="0" 
                class="TableHeader" height="20" width="100%">
                <tr class="fontHead">
                    <td align="center" height="25" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                    <td height="25">
                        <div align="left"><asp:CheckBox runat="server" id="chkSelectAll" onclick="CheckAll(this)"/></div>
                    </td>
                    <td height="25">
                        <div align="left">
                            &nbsp;
                            <asp:Label ID="lblCurrentIndex" Runat="server" Text="0" Visible="False"></asp:Label>
                            <asp:Label ID="lblPageSize" Runat="server" Text="49" Visible="False"></asp:Label>
                        </div>
                    </td>
                    <td height="25" width="20">
                        <div align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div>
                    </td>
                    <td height="25" width="20">
                        <div align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div>
                    </td>
                    <td height="25" width="125">
                        <div align="center">
                            <asp:Label ID="lblCounts" Runat="server" CssClass="fontHead"></asp:Label>
                        </div>
                    </td>
                    <td height="25" width="20">
                        <div align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div>
                    </td>
                    <td height="25" width="20">
                        <div align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div>
                    </td>
                    <td height="25">
                        <div align="left">
                            <b>
                            <asp:Label ID="lblRecordCount" Runat="server" Visible="true"></asp:Label>
                            &nbsp;<asp:Label ID="lblRecordsFound" Runat="server" CssClass="fontHead">Records Found</asp:Label></b></div>
                    </td>
                    <td height="25">
                        <p align="right">
                            <asp:DropDownList ID="ddlSortField" runat="server">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlSortBy" runat="server">
                            </asp:DropDownList>
                            <asp:ImageButton ID="btnSort" runat="server" CausesValidation="false"
                                ImageUrl="../System/Icons/icon_sort.gif" />
                        </p>
                    </td>
                </tr>
            </table>
            <table border="0" bordercolor="gainsboro" cellpadding="0" cellspacing="1">
                <tr>           
                    <td valign="top">
                        <asp:DataList ID="Datalist1" runat="server" 
                            EnableViewState="False" RepeatColumns="1" BorderColor="Gray" 
                            BorderWidth="1px" CellPadding="2" GridLines="Both">
                            <ItemStyle BackColor="White" BorderColor="Gainsboro" BorderStyle="Solid" 
                                BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Top" />
                            <ItemTemplate>   
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
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkColorSelect") != -1)
		                e.checked = actVar;
		        }
		    }

		    $(":checkbox[id$='chkColorSelect']").closest('table').click(function (e) {                
		        var chkColorSelect = $(this).find(":checkbox[id$='chkColorSelect']").get(0);
		        if (chkColorSelect && e.target.id != chkColorSelect.id) chkColorSelect.checked = !chkColorSelect.checked;
		    })
        </script>	
			
		</form>
		</body>
</HTML>
