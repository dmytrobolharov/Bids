<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Document_Activity.aspx.vb"
    Inherits="plmOnApp.Style.Document.Style_Document_Activity" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title>Attachment Activity</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
   
</head>
<body>
 
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" 
                    Visible="True" CausesValidation="False"></cc1:ConfirmedImageButton>
                                 
               
            </td>
            <td class="fontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td valign="middle">
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana">Attachment Activity</asp:Label>
            </td>
        </tr>
    </table>
    
    <asp:datagrid id="dgActivity" runat="server" Width="600px" BorderColor="Silver" BorderStyle="Solid"
							BorderWidth="1px" AutoGenerateColumns="False" ShowHeader="true" DataKeyField="StyleDocumentActivityID">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplateYellow"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplateYellow"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
								<HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Log No") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblActivityNo" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn >
								    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Date") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblActivityDate" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn >
								<HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("User") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblActivityUser" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn >
								    <HeaderTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Description") %>'></asp:Label>
								    </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblActivityDescription" runat="server" CssClass="font" />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
    
   
    </form>

</body>



</html>
