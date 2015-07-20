<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_DesignSample_Edit.ascx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_DesignSample_Edit" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc1" TagName="SampleRequest_Workflow_Submit_Comment" Src="SampleRequest_Workflow_Submit_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<script type="text/javascript" src="../System/Jscript/popup.js"></script>
<script type="text/javascript" src='../System/Jscript/Custom.js'></script>

<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
	<TR>
		<TD vAlign="top" width="1%" bgColor="#ffffff">
		    <cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
		    
		    <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	            <tr class="TableHeader">
		            <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td width="20"><asp:imagebutton 
		            id="imgStatusCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton><asp:imagebutton 
		            id="imgStatusExpand" visible="false"  runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton></td>
		            <td class="fontHead"><asp:Label ID="lblSubmitStatusH" runat="server"></asp:Label></td>
	            </tr>
            </table>
            <asp:panel id="pnlStatus" runat="server">
	            <cc1:confirmedimagebutton id="btnDelete"  runat="server" Visible="false"></cc1:confirmedimagebutton>
	            <asp:PlaceHolder runat="server" ID="phlStatus" ></asp:PlaceHolder>    
            </asp:panel>
		    
			<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0" style="display:none">
				<TR class="TableHeader">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></TD>
					<TD class="fontHead" width="1"><cc1:confirmedimagebutton id="btnSizeChange" runat="server" visible="false" ></cc1:confirmedimagebutton></TD>
					<TD class="fontHead">&nbsp;
						<cc1:bwhyperlink id="lblHeaderSpec" runat="server"></cc1:bwhyperlink>&nbsp;
						
						<asp:label id="txtPageName" runat="server" Visible="false"></asp:label>&nbsp;
					</TD>
				</TR>
			</TABLE>
            <TABLE height="30" cellSpacing="0" cellPadding="0" border="0" runat="server" id="SpecCreateTable" width="100%">
									<TR class="TableHeader">
										<TD style="display:none">
											<asp:CheckBox id="cbTolerance" runat="server" visible="false" ForeColor="Red" CssClass="fontHead"
												Checked="True"></asp:CheckBox>
										</TD>
										<TD style="display:none">
											<asp:CheckBox id="cbPostRevision" runat="server" ForeColor="Red" Width="250px" CssClass="fontHead"
												Checked="True"></asp:CheckBox>
										</TD>
										<TD>
                                           <asp:ImageButton id="btnSpecCreate" runat="server">
											</asp:ImageButton>
                                            <cc1:confirmedimagebutton id="btnSamplesize" visible="true" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                                            <cc1:confirmedimagebutton id="btnshowhidesizes"  visible="true" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
											<asp:HiddenField ID="HFSubmitForm" runat="server" Value="0" />
											<asp:ImageButton id="btnComment" runat="server" Visible="false">
											</asp:ImageButton>
                                            <cc1:confirmedimagebutton id="btnSpecRemove"  runat="server" Visible="false"></cc1:confirmedimagebutton>
                                            <cc1:confirmedimagebutton id="btnSpecExplode" runat="server" Message="NONE" Visible="false"></cc1:confirmedimagebutton>
                                            <cc1:confirmedimagebutton id="btnUpdateDevSpec" runat="server" Message="NONE" Visible="false"></cc1:confirmedimagebutton>
                                            <cc1:confirmedimagebutton id="btnSizeFix"  runat="server" Visible="false"></cc1:confirmedimagebutton>
										</TD>
									</TR>
								</TABLE>
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
				    <tr>
					    <td valign="top" width="100%" bgColor="#ffffff">					    
    						
							    <asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>						
					    </td>
				    </tr>
			    </table>	
			<asp:panel id="Panel1" runat="server">
				<TABLE id="Table1" cellSpacing="1" cellPadding="1" border="0">
					<TR>
						<TD vAlign="top">
							<TABLE height="26" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD vAlign="bottom">
										<cc2:YSTabView id="YSTabView2" runat="server"></cc2:YSTabView></TD>
								</TR>
							</TABLE>
							<asp:Panel id="pnlSpecGrid" runat="server">
                                <script type="text/javascript">
                                    function checkSubmit() {
                                        if (document.getElementById("<%=HFSubmitForm.ClientID %>").value == 1)
                                            return false;
                                        else {
                                            document.getElementById("<%=HFSubmitForm.ClientID %>").value = 1;
                                            return true;
                                        }
                                    }
                                </script>
								
								<asp:Panel ID="innerSpecPanel" runat=server>
                                <table cellspacing="0" cellpadding="0" width="100%" border="0" runat="server" id="buttons2">
							<tr class="fontHead TableHeader" valign="top" align="left">
								<td width="10" style="height: 24px">&nbsp;</td>
								<td noWrap width="85" style="height: 24px"><asp:Label id="lblNoofRows" runat="server">No. of Row(s)</asp:Label>:</td>
								<td width="35" style="height: 24px" valign="top"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
										<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
										<asp:ListItem Value="2">2</asp:ListItem>
										<asp:ListItem Value="3">3</asp:ListItem>
										<asp:ListItem Value="4">4</asp:ListItem>
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
									</asp:dropdownlist></td>
								    <td style="height: 24px"><cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE" ></cc1:confirmedimagebutton>								
								    <cc1:confirmedimagebutton id="imgBtnLibrary" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
								    <cc1:bwimagebutton id="btnPOMTemp"  runat="server"  WindowName="POMTemplate"></cc1:bwimagebutton>
                                    <cc1:confirmedimagebutton id="imgBtnRemove" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                                    <cc1:bwimagebutton id="btnPOMSort" visible="true" runat="server"  WindowName="POMLibrary"></cc1:bwimagebutton>	
                                    
                                </td>
							</tr>
						</table>	
                        						
                            <table cellspacing="0" cellpadding="0" width="100%" border="0" runat="server" id="buttons1">
							<tr class="fontHead TableHeader" valign="top" align="left">
                            <td style="width: 143px"> &nbsp;</td>
                            <td style="height: 24px">
                            <cc1:bwimagebutton id="btnPOMLinked" visible="true" runat="server" WindowName="POMLink"></cc1:bwimagebutton>							
								<cc1:bwimagebutton id="btnPOMLink" visible="true" runat="server"  WindowName="POMBreakLink"></cc1:bwimagebutton>
                                <cc1:bwimagebutton id="btnPomCritical" visible="true" runat="server" WindowName="POMCritical"></cc1:bwimagebutton>
                                <cc1:bwimagebutton id="btnOnQA" visible="true" runat="server" WindowName="POMShowOnQA"></cc1:bwimagebutton>
                            </td>
                            </tr>
                            </table>   
                               
                               
                                <table class="TableHeader" style="display:none" cellspacing="0" cellpadding="0" width="100%" border="0">
				            <tr>
					            <td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td><asp:label id="Label1" runat="server">PoM Search</asp:label></td>
				            </tr>
			            </table>					
					    <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
						    <tr>							    
							    <td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>								
							    <td vAlign="top" width="100%">
								    <table height="45">
									    <tr>
										    <td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>											
									    </tr>
								    </table>
							    </td>																
						    </tr>
					    </table>														
			            <table class="TableHeader" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <tr vAlign="middle">
					            <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td class="fontHead" width="10"></td>
					            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"  ImageUrl="../System/Icons/icon_first_disable.gif"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"  ImageUrl="../System/Icons/icon_Previous_disable.gif"></asp:imagebutton></td>
					            <td nowrap align="center" width="100"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
					            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"  ImageUrl="../System/Icons/icon_next_disable.gif"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last_disable.gif"></asp:imagebutton></td>
					            <td width="10">&nbsp;</td>
					            <td nowrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
					            <td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
					            <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							            <asp:ListItem Value="5">5</asp:ListItem>
							            <asp:ListItem Value="10">10</asp:ListItem>
							            <asp:ListItem Value="15">15</asp:ListItem>
							            <asp:ListItem Value="20">20</asp:ListItem>
							            <asp:ListItem Value="25">25</asp:ListItem>
							            <asp:ListItem Value="30">30</asp:ListItem>
							            <asp:ListItem Value="40">40</asp:ListItem>
							            <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
						            </asp:dropdownlist></td>
					            <td width="10"><asp:button id="btnRepage" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
				            </tr>
			            </table>

                                <asp:datagrid id="DataGrid1" runat="server" DataKeyField="SampleRequestAMLMeasPomID" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							AllowPaging="true" PagerStyle-Visible="false" >
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
                                <asp:TemplateColumn HeaderStyle-CssClass="TableHeaderRed" ItemStyle-CssClass="TableHeaderRed" HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                    <HeaderTemplate >
                                        <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chbAMLMeasPOMId" />
                                    </ItemTemplate>                                                   
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
					                <HeaderTemplate>
						                <DIV align="center">
							                <asp:Label id="lblIsLinked" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></DIV>
					                </HeaderTemplate>
					                <ItemTemplate>
						                <asp:Image id="ImgIsLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif"></asp:Image>
					                </ItemTemplate>
				                </asp:TemplateColumn>
				                <asp:TemplateColumn>
					                <HeaderTemplate>
						                <div align="center">
							                <asp:Label id="lblCritical" runat="server" CssClass="fontHead"><%#GetSystemText("C")%></asp:Label></div>
					                </HeaderTemplate>
					                <ItemTemplate>
						                <asp:Image id="ImgCritical" runat="server" ImageUrl="../System/Icons/icon_warning.gif"></asp:Image>
					                </ItemTemplate>
				                </asp:TemplateColumn>
				                <asp:TemplateColumn>
					                <HeaderTemplate>
						                <div align="center">
							                <asp:Label id="lblFlagQA" runat="server" CssClass="fontHead"><%#GetSystemText("QA")%></asp:Label></div>
					                </HeaderTemplate>
					                <ItemTemplate>
						                <asp:Image id="ImgFlagQA" runat="server" ImageUrl="../System/Icons/Control_CheckBox.gif"></asp:Image>
					                </ItemTemplate>
				                </asp:TemplateColumn>
				                <asp:TemplateColumn>
					                <HeaderTemplate>
						                <div align="center">
							                <asp:Label id="lblHow2MeasText" runat="server" CssClass="fontHead"><%#GetSystemText("H")%></asp:Label></div>
					                </HeaderTemplate>
					                <ItemTemplate>
						                <cc1:BWImageButton id="ImgBtnHow2MeasText" runat="server" ImageUrl="../System/Icons/icon_howto.gif" WindowName="POMLibrary"></cc1:BWImageButton>
					                </ItemTemplate>
				                </asp:TemplateColumn>
                            </Columns>					
						</asp:datagrid>

							</asp:Panel>
                            	
                                <table style="display: none" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr class="fontHead">
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td nowrap width="85">
                                            <asp:Label runat="server" Visible="false" ID="lblRows" CssClass="fontHead">
                                                <asp:Label ID="lblNumOfRows" runat="server"></asp:Label></asp:Label>
                                        </td>
                                        <td>
                                            <cc1:BWImageButton ID="btnPomLibraryTop" runat="server" WindowName="POMLibrary"></cc1:BWImageButton>
                                            <cc1:BWImageButton ID="btnPOMDelete" runat="server" WindowName="POMLibrary"></cc1:BWImageButton>
                                        </td>
                                    </tr>
                                </table>
							</asp:Panel>
							<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
							<TABLE id="TB_FitImage" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
								<TR>
									<TD>
										<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR class="TableHeader">
												<TD vAlign="middle" align="center" width="10">
                                                    <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
												<TD class="fontHead">
												    <cc1:ConfirmedImageButton ID="btnAttachMultipleFile" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
													<cc1:confirmedimagebutton id="btnDeleteImage" runat="server" ></cc1:confirmedimagebutton>
                                                    <cc1:BWImageButton ID="btn3DFiles" runat="server" CausesValidation="False" />
                                                </TD>
											</TR>
										</TABLE>
										<asp:datagrid id="dgFitImage" runat="server" AutoGenerateColumns="False" PageSize="100" BorderWidth="1px"
											BorderStyle="Solid" BorderColor="Silver" Width="100%" DataKeyField="SampleRequestSubmitImageID">
											<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
											<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
											<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
											<Columns>
												<asp:TemplateColumn>
													<HeaderTemplate>
														<asp:Image id="Image1" runat="server" ImageUrl="../System/Icons/icon_delete.gif"></asp:Image>
													</HeaderTemplate>
													<ItemTemplate>
														<asp:CheckBox id="cbSpecImageDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>'></asp:CheckBox>
													</ItemTemplate>
												</asp:TemplateColumn>
											</Columns>
										</asp:datagrid></TD>
								</TR>
							</TABLE>
							<table id="TB_FitPhotos" cellspacing="0" cellpadding="0" width="100%" border="0"
                                runat="server">
                                <tr>
                                    <td>
                                        <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr class="TableHeader">
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                </td>
                                                <td class="fontHead">
                                                    <cc1:confirmedimagebutton id="btnSaveSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                                                    <cc1:ConfirmedImageButton ID="btnUploadFile" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                                                    <cc1:ConfirmedImageButton ID="btnDeleteFitPhotos" runat="server" Message="Are you sure you want to remove this photo?"></cc1:ConfirmedImageButton>                                                    
                                               </td>
                                            </tr>
                                        </table>
                                        <table>
                                            <tr>
                                                <td class="fontHead" width="100">
                                                    <asp:Label ID="lblUpload" runat="server"></asp:Label>:
                                                </td>
                                                <td>
                                                    <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:DataGrid ID="dgFitPhotos" runat="server" AutoGenerateColumns="False" PageSize="100"
                                            BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver" Width="100%" DataKeyField="FitPhotoId">
                                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                            <Columns>
                                                <asp:TemplateColumn>
                                                    <HeaderTemplate>
                                                        <asp:Image ID="Image2" runat="server" ImageUrl="../System/Icons/icon_delete.gif">
                                                        </asp:Image>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cbFitPhotosDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>'>
                                                        </asp:CheckBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </td>
                                </tr>
                            </table>
						</TD>
					</TR>
				</TABLE>
				
				
                <asp:datagrid id="dgHowToMeasure" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
                    PageSize="10000" AutoGenerateColumns="false" Width="200px"  DataKeyField="SampleRequestAMLMeasPOMId">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate" ></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns></Columns>
                </asp:datagrid>
                
                <asp:datagrid id="DataGrid2" runat="server" BorderColor="Silver" 
                            BorderStyle="Solid" BorderWidth="1px"
					            PageSize="100" AutoGenerateColumns="False" AllowPaging="true" PagerStyle-Visible="false">
					            <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					            <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle></asp:datagrid>	
			</asp:panel></TD>
		<TD vAlign="top" width="400" bgColor="#ffffff"><cc2:ystabview id="Ystabview3" runat="server"></cc2:ystabview><asp:panel id="pnlComment" runat="server">
				<uc1:SampleRequest_Workflow_Submit_Comment id="SampleRequest_Workflow_Submit_Comment1" runat="server"></uc1:SampleRequest_Workflow_Submit_Comment>
			</asp:panel><asp:panel id="pnlFitComment" runat="server">
				<TABLE id="TB_FitComment" cellSpacing="0" cellPadding="0" width="400" border="0" runat="server">
					<TR class="TableHeader">
						<TD>&nbsp;
							<asp:imagebutton id="btnComment1" runat="server" Visible="false"></asp:imagebutton></TD>
					</TR>
					<TR>
						<TD bgColor="#ffffff"><BR>
							<asp:label id="txt_FitComment" runat="server" CssClass="font"></asp:label><BR>
							<BR>
						</TD>
					</TR>
				</TABLE>
			</asp:panel></TD>
		<TD vAlign="top" width="98%" bgColor="#ffffff"></TD>
	</TR>
