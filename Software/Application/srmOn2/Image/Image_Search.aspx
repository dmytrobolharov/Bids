<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Search.aspx.vb" Inherits="srmOnApp.Image_Search" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Image_Folder</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
			<asp:Panel runat="server" ID="pnlMain">		
			    <TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				    runat="server">
				    <tr vAlign="middle">
					    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					    <td>
					        <cc1:confirmedimagebutton id="imgBtnNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    </td>
				    </tr>
			    </TABLE>
			    <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				    <tr>
					    <td>&nbsp;</td>
					    <td>&nbsp;</td>
				    </tr>
			    </table>
			    <table id="Table4" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				    height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				    <tr>
					    <td>&nbsp;<asp:label id="lblImageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Image Folder...</asp:label></td>
				    </tr>
			    </table>
                <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
                    <tr>
                        <td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
                        <td vAlign="top" width="100%">
                            <table height="45">
                                <tr><td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td></tr>
                            </table>
                        </td>
                    </tr>
                </table>
			    <TABLE class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
				    border="0">
				    <TR class="fontHead">
					    <TD align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					    <TD height="25">
						    <DIV align="left">&nbsp;
							    <asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label><asp:label id="lblPageSize" Runat="server" Visible="False" Text="25">25</asp:label></DIV>
					    </TD>
					    <TD width="20" height="25">
						    <DIV align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></DIV>
					    </TD>
					    <TD width="20" height="25">
						    <DIV align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></DIV>
					    </TD>
					    <TD width="125" height="25">
						    <DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
					    </TD>
					    <TD width="20" height="25">
						    <DIV align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></DIV>
					    </TD>
					    <TD width="20" height="25">
						    <DIV align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></DIV>
					    </TD>
					    <TD height="25">
						    <DIV align="left"><B><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;
						        <asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label>
						        </B>
                            </DIV>
					    </TD>
					    <TD height="25">
						    <P align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist><asp:dropdownlist id="ddlSortBy" runat="server">
								    <asp:ListItem Value="ASC">ASC</asp:ListItem>
								    <asp:ListItem Value="DESC">DESC</asp:ListItem>
							    </asp:dropdownlist><asp:imagebutton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:imagebutton></P>
					    </TD>
				    </TR>
			    </TABLE>
			    <!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
			    <TABLE borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
				    <TR>
					    <TD vAlign="top"><asp:datalist id="Datalist2" runat="server" EnableViewState="false" RepeatDirection="Horizontal"
							    RepeatColumns="1" RepeatLayout="Table" DataKeyField="ImageId">
							    <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
								    VerticalAlign="Top" BackColor="White"></ItemStyle>
                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>								
							    <ItemTemplate>
				                    <table id="tbItem" runat="server" bordercolor='#CCCCCC' border="1" cellpadding="0" width="100%" 
				                     cellspacing="0" ><tr><td><table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" >
				                     <tr><td><asp:Label ID="lblEdit" runat="server"></asp:Label></td></tr></table></td></tr>
				                    <tr height='<%#ImageWidth%>' ><td ><asp:Image id="imgDesign" runat="server" /></td>
				                    </tr><tr><td> <asp:PlaceHolder ID="pnlHeader" runat="server" >
				                    </asp:PlaceHolder></td></tr></table>
				                    <input type="hidden" id="txtImageVersion" runat="server" />
				                    <input type="hidden" id="txtImageFileName" runat="server" /><br/>
				     		    </ItemTemplate>
						    </asp:datalist></TD>
				    </TR>
			    </TABLE>
			    <input id="imageSize" type="hidden" runat="server">
			</asp:Panel>
		</form>
	</body>
</HTML>
