<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DimensionalBOMMaterial_ColorSelect.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOMMaterial_ColorSelect" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Material</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td align="center" width="10" height="25"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td> 
                <td>&nbsp;<asp:Label ID="lblColorPalette" runat="server"></asp:Label>&nbsp;&nbsp;
                <asp:checkbox id="chkAllColor" visible="false" runat="server" ></asp:checkbox>&nbsp;&nbsp;
                <cc1:confirmedimagebutton id="btnClearAll" visible="false" runat="server" /> &nbsp;&nbsp;
                <cc1:confirmedimagebutton id="btnClear" runat="server" /> </td>
                <td>&nbsp;</td>                
            </tr>
        </table>		    
    
        <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
			<TR vAlign="top">
				<TD>
                   <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
						<tr>
							<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
							<td vAlign="top" width="100%">
								<table height="45">
									<tr>
										<td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>				
					<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
						border="0">
						<TR vAlign="middle">
							<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
							<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
							<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
							<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
							<TD width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
							<TD width="10">&nbsp;</TD>
							<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></TD>
							<TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></TD>
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
							<TD width="10"><asp:button id="Button1" runat="server" CssClass="fontHead" Text="GO"></asp:button></TD>
						</TR>
					</TABLE>					
					<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="MaterialColorID">
						<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="font"></ItemStyle>
						<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
						<PagerStyle Visible="False"></PagerStyle>
						<Columns>						    
		                    <asp:TemplateColumn>
		                        <ItemStyle Width="50px"></ItemStyle>
		                        <ItemTemplate>
		                            <cc1:confirmedimagebutton id="imgColor" runat="server"  CommandName="Select" Message="NONE" /> 			                                                      
		                        </ItemTemplate> 
		                    </asp:TemplateColumn>
		                </Columns>
					</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
			</TR>
		</TABLE>        
    </form>
    <script type="text/javascript">
        function UpdateText(strcolorid, strcolorname) {
            var frm = window.opener.document.Form1;
            if (frm != null) {
                if (frm.txtColorSel != null) {
//                    alert('colorid:' + strcolorid);
                    frm.txtColorSel.value = strcolorname;
                }
                if (frm.hdnColorName != null) {
                    frm.hdnColorName.value = strcolorid;
                }
            }
            window.close();
        }				    
	</script>	    
</body>
</html>
