<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_AttributePlanning.aspx.vb" Inherits="plmOnApp.LinePlan_Item_AttributePlanning" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Range Planning Attributes</title>
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">    
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">

		<table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<tr vAlign="middle">
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" style="height: 24px">
    				</cc1:confirmedimagebutton><asp:ImageButton runat="server" ID="btnClose" OnClientClick="return btnClose_Click()"></asp:ImageButton></td>
				<td class="FontHead" align="right" width="75"></td>
				<td width="40"></td>
				<td></td>
			</tr>
			<tr>
			    <td colspan="5" align="center"><asp:Label runat="server" ID="lblMsg" CssClass="fontRed"></asp:Label></td>
            </tr>
		</table>
	
        <asp:DataList runat="server" ID="dlAttributes" DataKeyField="LinePlanStyleAttributeID" >
                <ItemTemplate>
                        <table  border="0" width ="600">
                            <tr><td><br /><br /> 
                        <asp:datagrid id="DataGrid1" runat="server" PageSize="1000" OnItemDataBound="dataGrid1_ItemDataBound" ShowFooter="False" 
                        DataKeyField="LinePlanRangeAttributeID" CellPadding="0" CellSpacing="2" BorderWidth="0" CssClass="fontHead" BackColor="#DFDFDF">
                        <ItemStyle BorderStyle="Solid" BorderWidth="1" BorderColor="Black" BackColor="White"></ItemStyle>
                        <HeaderStyle CssClass="fontHead"></HeaderStyle>
                        
                        <Columns>
	                        <asp:TemplateColumn>
		                        <HeaderTemplate>
                                    </td>
                                        <td align="center" height="20px">&nbsp;</td>
                                        <td runat="server" id="tdDel1" class="TableHeaderBlue" align="center" height="20px" 
                                            colspan="3"><asp:label runat="server" ID="lblAttribute"></asp:label></td>
                                    </tr>
                                    <td height="18px">&nbsp;</td>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdDataType" runat="server" />
                                    <asp:HiddenField ID="hdDataFormat" runat="server" />
                                </ItemTemplate>
                                <FooterTemplate>
                                <tr>
                                     <td height="50" bgcolor="White"></td>   
                                     <td colspan="14" bgcolor="White">&nbsp;</td>
                                </tr>  
                                </FooterTemplate>
                            </asp:TemplateColumn>
                       </Columns> 
                </asp:datagrid>                        
                            
                            
                            </td>
                            </tr>
                        </table>
            </ItemTemplate>
        </asp:DataList>
    

    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
