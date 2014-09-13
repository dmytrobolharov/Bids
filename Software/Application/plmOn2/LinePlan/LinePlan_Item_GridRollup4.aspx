<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_GridRollup4.aspx.vb" Inherits="plmOnApp.LinePlan_Item_GridRollup4" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register src="LinePlanningHeader.ascx" tagname="LinePlanningHeader" tagprefix="uc1" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Line Planning</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />        
</head>
<body>
    <form id="form1" runat="server">
	    <table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><cc1:bwimagebutton id="btnCosting" runat="server" ></cc1:bwimagebutton>
                    <cc1:bwimagebutton id="btnColorway" runat="server" ></cc1:bwimagebutton>
			        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                </td>
			    <td class="FontHead" align="right" width="75"></td>
			    <td width="40"></td>
			    <td></td>
		    </tr>
	    </table>
	    <uc1:LinePlanningHeader ID="LinePlanningHeader1" runat="server" />    
		<br>
		<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>	
        <table cellSpacing="0" cellPadding="0" border="0" width="100%">
            <tr class="TableHeader">
                <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                <td align="left"><asp:Panel ID="pnlLinePlanBreadCrumb" runat="server"></asp:Panel></td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <asp:Panel ID="pnlLinePlanRange" runat="server"></asp:Panel>	

        <br />
        
        <table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
        <tr vAlign="middle">
		    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>  
		</tr>
        </table>
        
		 <br /><br />           
       	 <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
			<tr>
				<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
				<td width="100%" vAlign="top">
					<TABLE id="Table3" height="45">
						<TR>
							<TD>
								<asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></TD>
						</TR>
					</TABLE>
				</td>
			</tr>
		</table>
		<br />
		        
        <table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
            <tr>
                <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                <td width="300px">
                    <asp:RadioButtonList ID="rbRangeType" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" Height="20px">
                    </asp:RadioButtonList>
                </td>  
                <td>
                    <asp:RadioButtonList ID="rbViewer" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" Height="20px">
                        <asp:ListItem Text="List View&nbsp;&nbsp;" Value="ListView" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Thumb View&nbsp;&nbsp;" Value="ThumbView"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>        
        <asp:Panel ID="pnlStyle" runat="server"></asp:Panel>	  
        	    
    </form>
</body>
</html>
