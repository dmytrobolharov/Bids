/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialLogic_UPDATE]    Script Date: 11/19/2012 13:52:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialLogic_UPDATE]    Script Date: 11/19/2012 13:52:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_StyleMaterialLogic_UPDATE] (
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT, 
@MDate DATETIME,
@MUser NVARCHAR (200)
)
AS 


DECLARE @MatRow INT
DECLARE @MatCurrent INT
DECLARE @MatTotal INT

DECLARE @StyleMaterialMasterID UNIQUEIDENTIFIER 
DECLARE @MaterialTrack INT
DECLARE @UOM NVARCHAR(50)
DECLARE @Qty NVARCHAR(18)
DECLARE @MaterialPrice MONEY 
DECLARE @MaterialSize NVARCHAR (200)
DECLARE @MaterialSizeID UNIQUEIDENTIFIER 
DECLARE @Colorway INT
DECLARE @Artwork INT
DECLARE @License INT
DECLARE @Placement NVARCHAR(4000)

DECLARE @StyleMaterialID  UNIQUEIDENTIFIER
DECLARE @MaterialID UNIQUEIDENTIFIER

/**********************************************************************/
-- Update MaterialSize 
CREATE TABLE #tmpMat  (
	ROWID INT IDENTITY(1,1),
	StyleMaterialID UNIQUEIDENTIFIER ,
	MaterialID UNIQUEIDENTIFIER ,
	MaterialSizeID UNIQUEIDENTIFIER 
)

INSERT INTO  #tmpMat  ( StyleMaterialID, MaterialID, MaterialSizeID)
SELECT  StyleMaterialID, MaterialID, MaterialSizeID
FROM pStyleMaterials 
WHERE StyleID = @StyleID 
AND StyleSet = @StyleSet 

SET @MatRow = 1
SELECT @MatTotal = COUNT (*)  FROM #tmpMat

WHILE @MatRow <= @MatTotal 
BEGIN
	SELECT @StyleMaterialID =  StyleMaterialID , @MaterialID = MaterialID , @MaterialSizeID = MaterialSizeID
	FROM #tmpMat
	WHERE ROWID = @MatRow

	IF @MaterialSizeID IS NULL OR @MaterialSizeID  = '00000000-0000-0000-0000-000000000000'
		SET @MaterialSize = '*NA'
	ELSE
		SELECT @MaterialSize = MaterialSize FROM pMaterialSize WHERE MaterialSizeID = @MaterialSizeID 

	UPDATE pStyleMaterials SET MaterialSize = @MaterialSize WHERE StyleMaterialID = @StyleMaterialID 
		
	SET @MatRow = @MatRow  + 1 
END 



CREATE TABLE #tmpMaterial  (
	ROWID INT IDENTITY(1,1),
	StyleMaterialMasterID UNIQUEIDENTIFIER , 
	StyleMaterialID UNIQUEIDENTIFIER,
	MaterialTrack INT, 
	UOM NVARCHAR(50),
	Qty NVARCHAR(18),
	MaterialPrice MONEY ,
	MaterialSize NVARCHAR (200),
	MaterialSizeID UNIQUEIDENTIFIER , 
	Colorway INT,
	Artwork INT,
	License INT, 
	Placement NVARCHAR(4000)
)

INSERT INTO  #tmpMaterial (StyleMaterialMasterID , MaterialTrack, UOM,Qty, MaterialPrice, MaterialSize, MaterialSizeID , 
Colorway, Artwork, License, Placement , StyleMaterialID )
SELECT StyleMaterialMasterID , MaterialTrack, UOM,Qty, MaterialPrice, MaterialSize, MaterialSizeID , 
Colorway, Artwork, License, Placement , StyleMaterialID 
FROM pStyleMaterials 
WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
AND MaterialLinked = 1


DECLARE @DevelopmentID UNIQUEIDENTIFIER 

SELECT @DevelopmentID = StyleDevelopmentID
FROM pStyleDevelopmentItem 
WHERE StyleID = @StyleID

SELECT @MatTotal  = COUNT(*) FROM #tmpMaterial
SET @MatCurrent = 1 

WHILE @MatCurrent <= @MatTotal 
BEGIN
	
	SELECT @StyleMaterialMasterID = StyleMaterialMasterID,
	@MaterialTrack = MaterialTrack,
	@UOM = UOM,
	@Qty = Qty,
	@MaterialPrice = MaterialPrice,
	@MaterialSize = MaterialSize,
	@MaterialSizeID = MaterialSizeID,
	@Colorway = Colorway,
	@Artwork = Artwork, 
	@License = License,
	@Placement = Placement,
	@StyleMaterialID = StyleMaterialID
	FROM #tmpMaterial WHERE ROWID = @MatCurrent
		
	UPDATE pStyleMaterials SET 
	MaterialTrack = @MaterialTrack,
	UOM = @UOM,
	Qty = @Qty,
	MaterialPrice = @MaterialPrice,
	MaterialSize = @MaterialSize,
	MaterialSizeID = @MaterialSizeID,
	Colorway = @Colorway,
	Artwork = @Artwork, 
	License = @License,
	Placement = @Placement ,
	MDate = @MDate,
	MUser  = @MUser 
	WHERE StyleMaterialMasterID = @StyleMaterialMasterID
	AND MaterialLinked = 1 
	AND StyleID IN ( 
		SELECT StyleID FROM pStyleDevelopmentItem 
		WHERE StyleDevelopmentID = @DevelopmentID
		AND StyleID <>  @StyleID
	)  
	SET @MatCurrent = @MatCurrent + 1 
	
	Update pStyleSourcingItem SET
	UOM = (Select UOM from pStyleMaterials where StyleMaterialID  = @StyleMaterialID and StyleSet = @StyleSet),
	Qty = (Select Qty from pStyleMaterials where StyleMaterialID = @StyleMaterialID and StyleSet = @StyleSet),
	MaterialPrice = (Select MaterialPrice from pStyleMaterials where StyleMaterialID = @StyleMaterialID and StyleSet = @StyleSet)
	Where StyleMaterialID = @StyleMaterialID and StyleSet = @StyleSet 
END 

DROP TABLE #tmpMaterial 


-------------------------------------------------------------
-- Update pStyleHeader 


DECLARE @MaterialImageID UNIQUEIDENTIFIER
DECLARE @MaterialImageVersion INT
DECLARE @MaterialNo NVARCHAR (50)
DECLARE @MaterialName  NVARCHAR (200)


SELECT TOP  1  
@MaterialID = MaterialID , 
@MaterialImageID = MaterialImageID,
@MaterialImageVersion  = MaterialImageVersion ,
@MaterialNo = MaterialNo ,
@MaterialName = MaterialName ,
@StyleMaterialID = StyleMaterialID
FROM pStyleMaterials 
WHERE StyleID = @StyleID AND MainMaterial = 1

UPDATE pStyleHeader SET 
MaterialID = @MaterialID , 
MaterialImageID = @MaterialImageID,
MaterialImageVersion  = @MaterialImageVersion ,
MaterialNo = @MaterialNo ,
MaterialName = @MaterialName ,
StyleMaterialID = @StyleMaterialID
WHERE StyleID = @StyleID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04372', GetDate())
GO
