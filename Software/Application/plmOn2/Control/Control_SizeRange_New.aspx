<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SizeRange_New.aspx.vb"
    Inherits="plmOnApp.Control_SizeRange_New" %>

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
                        runat="server"  Message="NONE" CausesValidation="False">
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
                <asp:TextBox ID="txtSizeRangeCode" runat="server" MaxLength="60" width="190"></asp:TextBox>
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
            <td style="width: 96px" height="20">
                <p align="center">
                    <asp:Label ID="lblSizeDescH" runat="server"></asp:Label></p>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc1" runat="server" Width="64px"></asp:TextBox>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc2" runat="server" Width="64px"></asp:TextBox>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc3" runat="server" Width="64px"></asp:TextBox>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc4" runat="server" Width="64px"></asp:TextBox>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc5" runat="server" Width="64px"></asp:TextBox>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc6" runat="server" Width="64px"></asp:TextBox>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc7" runat="server" Width="64px"></asp:TextBox>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc8" runat="server" Width="64px"></asp:TextBox>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc9" runat="server" Width="64px"></asp:TextBox>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc10" runat="server" Width="64px"></asp:TextBox>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc11" runat="server" Width="64px"></asp:TextBox>
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
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc12" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton12" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR13" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize13" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox13" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc13" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton13" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR14" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize14" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox14" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc14" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton14" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR15" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize15" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox15" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc15" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton15" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR16" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize16" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox16" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc16" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton16" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR17" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize17" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox17" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc17" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton17" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR18" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize18" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox18" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc18" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton18" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR19" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize19" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox19" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc19" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton19" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR20" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize20" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox20" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc20" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton20" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR21" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize21" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox21" runat="server" MaxLength="5" Width="64px"></asp:TextBox>                
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc21" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton21" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR22" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize22" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox22" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc22" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton22" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR23" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize23" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox23" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc23" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton23" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR24" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize24" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox24" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc24" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton24" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR25" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize25" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox25" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc25" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton25" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR26" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize26" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox26" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc26" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton26" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR27" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize27" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox27" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc27" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton27" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR28" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize28" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox28" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc28" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton28" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR29" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize29" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox29" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc29" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton29" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR30" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize30" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox30" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc30" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton30" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR31" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize31" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox31" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc31" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton31" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR32" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize32" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox32" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc32" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton32" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR33" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize33" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox33" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc33" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton33" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR34" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize34" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox34" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc34" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton34" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR35" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize35" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox35" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc35" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton35" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR36" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize36" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox36" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc36" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton36" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR37" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize37" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox37" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc37" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton37" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR38" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize38" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox38" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc38" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton38" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR39" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize39" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox39" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc39" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton39" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR40" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize40" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox40" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc40" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton40" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR41" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize41" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox41" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc41" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton41" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR42" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize42" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox42" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc42" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton42" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR43" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize43" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="TextBox43" runat="server" MaxLength="5" Width="64px"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc43" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="RadioButton43" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR44" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize44" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox44" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc44" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton44" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR45" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize45" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox45" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc45" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton45" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR46" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize46" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox46" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc46" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton46" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR47" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize47" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox47" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc47" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton47" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR48" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize48" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox48" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc48" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton48" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR49" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize49" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox49" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc49" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton49" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
        <tr id="TR50" runat="server">
            <td class="TableHeaderOver" width="65">
                &nbsp;<asp:Label ID="lblSize50" runat="server"></asp:Label>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="Textbox50" runat="server" Width="64px" MaxLength="5"></asp:TextBox>
            </td>
            <td style="width: 96px">
                &nbsp;
                <asp:TextBox ID="txtSizeDesc50" runat="server" Width="64px"></asp:TextBox>
            </td>
            <td>
                &nbsp;
                <asp:RadioButton ID="Radiobutton50" runat="server" GroupName="Sample"></asp:RadioButton>
            </td>
        </tr>
    </table>
    <br>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
