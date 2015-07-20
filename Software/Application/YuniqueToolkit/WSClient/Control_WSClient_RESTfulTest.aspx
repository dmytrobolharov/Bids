<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_WSClient_RESTfulTest.aspx.vb" Inherits="YuniFace.Control_WSClient_RESTfulTest" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<title runat="server" id="PageTitle">RESTful Test</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10">
					    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
					    <asp:imagebutton id="btnInvSearch" tabIndex="0" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
					</td>
					<td>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
			        </td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">RESTful Test</asp:label></td>
				</tr>
			</table>

            <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td>

		                <asp:Label id="lblIntro" runat="server" CssClass="fontHead">Use this form to run RESTful calls against a YuniquePLM system.</asp:Label>
                        <br />
                        <br />

                        <table style="width:100%;">

<%--
                            <tr>
                                <td class="fontHead" bgcolor="#66FF66">
                                    <asp:Label id="lblWSClientID" runat="server" CssClass="fontHead">WSClientID</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:TextBox ID="txtWSClientID" runat="server" Width="312px" Enabled="false"></asp:TextBox>
                                    GUID in uWebServiceClient
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="fontHead" bgcolor="#66FF66">
                                    <asp:Label id="lblWSClientPassword" runat="server" CssClass="fontHead">WSClientPassword</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:TextBox ID="txtWSClientPassword" runat="server" Width="310px" TextMode="Password"></asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
--%>
                            <tr>
                                <td class="fontHead" bgcolor="#66FF66">
                                    <asp:Label id="lblPLMUserName" runat="server" CssClass="fontHead">PLMUserName</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:TextBox ID="txtPLMUserName" runat="server" Width="312px"></asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="fontHead" bgcolor="#66FF66">
                                    <asp:Label id="lblUserPassword" runat="server" CssClass="fontHead">PLMUserPassword</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:TextBox ID="txtUserPassword" runat="server" Width="312px" TextMode="Password"></asp:TextBox>&nbsp;* Required
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="fontHead" bgcolor="#66FF66">
                                    <asp:Label id="lblCRUDType" runat="server" CssClass="fontHead">CRUD Type</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:DropDownList ID="ddlCRUD" runat="server" AutoPostBack="True" Height="21px" Width="312px">
                                        <asp:ListItem>List</asp:ListItem>
                                        <asp:ListItem>Create</asp:ListItem>
                                        <asp:ListItem>Read</asp:ListItem>
                                        <asp:ListItem>Update</asp:ListItem>
                                        <asp:ListItem>Delete</asp:ListItem>
                                        <asp:ListItem>Schema</asp:ListItem>
                                        <asp:ListItem>Copy</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="fontHead" bgcolor="#FFFF66">
                                    <asp:Label id="lblOrderBy" runat="server" CssClass="fontHead">Order By</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:TextBox ID="txtOrderBy" runat="server" Width="312px"></asp:TextBox>
                                    Prefix with &#39;Order By&#39;
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="fontHead" bgcolor="#FFFF66">
                                    <asp:Label id="lblPageNumber" runat="server" CssClass="fontHead">Page Number</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:TextBox ID="txtPageNumber" runat="server" Width="312px">1</asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="fontHead" bgcolor="#FFFF66">
                                    <asp:Label id="lblPageSize" runat="server" CssClass="fontHead">Page Size</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:TextBox ID="txtPageSize" runat="server" Width="310px">25</asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="fontHead" bgcolor="#FFFF66">
                                    <asp:Label id="lblSkipLookupTables" runat="server" CssClass="fontHead">Skip Lookup Tables</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:TextBox ID="txtSkipLookupTables" runat="server" Width="312px">0</asp:TextBox>
                                    Boolean using &#39;0&#39; or &#39;1&#39;
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="fontHead" id="lblParams" bgcolor="#FFCC00">
                                    <asp:Label id="lblParams" runat="server" CssClass="fontHead">Params</asp:Label>
                                </td>
                                <td class="font">
                                    <asp:TextBox ID="txtParams" runat="server" Width="671px" Height="50px" TextMode="MultiLine"></asp:TextBox>
                                </td>
                                <td>&nbsp;</td>
                            </tr>

                            <tr>
                                <td class="fontHead">&nbsp;</td>
                                <td class="font">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="fontHead">
                                    <cc1:confirmedimagebutton id="btnExecute" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                                </td>
                                <td class="font">
                                    <asp:Label id="lblResultSet" runat="server" CssClass="fontHead">Result Set:</asp:Label>&nbsp;
                                    <asp:DropDownList ID="ddlViews" runat="server" AutoPostBack="True" Width="147px" />
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                      </table>

                    </td>
				</tr>

                <tr>
                    <td>
                        <br />
                        <div id="divResults" style="overflow:scroll; width:100%; height:400px;">
                            <asp:MultiView ID="mvResults" runat="server">
                            </asp:MultiView>
                        </div>
                        <br />
                    </td>
                </tr>
			</table>

	    </form>
	</body>
</html>
