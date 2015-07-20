<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Sample_Spec.ascx.vb"
    Inherits="plmOnApp.SampleRequest_Workflow_Submit_Sample_Spec" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
    height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
    <tr>
        <td width="50" height="50">
            &nbsp;
        </td>
        <td class="fonthead">
            &nbsp;<font color="darkgray" size="3"><asp:Label ID="lblHeader" runat="server"></asp:Label></font>
        </td>
    </tr>
</table>
<table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
    <tr>
        <td width="800">
            <uc1:Style_Header ID="Style_Header1" runat="server"></uc1:Style_Header>
        </td>
        <td>
        </td>
    </tr>
</table>
<br>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr>
        <td>
            <table cellspacing="0" cellpadding="0" width="100%" align="center" bgcolor="#ffffff"
                border="0">
                <tr>
                    <td width="50">
                        &nbsp;
                    </td>
                    <td align="center" width="200">
                        <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fonthead">
                            <asp:Label ID="lblStyleAvailable" runat="server"></asp:Label>
                        </b></font>
                    </td>
                    <td width="50">
                    </td>
                    <td align="center" width="200">
                        <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fonthead">
                            <asp:Label ID="lblSelectSampleSize" runat="server"></asp:Label> &nbsp;
                           
                            (<asp:Label ID="lblSampleSize" runat="server" ForeColor="Red"></asp:Label>&nbsp;)
                        </b></font>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="center" width="200">
                        <asp:ListBox ID="lstSelect" runat="server" CssClass="fonthead" Width="250px" Height="250px"
                            SelectionMode="Multiple" BorderStyle="Outset"></asp:ListBox>
                    </td>
                    <td align="center" width="50">
                        <br>
                        <br>
                        <br>
                        <br>
                    </td>
                    <td align="center" width="200">
                        <asp:ListBox ID="lstSelected" CssClass="fonthead" Width="250px" Height="250px" SelectionMode="Multiple"
                            runat="server"></asp:ListBox>
                    </td>
                    <td align="center" width="50">
                        <br>
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
    border="0">
    <tr>
        <td align="center" width="50">
            &nbsp;
        </td>
        <td align="center" width="500">
            <asp:ImageButton ID="btnBack" runat="server" >
            </asp:ImageButton><asp:ImageButton ID="btnSave" runat="server" >
            </asp:ImageButton><asp:ImageButton ID="btnNext" runat="server" >
            </asp:ImageButton>
        </td>
        <td align="center">
            &nbsp;
        </td>
    </tr>
</table>
