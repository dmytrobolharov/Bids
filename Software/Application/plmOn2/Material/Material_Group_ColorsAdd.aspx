<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_Group_ColorsAdd.aspx.vb" Inherits="plmOnApp.Material_Group_ColorsAdd" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register assembly="YSTab" namespace="Yunique.WebControls.YSTab" tagprefix="cc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Palette</title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />  
</head>
<body>
    <form id="form1" runat="server">


		<TABLE class="TableHeader" id="TABLE1" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<td valign="top">
				    <asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
				    <asp:imagebutton id="btnBack" runat="server" ></asp:imagebutton>
				    <asp:imagebutton id="btnAdd" runat="server" ></asp:imagebutton>
				    <asp:imagebutton ID="btnClose" runat="server" OnClientClick="return btnClose_Click()"    />
                </td>
				<td width="75">&nbsp;</td>
				<td align="right"></td>
			</TR>
		</TABLE>    	     

		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td><asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
			</tr>
		</table>

	    <table height="10" cellSpacing="0" cellPadding="0" width="100%" border="0">
		    <tr>
			    <td>
                   &nbsp;
                </td>
		    </tr>
	    </table>
	     <cc2:YSTabView ID="YSTabView1" runat="server" />     

		<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
			<tr>
				<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
				<td width="100%" valign="top">
					<table id="Table3" height="45">
						<TR>
							<TD>
								<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
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
                        <div align="left">
                            &nbsp;
                            <asp:Label ID="lblCurrentIndex" Runat="server" Text="0" Visible="False"></asp:Label>
                            <asp:Label ID="lblPageSize" Runat="server" Text="49" Visible="False"></asp:Label>
                        </div>
                    </td>
                    <td height="25" width="20">
                        <div align="center">
                            <asp:imagebutton id="btnImgFirstRecord" runat="server" ImageUrl="../System/Icons/icon_first.gif" ></asp:imagebutton> </div>
                    </td>
                    <td height="25" width="20">
                        <div align="center">
                           <asp:imagebutton id="btnImgPreviousRecord" runat="server" ImageUrl="../System/Icons/icon_Previous.gif" ></asp:imagebutton>  </div>
                    </td>
                    <td height="25" width="125">
                        <div align="center">
                            <asp:Label ID="lblCounts" Runat="server" CssClass="plaintable"></asp:Label>
                        </div>
                    </td>
                    <td height="25" width="20">
                        <div align="center">
                             <asp:imagebutton id="btnImgNextRecord" runat="server" ImageUrl="../System/Icons/icon_next.gif" ></asp:imagebutton></div>
                    </td>
                    <td height="25" width="20">
                        <div align="center">
                            <asp:imagebutton id="btnImgLastRecord" runat="server" ImageUrl="../System/Icons/icon_last.gif" ></asp:imagebutton></div>
                    </td>
                    <td height="25">
                        <div align="left">
                            <b>
                            <asp:Label ID="lblRecordCount" Runat="server" Visible="true"></asp:Label>
                            &nbsp;<asp:Label id="lblRecordsFound" runat="server" text="Records Found"></asp:Label></b></div>
                    </td>
                    <td height="25">
                        <p align="right">
                            <asp:DropDownList ID="ddlSortField" runat="server">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlSortBy" runat="server">
                                <asp:ListItem Value="ASC">ASC</asp:ListItem>
                                <asp:ListItem Value="DESC">DESC</asp:ListItem>
                            </asp:DropDownList>
                            <asp:ImageButton ID="btnSort" runat="server" 
                                ImageUrl="../System/Icons/icon_sort.gif" />
                        </p>
                    </td>
                </tr>
            </table>

            <table border="0" bordercolor="gainsboro" cellpadding="0" cellspacing="1">
                <tr>           
                    <td valign="top">
                        <asp:DataList ID="Datalist1" runat="server" EnableViewState="False" RepeatColumns="1" BorderColor="Gray" 
                            BorderWidth="1px" CellPadding="2" GridLines="Both" DataKeyField="ColorPaletteID">
                            <ItemStyle BackColor="White" BorderColor="Gainsboro" BorderStyle="Solid" 
                                BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Top" />
                            <ItemTemplate>   
                            </ItemTemplate>
                        </asp:DataList>
                    </td>                   
                </tr>
            </table>


		<script language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
		                e.checked = actVar;
		        }
		    }
            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
		</script>	            
            				
    </form>
</body>
</html>
