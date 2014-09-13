<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_AddColor.aspx.vb" Inherits="plmOnApp.Sourcing_AddColor" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <form id="form1" runat="server">

    
	    <table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
			    id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
		    </tr>
	    </table>
	    <BR>
	    <table style="BORDER-TOP: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
		    cellSpacing="2" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
		    <tr>
			    <td><br>
				    <asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
		    </tr>
	    </table>
	    <br>
	    <br>
	    <br>
	    <br>


        <table cellpadding="0" cellspacing="0" >
		<tr class="TableHeader" height="20" valign="middle">
		    <td><table  cellSpacing="0" cellPadding="0" width="400" border="0">
			    <tr vAlign="middle">
				    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				    <td>
					    <input type="checkbox" ID="chkAll" onclick="CheckAll(this)">&nbsp;&nbsp;<asp:Label Runat="server" ID="lblSelColorway" CssClass="fontHead"></asp:Label>
				    </td>
			    </tr>
			    </table>
			 </td>
		</tr>	 
	    <tr valign="top" >
	        <td><asp:DataList Runat="server" ID="dgStylecolor" DataKeyField="StyleColorID" Width="100%">
	                <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro"></ItemStyle>
	                <ItemTemplate>
		                &nbsp;&nbsp;<asp:CheckBox Runat="server" ID="chkStyleColor"></asp:CheckBox>&nbsp;<asp:Label Runat="server" ID="lblStyleColor" Text='<%# string.Concat( DataBinder.Eval(Container.DataItem, "MainColor").ToString ) %>' CssClass="font"></asp:Label>
	                </ItemTemplate>
                </asp:DataList>
            </td>
	    </tr>
		</table>
			

		<SCRIPT language="javascript">
			var frm = document.form1 ;
			function CheckAll( checkAllBox ) {
				var actVar = checkAllBox.checked ;
				for(i=0;i< frm.length;i++){
					e=frm.elements[i];
					if ( e.type=='checkbox' && e.name.indexOf("chkStyleColor") != -1 )
					e.checked= actVar ;
				}
			}
		</SCRIPT>

    </form>
</body>
</html>
