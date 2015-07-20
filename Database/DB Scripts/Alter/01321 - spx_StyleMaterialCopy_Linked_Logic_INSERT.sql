IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialCopy_Linked_Logic_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMaterialCopy_Linked_Logic_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleMaterialCopy_Linked_Logic_INSERT](
	@StyleMaterialID UNIQUEIDENTIFIER, 
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@SQLUpdate NVARCHAR(MAX),
	@TeamID UNIQUEIDENTIFIER 
)
AS


DECLARE 
	@StyleLinkID UNIQUEIDENTIFIER,
	@TOTAL INT,
	@ROWID INT,
	@tmpStyleID  UNIQUEIDENTIFIER
	
	
SELECT @StyleLinkID = StyleLinkID  FROM pStyleHeader WITH(NOLOCK) WHERE StyleID = @StyleID  

CREATE TABLE #tmpStyle(
	ROWID INT IDENTITY(1,1),
	StyleID UNIQUEIDENTIFIER
)

IF @StyleLinkID IS NOT NULL 
BEGIN 
	INSERT INTO #tmpStyle (StyleID)
	SELECT StyleID  FROM dbo.pStyleHeader WITH (NOLOCK) WHERE StyleID	= @StyleID 
END 
ELSE 
BEGIN
	INSERT INTO #tmpStyle (StyleID ) VALUES (@StyleID)
END 

SELECT @TOTAL = COUNT(*) FROM #tmpStyle 
SET @ROWID = 1 

WHILE @ROWID <= @TOTAL
BEGIN
	SELECT @tmpStyleID = StyleID FROM #tmpStyle WHERE ROWID = @ROWID 	
	
	EXECUTE dbo.spx_StyleMaterialCopy_Logic_INSERT
		@StyleMaterialID = @StyleMaterialID,
		@StyleID = @tmpStyleID,
		@StyleSet = @StyleSet,
		@CUser = @CUser,
		@CDate = @CDate,
		@TeamID = @TeamID,
		@SQLUpdate = @SQLUpdate
		
	SET @ROWID = @ROWID + 1 
END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01321', GetDate())

GO