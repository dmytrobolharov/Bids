IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMaterial_DELETE') and sysstat & 0xf = 4)
    drop procedure spx_StyleMaterial_DELETE
GO


CREATE PROCEDURE [dbo].[spx_StyleMaterial_DELETE] (
@StyleMaterialID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200) =  NULL,
@MDate DATETIME = NULL
)
AS 

DECLARE @StyleMaterialMasterID uniqueidentifier
DECLARE @StyleColorItemMasterId uniqueidentifier


SELECT @StyleMaterialMasterID = StyleMaterialMasterID FROM pStyleMaterials WITH (NOLOCK) WHERE (StyleMaterialID = @StyleMaterialID)

BEGIN
	SELECT @StyleColorItemMasterId = StyleColorItemMasterId FROM pStyleColorwayItem WITH (NOLOCK) WHERE (StyleMaterialID = @StyleMaterialID)
	--DELETE FROM pStyleColorwayItem WHERE (StyleColorItemMasterId = @StyleColorItemMasterId)
END

DECLARE
@MainMaterial int,
@StyleId uniqueidentifier,
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
FROM pStyleMaterials WITH (NOLOCK) WHERE (StyleMaterialId = @StyleMaterialid)


IF @MainMaterial = 1
BEGIN
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

--***
--** Save StyleMaterialID to be deleted
--***
CREATE TABLE #tmpSM(
ROWID INT IDENTITY(1,1),
StyleMaterialID UNIQUEIDENTIFIER,
StyleID UNIQUEIDENTIFIER,
StyleSet INT,
MaterialNo NVARCHAR(200)
)

INSERT INTO  #tmpSM (StyleMaterialID, StyleID, StyleSet, MaterialNo) 
SELECT StyleMaterialID, StyleID, StyleSet, MaterialNo
FROM dbo.pStyleMaterials WHERE StyleMaterialID = @StyleMaterialID


/*******************************************/
/*Delete the Material from pStyleMaterials.*/
/*******************************************/
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
	INSERT INTO  #tmpSM (StyleMaterialID, StyleID, StyleSet, MaterialNo) 
	SELECT StyleMaterialID , StyleID, StyleSet, MaterialNo
	FROM pStyleMaterials	
	WHERE StyleMaterialMasterID = @StyleMaterialMasterID
	AND MaterialLinked = 1
	AND StyleID IN (
		SELECT StyleID
		FROM pStyleDevelopmentItem WITH (NOLOCK)
		WHERE StyleDevelopmentID = @StyleDevelopmentID
		AND Variation = @Variation
	)
	
	--Delete the material(s) from the Size Class(es) in the variation.
	--Make sure to delete the material for the Size Class selected.
	DELETE FROM pStyleMaterials WHERE (StyleMaterialID = @StyleMaterialID)
	
	--Delete any other materials in this variation that were linked to this material.
	DELETE FROM pStyleMaterials	WHERE (StyleMaterialMasterID = @StyleMaterialMasterID
										AND MaterialLinked = 1
										AND StyleID IN (SELECT StyleID
														FROM pStyleDevelopmentItem WITH (NOLOCK)
														WHERE StyleDevelopmentID = @StyleDevelopmentID
																AND Variation = @Variation))
END





/*=================================================================================================================================================================================
-- DELET MATERIAL FROM STYLE SOURCING AND MATERIAL SAMPLE REQUEST
=================================================================================================================================================================================*/

--DELETE FROM pSampleRequestMaterial WHERE StyleMaterialID = @StyleMaterialID 
--DELETE FROM pStyleSourcingItem WHERE StyleMaterialID = @StyleMaterialID

--***
--** DELETE every single record related to a StyleMaterialID 
--***
IF (SELECT COUNT(*) FROM #tmpSM ) > 0 
BEGIN 
	DELETE FROM pStyleColorwayItem
	WHERE StyleMaterialID IN ( 
		SELECT StyleMaterialID FROM #tmpSM
	)
	DELETE FROM pStyleSourcingItem
	WHERE StyleMaterialID IN ( 
		SELECT StyleMaterialID FROM #tmpSM
	)
	DELETE FROM dbo.pSampleRequestMaterial
	WHERE StyleMaterialID IN ( 
		SELECT StyleMaterialID FROM #tmpSM
	)
END 

--***
--** Register in Log, materials deleted
--***
DECLARE @ROWID INT 
DECLARE @TOTAL INT 
DECLARE @StyleSet INT 

SET @ROWID = 1 
SELECT @TOTAL  = COUNT(*) FROM #tmpSM 

SELECT @TOTAL   AS total

WHILE @ROWID <= @TOTAL 
BEGIN 
	SELECT @StyleID = StyleID, @StyleSet =StyleSet, @MaterialNo = MaterialNo
	FROM #tmpSM WHERE ROWID = @ROWID 

	EXEC spx_StyleMaterial_Log_INSERT 
	@StyleID = @StyleID,
	@StyleChangeType = 'Delete' ,  
	@MaterialNo = @MaterialNo ,
	@StyleSet  = @StyleSet,
	@CUser = @MUser, @CDate = @MDate

	SET @ROWID = @ROWID + 1 
END 

GO