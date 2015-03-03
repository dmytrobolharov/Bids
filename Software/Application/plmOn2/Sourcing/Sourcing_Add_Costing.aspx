<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Add_Costing.aspx.vb" Inherits="plmOnApp.Sourcing_Add_Costing" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <script>
    function btnClose_Click() {
        <%= strExitScript %>
        return false;
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">

	    <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" >
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" 
                         style="height: 24px"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
			    id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click();"></cc1:confirmedimagebutton></td>
		    </tr>
	    </table>

        <table cellSpacing="0" cellPadding="0" width="370" border="0" >
        <tr>
        <td width="20">&nbsp;</td>
        <td >
            <table  cellSpacing="0" cellPadding="0" width="350" border="0" >
            <tr><td>
                <asp:Label ID="lblCosting" runat="server"  CssClass="fontHead">Select Costing type:</asp:Label>
                <br />
                <asp:RadioButtonList  runat="server" ID="rblCosting" > 
                </asp:RadioButtonList>
                <asp:Label ID="lblCostingMessage" runat="server" CssClass="fontHead" ForeColor="Red" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
            <td>
                <br />
                <asp:Label ID="lblColorway" runat="server"  CssClass="fontHead"></asp:Label>
                <asp:datagrid id="dgStylecolor" runat="server" DataKeyField="StyleColorID" AutoGenerateColumns="False" Width="80%" ShowHeader="False" BorderWidth="1">
                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
    		    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>

		        <Columns>
			        <asp:TemplateColumn>
				        <ItemStyle Width="25" HorizontalAlign="Center" ></ItemStyle>
				        <ItemTemplate>
					        <asp:checkbox Runat="server" ID="chkSelect"></asp:checkbox>
				        </ItemTemplate>
			        </asp:TemplateColumn>
			        <asp:TemplateColumn>
				        <ItemStyle ></ItemStyle>
				        <ItemTemplate>
					        <asp:Label Runat="server" ID="lblStyleColor" CssClass="font" Text='<%# string.Concat( DataBinder.Eval(Container.DataItem, "MainColor").ToString ) %>' ></asp:Label>
				        </ItemTemplate>
			        </asp:TemplateColumn>
		        </Columns>
		        <PagerStyle Visible="False"></PagerStyle>
	            </asp:datagrid>
            </td>
            </tr>
            </table>
        </td>
        </tr>
        </table>

    </form>
</body>
</html>
