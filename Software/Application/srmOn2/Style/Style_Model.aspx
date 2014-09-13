<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Model.aspx.vb" Inherits="srmOnApp.Style_Model" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Style - Model</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
    <!-- Toolbar -->
    
    <uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow>
    <uc2:style_header id=Style_Header1 runat="server">
		</uc2:style_header>
				<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
				<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
			</tr>
		</table>
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>

                <asp:CheckBox valign="top" align="center" ID="chbImperial" autopostback="true"  runat="server" Text="Imperial" CssClass="fontHead" />
            </td>
        </tr>
    </table>

  <asp:datagrid id="DataGrid1" runat="server" DataKeyField="ID" AllowSorting="True"
	   AutoGenerateColumns="False">
		<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
		<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
		<headerStyle Height="25px" CssClass="TableHeaderRed"></headerStyle>
		<PagerStyle Visible="False"></PagerStyle>		
            <Columns>
		         <asp:TemplateColumn ItemStyle-Width="25">
                   <ItemStyle Height="20px" Width="50px" CssClass="ItemTemplate" BorderWidth="1pt" BorderColor="Gainsboro" BorderStyle="Solid"></ItemStyle>
                    <HeaderStyle CssClass="TableHeader" BorderColor="Gainsboro"  />
                    <HeaderTemplate>
                        <DIV align="center">
									<asp:Label id="lblLink" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></DIV>
					</HeaderTemplate>
                    <ItemTemplate>                 
                        <asp:Image id="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" Visible='<%# DisplayLinkedVisible(Container.DataItem("IsLinked")) %>' ToolTip='<%#GetSystemText("Linked")%>'/>
                    </ItemTemplate>
                 </asp:TemplateColumn>
                 <%--<asp:TemplateColumn >
                   <ItemStyle Height="20px" Width="50px" CssClass="ItemTemplate" BorderWidth="1pt" BorderColor="Gainsboro" BorderStyle="Solid"></ItemStyle>
                    <HeaderStyle CssClass="TableHeader" BorderColor="Gainsboro"  />
                    <HeaderTemplate>
                      <DIV align="center">
									<asp:Label id="lblLinkBF" runat="server" CssClass="fontHead"><%#GetSystemText("LBF")%></asp:Label></DIV>
					 </HeaderTemplate>
                    <ItemTemplate>
                     <asp:Image id="ImgLinkedBF" runat="server" ImageUrl="../System/Icons/icon_folderLinked.gif" Visible='<%# DisplayBF(Container.DataItem("IsLinkedBF")) %>' ToolTip='<%#GetSystemText("Linked to Body Folder")%>'/>
                 
                    </ItemTemplate>
                </asp:TemplateColumn>--%>
            </Columns>  
       		
   </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>

    </form>
</body>
</html>
