<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Sample_Process.ascx.vb"
    Inherits="srmOnApp.SampleRequest_Workflow_Submit_Sample_Process" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
    height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
    <tr>
        <td width="50" height="50">
            &nbsp;
        </td>
        <td class="fonthead">
            <font color="darkgray" size="3">
                <asp:Label runat="server" ID="lblSelectStyle">Select Style Process</asp:Label>...</font>
        </td>
    </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="Table2">
    <tr>
        <td>
            <table width="100%" align="center" bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0"
                id="Table3">
                <tr>
                    <td width="50">
                        &nbsp;
                    </td>
                    <td align="center" width="200" style="height: 15px">
                        <font face="Microsoft Sans Serif" color="#000000" size="2">
                            <asp:Label runat="server" ID="lblProcessAvailable" CssClass="fonthead">
								Process Available</asp:Label></font>
                    </td>
                    <td width="50" style="height: 15px">
                    </td>
                    <td align="center" width="200" style="height: 15px">
                        <font face="Microsoft Sans Serif" color="#000000" size="2">
                            <asp:Label runat="server" ID="lblProcessSelected" CssClass="fonthead">
								Process Selected</asp:Label></font>
                    </td>
                    <td style="height: 15px">
                        &nbsp;
                    </td>
                    <td style="height: 15px">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="center" width="200">
                        <asp:ListBox ID="lstSelect" runat="server" CssClass="fonthead" Width="200px" Height="250px"
                            SelectionMode="Multiple" BorderStyle="Outset"></asp:ListBox>
                    </td>
                    <td align="center" width="50">
                        <asp:ImageButton ID="btnaddall"  runat="server"></asp:ImageButton>
                        <br>
                        <asp:ImageButton ID="btnadditem"  runat="server"></asp:ImageButton>
                        <br>
                        <asp:ImageButton ID="btnremoveitem" runat="server"></asp:ImageButton>
                        <br>
                        <asp:ImageButton ID="btnremoveall"  runat="server"></asp:ImageButton>
                        <br>
                    </td>
                    <td align="center" width="200">
                        <asp:ListBox ID="lstSelected" CssClass="fonthead" Width="200px" Height="250px" SelectionMode="Multiple"
                            runat="server"></asp:ListBox>
                    </td>
                    <td align="center" width="50">
                        <asp:ImageButton ID="btnColmoveup"  runat="server"></asp:ImageButton>
                        <br>
                        <asp:ImageButton ID="btnColmovedwn" runat="server"></asp:ImageButton>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table style="border-top: gray thin solid; border-left-style: none; background-color: gainsboro"
    height="35" cellspacing="0" cellpadding="0" width="100%" bgcolor="gainsboro"
    border="0" id="Table4">
    <tr>
        <td align="center" width="50">
            &nbsp;
        </td>
        <td align="center" width="500">
            <asp:ImageButton ID="btnBack" runat="server"></asp:ImageButton>
            <asp:ImageButton ID="btnSave" runat="server"></asp:ImageButton>
            <asp:ImageButton ID="btnNext" runat="server"></asp:ImageButton>
        </td>
        <td align="center">
            &nbsp;
        </td>
    </tr>
</table>
