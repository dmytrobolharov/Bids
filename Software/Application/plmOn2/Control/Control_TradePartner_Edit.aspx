<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_TradePartner_Edit.aspx.vb"
    Inherits="plmOnApp.Control_TradePartner_Edit" %>

<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Trading Partner</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/CheckListDropDown.css" type="text/css" rel="stylesheet"/>		
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../System/Jscript/arc90_multiselect.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	<script language="javascript" type="text/javascript">
	    // change the default options for all multiselects
	    a$.NO_SELECTION = 'No selection'; 	// TEXT for 'No selection' when nothing selected
	    a$.SELECTED = 'items selected'; // TEXT for 'XX Options selected' when over 1 selected
	    a$.SELECT_ALL = 'Select All'; 		// TEXT for 'Select All' for checkboxes
	    a$.SelectAllMin = 3; 				// minimum number of options needed to show 'Select All'
	    a$.WhenToUse = 'class'; 			// class | multiple | all : for how to make selects become multiselects
	    a$.msSeparator = '|'; 				// separator for values (can be multiple characters)
	</script>	

    <script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
    </script>

</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td width="100%">
                <cc2:ConfirmedImageButton ID="btnSaveUser" runat="server"  Message="NONE"></cc2:ConfirmedImageButton>
                <cc2:BWImageButton ID="btnPassword" runat="server"  ToolBar="False" Status="False" ScrollBars="False" Resizable="False" MenuBar="False" Location="False" WindowHeight="250px" WindowWidth="600px" WindowName="Control_TradePartner_Edit_Password" NavigateUrl="Control_TradePartner_Edit_Password.aspx">
                </cc2:BWImageButton>
                <cc2:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc2:ConfirmedImageButton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top" colspan="2" height="50">
                            <asp:Label ID="lblTradeName" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                                ForeColor="#E0E0E0"></asp:Label>&nbsp;
                        </td>
                        <td valign="top" height="50">
                        </td>
                    </tr>
                </table>
                <table id="Table2" cellspacing="2" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>

                </table>
                <br>
                <cc1:YSTabView ID="YSTabView1" runat="server"></cc1:YSTabView>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlContact" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr>
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="100%">
                    <cc2:BWImageButton ID="btnAddContact" runat="server" >
                    </cc2:BWImageButton>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="top" colspan="2">
                    <asp:Label Visible="false" ID="lblSort" runat="server"></asp:Label>
                    <asp:DataList ID="ContactDataList" runat="server" OnDeleteCommand="ContactDataList_DeleteCommand"
                        OnCancelCommand="ContactDataList_CancelCommand" OnUpdateCommand="ContactDataList_UpdateCommand"
                        OnEditCommand="ContactDataList_EditCommand" DataKeyField="TradePartnerContactID"
                        BackColor="White" BorderWidth="0px" Width="800">
                        <HeaderTemplate>
                            <table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0"
                                height="22">
                                <tr class="TableHeaderOver">
                                    <td class="fontHead" width="20">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="200">
                                        <asp:LinkButton ID="Linkbutton1" runat="Server" CommandName="sort" CommandArgument="FULLNAME"
                                            ><%#GetSystemText("Contact Name")%></asp:LinkButton>
                                    </td>
                                    <td class="fontHead" width="100">
                                        <asp:LinkButton ID="Linkbutton5" runat="Server" CommandName="sort" CommandArgument="Title"
                                            ><%#GetSystemText("Title")%></asp:LinkButton>
                                    </td>
                                    <td class="fontHead" width="100">
                                        <asp:LinkButton ID="Linkbutton6" runat="Server" CommandName="sort" CommandArgument="PhoneNumber"
                                            ><%#GetSystemText("Phone No.")%></asp:LinkButton>
                                    </td>
                                    <td class="fontHead" width="100">
                                        <asp:LinkButton ID="Linkbutton7" runat="Server" CommandName="sort" CommandArgument="MobileNumber"
                                            ><%#GetSystemText("Mobile No.")%></asp:LinkButton>
                                    </td>
                                    <td class="fontHead" width="100">
                                        <asp:LinkButton ID="Linkbutton8" runat="Server" CommandName="sort" CommandArgument="Email"
                                            ><%#GetSystemText("Email")%></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <EditItemStyle BorderWidth="0px"></EditItemStyle>
                        <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
                        <FooterTemplate>
                        </FooterTemplate>
                        <ItemStyle BackColor="White"></ItemStyle>
                        <ItemTemplate>
                            <table width="100%">
                                <tr>
                                    <td class="fontHead" width="20">
                                        <asp:LinkButton ID="Linkbutton1" runat="Server" CommandName="edit" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'></asp:LinkButton>
                                    </td>
                                    <td class="font" width="205">
                                        <%#Container.DataItem("FULLNAME")%>
                                    </td>
                                    <td class="font" width="105">
                                        <%#Container.DataItem("Title")%>
                                    </td>
                                    <td class="font" width="105">
                                        <%#Container.DataItem("PhoneNumber")%>
                                    </td>
                                    <td class="font" width="105">
                                        <%#Container.DataItem("MobileNumber")%>
                                    </td>
                                    <td class="font" width="100">
                                        <%#Container.DataItem("Email")%>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                    </td>
                                    <td width="500">
                                        <asp:LinkButton ID="Linkbutton2" runat="Server" CommandName="update" >'></asp:LinkButton>
                                        <cc2:ConfirmedLinkButton ID="Linkbutton4" runat="Server" Message='<%#GetSystemText("Are you sure you want to delete this contact?") %>' CommandName="delete" NAME="Linkbutton4"></cc2:ConfirmedLinkButton>
                                        <asp:LinkButton ID="Linkbutton3" runat="Server" CommandName="cancel" ></asp:LinkButton>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <table height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="gray" border="0">
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead">
                                        <font color="white"><asp:Label ID="lblEditContactH" runat="server"><%#GetSystemText("Edit Contact")%>:</asp:Label>
                                            <asp:Label ID="lblContactName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FullName").ToString  %>'>
                                            </asp:Label></font>
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="1" cellpadding="1" width="800" border="0">
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="125">
                                        <asp:Label ID="lblFirstName" runat="server"><%#GetSystemText("First Name")%></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtFirstName" TabIndex="1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FirstName").ToString  %>'>
                                        </asp:TextBox>
                                    </td>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="125">
                                       <asp:Label ID="lblPhone" runat="server"><%#GetSystemText("Phone No.")%></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPhoneNumber" TabIndex="4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PhoneNumber").ToString  %>'>
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="125">
                                        <asp:Label ID="lblLastName" runat="server"><%#GetSystemText("Last Name")%></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLastName" TabIndex="2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Lastname").ToString  %>'>
                                        </asp:TextBox>
                                    </td>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="125">
                                        <asp:Label ID="lblMobile" runat="server"><%#GetSystemText("Mobile No.")%></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMobileNumber" TabIndex="5" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MobileNumber").ToString  %>'>
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="125">
                                      <asp:Label ID="lblTitle" runat="server"><%#GetSystemText("Title")%></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtTitle" TabIndex="3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Title").ToString  %>'>
                                        </asp:TextBox>
                                    </td>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="125">
                                       <asp:Label ID="lblEmail" runat="server"><%#GetSystemText("Email")%></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEmail" TabIndex="6" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Email").ToString  %>'>
                                        </asp:TextBox>
                                    </td>
                                </tr>
                                                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="125">
                                      <asp:Label ID="lblPrefLang" runat="server"><%#GetSystemText("Pref. Lang.")%></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="drlPrefLang" TabIndex="3" runat="server" Width="125" AppendDataBoundItems="true" DataTextField="PreferredLang" DataValueField="CultureName" DataSource='<%# TradeContactLangDataTable()%>'>
                                            <asp:ListItem Value="" Text=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                    </asp:DataList>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlVendor" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr>
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="100%">
                    <cc2:BWImageButton ID="btnAddVendor" runat="server" ></cc2:BWImageButton>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <asp:DataList ID="VendorDatalist" runat="server" DataKeyField="TradePartnerVendorID"
            BackColor="White" BorderWidth="0px" Width="800" OnItemDataBound="VendorDatalist_ItemDataBound">
            <HeaderTemplate>
                <table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0"
                    height="22">
                    <tr class="TableHeaderOver">
                        <td class="fontHead" width="50">
                            &nbsp;
                        </td>
                        <td class="fontHead" width="200">
                            <asp:Label ID="lblVendor" runat="server"><%#GetSystemText("Vendor")%></asp:Label>
                        </td>
                        <td class="fontHead" width="100">
                           <asp:Label ID="lblCity" runat="server"><%#GetSystemText("City")%></asp:Label>
                        </td>
                        <td class="fontHead" width="100">
                            <asp:Label ID="lblState" runat="server"><%#GetSystemText("State")%></asp:Label>
                        </td>
                        <td class="fontHead" width="100">
                            <asp:Label ID="lblCountry" runat="server"><%#GetSystemText("Country")%></asp:Label>
                        </td>
                        <td class="fontHead" width="100">
                            <asp:Label ID="lblPhoneNumber" runat="server"><%#GetSystemText("Phone Number")%></asp:Label>
                        </td>
                    </tr>
                </table>
            </HeaderTemplate>
            <EditItemStyle BorderWidth="0px"></EditItemStyle>
            <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
            <FooterTemplate>
            </FooterTemplate>
            <ItemStyle BackColor="White"></ItemStyle>
            <ItemTemplate>
                <table width="100%">
                    <tr>
                        <td class="fontHead" width="50">
                            <cc2:BWImageButton ID="btnEditVendor" runat="server">
                            </cc2:BWImageButton>
                        </td>
                        <td class="font" width="205">
                            (<%#Container.DataItem("VendorCode")%>)
                            <%#Container.DataItem("VendorName")%>
                        </td>
                        <td class="font" width="105">
                            <%#Container.DataItem("City")%>
                        </td>
                        <td class="font" width="105">
                            <%#Container.DataItem("State")%>
                        </td>
                        <td class="font" width="105">
                            <%#Container.DataItem("Country")%>
                        </td>
                        <td class="font" width="100">
                            <%#Container.DataItem("PhoneNumber")%>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
    </asp:Panel>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
