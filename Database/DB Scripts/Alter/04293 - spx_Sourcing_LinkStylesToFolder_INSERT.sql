
/****** Object:  StoredProcedure [dbo].[spx_Sourcing_LinkStylesToFolder_INSERT]    Script Date: 11/05/2012 16:59:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_LinkStylesToFolder_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_LinkStylesToFolder_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_Sourcing_LinkStylesToFolder_INSERT]    Script Date: 11/05/2012 16:59:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- After a new folder was created, call this procedure to 
CREATE PROCEDURE [dbo].[spx_Sourcing_LinkStylesToFolder_INSERT]
	@SourcingHeaderID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @SeasonYearID UNIQUEIDENTIFIER
    DECLARE @DivisionID NVARCHAR(50)
    DECLARE @StyleCategoryID UNIQUEIDENTIFIER
    DECLARE @Season NVARCHAR(200)
    DECLARE @Year NVARCHAR(200)
    DECLARE @CDate DATETIME
    DECLARE @CUser NVARCHAR(200)
    
    SELECT @DivisionID = Division, @StyleCategoryID = StyleCategoryID, @Season = Season, @Year = [Year],
			@CDate = CDate, @CUser = CUser
    FROM pSourcingHeader
    WHERE SourcingHeaderID = @SourcingHeaderID
    
    SELECT @SeasonYearID = SeasonYearID FROM pSeasonYear
    WHERE Season = @Season AND [Year] = @Year
    
    DECLARE @StyleCursor CURSOR
    DECLARE @CurrentStyleID UNIQUEIDENTIFIER
    
    -- Adding each style with the same division, category and season/year,
	-- as header, to folder, through the procedure
if @StyleCategoryID is null
	begin
    SET @StyleCursor = CURSOR SCROLL
    FOR SELECT distinct a.StyleID FROM pStyleHeader a, pStyleSeasonYear b
	WHERE a.CustomField1 = @DivisionID
	AND a.styleId = b.StyleId 
	AND b.StyleYear= @Year 
	AND b.StyleSeason = @Season
	OPEN @StyleCursor
	FETCH NEXT FROM @StyleCursor INTO @CurrentStyleID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		EXEC spx_SourcingStyle_FromStyleFolder_INSERT
				@SourcingHeaderID = @SourcingHeaderID,
				@StyleID = @CurrentStyleID,
				@CUser = @CUser,
				@CDate = @CDate
		
		FETCH NEXT FROM @StyleCursor INTO @CurrentStyleID
	END
	
	end
	else
	begin 
	SET @StyleCursor = CURSOR SCROLL
    FOR SELECT distinct a.StyleID FROM pStyleHeader a, pStyleSeasonYear b
	WHERE a.CustomField1 = @DivisionID
	AND  a.StyleCategory = @StyleCategoryID
	AND a.styleId = b.StyleId 
	AND b.StyleYear= @Year 
	AND b.StyleSeason = @Season
	OPEN @StyleCursor
	FETCH NEXT FROM @StyleCursor INTO @CurrentStyleID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		EXEC spx_SourcingStyle_FromStyleFolder_INSERT
				@SourcingHeaderID = @SourcingHeaderID,
				@StyleID = @CurrentStyleID,
				@CUser = @CUser,
				@CDate = @CDate
		
		FETCH NEXT FROM @StyleCursor INTO @CurrentStyleID
	END
	
	end
	
	
END



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04293', GetDate())
GO

