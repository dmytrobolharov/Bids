<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlanningAttribute_Add.aspx.vb" Inherits="plmOnApp.LinePlanningAttribute_Add" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Attributes</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet"/>
	<script  type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js" ></script>
</head>
<body>
    <form id="form1" runat="server">
	    <TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <TR vAlign="middle">
			    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			    <TD><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
                    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton></TD>
			    <td>&nbsp;</td>
			    
		    </TR>
	    </TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Attributes</asp:label></td>
				</tr>
			</table>
			<br />
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
			    border="0">
			    <TR vAlign="middle">
				    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				    <TD width="16">&nbsp;</TD>
				    <TD class="fontHead" width="100">&nbsp;</TD>
				    <TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
				    <TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
				    <TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
				    <TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
				    <TD width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
				    <TD width="10">&nbsp;</TD>
				    <TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
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
				    <TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
			    </TR>
		    </TABLE>
						
			
			<table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>            
						
				    
			<br />
            <asp:datagrid id="DataGrid1" runat="server"  DataKeyField="AttributeID">
			    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
			    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
			    <HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
			    <PagerStyle Visible="False"></PagerStyle>
			    <Columns>
			        <asp:TemplateColumn>
			            <HeaderTemplate>
			                <input type="checkbox" onclick="CheckAll(this)" id="chkSelAll" />
			            </HeaderTemplate>
			            <ItemTemplate>
			                <input type="checkbox" runat="server" id="chkSelected" />
			                <input type="hidden" runat ="server"  id="hdnTypeID" />
			                <input type="hidden" runat ="server"  id="hdnAttributeName" />
			            </ItemTemplate>
			        </asp:TemplateColumn>
			    </Columns>
		    </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>			

    </form>
    <script language="javascript">
        var frm = document.form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
                    e.checked = actVar;
            }
        }
		</script>
</body>
</html>
