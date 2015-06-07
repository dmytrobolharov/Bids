<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_FitPhoto_Delete.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_FitPhoto_Delete" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Delete</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body bgcolor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnDelete" runat="server"  Message=""></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</TABLE>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0" height="35" bgcolor="#ffffff">
				<TR>					
					<TD><asp:CheckBox id="cbDeleteAll" runat="server" CssClass="fontRed" Visible="true"></asp:CheckBox></TD>
				</TR>
			</TABLE>
            <asp:DataList id="DataList1" RepeatLayout="Flow" RepeatDirection="Vertical" runat="server" DataKeyField="FitPhotoID">
                <ItemTemplate>
			    <asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
				    PageSize="1000" AutoGenerateColumns="False" DataKeyField="FitPhotoID">
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				    <HeaderStyle Height="20px" CssClass="TableHeader" HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>
				    <Columns>
					    <asp:TemplateColumn>
						    <ItemTemplate>
							    <asp:CheckBox ID="chkDeleteFitPhoto" runat="server" />
						    </ItemTemplate>
					    </asp:TemplateColumn>
				    </Columns>
			    </asp:datagrid>
			    <asp:datagrid id="DataGrid2" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
				    PageSize="1000" AutoGenerateColumns="False" DataKeyField="FitPhotoCommentId">
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				    <HeaderStyle Height="20px" CssClass="TableHeader" HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>
				    <Columns>
					    <asp:TemplateColumn>
						    <HeaderTemplate>
							    <asp:CheckBox id="checkAllComment" runat="server" name="checkAll" />
						    </HeaderTemplate>
						    <ItemTemplate>
							    <asp:CheckBox ID="chkDeleteComment" runat="server" />
						    </ItemTemplate>
					    </asp:TemplateColumn>
				    </Columns>
			    </asp:datagrid>
                </ItemTemplate>
            </asp:DataList>
            <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
            <script type="text/javascript">
                $("#cbDeleteAll").on("change", function () { $("input[id^='DataList1']:checkbox").prop("checked", $(this).prop("checked")); });
                $("input[id*='chkDeleteFitPhoto']").on("change",
                function () {
                    $(this).parents("[id*='DataGrid1']").parent().find("input[id*='checkAllComment']").prop("checked", $(this).prop("checked"));
                    $(this).parents("[id*='DataGrid1']").parent().find("input[id*='chkDeleteComment']").prop("checked", $(this).prop("checked"));
                    if ($(this).prop("checked") == false) { $("#cbDeleteAll").prop("checked", $(this).prop("checked")); };
                });
                $("input[id*='checkAllComment']").on("change",
                function () {
                    $(this).parents("[id*='DataGrid2']").find("input[id*='chkDeleteComment']").prop("checked", $(this).prop("checked"));
                    if ($(this).prop("checked") == false) { $("#cbDeleteAll").prop("checked", $(this).prop("checked")); };
                });
                $("input[id*='chkDeleteComment']").on("change",
                function () {
                    if ($(this).prop("checked") == false) {
                        $("#cbDeleteAll").prop("checked", $(this).prop("checked"));
                        $(this).parents("[id*='DataGrid2']").parent().find("input[id*='checkAllComment']").prop("checked", $(this).prop("checked"));
                        $(this).parents("[id*='DataGrid2']").parent().find("input[id*='chkDeleteFitPhoto']").prop("checked", $(this).prop("checked"));
                    };
                });
            </script>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
