<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_MeasQA_Edit.ascx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_MeasQA_Edit" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc1" TagName="SampleRequest_Workflow_Submit_Comment" Src="SampleRequest_Workflow_Submit_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
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
	            <cc1:confirmedimagebutton id="btnDelete"  runat="server"></cc1:confirmedimagebutton>
	            <asp:PlaceHolder runat="server" ID="phlStatus" ></asp:PlaceHolder>    
            </asp:panel>
		    
			<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR class="TableHeader">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></TD>
					<TD class="fontHead" width="1"><cc1:confirmedimagebutton id="btnSizeChange" runat="server"  ></cc1:confirmedimagebutton></TD>
					<TD class="fontHead" width="1"><cc1:confirmedimagebutton id="btnSampleChange" runat="server"  ></cc1:confirmedimagebutton></TD>
					<TD class="fontHead">&nbsp;
						<cc1:bwhyperlink id="lblHeaderSpec" runat="server"></cc1:bwhyperlink>&nbsp;
						<asp:label id="txtSampleSize" runat="server"></asp:label>&nbsp;
						<asp:label id="txtPageName" runat="server"></asp:label>&nbsp;
					</TD>
				</TR>
			</TABLE>
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
								<TABLE height="30" cellSpacing="0" cellPadding="0" border="0">
									<TR>
										<TD>
											<asp:CheckBox id="cbTolerance" runat="server" visible="false" ForeColor="Red" CssClass="fontHead"
												Checked="True"></asp:CheckBox>
										</TD>
										<TD>
											<asp:CheckBox id="cbPostRevision" runat="server" visible="false" ForeColor="Red" Width="250px" CssClass="fontHead"
												Checked="True"></asp:CheckBox>
										</TD>
										<TD>
											<asp:ImageButton id="btnSpecCreate" runat="server">
											</asp:ImageButton>
											<asp:HiddenField ID="HFSubmitForm" runat="server" Value="0" />
											<asp:ImageButton id="btnComment" runat="server" Visible="false">
											</asp:ImageButton>
                                            <cc1:confirmedimagebutton id="btnSpecRemove" visible="false" runat="server"></cc1:confirmedimagebutton>
                                            <cc1:confirmedimagebutton id="btnSpecExplode" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                                            <cc1:bwimagebutton id="btnPOMSort" runat="server" visible="false" WindowName="POMLibrary">
											</cc1:bwimagebutton><cc1:confirmedimagebutton id="btnUpdateDevSpec" visible="false" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                                            <cc1:confirmedimagebutton id="btnSizeFix" visible="false" runat="server"></cc1:confirmedimagebutton>
										</TD>
									</TR>
								</TABLE>
								
                                <asp:datagrid id="dgSampleSpec" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
	                                PageSize="10000" AutoGenerateColumns="false" Width="375px" DataKeyField="SamplePomId">
                                    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                                    <ItemStyle Height="20px" CssClass="font" VerticalAlign="Top" BackColor="White"></ItemStyle>
                                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
	                                <Columns></Columns>
                                </asp:datagrid>
								
								<TABLE style="display:none" cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR class="fontHead">
										<TD>&nbsp;</TD>
										<TD noWrap width="85"> <asp:label runat="server" visible="false" ID="lblRows" CssClass="fontHead" ><asp:Label ID="lblNumOfRows" runat="server"></asp:Label></asp:label></TD>
										<TD width="35">
											<asp:dropdownlist id="dpNewRow" visible="false" runat="server" CssClass="fontHead">
												<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
												<asp:ListItem Value="2">2</asp:ListItem>
												<asp:ListItem Value="3">3</asp:ListItem>
												<asp:ListItem Value="4">4</asp:ListItem>
												<asp:ListItem Value="5">5</asp:ListItem>
												<asp:ListItem Value="10">10</asp:ListItem>
												<asp:ListItem Value="15">15</asp:ListItem>
												<asp:ListItem Value="20">20</asp:ListItem>
											</asp:dropdownlist></TD>
										<TD>
											<cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE"></cc1:confirmedimagebutton>
											<cc1:bwimagebutton id="btnPOMTemp" runat="server" visible="false" WindowName="POMTemplate"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPomLibraryTop" runat="server" WindowName="POMLibrary"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPomCritical" runat="server" visible="false" WindowName="POMLibrary"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPOMLinked" runat="server" visible="false" WindowName="POMLibrary"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPOMDelete" runat="server" WindowName="POMLibrary"  ></cc1:bwimagebutton> </TD>
									</TR>
								</TABLE>
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
													<%--<cc1:confirmedimagebutton id="btnNewImage" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_add.gif" Message="NONE"></cc1:confirmedimagebutton>--%>
													<cc1:confirmedimagebutton id="btnDeleteImage" runat="server" ></cc1:confirmedimagebutton></TD>
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
						</TD>
					</TR>
				</TABLE>
				<table id="TB_FitPhotos" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                    <tr>
                        <td>
                            <table id="TB_UpDelPhoto" height="25" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                                <tr class="TableHeader">
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                    </td>
                                    <td class="fontHead">
                                        <cc1:confirmedimagebutton id="btnSaveSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                                        <cc1:ConfirmedImageButton ID="btnUploadFile" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_upload.gif&PL=EN-US" Message="NONE"></cc1:ConfirmedImageButton>
                                        <cc1:ConfirmedImageButton ID="btnDeleteFitPhotos" runat="server" Message="Are you sure you want to remove this photo?"></cc1:ConfirmedImageButton>
                                    </td>
                                </tr>
                            </table>
                            <table id="TB_UpldPhoto" runat="server">
                                <tr>
                                    <td class="fontHead" width="100">
                                        <asp:Label ID="lblUpload" runat="server"></asp:Label>:
                                    </td>
                                    <td>
                                        <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <asp:DataGrid ID="dgFitPhotos" runat="server" AutoGenerateColumns="False" PageSize="100" BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver" Width="100%" DataKeyField="FitPhotoId">
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
				
                <asp:datagrid id="dgHowToMeasure" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
                    PageSize="10000" AutoGenerateColumns="false" Width="200px"  DataKeyField="SamplePomId">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate" ></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns></Columns>
                </asp:datagrid>
                

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

<script language="javascript" type="text/javascript">
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

    function checkSubmit() {
        if (document.getElementById("<%=HFSubmitForm.ClientID %>").value == 1)
            return false;
        else {
            document.getElementById("<%=HFSubmitForm.ClientID %>").value = 1;
            return true;
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
    
</script>
