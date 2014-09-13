/****** Object:  StoredProcedure [dbo].[spx_StyleColorway_SeasonColor_LineFolderFlash_DELETE]    Script Date: 12/05/2012 13:06:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorway_SeasonColor_LineFolderFlash_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorway_SeasonColor_LineFolderFlash_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorway_SeasonColor_LineFolderFlash_DELETE]    Script Date: 12/05/2012 13:06:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleColorway_SeasonColor_LineFolderFlash_DELETE]
	@LineFolderItemID UNIQUEIDENTIFIER,
	@StyleColorID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @StyleSeasonYearID  UNIQUEIDENTIFIER
	DECLARE @StyleID UNIQUEIDENTIFIER
	DECLARE @LineFolderID UNIQUEIDENTIFIER

	SELECT @StyleID = StyleID, @StyleSeasonYearID = StyleSeasonYearID, @LineFolderID = LineFolderID
	FROM pLineFolderItem WHERE LineFolderItemID = @LineFolderItemID
			
	DECLARE @Season NVARCHAR(200)  
	DECLARE @Year NVARCHAR(200) 
	 
	 SELECT @Season=a.Season, @Year=a.Year 
	 FROM pSeasonYear a, pStyleSeasonYear b
	 WHERE b.StyleSeasonYearID=@StyleSeasonYearID 
	 and a.SeasonYearID = b.SeasonYearID
	  

	IF EXISTS ( SELECT * FROM pStyleColorwaySeasonYear WITH (NOLOCK)  
	  WHERE StyleSeasonYearID = @StyleSeasonYearID AND StyleColorwayID = @StyleColorID )   
	BEGIN

		DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER 

		SELECT  @StyleColorwaySeasonYearID=a.StyleColorwaySeasonYearID    
		 FROM pStyleColorwaySeasonYear a  WITH(NOLOCK)  
		 WHERE a.StyleSeasonYearID = @StyleSeasonYearID    
		  AND a.StyleColorwayID = @StyleColorID
		  
		--** DELETE Colorway / SeasonYear     
		DELETE FROM pStyleColorwaySeasonYear     
		WHERE StyleColorwaySeasonYearID IN (     
		 SELECT  a.StyleColorwaySeasonYearID    
		 FROM pStyleColorwaySeasonYear a  WITH(NOLOCK)  
		 WHERE a.StyleSeasonYearID = @StyleSeasonYearID    
		  AND a.StyleColorwayID = @StyleColorID  
		)    
		   
		   
		  
		--**DELETE SourcingItems    
		DELETE FROM pStyleSourcingItem    
		WHERE StyleSourcingItemID IN (     
		 SELECT  b.StyleSourcingItemID     
		 FROM pStyleSourcing a  WITH(NOLOCK)  
		  INNER JOIN pStyleSourcingItem  b WITH(NOLOCK) ON a.StyleSourcingID =  b.StyleSourcingID     
		 WHERE a.StyleSeasonYearID = @StyleSeasonYearID    
		  AND b.StyleColorID = @StyleColorID  
		)    
		    
		  
		--** DELETE QuoteItems     
		DELETE FROM pStyleQuoteItem    
		WHERE StyleQuoteItemID IN (     
		 SELECT a.StyleQuoteItemID    
		 FROM pStyleQuoteItem a  WITH(NOLOCK)  
		  INNER JOIN pStyleSourcing c WITH(NOLOCK) ON a.StyleSourcingID = c.StyleSourcingID     
		 WHERE c.StyleSeasonYearID = @StyleSeasonYearID    
		  AND a.StyleColorID = @StyleColorID  
		)
		
		-- DELETE colorway from line folder
		
		EXEC spx_LineFolderItemColor_DELETE
		@LineFolderItemID = @LineFolderItemID,
		@LineFolderID = @LineFolderID,
		@StyleColorID = @StyleColorID,
		@StyleID = @StyleID

	END

END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04548', GetDate())
GO
