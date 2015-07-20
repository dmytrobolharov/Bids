<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmitAttachment.ascx.vb" Inherits="srmOnApp.Material_RequestSubmitAttachment" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
                <table height="25" cellSpacing="0" cellPadding="0" border="0" width="100%">
	                <tr class="TableHeader">
		                <td vAlign="middle" align="center" width="20"><IMG src="../System/Icons/icon_attach.gif"></td>
		                <td class="fontHead">&nbsp;<asp:label id="lblAttachments" runat="server">Attachments</asp:label></td>
		                <td align="right" ><cc1:bwhyperlink ID="btnAddAttach" runat="server" ForeColor="#0066CC" Font-Underline="True" ></cc1:bwhyperlink>
                            <cc1:confirmedlinkbutton id="btnRemoveAttachment" runat="server"  
                                Message="Do you want to remove selected files?" ForeColor="#CC3300" 
                                Font-Underline="True" ></cc1:confirmedlinkbutton>
                        </td>
	                </tr>
                </table>
                <asp:datagrid id="dgAttachmentMain" runat="server" AutoGenerateColumns="False" 
                    BorderWidth="1px" DataKeyField="MaterialRequestSubmitDocumentID"
		            BorderStyle="Solid"  Width="100%" BorderColor="WhiteSmoke"
		            OnItemDataBound="dgAttachment_ItemDataBound"
		            OnItemCommand="dgAttachment_ItemCommand" ShowHeader="False">
		            <Columns>
                        <asp:TemplateColumn>
			                <ItemTemplate>
			                    <TABLE cellSpacing="0" cellPadding="0" border="0">
			                        <tr>
			                            <td width="25">&nbsp;</td>
			                            <td Class="font">
                                            <table style="background-position: left top; padding-top: 10px; padding-left: 0px; width: 400px; padding-right: 5px; margin-top: 0px; background: url(../System/Images/box_top.gif) no-repeat;">
                                                <tr><td></td></tr>
                                            </table>	
                                            <table style="background-position: #fff bottom; border-bottom: #d8d9da 0px solid; border-left: #d8d9da 1px solid; background: #fff; width: 400px; border-top: #d8d9da 0px solid; border-right: #d8d9da 1px solid; TEXT-INDENT: 5px; ">
                                               
			                                            <tr>
			                                                <td width="18"><asp:CheckBox ID="chkDeleteFile" runat="server" /></td> 
			                                                <td width="18"><asp:ImageButton runat="server" ID="btnDownload" OnClientClick="dont_show_wait_next_time(); return False;" ImageUrl="../System/Icons/icon_file.gif" CommandName="download" /></td>
			                                                <td><asp:Label id="lblDescription" runat="server" Font-Size="10pt" ForeColor="Black"></asp:Label></td>
			                                            </tr>
			                                            <tr>
			                                                <td width="18"></td>
			                                                <td width="18"></td>
			                                                <td></td>
			                                            </tr> 
                                            </table>	
                                            <table style="background-position: left bottom; padding-bottom: 30px; padding-left: 0px; width: 400px; padding-right: 5px; margin-bottom: 10px; background: url(../System/Images/box_base.gif) no-repeat;">
                                                <tr>
                                                    <td width="30" height="40">&nbsp;</td>
                                                    <td>
							                            <div Class="fontHead">By:&nbsp;<%#Container.DataItem("MUser")%>&nbsp;<%#SystemHandler.GetLocalTime(Container.DataItem("MDate"))%></div>	        
							                        </td>
							                        <td><div Class="fontRed">&nbsp;</div></td>
							                    </tr>
                                            </table>		        
			                            </td>
			                        </tr>
			                    </TABLE> 
			                </ItemTemplate>
		                </asp:TemplateColumn>
		            </Columns>
				</asp:datagrid>     
