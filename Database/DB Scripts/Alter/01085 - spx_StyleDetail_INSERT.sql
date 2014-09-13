IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetail_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleDetail_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleDetail_INSERT](
@StyleDesignDetailID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@CreatedBy NVARCHAR(100),
@CreatedDate DATETIME,
@SessionItemTempID UNIQUEIDENTIFIER
)
AS 

CREATE TABLE [#tempStyleDesign] ( 
	RecID						INT IDENTITY(1,1)  NOT NULL,
	StyleDesignDetailID		UNIQUEIDENTIFIER NULL,
	StyleDesignMasterID		UNIQUEIDENTIFIER NULL,
	StyleID               	UNIQUEIDENTIFIER NULL,
	CUser                 	NVARCHAR(200) NULL,
	CDate                 	DATETIME NULL,
	MUser                 	NVARCHAR(200) NULL,
	MDate                 	DATETIME NULL,
	StyleLinkID				UNIQUEIDENTIFIER,
	StyleNonApparel			INT
)


DECLARE 
	@RowStyleLoop 			INT,
	@RowStyleCount 			INT,
	@tmpStyleID				UNIQUEIDENTIFIER,
	@tmpStyleVariation		INT,
	@StyleDesignMasterID UNIQUEIDENTIFIER,
	@StyleDevelopmentId	UNIQUEIDENTIFIER,
	@tmpStyleDesignDetailID UNIQUEIDENTIFIER, 
	@StyleDetailLinkItemID UNIQUEIDENTIFIER
	
DECLARE 
	@StyleNonApparel INT,
	@StyleLinkID UNIQUEIDENTIFIER
	

DECLARE @nSort AS INT 
DECLARE @nMax AS INT 
DECLARE @nCount AS INT
DECLARE @vcCount AS VARCHAR (4)


SET @StyleDesignMasterID = NEWID()

SELECT @tmpStyleVariation = a.Variation, @StyleDevelopmentId = a.StyleDevelopmentId 
FROM pStyleDevelopmentItem a WITH (NOLOCK) 
	INNER JOIN dbo.pStyleHeader b WITH (NOLOCK) ON  a.StyleID = b.StyleID
	INNER JOIN dbo.pStyleType c WITH(NOLOCK) ON c.StyleTypeID = b.StyleType
WHERE a.StyleId = @StyleId


BEGIN
	INSERT INTO #tempStyleDesign( StyleDesignMasterID, StyleID, StyleDesignDetailID,
		StyleLinkID, StyleNonApparel)
	SELECT @StyleDesignMasterID, a.StyleID, NEWID(), 
		b.StyleLinkID, c.StyleNonApparel
	FROM pStyleDevelopmentItem a WITH (NOLOCK)
		INNER JOIN dbo.pStyleHeader b WITH (NOLOCK) ON a.StyleID = b.StyleID
		INNER JOIN dbo.pStyleType c WITH(NOLOCK) ON b.StyleType = c.StyleTypeID
	WHERE a.StyleDevelopmentID = @StyleDevelopmentId AND a.Variation = @tmpStyleVariation
	
END

SET @RowStyleLoop = 1
SELECT @RowStyleCount = COUNT(*) FROM #tempStyleDesign

WHILE @RowStyleLoop <= @RowStyleCount 
BEGIN

	SELECT @tmpStyleID = StyleID, @tmpStyleDesignDetailID = StyleDesignDetailID, 
		@StyleNonApparel = StyleNonApparel, @StyleLinkID = StyleLinkID
	FROM #tempStyleDesign WHERE RecID = @RowStyleLoop

	SELECT @nCount = COUNT(*) FROM pStyleDetail WITH (NOLOCK) WHERE StyleId = @tmpStyleID  AND  StyleSet = @StyleSet 
	SELECT @nMax = CAST (MAX (Sort)  AS INT ) FROM pStyleDetail WITH (NOLOCK) WHERE StyleId = @tmpStyleID  AND  StyleSet = @StyleSet 
	
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	
	IF @nCount > @nMax 	
		SET @nSort = @nCount 
	ELSE 	
		SET @nSort = @nMax 
	
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '0000' +  CAST ( @nSort AS NVARCHAR (4) ) , 2 )
	

	IF @StyleId = @tmpStyleId
	BEGIN
		UPDATE #tempStyleDesign SET StyleDesignDetailID = @StyleDesignDetailID WHERE RecID = @RowStyleLoop
		SET @tmpStyleDesignDetailID = @StyleDesignDetailID 
	END

	--** APPAREL AND LINKED STYLE
	IF @StyleNonApparel = 0 AND @StyleLinkID IS NOT NULL 
	BEGIN
		SELECT TOP 1 @StyleDetailLinkItemID = a.StyleDetailLinkItemID 
		FROM dbo.pStyleDetail a
			INNER JOIN dbo.pStyleHeader b ON a.StyleID =  b.StyleID 
		WHERE b.StyleLinkID = @StyleLinkID AND a.SessionItemTempID = @SessionItemTempID
		
		IF @StyleDetailLinkItemID IS NULL
			SET @StyleDetailLinkItemID =  NEWID()
	END 

	INSERT INTO pStyleDetail (StyleDesignDetailID, StyleDesignMasterID, StyleID, StyleSet, 
		CUser, CDate, MUser, MDate , Sort, SessionItemTempID, StyleDetailLinkItemID)
	VALUES ( @tmpStyleDesignDetailID, @StyleDesignMasterID, @tmpStyleID, @StyleSet, 
		@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @vcCount , @SessionItemTempID, @StyleDetailLinkItemID)

	SET @RowStyleLoop = @RowStyleLoop + 1
	
END



----*** 
--IF @StyleNonApparel = 0 AND @StyleLinkID IS NOT NULL 
--BEGIN 
--	SET @RowStyleLoop = 1 
--	SELECT @RowStyleCount  = COUNT(*) FROM #tempStyleDesign
	
--	WHILE  @RowStyleLoop <= @RowStyleCount  
--	BEGIN 
	
--		SELECT @StyleID = StyleID , @StyleDesignDetailID =  StyleDesignDetailID
--		FROM #tempStyleDesign WHERE  RecID = @RowStyleLoop 
		
--		EXECUTE dbo.spx_StyleDesignDetailLogic_UPDATE
--			@StyleDesignDetailID = @StyleDesignDetailID,
--			@MUser = @CreatedBy,
--			@MDate  = @CreatedDate,	
--			@TeamID  = NULL
			
--		SET @RowStyleLoop = @RowStyleLoop + 1 
--	END 
	
--END 



