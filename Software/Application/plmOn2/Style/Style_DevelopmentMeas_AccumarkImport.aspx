<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DevelopmentMeas_AccumarkImport.aspx.vb"
    Inherits="plmOnApp.Style.Measurements.Style_DevelopmentMeas_AccumarkImport" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">

    <script language="javascript">
        function SelectColor(sColor, sTxtBox) {
            opener.document.Form1[sTxtBox].value = sColor;
            self.close();
        }
    </script>

    <style type="text/css">
        .style2
        {
            width: 211px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
            border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnNewUpload" runat="server" Message="NONE" >
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnCancel" runat="server" Message="NONE" 
                        Visible="False" CausesValidation="False"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSave"  runat="server" 
                        Message="NONE"></cc1:ConfirmedImageButton>
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
                    &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#999999" Font-Size="X-Large"
                        Font-Names="Tahoma,Verdana">Accumark Import...</asp:Label>
                </td>
            </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="400" border="0">
            <tr>
            
                <td valign="top" class="style2" align="right">
                    <asp:Label ID="lblFileUpload" runat="server" Font-Bold="True">File Upload:</asp:Label>
                </td>
                <td class="font">
                    <input class="font" id="txtNewStyleDocumentPath" type="file" size="20" name="txtStyleDocumentPath"
                        runat="server" />
                </td>
            </tr>
            <tr>
            <td class="fontHead" align="right" > <asp:Label ID="Label1" runat="server" >Measurement Type:</asp:Label></td>
                <td class="fontHead" colspan="2" height="35">
                    &nbsp;&nbsp;
                    <asp:RadioButtonList ID="rbMeas" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Value="1" Selected="True">IsMetric</asp:ListItem>
                        <asp:ListItem Value="0">IsImperial</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
            <td>
            
            </td> 
            <td>
           
            </td>
            </tr>
            <tr>
            <td>
            
            </td> 
            <td>
             
            </td>
            </tr>
             <tr>
            <td>
            
            </td> 
            <td>
           
            </td>
            </tr>
            
            <tr>
            <td  > </td>
                <td valign="top" class="style2">
                    <asp:DataGrid ID="DataGrid1" runat="server" Width="300px" AutoGenerateColumns="False"
                        PageSize="100" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <Columns>
                            <asp:TemplateColumn>
                                <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                                <HeaderTemplate>
                                    <asp:Label ID="lblMeasPage1" runat="server"><%#GetSystemText("Meas Page")%></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblMeasPage" runat="server"></asp:Label>
                                    <asp:HiddenField ID="hdnSizecol" runat="server"></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                <HeaderTemplate>
                                    <asp:Label ID="lblTextFile" runat="server"><%#GetSystemText("Text File")%></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:DropDownList ID="dlTextFile" runat="server">
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:DataGrid>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
