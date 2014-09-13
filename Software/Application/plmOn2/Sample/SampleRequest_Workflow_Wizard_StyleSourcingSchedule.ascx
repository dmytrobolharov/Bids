<%@ Control Language="vb" AutoEventWireup="false"  Codebehind="SampleRequest_Workflow_Wizard_StyleSourcingSchedule.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_StyleSourcingSchedule" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
<style type="text/css">
    .style1
    {
        font-family: Tahoma, Geneva, Arial, Helvetica, sans-serif;
        font-size: 11px;
        font-weight: bold;
        width: 133px;
        padding: 2px;
        background-image: url('../System/Images/table_header.gif');
        background-repeat: repeat-x;
        height: 3px;
    }
    .style2
    {
    }
    .style3
    {
        height: 3px;
    }
    .style4
    {
        font-family: Tahoma, Geneva, Arial, Helvetica, sans-serif;
        font-size: 11px;
        font-weight: bold;
        width: 100px;
        height: 3px;
        padding: 2px;
        background-image: url('../System/Images/table_header.gif');
        background-repeat: repeat-x;
    }
    .style5
    {
        font-family: Tahoma, Geneva, Arial, Helvetica, sans-serif;
        font-size: 11px;
        font-weight: bold;
        height: 3px;
        padding: 2px;
        background-image: url('../System/Images/table_header.gif');
        background-repeat: repeat-x;
    }
    .Grid2Dim4
    {
        padding-left : 0px;
        padding-right : 0px;
        color : black;
    }
</style>

    <script language="javascript" type="text/javascript">

        function isPostBack() {
            return document.referrer.indexOf(document.location.href) > -1;
        }

        function getQuerystring(key, defaultVal) {
            if (defaultVal == null) {
                defaultVal = "";
            }
            key = key.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + key + "=([^&#]*)");
            var qs = regex.exec(window.location.href);
            if (qs == null) {
                return defaultVal;
            }
            else {
                return qs[1];
            }
        }

        function LoadCheckBoxAll(checkAllBox) {

            if (getQuerystring('Post', '') == "") {
                var frm = document.Form1;
                for (j = 0; j < frm.elements.length; j++) {
                    e = frm.elements[j];
                    var strCheckBOx = frm.elements[j].type.toLowerCase()
                    if (strCheckBOx == 'checkbox' && e.name.indexOf("cb") != -1) {
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleSet2") != -1) {
                            e.disabled = false;
                        }
                        else {
                            e.disabled = true;
                        }
                        if (e.type == 'checkbox' && e.name.indexOf("cbSelectAll") != -1) {
                            e.disabled = false;
                        }
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleSet") != -1) {
                            e.disabled = false;
                        }
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleColorway") != -1) {
                            e.disabled = false;
                        }
                    }
                }
            }
            else {
                var a = 0;
                var b = 0;
                var c = 0;
                var frm = document.Form1;
                for (j = 0; j < frm.elements.length; j++) {
                    e = frm.elements[j];
                    var strCheckBOx = frm.elements[j].type.toLowerCase()
                    if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM1") != -1) {
                        e.disabled = false;
                        if (e.checked) {
                            a = 10;
                        }
                    }
                    if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2") != -1) {
                        e.disabled = false;
                        if (e.checked) {
                            b = 10;
                        }
                    }
                    if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3") != -1) {
                        e.disabled = false;
                        if (e.checked) {
                            c = 10;
                        }
                    }
                }
                if (a == 10 && b == 10 && c == 10) {

                }
                if (a != 10 && b != 10 && c != 10) {
                    var frm = document.Form1;
                    for (j = 0; j < frm.elements.length; j++) {
                        e = frm.elements[j];
                        var strCheckBOx = frm.elements[j].type.toLowerCase()
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM1") != -1) {
                            e.disabled = true;
                        }
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2") != -1) {
                            e.disabled = true;
                        }
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3") != -1) {
                            e.disabled = true;
                        }
                        if (e.type == 'checkbox' && e.name.indexOf("cbDim1SelectAll") != -1) {
                            e.disabled = true;
                        }
                        if (e.type == 'checkbox' && e.name.indexOf("cbDim2SelectAll") != -1) {
                            e.disabled = true;
                        }
                        if (e.type == 'checkbox' && e.name.indexOf("cbDim3SelectAll") != -1) {
                            e.disabled = true;
                        }
                    }
                }
                if (a == 10 && b != 10 && c != 10) {
                    var frm = document.Form1;
                    for (j = 0; j < frm.elements.length; j++) {
                        e = frm.elements[j];
                        var strCheckBOx = frm.elements[j].type.toLowerCase()
                        
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3") != -1) {
                            e.disabled = true;
                        }
                        
                        if (e.type == 'checkbox' && e.name.indexOf("cbDim3SelectAll") != -1) {
                            e.disabled = true;
                        }
                    }
                }
            }
        }
    </script>

