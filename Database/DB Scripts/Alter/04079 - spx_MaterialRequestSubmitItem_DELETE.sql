
/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitItem_DELETE]    Script Date: 10/03/2012 11:45:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitItem_DELETE]
GO


/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitItem_DELETE]    Script Date: 10/03/2012 11:45:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/*
Comments:

#01 - Ryan Cabanas - August 27, 2009
	There's a new feature to the Material Sample Workflow area under a TradePartner
at the Material.  You are now able to have an "all colors" workflow bubble, but
there is still individual color records behind the scenes.  Need to make sure that
they are in sync when something changes.
*/


create PROCEDURE [dbo].[spx_MaterialRequestSubmitItem_DELETE](@MaterialRequestSubmitItemID uniqueidentifier)
AS 


--/************/
--/*Testing.	*/
--/************/
--BEGIN
--	DECLARE @MaterialRequestSubmitItemID uniqueidentifier
--
--	SET @MaterialRequestSubmitItemID = '7841d5dd-338a-46bf-87d8-67cea98eeb85'
--END



--Comment #01
/********************************************************************/
/*Get some pertinent info before the original grid item is deleted.	*/
/********************************************************************/
BEGIN
	/*Declare Variables.*/
	DECLARE @MaterialRequestSubmitID uniqueidentifier
	DECLARE @MaterialRequestWorkflowItemID uniqueidentifier
	DECLARE @MaterialRequestSubmitItemCustom1 nvarchar(200)

	/*Get grid item info.*/
	SELECT @MaterialRequestSubmitID = MaterialRequestSubmitID
		,@MaterialRequestWorkflowItemID = MaterialRequestWorkflowItemID
		,@MaterialRequestSubmitItemCustom1 = MaterialRequestSubmitItemCustom1
	FROM pMaterialRequestSubmitItem
	WHERE MaterialRequestSubmitItemID  = @MaterialRequestSubmitItemID
END



--Comment #01
/********************************************************/
/*Find out if the workflow is a 'no color' workflow.	*/
/********************************************************/
BEGIN
	/*Declare variable.*/
	DECLARE @MaterialRequestWorkflowColor int

	/*Get flag.  If '0', then it's a 'no color' workflow.*/
	SELECT @MaterialRequestWorkflowColor = MaterialRequestWorkflowColor
	FROM pMaterialRequestSubmitItem
		INNER JOIN pMaterialRequestSubmit	ON	pMaterialRequestSubmitItem.MaterialRequestSubmitID = pMaterialRequestSubmit.MaterialRequestSubmitID
		INNER JOIN pMaterialRequestSubmitWorkflow	ON	pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID
		INNER JOIN pMaterialRequestWorkflow	ON	pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
	WHERE pMaterialRequestSubmitItem.MaterialRequestSubmitItemID = @MaterialRequestSubmitItemID
END



DELETE FROM pMaterialRequestSubmitItem 
WHERE MaterialRequestSubmitItemID  = @MaterialRequestSubmitItemID



--Comment #01
/*Delete grid record from other 'no color' workflows, if applicable.*/
IF @MaterialRequestWorkflowColor = 1	--It's a 'no color' grid record.
	BEGIN
		/*Declare variables.*/
		DECLARE @MaterialRequestSubmitID_Original uniqueidentifier
		DECLARE @MaterialRequestSubmitID_Other uniqueidentifier
		DECLARE @TotalCount int
		DECLARE @RowCounter int

		/*Create temp table.*/
		CREATE TABLE #temp_MaterialRequestSubmitIDs(
			TableRow int identity(1,1)
			,MaterialRequestSubmitID uniqueidentifier)

		/*Use my own variable names.*/
		SET @MaterialRequestSubmitID_Original = @MaterialRequestSubmitID

		/*Get IDs of the other 'no color' records.*/
		INSERT INTO #temp_MaterialRequestSubmitIDs(MaterialRequestSubmitID)
		SELECT pMaterialRequestSubmit_OtherColors.MaterialRequestSubmitID
		FROM pMaterialRequestSubmitWorkflow
			INNER JOIN pMaterialRequestSubmit	ON	pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID
													AND pMaterialRequestSubmitWorkflow.Submit = pMaterialRequestSubmit.Submit
			INNER JOIN pMaterialRequestSubmitWorkflow AS pMaterialRequestSubmitWorkflow_OtherColors	ON	pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = pMaterialRequestSubmitWorkflow_OtherColors.MaterialTradePartnerID
																										AND pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow_OtherColors.MaterialRequestWorkflowID
																										AND pMaterialRequestSubmitWorkflow.Submit = pMaterialRequestSubmitWorkflow_OtherColors.Submit
			INNER JOIN pMaterialRequestSubmit AS pMaterialRequestSubmit_OtherColors	ON	pMaterialRequestSubmitWorkflow_OtherColors.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit_OtherColors.MaterialRequestSubmitWorkflowID
													AND pMaterialRequestSubmitWorkflow_OtherColors.Submit = pMaterialRequestSubmit_OtherColors.Submit
		WHERE pMaterialRequestSubmit.MaterialRequestSubmitID = @MaterialRequestSubmitID_Original
			AND pMaterialRequestSubmit_OtherColors.MaterialRequestSubmitID <> @MaterialRequestSubmitID_Original

		/*Get and set counts.*/
		SELECT @TotalCount = COUNT(*) FROM #temp_MaterialRequestSubmitIDs
		SET @RowCounter = 1

		/*Loop to add grid records for the other 'no colors'.*/
		WHILE(@RowCounter <= @TotalCount)
			BEGIN
				/*Get a 'MaterialRequestSubmitID'.*/
				SELECT @MaterialRequestSubmitID_Other = MaterialRequestSubmitID
				FROM #temp_MaterialRequestSubmitIDs
				WHERE TableRow = @RowCounter

				/*Delete grid record for other 'no color'.*/
				DELETE
				FROM pMaterialRequestSubmitItem
				WHERE MaterialRequestSubmitID  = @MaterialRequestSubmitID_Other
					AND MaterialRequestWorkflowItemID = @MaterialRequestWorkflowItemID
					AND MaterialRequestSubmitItemCustom1 = @MaterialRequestSubmitItemCustom1

				/*Up row counter.*/
				SET @RowCounter = @RowCounter + 1
			END

		/*Drop temp table.*/
		DROP TABLE #temp_MaterialRequestSubmitIDs
	END

GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04079', GetDate())
GO