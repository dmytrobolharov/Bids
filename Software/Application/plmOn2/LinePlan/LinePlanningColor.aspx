<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlanningColor.aspx.vb" Inherits="plmOnApp.LinePlanningColor" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title>Palette</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        
	</HEAD>
	<body>
		<form id="Form1" method="post" encType="multipart/form-data" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10">
					    <asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td valign="top">
                        <cc1:confirmedimagebutton id="btnColorAdd" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnColorAllocationAdd" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:ConfirmedImageButton ID="btnColorDelete" runat="server"></cc1:ConfirmedImageButton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>  
                    </td>
					<td></td>
				</TR>
			</TABLE>
		    <br>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>	
			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" width="100%">
					
                    					
			            <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				            <tr>
					            <td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					            <td vAlign="top" width="100%">
						            <TABLE id="Table3" height="45">
							            <TR>
								            <TD><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
							            </TR>
						            </TABLE>
					            </td>
				            </tr>
			            </table>	
			            

			            <table class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
				            <tr class="fontHead">
					            <td align="center" width="10" height="25"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td height="25">
						            <div align="left">&nbsp;
							            <asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label></div>
					            </td>
					            <td width="20" height="25">
						            <div align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div>
					            </td>
					            <td width="20" height="25">
						            <div align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div>
					            </td>
					            <td width="125" height="25">
						            <div align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></div>
					            </td>
					            <td width="20" height="25">
						            <div align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div>
					            </td>
					            <td width="20" height="25">
						            <div align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div>
					            </td>
					            <td height="25">
						            <div align="left"><B><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;
						                <asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label>
						                </b>
                                    </div>
					            </td>
					            <td height="25">
						            <P align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist><asp:dropdownlist id="ddlSortBy" runat="server">
								            <asp:ListItem Value="ASC">ASC</asp:ListItem>
								            <asp:ListItem Value="DESC">DESC</asp:ListItem>
							            </asp:dropdownlist><asp:imagebutton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:imagebutton></P>
					            </td>
				            </tr>
			            </table>			            				
					
			            <table borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
				            <tr>
					            <td vAlign="top"><asp:datalist id="DataList1" runat="server" RepeatDirection="Horizontal" 
                                    RepeatColumns="8" EnableViewState="False" DataKeyField="ColorPaletteID">
	                                <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
	                                <ItemTemplate>
		                                <asp:Panel align="left" id="colorChip" runat="server">
		                                <asp:CheckBox ID="colorCheck" runat="server" /> 
		                                <%--asp:Image id="imgColorChip" runat="server"></asp:Image--%>
		                                </asp:Panel>
		                                <br/>
		                                <asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder>
		                                <br/><br/>
	                                </ItemTemplate>
                                </asp:datalist></td>
				            </tr>
			            </table>
			            <input id="imageSize" type="hidden" runat="server">					
                    </tr>
			</table>
	
			
		</form>
	</body>
</HTML>
