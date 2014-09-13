IF EXISTS (SELECT *	FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowLogic_UPDATE]') AND type IN (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowLogic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowLogic_UPDATE] (@MaterialTradePartnerID UNIQUEIDENTIFIER, @MaterialTradePartnerColorID UNIQUEIDENTIFIER)
AS
DECLARE @TradePartnerID UNIQUEIDENTIFIER, @MaterialSizeID UNIQUEIDENTIFIER, @MaterialID UNIQUEIDENTIFIER, @MaterialColorID UNIQUEIDENTIFIER, @TradePartnerVendorID UNIQUEIDENTIFIER, @CUser NVARCHAR(200), @CDate DATETIME, @StartDate DATETIME, @DueDate DATETIME, @EndDate DATETIME, @MaterialRequestWorkflowTempID UNIQUEIDENTIFIER, @MaterialRequestWorkflowTempItemID UNIQUEIDENTIFIER, @MaterialRequestSubmitID UNIQUEIDENTIFIER

SELECT @TradePartnerID = TradePartnerID, @TradePartnerVendorID = TradePartnerVendorID, @StartDate = MaterialRequestWorkflowStartDate, @DueDate = MaterialRequestWorkflowDueDate, @EndDate = NULL, @CUser = CUser, @CDate = CDate, @MaterialRequestWorkflowTempID = MaterialRequestWorkflowTempID
FROM pMaterialTradePartner WITH (NOLOCK)
WHERE MaterialTradePartnerID = @MaterialTradePartnerID

SELECT @MaterialSizeID = MaterialSizeID, @MaterialID = MaterialID, @MaterialColorID = MaterialColorID
FROM pMaterialTradePartnerColor WITH (NOLOCK)
WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID

--***Declare variables.          
DECLARE @TotalCount INT, @RowCounter INT, @MaterialRequestWorkflowID NVARCHAR(5), @NewMaterialRequestSubmitWorkflowID UNIQUEIDENTIFIER, @MaterialRequestSubmitWorkflowID_Other UNIQUEIDENTIFIER, @TotalCount_2 INT, @RowCounter_2 INT, @NewMaterialRequestSubmitID UNIQUEIDENTIFIER, @MaterialRequestSubmitID_Other UNIQUEIDENTIFIER, @MaterialRequestWorkflowID_Other NVARCHAR(5)

--***Create temp tables.      
CREATE TABLE #tempNoColorMaterialRequestWorkflowIDs (TableRow INT IDENTITY(1, 1), MaterialRequestWorkflowID NVARCHAR(5) COLLATE SQL_Latin1_General_CP1_CI_AS, MaterialRequestWorkflowTempItemID UNIQUEIDENTIFIER)

CREATE TABLE #tempMaterialRequestSubmitIDs (TableRow INT IDENTITY(1, 1), MaterialRequestSubmitID UNIQUEIDENTIFIER, MaterialRequestWorkflowID NVARCHAR(5))

--** For "All colors" workflows --    
INSERT INTO #tempNoColorMaterialRequestWorkflowIDs (MaterialRequestWorkflowID, MaterialRequestWorkflowTempItemID)
SELECT b.MaterialRequestWorkflowID, a.MaterialRequestWorkflowTempItemID
FROM pMaterialRequestWorkflowTemplateItem a WITH (NOLOCK)
INNER JOIN pMaterialRequestWorkflow b WITH (NOLOCK) ON a.MaterialRequestWorkflowID = b.MaterialRequestWorkflowID
WHERE a.MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID AND b.MaterialRequestWorkflowColor = 1

--***Get counts.          
SELECT @TotalCount = COUNT(*)
FROM #tempNoColorMaterialRequestWorkflowIDs

SET @RowCounter = 1

