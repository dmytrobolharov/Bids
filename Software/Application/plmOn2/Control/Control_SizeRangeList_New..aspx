 <%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SizeRangeList_New.aspx.vb"
    Inherits="plmOnApp.Control_SizeRangeList_New" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Size Range</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
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
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" 
                    Message="NONE"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="btnClose" OnClientClick="return btnClose_Click()"
                        runat="server" Message="NONE" CausesValidation="False">
                    </cc1:ConfirmedImageButton>
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
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
                <asp:Label ID="lblSampleRequired" runat="server" ForeColor="Red" CssClass="FontHead"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td class="fontHead" width="125">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td class="fontHead" width="125">
               <asp:Label ID="lblSizeRangeName" runat="server"></asp:Label>
            </td>
            <td>
                &nbsp;
                <asp:TextBox ID="txtSizeRangeCode" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvSizeRangeName" runat="server" 
                    ControlToValidate="txtSizeRangeCode" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td class="fontHead" width="125">
                <asp:Label ID="lblSizeRangeActive" runat="server"></asp:Label>
            </td>
            <td>
                &nbsp;
                <asp:CheckBox ID="cbSizeRangeCodeActive" runat="server" CssClass="fontHead"
                    Checked="True"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td width="10">
                &nbsp;
            </td>
            <td class="fontHead" width="125">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table bordercolor="#cccccc" cellspacing="0" cellpadding="0" width="300" bgcolor="#ffffff"
        border="1">
        <tr class="TableHeader">
            <td width="65" height="20">
                &nbsp;
            </td>
            <td style="width: 96px" height="20">
                <p align="center">
                    <asp:Label ID="lblSizeH" runat="server"></asp:Label></p>
            </td>
            <td height="20">
                &nbsp;<asp:Label ID="lblSample" runat="server"></asp:Label>
            </td>
        </tr>
        <tr id="TR1" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize1" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox1" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvSize1" runat="server" CssClass="Fonthead" ErrorMessage="*"
                    ControlToValidate="TextBox1" ToolTip="Required Size" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton1" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR2" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize2" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox2" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton2" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR3" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize3" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox3" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton3" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR4" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize4" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox4" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton4" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR5" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize5" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox5" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton5" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR6" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize6" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox6" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton6" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR7" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize7" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox7" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton7" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR8" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize8" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox8" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton8" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR9" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize9" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox9" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton9" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR10" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize10" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox10" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton10" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR11" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize11" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox11" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton11" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR12" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize12" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox12" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton12" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="Tr13" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize13" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox13" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton13" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="Tr14" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize14" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox14" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton14" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="Tr15" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize15" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox15" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton15" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="Tr16" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize16" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox16" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton16" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="Tr17" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize17" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox17" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton17" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="Tr18" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize18" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox18" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton18" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="Tr19" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize19" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox19" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton19" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="Tr20" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize20" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox20" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton20" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
    </table>
    <br>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
    </form>
</body></html>

