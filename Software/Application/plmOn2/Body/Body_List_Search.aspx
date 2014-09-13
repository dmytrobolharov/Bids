<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_List_Search.aspx.vb" Inherits="plmOnApp.Body_List_Search" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Body Search</title>
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
    <asp:Panel runat="server" ID="pnlPerm" Visible="false">
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
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px"
							Height="0px"></asp:imagebutton>
						<cc1:bwimagebutton id="btnNew" runat="server" Message="NONE"></cc1:bwimagebutton>
                        <cc1:bwimagebutton id="btnCopy" runat="server" Message="NONE"></cc1:bwimagebutton>
						<cc1:confirmedimagebutton id="imgBtnClose" runat="server" Message="NONE" Visible="False"></cc1:confirmedimagebutton></td>
				</tr>
			</TABLE>
			<table id="Table4" style="BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				    height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				    <tr>
					    <td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Image Folder...</asp:label></td>
				    </tr>
			</table>
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
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
			<asp:PlaceHolder id="phBody" runat="server"></asp:PlaceHolder>
			<asp:PlaceHolder id="phBodyGrid" runat="server"></asp:PlaceHolder>
        </asp:Panel>
    </form>
</body>
</html>
