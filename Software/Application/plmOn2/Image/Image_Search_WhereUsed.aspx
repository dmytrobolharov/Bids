<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Search_WhereUsed.aspx.vb" Inherits="plmOnApp.Image_Search_WhereUsed" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Image_Folder_WhereUsed</title>
		
		
		
		
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .font
            {
                white-space:nowrap;    
            }
            .TableHeader
            {
                background-position :center;
                background-color: White;
            }
        </style>
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		
			<asp:Panel runat="server" ID="pnlPerm" Visible=false>
				<table style="height:50;" cellspacing="0" cellpadding="0" width="100%"  bgColor="#990000" border="1" borderColor="red">
					<tr>
						<td>
                            <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                    <td><asp:Label ID="lblPerm" runat="server" 
                                        Text="You might not have permission to access user groups using your credentials." 
                                        CssClass="fontHead" ForeColor="White"></asp:Label></td>
                                </tr>
                            </table>
                          </td>
                      </tr>
                  </table>			
			</asp:Panel>
			<asp:Panel runat="server" ID="pnlMain">		
		
			    <TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				    runat="server">
				    <tr vAlign="middle">
					    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					    <td>
					        <asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
					        <cc1:confirmedimagebutton id="imgBtnNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					        <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
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
						    <TABLE id="Table3" height="45">
							    <TR>
								    <TD><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
							    </TR>
						    </TABLE>
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
						    <DIV align="left"><B><asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label>
						     </B>
                            </DIV>
					    </TD>
					    <TD height="25">
						    <P align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist><asp:dropdownlist id="ddlSortBy" runat="server">
							    </asp:dropdownlist><asp:imagebutton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif" CausesValidation="false"></asp:imagebutton></P>
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
