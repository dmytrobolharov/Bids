IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialLinkMaterial_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialLinkMaterial_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialLinkMaterial_DELETE](
	@MaterialLinkID  UNIQUEIDENTIFIER  
)
AS


DELETE FROM pMaterialLinkColorwayItem 
WHERE MaterialLinkID  = @MaterialLinkID  

DELETE FROM pMaterialLink WHERE MaterialLinkID  = @MaterialLinkID

--** Remove submaterials from styleMaterials
DECLARE 
	@ROWID INT,
	@TOTAL INT,
	@StyleMaterialID UNIQUEIDENTIFIER
	

CREATE TABLE #sm(
	ROWID INT IDENTITY(1,1),
	StyleMaterialID UNIQUEIDENTIFIER
)

INSERT INTO #sm ( StyleMaterialID )
SELECT StyleMaterialID FROM dbo.pStyleMaterials
WHERE MaterialLinkID = @MaterialLinkID
	

SET @ROWID = 1 
SELECT @TOTAL = COUNT(*) FROM #sm

WHILE @ROWID <= @TOTAL 
BEGIN

	SELECT @StyleMaterialID = StyleMaterialID FROM #sm WHERE ROWID = @ROWID 

	EXEC spx_StyleMaterial_DELETE 
		@StyleMaterialID = @StyleMaterialID,
		@ChangeTransID = NULL,
		@ChangeTransUserID = NULL,
		@MUser = NULL,
		@MDate = NULL
				
	SET @ROWID = @ROWID + 1 
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01025', GetDate())
GO
	
	

					
	