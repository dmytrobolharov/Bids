<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Variation.ascx.vb" Inherits="plmOnApp.control_Style_Variation" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR height="100">
		<TD class="font" >
            <div class="imgContainer" align="center">
                <div class="imgDesignBackContainer">
                    <asp:Image class="imgDesignBack" ID="imgDesignBack" runat="server" ImageAlign="Middle"/>
                </div>
                <div class="imgDesignContainer">
                    <asp:Image class="imgDesign" ID="imgDesign" runat="server" ImageAlign="Middle"/>
                </div>
            </div>
		</TD>
	</TR>
	<TR>
		<TD class="font">
			<DIV align="center">
				<asp:Label id="lbStyleName" runat="server"></asp:Label></DIV>
		</TD>
	</TR>
</TABLE>

<asp:datalist id="DataList1" BorderColor="Silver" BorderWidth="0px" EnableViewState="True" RepeatDirection="Vertical"
	runat="server" Width="100%">
	<ItemTemplate>
		<TABLE class="TableHeaderBlue" height="25" cellSpacing="0" cellPadding="0" width="100%"
			border="0" runat="server">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<TD>
					<asp:Label id=lblVariationSize runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeClass") %>'>
					</asp:Label></TD>
			</TR>
		</TABLE>
	</ItemTemplate>
</asp:datalist>
