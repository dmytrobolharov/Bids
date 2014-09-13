IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetail_Link_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleDetail_Link_INSERT]
GO

CREATE PROCEDURE dbo.spx_StyleDetail_Link_INSERT(
@StyleID UNIQUEIDENTIFIER, 
@StyleSet INT ,
@CUser NVARCHAR(200),
@CDate DATETIME 
)
AS 


DECLARE 
	@StyleLinkID UNIQUEIDENTIFIER,
	@NewStyleDesignDetailID UNIQUEIDENTIFIER,
	@SessionItemTempID UNIQUEIDENTIFIER


SET @SessionItemTempID = NEWID()

SELECT @StyleLinkID = StyleLinkID FROM dbo.pStyleHeader WITH(NOLOCK)
WHERE StyleID = @StyleID

IF @StyleLinkID IS NULL 
BEGIN 
	SET @NewStyleDesignDetailID = NEWID()
	
	EXEC spx_StyleDetail_INSERT 
		@StyleDesignDetailID = @NewStyleDesignDetailID,
		@StyleID  = @StyleID,
		@StyleSet = @StyleSet,
		@CreatedBy = @CUser, 
		@CreatedDate = @CDate,
		@SessionItemTempID = NULL
		
END 
ELSE 
BEGIN 

	CREATE TABLE #tmpStyle(
		ROWID INT IDENTITY(1,1),
		StyleID UNIQUEIDENTIFIER
	)

	INSERT INTO #tmpStyle( StyleID )
	SELECT StyleID FROM dbo.pStyleHeader WITH(NOLOCK) WHERE StyleLinkID = @StyleLinkID
	
	DECLARE 
		@ROWID INT,
		@TOTAL INT
		
		
	SET @ROWID = 1 
	SELECT @TOTAL =  COUNT(*) FROM #tmpStyle 
		
	WHILE @ROWID <= @TOTAL
	BEGIN 
		SELECT @StyleID  = StyleID FROM #tmpStyle WHERE ROWID = @ROWID 
		SET @NewStyleDesignDetailID = NEWID()

		EXEC spx_StyleDetail_INSERT 
			@StyleDesignDetailID = @NewStyleDesignDetailID,
			@StyleID  = @StyleID,
			@StyleSet = @StyleSet,
			@CreatedBy = @CUser, 
			@CreatedDate = @CDate,
			@SessionItemTempID = @SessionItemTempID

		SET @ROWID = @ROWID + 1 
	END 
		
	DROP TABLE #tmpStyle

END 






