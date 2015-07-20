IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Translation_NewLanguageCopyTo_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Translation_NewLanguageCopyTo_INSERT]
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
CREATE PROCEDURE [dbo].[spx_Translation_NewLanguageCopyTo_INSERT]
	@sSystemHelpID VARCHAR(36),
	@sSystemCulture_CopyFrom NVARCHAR(6),
	@sSystemCulture_CopyTo NVARCHAR(6),
	@CUser NVARCHAR(50)
AS
	DECLARE @SQL AS NVARCHAR(1000),
			@CultureIdentifierID_CopyFrom AS VARCHAR(6),
			@CultureIdentifierID_CopyTo AS VARCHAR(6);
BEGIN --01
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @sSystemCulture_CopyFrom <> ''
	BEGIN --02
		SELECT @CultureIdentifierID_CopyFrom = CultureIndentifierID FROM sSystemCulture WHERE CultureName = @sSystemCulture_CopyFrom
	END --02
	
	IF @sSystemCulture_CopyTo <> ''
	BEGIN --03
		SELECT @CultureIdentifierID_CopyTo = CultureIndentifierID FROM sSystemCulture WHERE CultureName = @sSystemCulture_CopyTo
	END --03
	
	-- UPDATE Master table
    SET @SQL = 'UPDATE sSystemHelp
				SET ' + REPLACE(@sSystemCulture_CopyTo, '-', '_') + '=' + REPLACE(@sSystemCulture_CopyFrom, '-', '_')
	SET @SQL = @SQL + ', MDate = ''' + CAST(GETDATE() AS VARCHAR(20)) + ''''
	SET @SQL = @SQL + ', MUser = ''' + CAST(@CUser AS VARCHAR(50)) + ''''
	SET @SQL = @SQL + ' WHERE sSystemHelpID = ''' + @sSystemHelpID + ''''
	
	EXECUTE(@SQL)
	
	If NOT EXISTS (SELECT * FROM sSystemHelpDetail WHERE sSystemHelpID = @sSystemHelpID AND CultureIndentifierID = @CultureIdentifierID_CopyTo)
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
			SELECT	sSystemHelpID,
					@CultureIdentifierID_CopyTo,
					sSystemHelpDetail,
					sSystemHelpDetail_Plain,
					GETDATE(),
					@CUser
			FROM sSystemHelpDetail
			WHERE sSystemHelpID=@sSystemHelpID 
				AND CultureIndentifierID = @CultureIdentifierID_CopyFrom
		END --02
END --01
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03319'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03319', GetDate())
END

GO