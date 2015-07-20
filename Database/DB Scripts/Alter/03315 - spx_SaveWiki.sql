IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SaveWiki]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SaveWiki]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rajul Radadia
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spx_SaveWiki] 
	-- Add the parameters for the stored procedure here
	@sSystemHelpID VARCHAR(36),
	@CultureName NVARCHAR(6),
    @HelpPage NVARCHAR(200),
    @SystemHelpDetail NVARCHAR(MAX),
    @sSystemHelpDetail_Plain NVARCHAR(MAX),
    @MUser NVARCHAR(50)
AS
	DECLARE @SQL AS NVARCHAR(1000),
			@CultureIdentifierID AS VARCHAR(6);
BEGIN --01
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--Get the CultureIdentifierID
	SELECT @CultureIdentifierID = CultureIndentifierID 
	FROM sSystemCulture 
	WHERE CultureName = @CultureName

    -- UPDATE Master table
    SET @SQL = 'UPDATE sSystemHelp
				SET ' + REPLACE(@CultureName, '-', '_') + '=N''' + REPLACE(@HelpPage, '''', '''''') + ''''
	SET @SQL = @SQL + ', MDate = ''' + CAST(GETDATE() AS VARCHAR(20)) + ''''
	SET @SQL = @SQL + ', MUser = ''' + CAST(@MUser AS VARCHAR(50)) + ''''
	SET @SQL = @SQL + ' WHERE sSystemHelpID = ''' + @sSystemHelpID + ''''
	
	EXECUTE (@SQL)
	
	If NOT EXISTS (SELECT * FROM sSystemHelp h INNER JOIN sSystemHelpDetail d 
			ON h.sSystemHelpID = d.sSystemHelpID INNER JOIN sSystemCulture c
			ON d.CultureIndentifierID=c.CultureIndentifierID
			WHERE h.sSystemHelpID = @sSystemHelpID AND
				  d.CultureIndentifierID = @CultureIdentifierID)
		BEGIN --02
			INSERT INTO sSystemHelpDetail
			(			
				sSystemHelpID,
				CultureIndentifierID,
				sSystemHelpDetail,
				sSystemHelpDetail_Plain,
				CDate,
				CUser
				)
			VALUES (
				@sSystemHelpID,
				@CultureIdentifierID,
				@SystemHelpDetail,
				@sSystemHelpDetail_Plain,
				GETDATE(),
				@MUser
			)
		END --02
	ELSE
		BEGIN --03
			UPDATE [sSystemHelpDetail]
			SET sSystemHelpDetail = @SystemHelpDetail,
				sSystemHelpDetail_Plain = @sSystemHelpDetail_Plain,
				MDate = GETDATE(),
				MUser = @MUser
			WHERE sSystemHelpID = @sSystemHelpID AND
				  CultureIndentifierID = @CultureIdentifierID
		END --03
END --01

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03315'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03315', GetDate())
END

GO
