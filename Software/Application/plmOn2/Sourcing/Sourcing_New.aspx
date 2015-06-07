<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_New.aspx.vb" Inherits="plmOnApp.Sourcing_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>    
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">

		<table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click();" ></cc1:confirmedimagebutton></td>
				</tr>
			</table>	
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#999999" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Sourcing ...</asp:label></td>
				</tr>
			</table>
            <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                    <td width="125" align="right" nowrap="nowrap">
                       <asp:Label runat="server" ID="lblStyleSeasonYear" class="fontHead" >Select Season / Year</asp:Label> 
                    </td>
                    <td>
                       <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList> 
                    </td>
                </tr>
            </table>		
			<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>			
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
						<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
		                <ItemTemplate>
			                &nbsp;&nbsp;<asp:CheckBox Runat="server" ID="chkStyleColor"></asp:CheckBox>&nbsp;<asp:Label Runat="server" ID="lblStyleColor" Text='<%# string.Concat( DataBinder.Eval(Container.DataItem, "MainColor").ToString ) %>' CssClass="font"></asp:Label>
		                </ItemTemplate>
	                </asp:DataList>
	            </td>
		    </tr>
			</table>

			<script language="javascript">
				var frm = document.form1 ;
				function CheckAll( checkAllBox ) {
					var actVar = checkAllBox.checked ;
					for(i=0;i< frm.length;i++){
						e=frm.elements[i];
						if ( e.type=='checkbox' && e.name.indexOf("chkStyleColor") != -1 )
						e.checked= actVar ;
					}
                }
                function btnClose_Click() {
                    <%= strExitScript %>
                    return false;
                }
			</script>
			
			
    </form>
</body>
</html>
