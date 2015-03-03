<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_MeasurementLibrary_Edit.aspx.vb" Inherits="plmOnApp.Control_MeasurementLibrary_Edit" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Measurement Library</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <style type="text/css">
        .style1
        {
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;
            FONT-WEIGHT: normal;
            FONT-SIZE: 11px;
            COLOR: Black;
        }
    </style>
</head>
<body>
    <form id="Form1" method="post" runat="server" onkeypress="if(event.keyCode==13) {document.getElementById('btnImgSearch').click(); return false}">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="btnInvSearch"
                    runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btmImgNewPOM" runat="server" Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnPDFView" runat="server" Message="NONE"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server"  Message="NONE" Visible="false" CausesValidation="False"></cc1:ConfirmedImageButton>
            </td>
            <td class="FontHead" align="right" width="75">
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
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="#E0E0E0">Measurement Library</asp:Label>
            </td>
        </tr>
    </table>
    <table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr class="fontHead">
            <td align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td class="fontHead" width="50">
                <div align="right">
                    <asp:Label ID="lblCompanySearch" runat="server"></asp:Label></div>
            </td>
           <td width="100"><asp:dropdownlist id="ddlSearchCompany" runat="server" AppendDataBoundItems="true" EnableViewState="true" AutoPostBack="True">
                           <asp:ListItem Value="0">Select a company</asp:ListItem></asp:dropdownlist>
           </td>
           
            <td class="fontHead" width="50">
                <div align="right">
                    <asp:Label ID="lblSearch" runat="server"></asp:Label></div>
            </td>
            <td width="100">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="font"></asp:TextBox>
            </td>
            <td width="10">
                <asp:ImageButton ID="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif"
                    CausesValidation="False"></asp:ImageButton>
            </td>
            <td>
                <div align="left">
                    &nbsp;
                    <asp:Label ID="lblCurrentIndex" Text="0" Visible="False" runat="server"></asp:Label><asp:Label
                        ID="lblPageSize" Text="24" Visible="False" runat="server"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div>
            </td>
            <td width="150">
                <div align="center">
                    <asp:Label ID="lblCounts" runat="server" CssClass="plaintable"></asp:Label></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div>
            </td>
            <td width="20">
                <div align="center">
                    <asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div>
            </td>
            <td>
                <div align="left">
                    <b>
                        <asp:Label ID="lblRecordCount" runat="server" Visible="true"></asp:Label>&nbsp;<asp:Label
                            ID="lblRecCount" runat="server" Visible="true">Records Found</asp:Label></b></div>
                </B>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlNew" runat="server">
        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="500">
                    <asp:LinkButton ID="btnAddPOM" runat="Server" >
								<IMG border="0" alt="Save"  width="85" height="24"></asp:LinkButton>
                    <asp:LinkButton ID="btnAddClose" runat="Server" CausesValidation="False" >
								<IMG border="0" alt="Cancel" width="85" height="24"></asp:LinkButton>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <table cellspacing="1" cellpadding="1" width="100%" bgcolor="whitesmoke" border="0">
            <tr>
                <td valign="top" width="400">
                    <table cellspacing="0" cellpadding="0" border="0" 
                        style="width: 700px; margin-right: 0px">
                        
                            <tr>
                                <td width="10">
                                    &nbsp;
                                </td>
                                
                                <td class="fontHead" valign="top" width="100">                                
                                    <asp:Label ID="lblPOMCode" runat="server">"POM Code"</asp:Label>
                                </td>
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td class="fontHead" valign="top">
                                    <asp:TextBox ID="txtRefCode" runat="server" MaxLength="3"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rvPOMCode" runat="server" CssClass="fontHead" ControlToValidate="txtRefCode"
                                        Display="Dynamic" ErrorMessage="*" ></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblCompany" runat="server">Company</asp:Label>
                                    <asp:DropDownList ID="ddlNewCompany" runat="server" AppendDataBoundItems="true"></asp:DropDownList>                                       
                                     <asp:RequiredFieldValidator ID="rvPOMNewCompany" runat="server" CssClass="fontHead" initialvalue="0" ControlToValidate="ddlNewCompany"
                                        ToolTip ="Company Required" Display="Dynamic" ErrorMessage="*" ></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 22px" width="10">
                                    &nbsp;
                                </td>
                                <td class="fontHead" width="100">
                                    <asp:Label ID="lblPtMeasure" runat="server">"POM Description"</asp:Label>
                                </td>
                                <td width="10">
                                &nbsp;
                            </td>
                                <td class="style1">
                                    <asp:TextBox ID="txtMeasurDesc" runat="server" Width="250px" MaxLength="200"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rvPointOfMeasurment" runat="server" CssClass="fontHead"
                                        ControlToValidate="txtMeasurDesc" Display="Dynamic" ErrorMessage="*" ></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td class="fontHead" valign="top" width="100">
                                    <br>
                                    <asp:Label ID="lblHtoMeasure" runat="server"></asp:Label>
                                </td>
                                <td width="10">
                                &nbsp;
                            </td>
                                <td class="style1">
                                    <asp:TextBox ID="txtHowToMeasureText" runat="server" Rows="8" TextMode="MultiLine" Wrap="true" Columns="100"></asp:TextBox>
                                </td>
                            </tr>
                    </table>
                </td>
                <td valign="top">
                    <table cellspacing="0" cellpadding="0" width="400" border="0">
                        <tr>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td class="fontHead" valign="top" width="100">
                               <asp:Label ID="lblImageFile" runat="server"></asp:Label>
                            </td>
                            <td class="font">
                                <input class="font" id="txtHowToImagePath" type="file" name="txtHowToImagePath" runat="server">
                            </td>
                            <tr>
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                    </table>
                </td>
                <td>
                </td>
            </tr>
        </table>
    </asp:Panel>

    <script language="javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                    e.checked = actVar;
            }
        }
    </script>

    <asp:DataList ID="DataList1" runat="server" Width="100%" BorderWidth="1px" BorderStyle="Solid"
        BorderColor="WhiteSmoke" BackColor="White" DataKeyField="POMGuidId" OnEditCommand="DataList_EditCommand"
        OnUpdateCommand="DataList_UpdateCommand" OnCancelCommand="DataList_CancelCommand"
        OnDeleteCommand="DataList_DeleteCommand">
        <HeaderTemplate>
            <table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr class="Toolbar">
                    <td class="fontHead" width="20" height="20">
                        &nbsp;
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="Label1" runat="server"><%#GetSystemText("Company")%></asp:Label>
                    </td>
                    <td class="fontHead" width="75">
                        <asp:Label ID="lblCode" runat="server"><%#GetSystemText("Code")%></asp:Label>
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblPointofMeasure" runat="server"><%#GetSystemText("Point of Measure")%></asp:Label>                        
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblHowToMeasure" runat="server"><%#GetSystemText("How to Measure")%></asp:Label>
                    </td>
                    <td class="fontHead" width="200">
                        <asp:Label ID="lblHowToImage" runat="server"><%#GetSystemText("Image")%></asp:Label>
                    </td>
                </tr>
            </table>
        </HeaderTemplate>
        <AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
        <FooterTemplate>
        </FooterTemplate>
        <ItemStyle BackColor="White"></ItemStyle>
        <ItemTemplate>
            <table width="100%">
                <tr>
                    <td width="20" height="20">
                        <asp:LinkButton ID="btnEdit" runat="Server" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'
                            CommandName="edit" CausesValidation="false" Visible="<%#intAccessModify%>">
                        </asp:LinkButton>
                    </td>
                    <td class="font" width="200">
                    <asp:Label runat="server" ID="lblCompanyName">
                        
                        </asp:Label>
                    </td>
                    <td class="font" width="75">
                    <asp:Label runat="server" ID="lblPom">
                        <%#Container.DataItem("RefCode")%>
                        </asp:Label>
                    </td>
                    <td class="font" width="200">
                    <asp:Label runat="server" ID="lblPointMeasur">
                        <%#Container.DataItem("POMDesc")%>
                        </asp:Label>
                    </td>
                    <td class="font" width="200">
                        <asp:Label runat="server" ID="lblHow2MeasText">
									<%#Container.DataItem("How2MeasText")%>
                        </asp:Label>
                    </td>
                    <td class="font" width="200">
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# GetImageThumbnail(DataBinder.Eval(Container.DataItem, "POMGuidId").ToString,"50","jpg") %>'>
                        </asp:Image>
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
                        <asp:LinkButton ID="btnSave" runat="Server" 
                            CommandName="update" Visible="<%#intAccessModify%>">
                        </asp:LinkButton>
                        <cc1:ConfirmedLinkButton ID="btnDelete" runat="Server" Message='<%#GetSystemText("Are you sure you want to Delete this POM?")%>'
                             CommandName="delete"
                            Visible="<%#intAccessDelete%>">
                        </cc1:ConfirmedLinkButton>
                        <asp:LinkButton ID="btnCancel" runat="Server"
                            CommandName="cancel" CausesValidation="false"></asp:LinkButton>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table cellspacing="1" cellpadding="1" width="100%" bgcolor="whitesmoke" border="0">
                <tr>
                    <td valign="top" width="400">
                        <table cellspacing="0" cellpadding="0" width="700" border="0">
                            <tr>    
                                
                                <td width="10">
                                    &nbsp;
                                </td>
                                
                                <td class="fontHead" valign="top" width="100">                                
                                    <asp:Label ID="lblPomCde" runat="server"><%#GetSystemText("POM Code")%>:</asp:Label>
                                </td>
                                
                                <td class="fontHead" valign="top">
                                    <asp:TextBox ID="txtPOM" runat="server" MaxLength="3" Text='<%# DataBinder.Eval(Container.DataItem, "RefCode").ToString %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rvPOMCodeEdit" runat="server" CssClass="fontHead" ControlToValidate="txtPOM"
                                        ToolTip ="POM Code Required" Display="Dynamic" ErrorMessage="*" ></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblEditCompany" runat="server"><%#GetSystemText("Company")%>:</asp:Label>
                                    <asp:DropDownList ID="ddlEditCompany" runat="server" AppendDataBoundItems="true">
                                        <asp:ListItem Value="0">Select a company</asp:ListItem></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rvPOMCompany" runat="server" CssClass="fontHead" initialvalue="0" ControlToValidate="ddlEditCompany"
                                        ToolTip ="Company Required" Display="Dynamic" ErrorMessage="*" ></asp:RequiredFieldValidator>
                                </td>
                           
                                
           
                                
                                <tr>
                                    <td style="height: 22px" width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" width="100">
                                        <asp:Label ID="lblPtMeasur" runat="server"><%#GetSystemText("POM Description")%>:</asp:Label>
                                    </td>
                                    <td class="font">
                                        <asp:TextBox ID="txtPOMDesc" runat="server" Width="250px" Text='<%# DataBinder.Eval(Container.DataItem, "POMDesc").ToString  %>'>
                                        </asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rvPointMeasurEdit" runat="server" CssClass="fontHead" ToolTip = "Point Of Measurement Required..."
                                            ErrorMessage="*" Display="Dynamic"
                                            ControlToValidate="txtPOMDesc"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td class="fontHead" valign="top" width="100">
                                        <br>
                                        <asp:Label ID="lblHTmeasure" runat="server"><%#GetSystemText("How to Measure")%>:</asp:Label>
                                    </td>
                                    <td class="font">
                                        <asp:TextBox ID="txtHowToMeasure" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "How2MeasText").ToString  %>'
                                            ToolTip="Enter how to measure here.."  Columns="100" Wrap="true" TextMode="MultiLine"
                                            Rows="8">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                        </table>
                    </td>
                    <td valign="top">
                        <table cellspacing="0" cellpadding="0" width="400" border="0">
                            <tr>
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td class="fontHead" valign="top" width="100">
                                  <asp:Label ID="lblImgFile" runat="server"><%#GetSystemText("ImageFile")%>:</asp:Label>
                                </td>
                                <td class="font">
                                    <input class="font" id="txtImagePath" type="file" runat="server">
                                </td>
                                <tr>
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td colspan="2">
                                        <asp:Image ID="imgHowToImage" runat="server" ImageUrl='<%# GetImageThumbnail(DataBinder.Eval(Container.DataItem, "POMGuidId").ToString,"200","jpg") %>'>
                                        </asp:Image>
                                    </td>
                                </tr>
                        </table>
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
            <table cellspacing="0" cellpadding="0" width="100%" bgcolor="whitesmoke" border="0">
                <tr>
                    <td width="20">
                        &nbsp;
                    </td>
                    <td class="font" width="100">
                        <asp:Label ID="lblCreatedBy" runat="server"><%#GetSystemText("Created By")%>:</asp:Label>
                    </td>
                    <td class="font">
                        <asp:Label ID="lblCData" runat="server" Text='<%# Container.DataItem("CUser").ToString  &amp; " &nbsp; " &amp; Container.DataItem("CDate").ToString %>'>
                        </asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="20" bgcolor="whitesmoke">
                        &nbsp;
                    </td>
                    <td class="font" width="100">
                        <asp:Label ID="lblModifiedBy" runat="server"><%#GetSystemText("Modified By")%>:</asp:Label>
                    </td>
                    <td class="font">
                        <asp:Label ID="lblMData" runat="server" Text='<%# Container.DataItem("MUser").ToString &amp; " &nbsp; " &amp; Container.DataItem("MDate").ToString %>'>
                        </asp:Label>
                    </td>
                </tr>
                <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
            </table>
        </EditItemTemplate>
    </asp:DataList></form>

    </body>
</html>
