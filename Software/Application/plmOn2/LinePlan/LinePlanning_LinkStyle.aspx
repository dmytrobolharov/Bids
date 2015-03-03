<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlanning_LinkStyle.aspx.vb" Inherits="plmOnApp.LinePlanning_LinkStyle" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Line Planning</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">

    
		<table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<tr vAlign="middle">
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td><cc1:confirmedimagebutton id="btnNext" runat="server" Message="NONE" Visible="true"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton  id="btnClose"  Message="NONE" runat="server" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
			</tr>
		</table>
		
		<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material</asp:label></td>
			</tr>
		</table>
		
    
            <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>            
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr valign="top">
		            <td>
			            <table  class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <tr valign="middle">
					            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td class="fonthead" width="10">&nbsp;</td>
					            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
					            <td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fonthead"></asp:label></td>
					            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></td>
					            <td width="10">&nbsp;</td>
					            <td width="100"><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>				
					            <td class="fonthead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></td>
					            <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fonthead">
							            <asp:ListItem Value="5">5</asp:ListItem>
							            <asp:ListItem Value="10">10</asp:ListItem>
							            <asp:ListItem Value="15">15</asp:ListItem>
							            <asp:ListItem Value="20">20</asp:ListItem>
							            <asp:ListItem Value="25">25</asp:ListItem>
							            <asp:ListItem Value="30">30</asp:ListItem>
							            <asp:ListItem Value="40">40</asp:ListItem>
							            <asp:ListItem Value="50" Selected="true">50</asp:ListItem>
						            </asp:dropdownlist></td>
					            <td width="10"><asp:button id="Button1" runat="server" CssClass="fonthead" text="GO"></asp:button></td>
					            <td>&nbsp;</td>
				            </tr>
			            </table>
            			
			            <table width="100%" >
			            <tr>
			                <td>
			                    
                                <asp:datagrid id="DataGrid1" runat="server"  EnableViewState="true" DataKeyField="MaterialCoreID">
                                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                                    </AlternatingItemStyle>
                                    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                                    <headerStyle Height="25px" CssClass="tableheader"></headerStyle>
                                    <PagerStyle Visible="False"></PagerStyle>
                                    <Columns>
                                        <asp:TemplateColumn>
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblSelect" />
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:datagrid>
                                <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			                    
			                </td>
			            </tr>
			            </table>
            			
		            </td>
	            </tr>
            </table>    

    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
