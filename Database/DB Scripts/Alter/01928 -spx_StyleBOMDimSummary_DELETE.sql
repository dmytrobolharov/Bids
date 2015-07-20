IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimSummary_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMDimSummary_DELETE]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMDimSummary_DELETE]    Script Date: 09/12/2011 10:35:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create PROCEDURE [dbo].[spx_StyleBOMDimSummary_DELETE] (
	@StyleMaterialID UNIQUEIDENTIFIER 
	,@StyleID UNIQUEIDENTIFIER
	,@StyleSet int
	,@StyleBOMDimensionId uniqueidentifier
	,@MDate datetime
	,@MUser nvarchar(200)	
)
AS 

DECLARE @StyleMaterialMasterID uniqueidentifier
DECLARE @StyleColorItemMasterId uniqueidentifier


SELECT @StyleMaterialMasterID = StyleMaterialMasterID FROM pStyleBOM WITH (NOLOCK) WHERE (StyleMaterialID = @StyleMaterialID)
--and StyleBOMDimensionId=@StyleBOMDimensionId


DECLARE
@MainMaterial int,
@MaterialId uniqueidentifier,
@MaterialImageId uniqueidentifier,
@MaterialImageVersion int,
@MaterialNo nvarchar(50),
@MaterialName nvarchar(200),
@MaterialNull nvarchar(50)


SELECT @MainMaterial = MainMaterial, 
	@StyleId = StyleId,
	@MaterialId = MaterialId,
	@MaterialImageId = MaterialImageId,
	@MaterialImageVersion = MaterialImageVersion,
	@MaterialNo = MaterialNo,
	@MaterialName = MaterialName 
FROM pStyleBOM WITH (NOLOCK) WHERE (StyleMaterialId = @StyleMaterialid)


IF @MainMaterial = 1
BEGIN
	--select @MainMaterial as MainMaterial
	SET @MaterialNull = '{00000000-0000-0000-0000-000000000000}'

	DECLARE @StyleMasterId uniqueidentifier
	SELECT @StyleMasterId = StyleMasterId FROM pStyleHeader WITH (NOLOCK) WHERE StyleId = @StyleId
	
	UPDATE dbo.pStyleHeader
		SET  MaterialID = @MaterialNull, MaterialImageID = @MaterialNull, MaterialImageVersion = 0, MaterialNo = NULL, 
		MaterialName = NULL, StyleMaterialID = @MaterialNull
	WHERE  (StyleID = @StyleId)
	
	UPDATE dbo.pStyleHeader
		SET  MaterialID = @MaterialNull, MaterialImageID = @MaterialNull, MaterialImageVersion = 0, MaterialNo = NULL, 
		MaterialName = NULL, StyleMaterialID = @MaterialNull
	WHERE  (StyleMasterID = @StyleMasterId) 
	
END

DELETE FROM pStyleBOM WHERE StyleMaterialID = @StyleMaterialID		
DELETE FROM pStyleBOMItem WHERE StyleMaterialID = @StyleMaterialID		

