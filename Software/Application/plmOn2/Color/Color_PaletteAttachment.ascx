<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Color_PaletteAttachment.ascx.vb" Inherits="plmOnApp.Color_PaletteAttachment" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
                <table height="25" cellSpacing="0" cellPadding="0" border="0" width="100%">
	                <tr class="TableHeader">
		                <td vAlign="middle" align="center" width="20"><IMG src="../System/Icons/icon_attach.gif"></td>
		                <td class="fontHead">&nbsp;<asp:label id="lblAttachments" runat="server">Attachments</asp:label></td>
		                <td align="right" >
		                <cc1:confirmedlinkbutton  ID="btnMultipleFiles" runat="server" ForeColor="#009900" 
                                Font-Underline="True" ></cc1:confirmedlinkbutton>&nbsp;
<%--                                <cc1:bwhyperlink  ID="btnAddAttach" runat="server" ForeColor="#0066CC" Font-Underline="True" >
                             </cc1:bwhyperlink>--%>
                            <cc1:confirmedlinkbutton id="btnRemoveAttachment" runat="server" Text="Remove" 
                                 ForeColor="#CC3300" 
                                Font-Underline="True" ></cc1:confirmedlinkbutton>
                        </td>
	                </tr>
                </table>
                <asp:datagrid id="dgAttachmentMain" runat="server" AutoGenerateColumns="False" 
                    BorderWidth="1px" DataKeyField="ColorPaletteDocumentID"
		            BorderStyle="Solid"  Width="100%" BorderColor="WhiteSmoke"
		            OnItemDataBound="dgAttachment_ItemDataBound"
		            OnItemCommand="dgAttachment_ItemCommand" ShowHeader="False">
		            <Columns>
                        <asp:TemplateColumn>
			                <ItemTemplate>
			                    <table>
			                        <tr>
			                            <td width="18"><asp:CheckBox ID="chkDeleteFile" runat="server" /></td> 
			                            <td width="18"><asp:ImageButton runat="server" ID="btnDownload" ImageUrl="../System/Icons/icon_file.gif" CommandName="download" /></td>
			                            <td><asp:Label id="lblDescription" runat="server" Font-Size="10pt" ForeColor="Black"></asp:Label></td>
			                        </tr>
			                        <tr>
			                            <td width="18"></td>
			                            <td width="18"></td>
			                            <td><asp:Label id="lblCreatedBy" runat="server" CssClass="fontHead"></asp:Label></td>
			                        </tr> 
			                    </table>  
			                </ItemTemplate>
		                </asp:TemplateColumn>
		            </Columns>
				</asp:datagrid>     
