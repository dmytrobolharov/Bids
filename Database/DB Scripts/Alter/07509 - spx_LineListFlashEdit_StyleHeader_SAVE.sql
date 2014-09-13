/****** Object:  StoredProcedure [dbo].[spx_LineListFlashEdit_StyleHeader_SAVE]    Script Date: 04/16/2014 13:48:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListFlashEdit_StyleHeader_SAVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListFlashEdit_StyleHeader_SAVE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineListFlashEdit_StyleHeader_SAVE]    Script Date: 04/16/2014 13:48:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LineListFlashEdit_StyleHeader_SAVE]
(
	@LineListFlashEditID UNIQUEIDENTIFIER
	, @UpdateSQL NVARCHAR(MAX)	
)
AS 

BEGIN
	DECLARE @WhereSQL NVARCHAR(MAX)
	
	SET @WhereSQL = SUBSTRING(@UpdateSQL, CHARINDEX(' where', LOWER(@UpdateSQL)), LEN(@UpdateSQL))
	SET @UpdateSQL = SUBSTRING(@UpdateSQL, CHARINDEX(' set ', LOWER(@UpdateSQL)) + LEN(' set '), LEN(@UpdateSQL))
	SET @UpdateSQL = SUBSTRING(@UpdateSQL, 1, CHARINDEX(' where', LOWER(@UpdateSQL)))

	IF LTRIM(RTRIM(@UpdateSQL)) <> ''
	BEGIN
		
		SELECT * INTO ##temp FROM fnx_Split(@UpdateSQL, ',')

		DECLARE @Row INT = 1, @Total INT = (SELECT COUNT(*) FROM ##temp)

		WHILE @Row <= @Total
		BEGIN
			DECLARE @Field NVARCHAR(500) = (SELECT value FROM ##temp WHERE position = @Row)
			DECLARE @UpdateFieldSQL NVARCHAR(MAX) = 'UPDATE vwx_LineListFlashEdit_StyleHeader_SELECT SET ' + @Field + @WhereSQL
			
			EXEC sp_executesql @UpdateFieldSQL

			SET @Row = @Row + 1
		END

		IF EXISTS (SELECT * FROM ##temp WHERE value LIKE '%LineFolderItemDrop%')
			BEGIN
				DECLARE @MDate NVARCHAR(50) = (SELECT value FROM ##temp WHERE value LIKE '%MDate%')
				DECLARE @MUser NVARCHAR(500) = (SELECT value FROM ##temp WHERE value LIKE '%MUser%')
				
				DECLARE @UpdateMSQL NVARCHAR(MAX) = 'UPDATE vwx_LineListFlashEdit_StyleHeader_SELECT SET ' + REPLACE(@MDate, 'MDate', 'LineFolderItemDropDate') + ', ' + REPLACE(@MUser, 'MUser', 'LineFolderItemDropUser') + @WhereSQL
				EXEC sp_executesql @UpdateMSQL
			END
		DROP TABLE ##temp
		
	END
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07509', GetDate())
GO