<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fontHead">
			<P><FONT color="lightgrey">&nbsp;</FONT><FONT color="darkgray" size="3"><asp:Label ID="lblHeader"
                    runat="server" ></asp:Label>
					</FONT></P>
		</td>
	</tr>
</table>
<TABLE style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; "
	height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	<TR>
		<TD align="left" width="500"><asp:imagebutton id="btnBack" runat="server" ></asp:imagebutton><asp:imagebutton id="btnSave" runat="server"></asp:imagebutton><asp:imagebutton id="btnNext" OnClientClick="javascript:return ClickMe();" runat="server"></asp:imagebutton></TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</TABLE>
<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="800"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
		<td></td>
	</tr>
</table>
<BR>
<table cellSpacing="0" cellPadding="0" width=100% border="0">
	<tr>
		<td>
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" border="0">
				<TR>
					<TD class="style3"></TD>
					<!--<TD class="style4">
						<DIV align="left">
						  <asp:CheckBox ID="cbSelectAll" OnClick="CheckSetAll(this);" AutoPostBack="False" runat="server">
                        </asp:CheckBox>
                            <asp:Label ID="lblStyleSetH" runat="server" ></asp:Label>
                          
                            </DIV>
					</TD>
					
					<TD class="style4">
						<DIV align="left" >
						   <asp:CheckBox ID="cbBomSelectAll" OnClick="CheckSetBomAll(this,'cbStyleSet2');" AutoPostBack="False" runat="server">
                        </asp:CheckBox>
                            </DIV>
					</TD>
					<TD class="style5">
						<DIV align="center">
						  <asp:CheckBox ID="cbDim1SelectAll"  OnClick="CheckBomDim1All(this,'cbStyleBOM');" AutoPostBack="False" runat="server">
                        </asp:CheckBox>
                            </DIV>
					</TD>
				<TD class="style5">
						<DIV align="center">
						      <asp:CheckBox ID="cbDim2SelectAll"  OnClick="CheckBomDim2All(this,'cbStyleBOM');" AutoPostBack="False" runat="server">
                        </asp:CheckBox>
                            </DIV>
					</TD>
					<TD class="style5">
						<DIV align="center">
						    <asp:CheckBox ID="cbDim3SelectAll"  OnClick="CheckBomDim3All(this,'cbStyleBOM');" AutoPostBack="False" runat="server">
                        </asp:CheckBox>
                            </DIV>
					</TD>
					 <TD class="style5">
						<DIV align="left"  >
                            <asp:Label ID="lblSelectStyleH" runat="server" ></asp:Label></DIV>
					</TD>
					<TD class="style3"></TD>
				</TR>-->
				<TR>
					<TD ></TD>
					<TD vAlign="top" class="style2">
							<asp:datagrid id="dgStyleSet" runat="server" ForeColor="Transparent" ShowHeader="True" AutoGenerateColumns="False"
							PageSize="100" GridLines="Horizontal" BorderColor="White" BackColor="White" BorderStyle="None" BorderWidth="1px"
							CellPadding="0">
							<HeaderStyle CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
                                	<HeaderTemplate>
										<%# GetSystemText("Style")%>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="cbStyleSet"   runat="server"  
                                            oncheckedchanged="cbStyleSet_CheckedChanged" ></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
									<HeaderTemplate>
										<%# GetSystemText("Set")%>
									</HeaderTemplate>
									<ItemTemplate>
										&nbsp;
										<asp:Label id="lblStyleSet" runat="server" CssClass="fontHead"></asp:Label>
										<INPUT type="hidden" ID="txtStyleSet" Runat="server" NAME="txtStyleSet">
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
							</TD>	
													
					    <TD vAlign="top" width="400" class="style2">
	                      
						</TD>
						
						<TD vAlign="top" width="400" class="style2">
							
						</TD>
						
						<TD vAlign="top" width="400" class="style2">
						   
						</TD>
						
					    <TD vAlign="top" width="400" class="style2">
							
						</TD>
						
							<TD vAlign="top" width="400" class="style2">
						<asp:datagrid id="dgStyleColor" runat="server" ForeColor="Transparent" ShowHeader="True" AutoGenerateColumns="False"
							PageSize="100" GridLines="Horizontal" BorderColor="White" BackColor="White" BorderStyle="None" BorderWidth="1px"
							CellPadding="0" OnItemCommand="dgStyleColor_ItemCommand">
							<HeaderStyle CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<asp:CheckBox id="cbStyleColorway" runat="server"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
									<HeaderTemplate>
										<%= Me.strColorway %>
									</HeaderTemplate>
									<ItemTemplate>
										&nbsp;
										<asp:LinkButton id="lblMainColor" runat="server"  CommandName="Select" CssClass="fontHead"></asp:LinkButton>
										<INPUT type="hidden" ID="txtStyleColorwayId" Runat="server" NAME="txtStyleColorwayId">
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<PagerStyle HorizontalAlign="Right" ForeColor="Black" BackColor="White"></PagerStyle>
						</asp:datagrid>
						</TD>
						
					<TD vAlign="top" width="400" rowspan="3">
						<TABLE cellSpacing="1" cellPadding="1" width="448" border="0">
							<TR>
								<TD></TD>
								<TD><asp:label id="lblStartDate" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD><asp:label id="lblEndDate" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD><asp:label id="lblTemplate" runat="server" CssClass="fontHead"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD><asp:textbox id="txtStartDate" runat="server" Width="75px"></asp:textbox><A id="aStartDate" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A></TD>
								<TD><asp:textbox id="txtEndDate" runat="server" Width="75px"></asp:textbox><A id="aEndDate" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A></TD>
								<TD><asp:dropdownlist id="dplTemplate" runat="server" AutoPostBack="True"></asp:dropdownlist></TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing="1" cellPadding="1" width="500" border="0">
							<TR>
								<TD class="fontHead" width="75">
                                    <asp:Label ID="lblScheduleBy" runat="server" ></asp:Label>
								</TD>
								<TD><asp:radiobuttonlist id="rbSubmitType" runat="server" CssClass="fontHead" RepeatDirection="Horizontal">
									
									</asp:radiobuttonlist></TD>
							</TR>
						</TABLE>
							<asp:datagrid id="DataGrid1" runat="server" Width="600px" BorderStyle="Solid" AutoGenerateColumns="False"
							PageSize="100" BorderWidth="1px" BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" BackColor="White"></ItemStyle>
							<Columns>
							    <asp:TemplateColumn > 
							        <ItemTemplate>
							            <asp:CheckBox runat ="server" ID="chkSelect"  />
									</ItemTemplate>
							    </asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblProcessH" runat="server"><%#GetSystemText("Process")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflow" runat="server">
											<INPUT id="Hidden1" type="hidden" runat="server" NAME="txtWorkflow"></asp:Label><INPUT id="txtWorkflow" type="hidden" runat="server" NAME="txtWorkflow">
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="50px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblSubmitH" runat="server"><%#GetSystemText("Submit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtSubmitDays" runat="server" Width="50px" MaxLength="5"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblResubmitH" runat="server"><%#GetSystemText("Resubmit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtResubmitDays" runat="server" Width="50px" MaxLength="5"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblAssignedToHL" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:DropDownList id="dlAssignedTo" runat="server"></asp:DropDownList>
									</ItemTemplate>
								</asp:TemplateColumn>

								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblDueDateHL" runat="server"><%#GetSystemText("Due Date")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtDueDate" runat="server" Width="75px" MaxLength="10" Enabled="false"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								

								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate><asp:Label ID="lblFinalDateH" runat="server"><%#GetSystemText("Final Date")%></asp:Label></HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtFinalDate" runat="server" Width="75px" MaxLength="10" Enabled="true" ReadOnly="true"></asp:TextBox><asp:Label ID="lblLink" runat="server" 
										></asp:Label><input type="hidden" runat="server" id="hdnFinalDate" />
									</ItemTemplate>
								</asp:TemplateColumn>

							</Columns>
						</asp:datagrid></TD>
					<TD></TD>
				</TR>
				
				<TR>
					<TD >&nbsp;</TD>
					<TD vAlign="top" class="style2" colspan="6">
						<asp:DataGrid ID="Grid2Dim4" runat="server" AutoGenerateColumns="False" 
                            BackColor="White" BorderColor="White" BorderStyle="None" BorderWidth="1px" 
                            CellPadding="0" ForeColor="Transparent" GridLines="Horizontal" PageSize="100" 
                            ShowHeader="True"  >
                            <HeaderStyle CssClass="TableHeader"/>
                            <Columns>
                                <asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
                                <HeaderTemplate>
                                <!--SET-->
                                        <asp:CheckBox ID="cbSelectAll" OnClick="CheckSetAll(this);" AutoPostBack="False" runat="server"></asp:CheckBox>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbStyleSet2"  onclick="CheckSetSelect(this);" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
                                    <HeaderTemplate>
                                    <!--SET-->
                                        <%#GetSystemText("Style Set")%>
                                    </HeaderTemplate>
                                    <ItemTemplate >
                                        <asp:Label ID="lblStyleSet2" runat="server" CommandName="Select" 
                                            CssClass="fontHead"></asp:Label>
                                        <input id="txtStyleSet2"  runat="server" name="txtStyleSet2" type="hidden"></input>
                                        </input>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                            <Columns>
                                <asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
                                <HeaderTemplate>
                                    <!--BOM-->
                                        <asp:CheckBox ID="cbBomSelectAll" OnClick="CheckSetBomAll(this,'cbStyleSet2');" AutoPostBack="False" runat="server"></asp:CheckBox>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbStyleBOM" onclick="CheckBomSelect(this);" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
                                    <HeaderTemplate>
                                    <!--BOM-->
                                        <%#GetSystemText("BOM")%>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblStyleBOM3" runat="server" CommandName="Select" 
                                            CssClass="fontHead"></asp:Label>
                                            <input id="txtBOMCount" runat="server" name="txtBOMCount" type="hidden"/>
                                        <input id="txtStyleBOM3" runat="server" name="txtStyleBOM3" type="hidden"></input>
                                        </input>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                            <Columns>
                                <asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
                                <HeaderTemplate>
                                       <!-- DIM1 -->
                                       <asp:CheckBox ID="cbDim1SelectAll"  OnClick="CheckBomDim1All(this,'cbStyleBOM');" AutoPostBack="False" runat="server"></asp:CheckBox>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbStyleDIM1" onclick="CheckDIM1Select(this);" runat="server" />
                                        
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
                                    <HeaderTemplate>
                                       <!-- DIM1 -->
                                       <%#GetSystemText("Dim1")%>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblStyleDIM1" runat="server" CommandName="Select" 
                                            CssClass="fontHead"></asp:Label>
                                        <input id="txtStyleDIM1" runat="server" name="txtStyleDIM1" type="hidden"/>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                            <Columns>
                                <asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
                                <HeaderTemplate>
                                        <!--DIM2-->
                                        <asp:CheckBox ID="cbDim2SelectAll"  OnClick="CheckBomDim2All(this,'cbStyleBOM');" AutoPostBack="False" runat="server"></asp:CheckBox>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbStyleDIM2" onclick="CheckDIM2Select(this);"  runat="server" />
                                        
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
                                    <HeaderTemplate>
                                        <!--DIM2-->
                                        <%# GetSystemText("Dim2")%>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblStyleDIM2" runat="server" CommandName="Select" 
                                            CssClass="fontHead"></asp:Label>
                                        <input id="txtStyleDIM2" runat="server" name="txtStyleDIM2" type="hidden"/>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                            <Columns>
                                <asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
                                 <HeaderTemplate>
                                       <!-- DIM3 -->
                                       <asp:CheckBox ID="cbDim3SelectAll"  OnClick="CheckBomDim3All(this,'cbStyleBOM');" AutoPostBack="False" runat="server"></asp:CheckBox>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbStyleDIM3" onclick="CheckDIM3Select(this);" runat="server" />
                                        
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderStyle-CssClass="Grid2Dim4">
                                    <HeaderTemplate>
                                       <!-- DIM3 -->
                                       <%# GetSystemText("Dim3")%>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblStyleDIM3" runat="server" CommandName="Select" 
                                            CssClass="fontHead"></asp:Label>
                                        <input id="txtStyleDIM3" runat="server" name="txtStyleDIM3" type="hidden"/>                                       
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                        </asp:DataGrid>
							</TD>							
						
					<TD>&nbsp;</TD>
				</TR>
				
		
				
			</TABLE>
			
		</td>
	</tr>