</TABLE>
<TABLE height="24" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
	<TR vAlign="middle">
		<TD vAlign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></TD>
		<TD class="TableBar" vAlign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></TD>
		<TD class="TableBar"><asp:label id="lblCreatedBy" runat="server" ForeColor="Gray" CssClass="fontHead"></asp:label>&nbsp;/
			<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></TD>
		<TD vAlign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></TD>
	</TR>
</TABLE>

<input type="hidden" runat="server"  id ="hd_UserName" />
<input type="hidden" runat="server"  id ="hd_UserDate" />
<div  id="divCopy2Spec" style="border: 1px solid black; width: 150px; display: none; font-size: 11px;font-weight: bold; background-color: #ffffff;">
    <asp:RadioButton id="rdoESSpec" Text="Eval Size" Checked="true" GroupName="SampleSpec" runat="server"/><br />
    </div>
<div  id="divCpy2Rev" style="border: 1px solid black; width: 150px; display: none; font-size: 11px;font-weight: bold; background-color: #ffffff;">
    <asp:RadioButton id="rdoESRev" Text="Eval Size" Checked="true" GroupName="SampleRev" runat="server"/><br />
    <asp:RadioButton id="rdoSRev" Text="Sample" GroupName="SampleRev" runat="server"/><br />
</div>
<script language="javascript" type="text/javascript">
    function SpecPicker(obj) {
        if (obj.checked == true) {
            Popup.show('divCopy2Spec', obj, 'below left', { 'constrainToScreen': false });
        }
        else {
            Popup.hide('divCopy2Spec');
        }
        
    }
    function RevPicker(obj) {
        if (obj.checked == true) {
            Popup.show('divCpy2Rev', obj, 'below left', { 'constrainToScreen': false });
        }
        else {
            Popup.hide('divCpy2Rev');
        }

    }
    if (window.document.addEventListener) {
        window.document.addEventListener("keydown", avoidInvalidKeyStorkes, false);
    } else {
        window.document.attachEvent("onkeydown", avoidInvalidKeyStorkes);
        //alert(Event.KEYDOWN);
        //window.document.captureEvents(Event.KEYDOWN);
    }

    function avoidInvalidKeyStorkes(evtArg) {

        var evt = (document.all ? window.event : evtArg);
        var isIE = (document.all ? true : false);
        var KEYCODE = (document.all ? window.event.keyCode : evtArg.which);

        var element = (document.all ? window.event.srcElement : evtArg.target);
        var msg = "We have disabled this key: " + KEYCODE;

        switch (KEYCODE) {
            //case 13: //Enter
            case 112: //F1
            case 113: //F2
            case 114: //F3
            case 115: //F4
            case 116: //F5
            case 117: //F6
            case 118: //F7
            case 119: //F8
            case 120: //F9
            case 121: //F10
            case 122: //F11
            case 123: //F12
            case 27: //ESCAPE
                if (isIE) {
                    if (KEYCODE == "112") {

                        document.onhelp = function() { return (false); }
                        window.onhelp = function() { return (false); }
                    }

                    evt.returnValue = false;
                    evt.keyCode = 0;
                    //window.status = msg;
                } else {
                    evt.preventDefault();
                    evt.stopPropagation();
                    //alert(msg);
                }
                break;
            default:
                window.status = "";
                //window.status = "Done";
        }
    }

    function doubleclickEnd() {
        document.Form1['Spec$txtEndBy'].value = document.Form1['Spec$hd_UserName'].value;
        document.Form1['Spec$txtEndDate'].value = document.Form1['Spec$hd_UserDate'].value;
    }
    function doubleclickRec() {
        document.Form1['Spec$txtRecBy'].value = document.Form1['Spec$hd_UserName'].value;
        document.Form1['Spec$txtRecDate'].value = document.Form1['Spec$hd_UserDate'].value;
    }
    function doubleclickRev() {
        document.Form1['Spec$txtRevBy'].value = document.Form1['Spec$hd_UserName'].value;
        document.Form1['Spec$txtRevDate'].value = document.Form1['Spec$hd_UserDate'].value;

    }

    var frm = document.forms[0];
    function SelectAll(checkAllBox) {
        var actVar = checkAllBox.checked;
        for (var i = 0; i < frm.length; i++) {
            var e = frm.elements[i];
            if (e.type == 'checkbox' && e.name.indexOf("chbAMLMeasPOMId") != -1 && !e.disabled) {
                e.checked = actVar;
            }
        }
    }
</script>
