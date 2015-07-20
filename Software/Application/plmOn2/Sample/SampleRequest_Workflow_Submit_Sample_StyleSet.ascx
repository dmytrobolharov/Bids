<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Sample_StyleSet.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Sample_StyleSet" %>
<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fonthead"><p><font color="lightgrey">&nbsp;</font><font color="darkgray" size="3"><asp:Label ID="lblHeader"
                runat="server" ></asp:Label></font></p>
		</td>
	</tr>
</table>
<br/>
<br/>

<table width="100%" border="0" cellspacing="0" cellpadding="0" id="Table1" class="font">
<tr>
    <td width="100">&nbsp;</td>
    <td>
        <asp:radiobuttonlist id="rblStyleSet" runat="server" RepeatDirection="Vertical" CssClass="fontHead">
            
        </asp:radiobuttonlist>
    <td width="100">&nbsp;</td>
</tr>
</table>

<br/>
<br/>
<br/>

<table style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0"
	id="Table4">
	<TR>
		<TD align="center" width="50">&nbsp;</TD>
		<TD align="center" width="500">
			<asp:ImageButton id="btnBack" runat="server" Visible="False"></asp:ImageButton>
			<asp:imagebutton id="btnSave" runat="server" Visible="False"></asp:imagebutton>
			<asp:ImageButton id="btnNext"  runat="server"></asp:ImageButton>
		</TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</table>
<br/>