--***Loop to get already existing 'no color' bubble info and add it for the new 'no color' bubble.          
WHILE (@RowCounter <= @TotalCount)
BEGIN
	--***Make new ID.          
	SET @NewMaterialRequestSubmitWorkflowID = NEWID()
	--***Clear variables.          
	SET @MaterialRequestWorkflowID = NULL

	--***Get a workflow ID to work with.          
	SELECT @MaterialRequestWorkflowID = MaterialRequestWorkflowID, @MaterialRequestWorkflowTempItemID = MaterialRequestWorkflowTempItemID
	FROM #tempNoColorMaterialRequestWorkflowIDs
	WHERE TableRow = @RowCounter

	--***Check to see that a record already doesn't exist.          
	IF NOT EXISTS (
			SELECT *
			FROM pMaterialRequestSubmitWorkflow WITH (NOLOCK)
			WHERE MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID
			)
	BEGIN
		--***Get 'MaterialRequestSubmitWorkflowID' of an already existing 'no color'           
		--***record that will be used as the source to copy info from.          
		SELECT TOP 1 @MaterialRequestSubmitWorkflowID_Other = MaterialRequestSubmitWorkflowID
		FROM pMaterialRequestSubmitWorkflow WITH (NOLOCK)
		WHERE MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID

		IF @MaterialRequestSubmitWorkflowID_Other IS NOT NULL
		BEGIN
			--***Add new 'no color' record to the 'pMaterialRequestSubmitWorkflow' table using mostly source info.          
			INSERT INTO pMaterialRequestSubmitWorkflow (MaterialRequestSubmitWorkflowID, MaterialTradePartnerID, MaterialTradePartnerColorID, MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialID, MaterialColorID, TradePartnerID, TradePartnerVendorID, [Status], Submit, SubmitDays, ResubmitDays, AssignedTo, StartDate, DueDate, EndDate, CDate, CUser, MDate, MUser, TUser, TDate, FinalDate, AgentView, MaterialRequestSubmitAllColors, MaterialRequestPartnerTypeID)
			SELECT @NewMaterialRequestSubmitWorkflowID, @MaterialTradePartnerID, @MaterialTradePartnerColorID, @MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialID, @MaterialColorID, TradepartnerId, TradepartnerVendorId, [Status], Submit, SubmitDays, ResubmitDays, AssignedTo, StartDate, DueDate, EndDate, CDate, CUser, MDate, MUser, TUser, TDate, FinalDate, AgentView, MaterialRequestSubmitAllColors, MaterialRequestPartnerTypeID
			FROM pMaterialRequestSubmitWorkflow WITH (NOLOCK)
			WHERE MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID_Other
		END
		ELSE
		BEGIN
			--** from template  
			INSERT INTO pMaterialRequestSubmitWorkflow (MaterialTradePartnerID, MaterialTradePartnerColorID, MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialID, MaterialColorID, TradePartnerID, TradePartnerVendorID, [Status], Submit, SubmitDays, ResubmitDays, AssignedTo, StartDate, DueDate, EndDate, CDate, CUser, MDate, MUser, MaterialRequestSubmitAllColors, MaterialRequestPartnerTypeID)
			SELECT a.MaterialTradePartnerId, b.MaterialTradePartnerColorID, d.MaterialRequestWorkflowTempItemID, d.MaterialRequestWorkflowID, b.MaterialID, b.MaterialColorID, a.TradepartnerId, a.TradepartnerVendorId, 0 AS STATUS, 1 AS Submit, d.MaterialRequestWorkflowDays, d.MaterialRequestWorkflowRDays, d.MaterialRequestWorkflowAssignedTo, @StartDate, @DueDate, @EndDate, @CDate, @CUser, @CDate, @CUser, e.MaterialRequestWorkflowColor, d.MaterialRequestPartnerTypeID
			FROM pMaterialTradePartner a WITH (NOLOCK)
			INNER JOIN pMaterialTradePartnerColor b WITH (NOLOCK) ON a.MaterialTradePartnerId = b.MaterialTradePartnerID
			INNER JOIN pMaterialRequestWorkflowTemplateItem d WITH (NOLOCK) ON a.MaterialRequestWorkflowTempID = d.MaterialRequestWorkflowTempID
			INNER JOIN pMaterialRequestWorkflow e WITH (NOLOCK) ON d.MaterialRequestWorkflowID = e.MaterialRequestWorkflowID
			WHERE b.MaterialColorID = @MaterialColorID AND b.MaterialSizeID = @MaterialSizeID AND a.MaterialTradePartnerID = @MaterialTradePartnerID AND d.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
		END

		IF NOT EXISTS (
				SELECT *
				FROM pMaterialRequestSubmit a
				INNER JOIN pMaterialRequestSubmitWorkflow b ON a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID
				WHERE b.MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID
				)
		BEGIN
			DECLARE @MaterialRequestSubmitGroupID UNIQUEIDENTIFIER

			SET @MaterialRequestSubmitGroupID = NEWID()
			SET @MaterialRequestSubmitID = NEWID()

			INSERT INTO pMaterialRequestSubmit (MaterialRequestSubmitID, MaterialRequestSubmitWorkflowID, MaterialTradePartnerColorID, MaterialTradePartnerID, Submit, [Status], AssignedTo, StartDate, SubmitDays, ResubmitDays, DueDate, EndDate, CDate, CUser, MDate, MUser, MaterialRequestSubmitGroupID)
			SELECT @MaterialRequestSubmitID, a.MaterialRequestSubmitWorkflowID, a.MaterialTradePartnerColorID, b.MaterialTradePartnerId, 1 AS Submit, 0 AS [Status], a.AssignedTo, a.StartDate, a.SubmitDays, a.ResubmitDays, a.DueDate, a.EndDate, @CDate AS CDate, @CUser AS CUser, @CDate AS MDate, @CUser AS MUser, @MaterialRequestSubmitGroupID
			FROM pMaterialRequestSubmitWorkflow a WITH (NOLOCK)
			INNER JOIN pMaterialTradePartner b WITH (NOLOCK) ON a.MaterialTradePartnerID = b.MaterialTradePartnerId
			INNER JOIN pMaterialRequestWorkflow d WITH (NOLOCK) ON d.MaterialRequestWorkflowID = a.MaterialRequestWorkflowID
			INNER JOIN pMaterialRequestWorkflowTemplateItem e WITH (NOLOCK) ON d.MaterialRequestWorkflowID = e.MaterialRequestWorkflowID AND a.MaterialRequestWorkflowTempItemID = e.MaterialRequestWorkflowTempItemID
			WHERE a.MaterialTradePartnerID = @MaterialTradePartnerID AND a.MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND a.MaterialRequestWorkflowID = @MaterialRequestWorkflowID

			INSERT INTO dbo.pMaterialRequestSubmitGroup (MaterialRequestSubmitGroupID, MaterialTradePartnerID, MaterialRequestWorkflowID, MaterialTradePartnerColorID)
			VALUES (@MaterialRequestSubmitGroupID, @MaterialTradePartnerID, @MaterialRequestWorkflowID, @MaterialTradePartnerColorID)
		END
	END --End the 'IF' statement.          
	ELSE
	BEGIN
		UPDATE pMaterialRequestSubmitWorkflow
		SET MaterialRequestWorkflowTempItemID = @MaterialRequestWorkflowTempItemID
		WHERE MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID

		-- Update PartnerOwner field for all related records of table pMaterialRequestSubmitWorkflow 
		-- because MaterialRequestWorkflow for All Colors
		UPDATE pMaterialRequestSubmitWorkflow
		SET MaterialRequestPartnerTypeID = (
				SELECT MaterialRequestPartnerTypeID
				FROM pMaterialRequestSubmitWorkflow
				WHERE MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID AND MaterialRequestSubmitAllColors = 1
				)
		WHERE MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialRequestWorkflowID = @MaterialRequestWorkflowID AND MaterialRequestSubmitAllColors = 1
	END

	--***Up counter.          
	SET @RowCounter = @RowCounter + 1