/*
--***
--** Save StyleMaterialID to be deleted
--***
CREATE TABLE #tmpSM(
	ROWID INT IDENTITY(1,1),
	StyleMaterialID UNIQUEIDENTIFIER,
	MaterialName NVARCHAR(200),
	MaterialNo NVARCHAR(200),
	StyleID UNIQUEIDENTIFIER
)


INSERT INTO  #tmpSM (StyleMaterialID, MaterialName, MaterialNo, StyleID) 
SELECT StyleMaterialID, MaterialName, MaterialNo, StyleID 
FROM dbo.pStyleBOM WITH (NOLOCK)
WHERE StyleMaterialID = @StyleMaterialID


--******************************************
--*Delete the Material from pStyleBOM.
--******************************************
BEGIN
	--Declare variables to hold the Variation and DevelopmentID to delete material from only the active variation.
	DECLARE @Variation int
	DECLARE @StyleDevelopmentID uniqueidentifier
	
	--Get the Variation and DevelopmentID information.
	SELECT @Variation = Variation,
		@StyleDevelopmentID = StyleDevelopmentID
	FROM pStyleDevelopmentItem WITH (NOLOCK)
	WHERE StyleID = @StyleID
	

	--***
	--** Save StyleMaterialID from Variations to be deleted
	--***
	INSERT INTO  #tmpSM (StyleMaterialID, MaterialName, MaterialNo, StyleID) 
	SELECT a.StyleMaterialID, a.MaterialName, a.MaterialNo, a.StyleID  
	FROM pStyleBOM a WITH (NOLOCK)
		INNER JOIN dbo.pStyleDevelopmentItem b WITH (NOLOCK) ON a.StyleID = b.StyleID
	WHERE a.StyleMaterialMasterID = @StyleMaterialMasterID
	AND a.MaterialLinked = 1
	AND b.StyleDevelopmentID = @StyleDevelopmentID
	AND b.Variation = @Variation
	--and a.StyleBOMDimensionId=@StyleBOMDimensionId

	
	----Delete the material(s) from the Size Class(es) in the variation.
	----Make sure to delete the material for the Size Class selected.
	--DELETE FROM pStyleBOM WHERE (StyleMaterialID = @StyleMaterialID)
	
	----Delete any other materials in this variation that were linked to this material.
	--DELETE FROM pStyleBOM	WHERE (StyleMaterialMasterID = @StyleMaterialMasterID
	--									AND MaterialLinked = 1
	--									AND StyleID IN (SELECT StyleID
	--													FROM pStyleDevelopmentItem WITH (NOLOCK)
	--													WHERE StyleDevelopmentID = @StyleDevelopmentID
	--															AND Variation = @Variation))
																
															
																
END





--=================================================================================================================================================================================
-- DELET MATERIAL FROM STYLE SOURCING AND MATERIAL SAMPLE REQUEST
--=================================================================================================================================================================================
DECLARE 
	@ROWID INT,
	@TOTAL INT,
	@tmpStyleMaterialID UNIQUEIDENTIFIER ,
	@ChangeLogID UNIQUEIDENTIFIER,
	@ChangeLogItemID UNIQUEIDENTIFIER,
	@ChangeBeforeText NVARCHAR(400)

SET @ROWID = 1
SELECT @TOTAL = COUNT(*) FROM #tmpSM  

select @TOTAL as TOTAL

WHILE @ROWID  <= @TOTAL
BEGIN
	select @TOTAL as TOTAL0
	SELECT @tmpStyleMaterialID = StyleMaterialID,
	@ChangeBeforeText = '('+ ISNULL(MaterialNo,'') + ') '  + ISNULL(MaterialName,''),
	@StyleID = StyleID
	FROM #tmpSM WHERE ROWID = @ROWID 
	
	
	--BEGIN TRANSACTION 
	
	--	IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
	--	BEGIN
	--		--** Log action
	--		SET @ChangeLogID = NULL
	--		SET @ChangeLogItemID = NULL 
						
	--		EXECUTE spx_ChangeLog_INSERTID
	--			@changeTableId = '036F8B4C-C1CC-DF11-AF06-005056C00008', -- pStyleBOM
	--			@changeTransId = @ChangeTransID,
	--			@changeTablePKId = @tmpStyleMaterialID,
	--			@changeUserId = @ChangeTransUserID, 
	--			@ChangeUserName = @MUser,
	--			@changeDate = @MDate,
	--			@changeSort = '0000',
	--			@ShowResult = 0,
	--			@ChangeLogID = @ChangeLogID OUTPUT
					
	--		EXECUTE spx_ChangeLogItem_INSERT
	--			@ChangeLogID = @ChangeLogID,
	--			@ChangeTransID = @ChangeTransID,
	--			@ChangeFieldName = 'StyleMaterialID',
	--			@ChangeFieldAlias = 'StyleMaterialID',
	--			@ChangeBeforeValue = @tmpStyleMaterialID,
	--			@ChangeAfterValue = @StyleID, -- Saving StyleID in AfterValue column, just as a temporary value, data need to be re arranged				
	--			@ChangeBeforeText = @ChangeBeforeText,
	--			@ChangeAfterText = NULL,
	--			@ChangeSort = '0001',
	--			@ChangeLogItemID = @ChangeLogItemID OUTPUT 	
		
	--	END 
		
		
	
		DELETE FROM pStyleBOM WHERE StyleMaterialID = @tmpStyleMaterialID		
			
		
	
	SET @ROWID = @ROWID + 1 
END			
	
	

--***
--** DELETE every single record related to a StyleMaterialID 
--***
IF EXISTS(SELECT * FROM #tmpSM )
BEGIN 
   select @TOTAL as TOTAL1
	DELETE FROM pStyleBOMItem
	WHERE StyleMaterialID IN ( 
		SELECT StyleMaterialID FROM #tmpSM
	)
	--DELETE FROM pStyleSourcingItem
	--WHERE StyleMaterialID IN ( 
	--	SELECT StyleMaterialID FROM #tmpSM
	--)
	--DELETE FROM dbo.pSampleRequestMaterial
	--WHERE StyleMaterialID IN ( 
	--	SELECT StyleMaterialID FROM #tmpSM
	--)
END 


DROP TABLE #tmpSM

*/

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01928'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01928', GetDate())
END

GO