</table>
<script type="text/javascript" language="javascript">
    LoadCheckBoxAll('Control_cbSelectAll')

    function CheckSingleSetSelect(checkSel) {

        var frm = document.Form1;
        var actVarSel = checkSel.checked;
        actVarSel.disabled = false;
        for (j = 0; j < frm.length; j++) {
            e = frm.elements[j];
            if (e.type == 'checkbox' && e.name.indexOf("cb") != -1) {
                e.disabled = false;
            }
        }
    }


    function CheckSetAll(checkAllBox) {

        var frm = document.Form1;
        var actVar = checkAllBox.checked;
        if (actVar == false) {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cb") != -1) {
                    e.disabled = true;
                    e.checked = actVar;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleSet2") != -1) {
                    e.checked = actVar;
                    e.disabled = false;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleBOM") != -1) {
                    e.checked = actVar;
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbSelectAll") != -1) {
                    e.disabled = false;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbBomSelectAll") != -1) {
                    e.disabled = true;
                    e.checked = actVar;
                }
            }
        }
        else {
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleSet2") != -1) {
                    e.checked = actVar;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleBOM") != -1) {
                    e.disabled = false;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbBomSelectAll") != -1) {
                    e.disabled = false;
                }
            }
        }
    }

    function CheckBomAll(checkAllBox) {

        var frm = document.Form1;
        var actVar = checkAllBox.checked;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];
            if (e.type == 'checkbox' && e.name.indexOf("cbStyleBOM") != -1)
                e.checked = actVar;
        }
    }

    function CheckSetSelect(checkSel) {

        var frm = document.Form1;
        var actVar = $("input[id$='cbSelectAll']")[0];
        var actVarSel = checkSel.checked;
        var checkboxIndex = checkSel.name.charAt(checkSel.name.length - 1);

        if (actVarSel == false) {
            actVar.checked = false;
        }

        if (actVarSel == false) {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleSet2" + checkboxIndex) != -1) {
                    e.checked = actVarSel;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleBOM" + checkboxIndex) != -1) {
                    e.checked = actVarSel;
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM1" + checkboxIndex) != -1) {
                    e.checked = actVarSel;
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2" + checkboxIndex) != -1) {
                    e.checked = actVarSel;
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                    e.checked = actVarSel;
                    e.disabled = true;
                }
            }
        }
        else {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleBOM" + checkboxIndex) != -1) {
                    e.disabled = false;
                }
            }
        }
    }
    function CheckBomSelect(checkSel) {

        var frm = document.Form1;
        var actVar = $("input[id$='cbBomSelectAll']")[0];
        var actVar1 = $("input[id$='cbDim1SelectAll']")[0];
        var actVar2 = $("input[id$='cbDim2SelectAll']")[0];
        var actVar3 = $("input[id$='cbDim3SelectAll']")[0];
        var actVarSel = checkSel.checked;
        var checkboxIndex = checkSel.name.charAt(checkSel.name.length - 2) + checkSel.name.charAt(checkSel.name.length - 1);
        if (actVarSel == false) {
            actVar.checked = false;
            actVar1.checked = false;
            actVar2.checked = false;
            actVar3.checked = false;
        }
        if (actVarSel == false) {


            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleBOM" + checkboxIndex) != -1) {
                    e.checked = actVarSel;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM1" + checkboxIndex) != -1) {
                    e.checked = actVarSel;
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2" + checkboxIndex) != -1) {
                    e.checked = actVarSel;
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                    e.checked = actVarSel;
                    e.disabled = true;
                }
            }
        }
        else {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM1" + checkboxIndex) != -1) {
                    e.disabled = false;
                }
            }
        }
    }

    function CheckSetBomAll(checkAllBox, checkSetBox) {

        var frm = document.Form1;
        var actVar = checkAllBox.checked;
        var actSetNo = 0;
        var checkboxIndex = 1;

        if (actVar == false) {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleBOM") != -1) {
                    e.checked = actVar;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM1") != -1) {
                    e.disabled = true;
                    e.checked = actVar;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim1SelectAll") != -1) {
                    e.checked = actVar;
                }
            }
        }
        else {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM1") != -1) {
                    e.disabled = false;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim1SelectAll") != -1) {
                    e.disabled = false;
                }
            }
        }

        var checkboxIndex = 1;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];

            if (e.type == 'checkbox' && e.name.indexOf(checkSetBox + checkboxIndex) != -1) {
                if (e.checked == true) {
                    for (j = 0; j < frm.length; j++) {
                        e = frm.elements[j];
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleBOM" + checkboxIndex) != -1) {
                            e.checked = actVar;
                        }
                    }
                }
                checkboxIndex++;
            }
        }


    }

    function CheckBomDim1All(checkAllBox, checkBomBox) {

        var frm = document.Form1;
        var actVar = checkAllBox.checked;
        var actSetNo = 0;
        var checkboxIndex = 1;
        var checkbox1Index = 2;

        if (actVar == false) {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM1") != -1) {
                    e.checked = actVar;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2") != -1) {
                    e.checked = actVar;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3") != -1) {
                    e.checked = actVar;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim2SelectAll") != -1) {
                    e.checked = actVar;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim3SelectAll") != -1) {
                    e.checked = actVar;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2") != -1) {
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3") != -1) {
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim2SelectAll") != -1) {
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim3SelectAll") != -1) {
                    e.disabled = true;
                }
            }
        }
        else {

            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];

                if (e.type == 'checkbox' && e.name.indexOf(checkBomBox + checkboxIndex) != -1) {
                    if (e.checked == true) {
                        for (j = 0; j < frm.length; j++) {
                            e = frm.elements[j];
                            if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM1" + checkboxIndex) != -1) {
                                e.checked = actVar;
                            }
                            if (e.type == 'checkbox' && e.name.indexOf("cbDim2SelectAll") != -1) {
                                e.disabled = false;
                            }
                            if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2" + checkboxIndex) != -1) {
                                e.disabled = false;
                            }
                        }
                    }
                    checkboxIndex++;
                }
            }
        }

        var checkboxIndex = 1;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];

            if (e.type == 'checkbox' && e.name.indexOf(checkBomBox + checkboxIndex + checkbox1Index) != -1) {
                if (e.checked == true) {
                    for (j = 0; j < frm.length; j++) {
                        e = frm.elements[j];
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM1" + checkboxIndex + checkbox1Index) != -1) {
                            e.checked = actVar;
                        }
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2" + checkboxIndex + checkbox1Index) != -1) {
                            e.disabled = false;
                        }
                    }
                }
                checkboxIndex++;
            }
        }

    }
    function CheckBomDim2All(checkAllBox, checkBomBox) {

        var frm = document.Form1;
        var actVar = checkAllBox.checked;
        var actSetNo = 0;
        var checkboxIndex = 1;
        var checkbox1Index = 2;
        if (actVar == false) {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2") != -1) {
                    e.checked = actVar;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim3SelectAll") != -1) {
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim3SelectAll") != -1) {
                    e.checked = actVar;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                    e.checked = actVar;
                }
            }
        }
        else {

            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf(checkBomBox + checkboxIndex) != -1) {
                    if (e.checked == true) {
                        for (j = 0; j < frm.length; j++) {
                            e = frm.elements[j];
                            if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2" + checkboxIndex) != -1) {
                                e.checked = actVar;
                            }
                            if (e.type == 'checkbox' && e.name.indexOf("cbDim3SelectAll") != -1) {
                                e.disabled = false;
                            }
                            if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                                e.disabled = false;
                            }
                        }
                    }
                    checkboxIndex++;
                }
            }
        }
        var checkboxIndex = 1;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];

            if (e.type == 'checkbox' && e.name.indexOf(checkBomBox + checkboxIndex + checkbox1Index) != -1) {
                if (e.checked == true) {
                    for (j = 0; j < frm.length; j++) {
                        e = frm.elements[j];
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2" + checkboxIndex + checkbox1Index) != -1) {
                            e.checked = actVar;
                        }
                    }
                }
                checkboxIndex++;
            }
        }
    }
    function CheckBomDim3All(checkAllBox, checkBomBox) {

        var frm = document.Form1;
        var actVar = checkAllBox.checked;
        var actSetNo = 0;
        var checkboxIndex = 1;
        var checkbox1Index = 2;
        if (actVar == false) {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3") != -1) {
                    e.checked = actVar;
                }
            }
        }

        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];

            if (e.type == 'checkbox' && e.name.indexOf(checkBomBox + checkboxIndex) != -1) {
                if (e.checked == true) {
                    for (j = 0; j < frm.length; j++) {
                        e = frm.elements[j];
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                            e.checked = actVar;
                        }
                    }
                }
                checkboxIndex++;
            }
        }
        var checkboxIndex = 1;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];

            if (e.type == 'checkbox' && e.name.indexOf(checkBomBox + checkboxIndex + checkbox1Index) != -1) {
                if (e.checked == true) {
                    for (j = 0; j < frm.length; j++) {
                        e = frm.elements[j];
                        if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex + checkbox1Index) != -1) {
                            e.checked = actVar;
                        }
                    }
                }
                checkboxIndex++;
            }
        }
    }
    function CheckDIM1Select(checkSel) {

        var frm = document.Form1;
        var actVar = document.getElementById("Control_cbBomSelectAll");
        var actVar1 = document.getElementById("Control_cbDim1SelectAll");
        var actVar2 = document.getElementById("Control_cbDim2SelectAll");
        var actVar3 = document.getElementById("Control_cbDim3SelectAll");
        var actVarSel = checkSel.checked;
        var checkboxIndex = checkSel.name.charAt(checkSel.name.length - 2) + checkSel.name.charAt(checkSel.name.length - 1);

        var checkbox1Index = 2;

        if (actVarSel == false) {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbDim1SelectAll") != -1) {
                    e.checked = actVarSel;
                }
            }
        }
        else {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];

                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2" + checkboxIndex) != -1) {
                    e.disabled = false;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                    if (!e.disabled) {
                    }
                    else {
                        e.disabled = true;
                    }
                }
            }
        }
        var a = 0
        for (j = 0; j < frm.length; j++) {
            e = frm.elements[j];
            if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM1" + checkboxIndex) != -1) {
                if (e.checked) {
                    a = a + 1;
                }
                else {
                }
            }
        }
        if (a == 0) {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2" + checkboxIndex) != -1) {
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim2SelectAll") != -1) {
                    e.disabled = true;
                }

                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                    e.disabled = true;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim3SelectAll") != -1) {
                    e.disabled = true;
                }

                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2" + checkboxIndex) != -1) {
                    e.checked = actVarSel;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim2SelectAll") != -1) {
                    e.checked = actVarSel;
                }

                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                    e.checked = actVarSel;
                }
                if (e.type == 'checkbox' && e.name.indexOf("cbDim3SelectAll") != -1) {
                    e.checked = actVarSel;
                }
            }
        }
    }
    function CheckDIM2Select(checkSel) {
        
        var frm = document.Form1;
        var actVar = document.getElementById("Control_cbBomSelectAll");
        var actVar1 = document.getElementById("Control_cbDim1SelectAll");
        var actVar2 = document.getElementById("Control_cbDim2SelectAll");
        var actVar3 = document.getElementById("Control_cbDim3SelectAll");
        var actVarSel = checkSel.checked;
        var checkboxIndex = checkSel.name.charAt(checkSel.name.length - 2) + checkSel.name.charAt(checkSel.name.length - 1);
        var checkbox1Index = 2;
        if (actVarSel == false) {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];
                if (e.type == 'checkbox' && e.name.indexOf("cbDim2SelectAll") != -1) {
                    e.checked = actVarSel;
                }
            }
        }
        else {
            for (j = 0; j < frm.length; j++) {
                e = frm.elements[j];

                if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                    e.disabled = false;
                }
            }
        }
        var a=0
        for (j = 0; j < frm.length; j++) {
            e = frm.elements[j];            
            if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM2" + checkboxIndex) != -1) {
            if (e.checked) {
                a = a + 1;
            }
            else {  
            }
           }
       }
       
       if (a == 0) {
           
           for (j = 0; j < frm.length; j++) {
               e = frm.elements[j];
               if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                   e.disabled = true;
               }
               if (e.type == 'checkbox' && e.name.indexOf("cbDim3SelectAll") != -1) {
                   e.disabled = true;
               }
               if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
                   e.checked = actVarSel;
               }
               if (e.type == 'checkbox' && e.name.indexOf("cbDim3SelectAll") != -1) {
                   e.checked = actVarSel;
               }
           }
       }
   }
   function CheckDIM3Select(checkSel) {
       
       var frm = document.Form1;
       var actVar = document.getElementById("Control_cbBomSelectAll");
       var actVar1 = document.getElementById("Control_cbDim1SelectAll");
       var actVar2 = document.getElementById("Control_cbDim2SelectAll");
       var actVar3 = document.getElementById("Control_cbDim3SelectAll");
       var actVarSel = checkSel.checked;
       var checkboxIndex = checkSel.name.charAt(checkSel.name.length - 2) + checkSel.name.charAt(checkSel.name.length - 1);
       var checkbox1Index = 2;
       
       var a = 0
       for (j = 0; j < frm.length; j++) {
           e = frm.elements[j];
           if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM3" + checkboxIndex) != -1) {
               if (e.checked) {
                   a = a + 1;
               }
               else {
               }
           }
       }

       if (a == 0) {
       }
   }

   function CheckStyleSetSelected() {

       var frm = document.Form1;
       var strFlag ='False';
       for (i = 0; i < frm.elements.length; i++) {
           e = frm.elements[i];
           strCheckBox = frm.elements[i].type.toLowerCase()
           if (e.type == 'checkbox' && e.name.indexOf("cbStyleSet2") != -1) {
               if (e.checked) {
                   strFlag = 'True';
               }
               else {
                   strFlag = 'False';
               }
           }
       }
       if (strFlag == 'True') {
           return true;
       }
       else {
           alert("Select Style Set !!!");
           return false;
       }
       return true;
   }
   function CheckStyleBOMPageSelected() {

       var frm = document.Form1;
       var strFlag = 'False';
       for (ii = 0; ii < frm.elements.length; ii++) {
           e = frm.elements[ii];
           strCheckBox = frm.elements[ii].type.toLowerCase()
           if (e.type == 'checkbox' && e.name.indexOf("cbStyleBOM") != -1) {
               if (e.checked) {
                   strFlag = 'True';
               }
               else {
                   strFlag = 'False';
               }
           }
       }
       if (strFlag == 'True') {
           return true;
       }
       else {
           alert("Select Style BOM Page !!!");
           return false;
       }
       return true;
   }
   function ClickMe() {
       //       if (!CheckStyleSetSelected()) {
       //           return false;
       //       }
       //       if (!CheckStyleBOMPageSelected()) {
       //           return false;
       //       }
       if (Page_ClientValidate()) {
           var a = 0;
           var b = 0;
           var c = 0;
           var DimCount = 0;

           var StyleBOM;
           var strCheckBox;

           var frm = document.Form1;
           var DocCount = 1;
           var setCount = 1;

           var objPattern1 = '';
           var objPattern2 = '';
           var objPattern3 = '';
           var objPattern = '';

           var boolDim1Checked = false;
           var boolDim2Checked = false;
           var boolDim3Checked = false;

           var boolDim1ControlDoesNotExist = false;
           var boolDim2ControlDoesNotExist = false;
           var boolDim3ControlDoesNotExist = false;
           var arrBOMDimCount = new Array(100);

           for (i = 0; i < frm.elements.length; i++) {
               e = frm.elements[i];
               strCheckBox = frm.elements[i].type.toLowerCase()
               if (e.type == 'checkbox' && e.name.indexOf("cbStyleSet") != -1) {
                   setCount++;
               }
           }

           for (jj = 0; jj < frm.elements.length; jj++) {
               e = frm.elements[jj];
               strCheckBox = frm.elements[jj].type.toLowerCase()
               if (e.type == 'hidden' && e.name.indexOf("txtBOMCount") != -1 && e.value.length > 0) {
                   arrBOMDimCount[DocCount] = e.value;
                   DocCount++;
               }
           }

           var curDocCount = 0;
           var setFound = 0;

           for (k = 1; k < frm.elements.length; k++) {
               if (setFound >= setCount) {
                   break;
               }

               e = frm.elements[k];

               strCheckBox = frm.elements[k].type.toLowerCase()

               if (e.type == 'checkbox' && e.name.indexOf("cbStyleSet") != -1) {
                   setFound = setFound + 1;
               }

               if (e.type == 'checkbox' && e.name.indexOf("cbStyleBOM") != -1) {
                   curDocCount = curDocCount + 1;

                   if (e.checked) {

                       boolDim1Checked = false;
                       boolDim2Checked = false;
                       boolDim3Checked = false;

                       boolDim1ControlDoesNotExist = true;
                       boolDim2ControlDoesNotExist = true;
                       boolDim3ControlDoesNotExist = true;

                       for (pattern = 1; pattern <= arrBOMDimCount[curDocCount]; pattern++) {

                           objPattern = pattern + '' + setFound + '' + curDocCount;

                           for (m = 0; m < frm.elements.length; m++) {

                               e = frm.elements[m];
                               strCheckBox = frm.elements[m].type.toLowerCase()

                               if (e.type == 'checkbox' && e.name.indexOf("cbStyleDIM" + objPattern) != -1) {

                                   if (pattern == 1 && boolDim1Checked == false) {
                                       boolDim1ControlDoesNotExist = false;
                                       if (e.checked) {
                                           boolDim1Checked = true;
                                           break;
                                       }
                                   }

                                   if (pattern == 2 && boolDim2Checked == false) {
                                       boolDim2ControlDoesNotExist = false
                                       if (e.checked) {
                                           boolDim2Checked = true;
                                           break;
                                       }
                                   }
                                   if (pattern == 3 && boolDim3Checked == false) {
                                       boolDim3ControlDoesNotExist = false;
                                       if (e.checked) {
                                           boolDim3Checked = true;
                                           break;
                                       }
                                   }
                               }
                           }

                           if (pattern == 1 && boolDim1Checked == false && !boolDim1ControlDoesNotExist) {
                               alert('Must select atleast one dimensions from Dim1');
                               return false;
                           }

                           if (pattern == 2 && boolDim2Checked == false && !boolDim2ControlDoesNotExist) {
                               alert('Must select atleast one dimensions from Dim2');
                               return false;
                           }

                           if (pattern == 3 && boolDim3Checked == false && !boolDim3ControlDoesNotExist) {
                               alert('Must select atleast one dimensions from Dim3');
                               return false;
                           }

                       }
                   }
               }
           }
           return true;
       }
   }
</script>
