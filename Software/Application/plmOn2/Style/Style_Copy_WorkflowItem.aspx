<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Copy_WorkflowItem.aspx.vb" Inherits="plmOnApp.Style_Copy_WorkflowItem" %>
<%@ Register TagPrefix="uc1" TagName="Style_Copy_Workflow" Src="Style_Copy_Workflow.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
		<title id="titleCopy" runat="server">Copy</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25" border="0">
				<tr>
					<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnCopy" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnLink" visible="false" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<%--<cc1:confirmedimagebutton id="btnBack" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_wiz_back.gif" Message="NONE"></cc1:confirmedimagebutton>--%>
					<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<uc1:Style_Copy_Workflow id="Style_Copy_Workflow1" runat="server"></uc1:Style_Copy_Workflow>
			<uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			

            <br />
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                    <td>
                    &nbsp;
                    </td>
                    <td>
                        <asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="WorkFlowItemID">
                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                            <ItemStyle Height="20px" Wrap="false" CssClass="ItemTemplate"></ItemStyle>
                            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                            <PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                                <asp:TemplateColumn HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                    <HeaderTemplate >
                                        <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                                    </HeaderTemplate>                        
                                </asp:TemplateColumn>               
                        </Columns>
                        </asp:datagrid>   
                    </td>
                </tr>
            </table>
		</form>
        <script type="text/javascript" language="javascript">
            var frm = document.Form1;
            function SelectAll(checkAllBox) {
                var actVar = checkAllBox.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox' && e.name.indexOf("chbWorkFlowItemID") != -1)
                        e.checked = actVar;
                }
            }

	    </script>  

	</body>
</html>
