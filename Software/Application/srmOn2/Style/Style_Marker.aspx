<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Marker.aspx.vb" Inherits="srmOnApp.Style_Marker" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Style - Marker</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form2" runat="server">
    <!-- Toolbar -->
    <uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow><asp:panel id="pnlChange" runat="server">
		</asp:panel><uc2:style_header id=Style_Header1 runat="server">
		</uc2:style_header>
				<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
				<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
			</tr>
		</table><br />
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
    <br />
    <!-- HEADER -->
    <!-- Model List View -->
  
          	<asp:datagrid id="Datagrid2" runat="server" AllowSorting="False" AutoGenerateColumns="false" DataKeyField="ID" width="1800px">
				<AlternatingItemStyle Height="25px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="25px" CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
                    <Columns>
		                 <asp:TemplateColumn ItemStyle-Width="25" >                           
                            <HeaderTemplate>
                                <DIV align="center">
									        <asp:Label id="lblLink" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></DIV>
					        </HeaderTemplate>
                            <ItemTemplate>                 
                                <asp:Image id="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" Visible='<%# DisplayLinkedVisible(Container.DataItem("IsLinked")) %>' ToolTip='<%#GetSystemText("Linked")%>'/>
                            </ItemTemplate>
                         </asp:TemplateColumn>
                         <%--<asp:TemplateColumn>
                            <HeaderTemplate>
                              <DIV align="center">
									        <asp:Label id="lblLinkBF" runat="server" CssClass="fontHead"><%#GetSystemText("LBF")%></asp:Label></DIV>
					         </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image id="ImgLinkedBF" runat="server" ImageUrl="../System/Icons/icon_folderLinked.gif" Visible='<%# DisplayBF(Container.DataItem("IsLinkedBF")) %>' ToolTip='<%#GetSystemText("Linked to Body Folder")%>'/>
                         
                            </ItemTemplate>
                        </asp:TemplateColumn>--%>
                    </Columns>     			
        	
            </asp:datagrid>
           
    
    
     <asp:Label ID="SortOrder2" runat="server" Visible="False"></asp:Label>
    <br />
    <br />
 
    <asp:Label ID="lblSummary"  runat="server" Font-Names="Tahoma,Verdana" 
            Font-Size="Large" ForeColor="#666666">Marker Spreadsheet</asp:Label>
    <br />
    <br />
    
          <asp:datagrid id="Datagrid1" runat="server" AllowSorting="True" 
         AutoGenerateColumns="true" BorderColor="Gainsboro" BorderStyle="None" 
            BorderWidth="1px">
        <AlternatingItemStyle Height="20px" Width="50px" CssClass="AlternateItemTemplate">
        </AlternatingItemStyle>
        <ItemStyle Height="20px" Width="50px" CssClass="ItemTemplate" BorderColor="Gainsboro" 
                  BorderWidth="1px"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader" BorderColor="Gainsboro" 
                  BorderWidth="1px"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
					<Columns>
	                    
		                       
	                </Columns>    
	    </asp:datagrid>  
	    <asp:Label ID="SortOrder1" runat="server" Visible="False"></asp:Label>
    </form>
</body>
</html>


