<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Summary_Comment.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Summary_Comment" %>


<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="middle">
		<TD vAlign="middle" align="center" width="10">
		    <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3">
		</TD>
		<TD>
			<asp:Label id="lblHeaderComment" runat="server"></asp:Label>
		</TD>
		<TD>
		</TD>
	</TR>
</table>

<asp:datalist id="dlSummary" runat="server" DataKeyField="SampleRequestSubmitID" RepeatLayout="Table" 
    RepeatDirection="Horizontal" EnableViewState="false">
    <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro" 
        VerticalAlign="Top" BackColor="White">
    </ItemStyle>
    <ItemTemplate>
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table width='100%' class='TableHeaderOver' height='25' >
                        <tr>
                            <td>
                                <img height='15' src='../System/Images/bbTbSCnr.gif' width='3'>
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label class="fontHead" runat="server" ID="lblSubmitHeader">submit</asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width='100%' bgcolor="white">        
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="lblTest"></asp:Label>
                                <asp:PlaceHolder runat="server" ID="plhControlSummary"></asp:PlaceHolder>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </ItemTemplate>
    <HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
</asp:datalist>