END --End the loop of going through the 'no color' workflow bubbles.          

-- "Color" workflows  
BEGIN
	INSERT INTO pMaterialRequestSubmitWorkflow (
		MaterialTradePartnerID, MaterialTradePartnerColorID, MaterialRequestWorkflowTempItemID, MaterialRequestWorkflowID, MaterialID, MaterialColorID, TradePartnerID, TradePartnerVendorID, [Status], Submit, SubmitDays, ResubmitDays, AssignedTo, StartDate, DueDate, EndDate, CDate, CUser, MDate, MUser, MaterialRequestSubmitAllColors --- comment #03           
		, MaterialRequestPartnerTypeID
		)
	SELECT a.MaterialTradePartnerId, b.MaterialTradePartnerColorID, d.MaterialRequestWorkflowTempItemID, d.MaterialRequestWorkflowID, b.MaterialID, b.MaterialColorID, a.TradepartnerId, a.TradepartnerVendorId, 0 AS STATUS, 1 AS Submit, d.MaterialRequestWorkflowDays, d.MaterialRequestWorkflowRDays, d.MaterialRequestWorkflowAssignedTo, @StartDate, ISNULL(@DueDate, DATEADD(DAY, ISNULL(d.MaterialRequestWorkflowDays, 0), @StartDate)),
		--WI # 4662 - Check if due date is null then add startdate + MaterialRequestWorkflowDays                      
		@EndDate, @CDate, @CUser, @CDate, @CUser, e.MaterialRequestWorkflowColor --- comment #03           
		, d.MaterialRequestPartnerTypeID
	FROM pMaterialTradePartner a WITH (NOLOCK)
	INNER JOIN pMaterialTradePartnerColor b WITH (NOLOCK) ON a.MaterialTradePartnerId = b.MaterialTradePartnerID
	INNER JOIN pMaterialRequestWorkflowTemplateItem d WITH (NOLOCK) ON a.MaterialRequestWorkflowTempID = d.MaterialRequestWorkflowTempID
	INNER JOIN pMaterialRequestWorkflow e WITH (NOLOCK) ON d.MaterialRequestWorkflowID = e.MaterialRequestWorkflowID --Comment #02          
	LEFT OUTER JOIN pMaterialRequestSubmitWorkflow f WITH (NOLOCK) ON f.MaterialRequestWorkflowID = d.MaterialRequestWorkflowID AND f.MaterialTradePartnerColorID = @MaterialTradePartnerColorID
	WHERE b.MaterialColorID = @MaterialColorID AND b.MaterialSizeID = @MaterialSizeID AND a.MaterialTradePartnerID = @MaterialTradePartnerID AND f.MaterialRequestWorkflowID IS NULL

	INSERT INTO pMaterialRequestSubmit (MaterialRequestSubmitWorkflowID, MaterialTradePartnerColorID, MaterialTradePartnerID, Submit, [Status], AssignedTo, StartDate, SubmitDays, ResubmitDays, DueDate, EndDate, CDate, CUser, MDate, MUser)
	SELECT a.MaterialRequestSubmitWorkflowID, c.MaterialTradePartnerColorID, b.MaterialTradePartnerId, 1 AS Submit, 0 AS [Status], a.AssignedTo, a.StartDate, a.SubmitDays, a.ResubmitDays, a.DueDate, a.EndDate, @CDate AS CDate, @CUser AS CUser, @CDate AS MDate, @CUser AS MUser
	FROM pMaterialRequestSubmitWorkflow a WITH (NOLOCK)
	INNER JOIN pMaterialTradePartner b WITH (NOLOCK)
	INNER JOIN pMaterialTradePartnerColor c WITH (NOLOCK) ON b.MaterialTradePartnerId = c.MaterialTradePartnerID ON a.MaterialTradePartnerColorID = c.MaterialTradePartnerColorID INNER JOIN pMaterialRequestWorkflow d WITH (NOLOCK)
	INNER JOIN pMaterialRequestWorkflowTemplateItem e WITH (NOLOCK) ON d.MaterialRequestWorkflowID = e.MaterialRequestWorkflowID ON a.MaterialRequestWorkflowTempItemID = e.MaterialRequestWorkflowTempItemID LEFT OUTER JOIN pMaterialRequestSubmit f WITH (NOLOCK) ON f.MaterialRequestSubmitWorkflowID = a.MaterialRequestSubmitWorkflowID AND f.MaterialTradePartnerColorID = @MaterialTradePartnerColorID WHERE c.MaterialColorID = @MaterialColorID AND c.MaterialSizeID = @MaterialSizeID AND b.MaterialTradePartnerID = @MaterialTradePartnerID AND f.MaterialRequestSubmitWorkflowID IS NULL AND d.MaterialRequestWorkflowColor = 0
END

--***Drop temp tables.          
DROP TABLE #tempNoColorMaterialRequestWorkflowIDs

--DROP TABLE #tempNoColorMaterialRequestWorkflowIDs_Exist          
DROP TABLE #tempMaterialRequestSubmitIDs

UPDATE pMaterialRequestSubmitWorkflow
SET DueDate = ISNULL(@DueDate, DATEADD(day, ISNULL(pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowDays, 0), pMaterialTradePartner.MaterialrequestWorkflowStartDate))
FROM pMaterialRequestSubmitWorkflow
INNER JOIN pMaterialTradePartnerColor ON pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = pMaterialTradePartnerColor.MaterialTradePartnerColorID
INNER JOIN pMaterialTradePartner ON pMaterialTradePartner.MaterialTradepartnerID = pMaterialTradePartnerColor.MaterialTradePartnerID
INNER JOIN pMaterialRequestWorkflowTemplateItem ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID = pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempItemID
WHERE pMaterialTradePartnerColor.MaterialTradePartnerColorID = @MaterialTradePartnerColorID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06504', GetDate())
GO
