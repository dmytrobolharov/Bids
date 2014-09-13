<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_GRMeasurements_POM_New.aspx.vb" Inherits="plmOnApp.Control_GRMeasurements_POM_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<HEAD>
		<title runat="server" id="PageTitle">POM</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	
	    <style type="text/css">
            .style1
            {
                width: 1px;
            }
            .style2
            {
                width: 561px;
            }
        </style>
	</HEAD>
<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" 
                    Message="NONE"></cc1:ConfirmedImageButton>                
                <cc1:confirmedimagebutton ID="btClose" runat="server" Message="NONE" CausesValidation="False" ></cc1:confirmedimagebutton>                 
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td valign="middle">
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
         </td>
        </tr>
    </table>
    
   <table cellspacing="0" cellpadding="0" width="100%" border="0" style="border-bottom: orange thin solid;">       
         <asp:Panel ID="pnlPOM" runat="server">
			<table cellspacing="2" cellpadding="0" width="100%" border="0">
			<tr>
				<td><table>
				    <tr><td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				    	</tr>		
                    <TR><td><table><tr>
			            <TD Width="100px"><B class="fonthead"><asp:Label ID="lblAvailable" runat="server"></asp:Label></B></FONT></TD>
			            <TD Width="50px"> &nbsp;</TD>
			            <TD Width="100px"><B class="fonthead"><asp:Label ID="lblSelected" runat="server"></asp:Label></B></FONT></TD>
			            
		             </tr></table></td></TR>
	                <TR><td><table><tr>
		                <TD><asp:listbox id="lstSelect" runat="server"  CssClass="fonthead" Width="100px" Height="150px" SelectionMode="Multiple"
				                BorderStyle="Outset"></asp:listbox></TD>
		                <TD class="fonthead" align="center">(+/-)<br>
			                <br>
			                <asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
			                <asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
			                <asp:imagebutton id="btnremoveitem" runat="server"></asp:imagebutton><BR>
				        </TD>
		                <TD><asp:listbox id="lstSelected" CssClass="fonthead" 
                                Width="100px" Height="150px" SelectionMode="Multiple"
				                Runat="server"></asp:listbox></TD>
		                <TD width="30%" class="style1"></TD>
	               </tr></table></td></TR>
				
				</table></td>
                <td valign="top">
                    <table cellspacing="0" cellpadding="0" width="300" border="0" style="background-color:White">
                        <tr>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td class="fontHead" valign="top" width="100">
                               <asp:Label ID="lblImageFile" runat="server"></asp:Label>:
                            </td>
                            <td class="font">
                                <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td colspan="2"  class="font" width="50">
                            <br />
                                <cc1:BWImageButton id="imgFeature" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
			</tr>
		</table>
							
		</asp:Panel>
    </table>	
   									
		
    <br>
    </form>
    <SCRIPT language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		    var actVar = checkAllBox.checked ;
		    for(i=0;i< frm.length;i++)
		    {
			    e=frm.elements[i];
			    if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			    e.checked= actVar ;
		    }
        }

        function DoubleClick(strParam) {
            //disabled for 4.0
        var lstRight = document.getElementById("lstSelected");
        var lstLeft = document.getElementById("lstSelect");

        if (strParam == 'left') {
            if (lstLeft.selectedIndex != -1) {

                lstRight.appendChild(lstLeft.options.item(lstLeft.selectedIndex));
                lstLeft.remove(lstLeft.selectedIndex);
            }
            lstLeft.selectedIndex = -1;
        }
    }
   
		</SCRIPT>
</body>
</html>
