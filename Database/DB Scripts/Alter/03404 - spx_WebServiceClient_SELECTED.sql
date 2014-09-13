
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WebServiceClient_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WebServiceClient_SELECTED]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_WebServiceClient_SELECTED]  
 @WSClientID [uniqueidentifier] = NULL  
WITH EXECUTE AS CALLER  
AS  
  
BEGIN  
 SELECT TOP (1) WSClientID, WSClientName, Address1, Address2, City, [State], PostalCode, Country, PhoneNumber, FaxNumber, Username, [Password], ContactName1,   
    ContactTitle1, ContactEmail1, ContactName2, ContactTitle2, ContactEmail2, ContactName3, ContactTitle3, ContactEmail3, ContactName4, ContactTitle4, ContactEmail4,   
    Active, CUser, CDate, MUser, MDate  
 FROM  uWebServiceClient  
 WHERE WSClientID = @WSClientID  
END  


GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03404', GetDate())

GO	