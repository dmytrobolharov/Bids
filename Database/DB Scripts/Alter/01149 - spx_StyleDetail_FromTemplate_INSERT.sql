IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetail_FromTemplate_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleDetail_FromTemplate_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleDetail_FromTemplate_INSERT](
	@TemplateStyleDetailID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@TeamID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS

DECLARE @StyleLinkID UNIQUEIDENTIFIER 

SELECT @StyleLinkID = StyleLinkID
FROM dbo.pStyleHeader WITH(NOLOCK)
WHERE StyleID = @StyleID 

IF @StyleLinkID IS NULL 
	INSERT INTO pStyleDetail (StyleID, StyleSet, Sort, FeatureDetail, Measurement, StitchType, Comments, CUser, CDate, MUser, MDate) 
	SELECT @StyleID, @StyleSet, Sort, FeatureDetail, Measurement, StitchType, Comments, CUser, CDate, MUser, MDate 
	FROM pTemplateStyleDetailItem WITH(NOLOCK)
	WHERE TemplateStyleDetailID = @TemplateStyleDetailID
ELSE
BEGIN

	DECLARE 
		@TemplateStyleDetailItemID UNIQUEIDENTIFIER,
		@StyleDetailLinkItemID UNIQUEIDENTIFIER,
		@TOTAL INT,
		@ROWID INT 
		

	CREATE TABLE #item(
		ROWID INT IDENTITY (1,1),	
		TemplateStyleDetailItemID UNIQUEIDENTIFIER,
		StyleDetailLinkItemID UNIQUEIDENTIFIER
	)
	
	INSERT INTO #item(TemplateStyleDetailItemID,StyleDetailLinkItemID)
	SELECT  TemplateStyleDetailItemID, NEWID()
	FROM pTemplateStyleDetailItem WITH(NOLOCK)
	WHERE TemplateStyleDetailID = @TemplateStyleDetailID
	
	
	SET @ROWID = 1 
	SELECT @TOTAL  = COUNT(*) FROM #item 
	
	WHILE @ROWID <= @TOTAL 
	BEGIN 
	
		SELECT @TemplateStyleDetailItemID = TemplateStyleDetailItemID, @StyleDetailLinkItemID = StyleDetailLinkItemID
		FROM #item WHERE ROWID = @ROWID 
		
		INSERT INTO pStyleDetail (StyleID, StyleSet, Sort, FeatureDetail, Measurement, StitchType, Comments, 
			CUser, CDate, MUser, MDate, StyleDetailLinkItemID) 
		SELECT b.StyleID, @StyleSet, Sort, FeatureDetail, Measurement, StitchType, Comments, 
			@CUser, @CDate, @CUser, @CDate, @StyleDetailLinkItemID 
		FROM pTemplateStyleDetailItem a WITH(NOLOCK)
			CROSS JOIN pStyleHeader b  
		WHERE a.TemplateStyleDetailItemID = @TemplateStyleDetailItemID 
		AND b.StyleLinkID =  @StyleLinkID
	
		SET @ROWID =  @ROWID + 1 
	END 
	
	DROP TABLE #item
	

END 
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01149', GetDate())
GO
