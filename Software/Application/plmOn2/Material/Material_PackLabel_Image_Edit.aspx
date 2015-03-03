<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_PackLabel_Image_Edit.aspx.vb" Inherits="plmOnApp.Material_PackLabel_Image_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE">
					    </cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnUpdate" runat="server"  Message="NONE"
							Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnCancelUpdate" runat="server"  Message="NONE"
							Visible="False"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"
							CausesValidation="False"></cc1:confirmedimagebutton></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0">Packaging And Label Image...</asp:label></td>
				</tr>
			</table>			
			
			<table style="BACKGROUND-COLOR: white" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:PlaceHolder  runat ="server" ID="phHeader" ></asp:PlaceHolder></td>
				</tr>
			</table>			


			<table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="whitesmoke" border="0">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="imgBtnFolderImage" runat="server"
							Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnEditImage" runat="server" 
							Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server" 
							CausesValidation="False"></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			
			
			<table  cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr >
			 <td valign="top" align="center" width="650"><asp:panel id="pnlFileLocked" runat="server" Visible="False">
				    <table cellSpacing="0" cellPadding="1" width="600" bgColor="#ea0000" border="0">
					    <tr>
						    <td width="10">&nbsp;</td>
						    <td width="20"><IMG height="16" src="../System/Icons/icon_lock.gif" width="16"></td>
						    <td>&nbsp;
							    <asp:Label id="lblFileLocked" runat="server" ForeColor="White" CssClass="fontHead"></asp:Label></td>
					    </tr>
				    </table>
			    </asp:panel>			
			    <asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
			</td>
			<td width="10">&nbsp;</td>
			<td valign="top">
			    <asp:Label ID="lblDescription" runat ="server" CssClass="fontHead">Description</asp:Label>
			    <br />
			    <asp:TextBox id="txtDescription" runat="server" CssClass="font" MaxLength="200"> </asp:TextBox>
			    <br />
			    <asp:Label ID="lblNotes" runat ="server" CssClass="fontHead">Notes</asp:Label>
			    <br/>
			    <asp:TextBox ID="txtNotes" runat ="server"  CssClass="font" Columns="20" TextMode="MultiLine" Height="400px" Width="350" ></asp:TextBox>
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
