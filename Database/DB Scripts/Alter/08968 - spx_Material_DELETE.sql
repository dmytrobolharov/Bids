/****** Object:  StoredProcedure [dbo].[spx_Material_DELETE]    Script Date: 08/22/2014 16:22:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_Material_DELETE]    Script Date: 08/22/2014 16:22:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Material_DELETE]
(@MaterialID uniqueidentifier,
@CreatedDate datetime,
@CreatedBy nvarchar(200))
AS 
BEGIN

	-- Breaking the connections between all the calendars
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER
	
	DECLARE CalendarsCursor CURSOR SCROLL FOR
	SELECT TACalTemplateID FROM pTACalReference 
	WHERE ReferenceId = @MaterialID AND TACalReferenceTypeId = 8
	
	OPEN CalendarsCursor
	FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC spx_TACalReference_DELETE @TACalTemplateID, @MaterialID
		FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	END
	CLOSE CalendarsCursor
	DEALLOCATE CalendarsCursor

	DELETE FROM pMaterialRequestSubmitComment WHERE MaterialID = @MaterialID
	DELETE FROM pMaterialRequestSubmitWorkflow WHERE MaterialID = @MaterialID

	DELETE FROM pMaterialRequestSubmitItem 
	WHERE MaterialRequestSubmitID IN 
	(SELECT MaterialRequestSubmitID FROM pMaterialRequestSubmit WHERE MaterialTradePartnerID IN 
	(SELECT MaterialTradePartnerId FROM pMaterialTradePartner WHERE MaterialID = @MaterialID))

	DELETE FROM pMaterialRequestSubmit WHERE MaterialTradePartnerID IN (SELECT MaterialTradePartnerID FROM pMaterialTradePartner WHERE MaterialID = @MaterialID)

	-- Deleting all material requests in a proper way
	DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER
	DECLARE RequestCursor CURSOR SCROLL FOR
	SELECT MaterialTradePartnerID FROM pMaterialTradePartner WHERE MaterialID = @MaterialID
	OPEN RequestCursor
	FETCH NEXT FROM RequestCursor INTO @MaterialTradePartnerID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC spx_MaterialRequestSubmitWorkflow_DELETE @MaterialTradePartnerID
		FETCH NEXT FROM RequestCursor INTO @MaterialTradePartnerID
	END
	CLOSE RequestCursor
	DEALLOCATE RequestCursor
		
	DELETE FROM pMaterialTradePartnerColor WHERE MaterialID = @MaterialID
	

	DELETE FROM pMaterialContent WHERE MaterialID = @MaterialID
	DELETE FROM pMaterialTesting WHERE (MaterialID = @MaterialID)
	DELETE FROM pMaterialHistory WHERE (MaterialID = @MaterialID)
	DELETE FROM pMaterialColor WHERE (MaterialID = @MaterialID)
	DELETE FROM pMaterialSize WHERE (MaterialID = @MaterialID)
	DELETE FROM pMaterialDesign WHERE (MaterialID = @MaterialID)
	DELETE FROM pMaterialSeasonYear WHERE (MaterialID = @MaterialID)
	DELETE FROM pMaterialColorSeasonYear WHERE (MaterialID = @MaterialID)
	DELETE FROM pMaterial WHERE (MaterialID = @MaterialID)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08968', GetDate())
GO
