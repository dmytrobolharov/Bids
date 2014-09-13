IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NBOLTemplateItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NBOLTemplateItem_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_NBOLTemplateItem_INSERT]
	@TemplateID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@OperationID UNIQUEIDENTIFIER = NULL,
	@MacroID UNIQUEIDENTIFIER = NULL,
	@UpdateSql NVARCHAR(MAX) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF @OperationID IS NOT NULL
    BEGIN
		EXEC spx_NBOLOperationToTemplate_INSERT @TemplateId = @TemplateID, @OperationId = @OperationID,
			@CUser = @CUser, @CDate = @CDate
    END
    ELSE IF @MacroID IS NOT NULL
    BEGIN
		EXEC spx_NBOLMacroToTemplate_INSERT @TemplateId = @TemplateID, @MacroId = @MacroID,
			@CUser = @CUser, @CDate = @CDate
    END
    ELSE IF LEN(@UpdateSQL) > 0
    BEGIN
		DECLARE @TemplateItemID UNIQUEIDENTIFIER = NEWID(),
				@nMax INT,
				@Sort NVARCHAR(5)
		
		SELECT @nMax = CAST(MAX(Sort) AS INT) FROM pNBOLTemplateItem WITH (NOLOCK) WHERE TemplateID = @TemplateID
		IF @nMax IS NULL SET @nMax = 0
		SET @nMax = @nMax + 1
		SET @Sort =  RIGHT('00000' +  CAST(@nMax AS NVARCHAR(5)), 5)
		
		INSERT INTO pNBOLTemplateItem(TemplateItemID, TemplateID, Sort, CUser, CDate, MUser, MDate)
		VALUES (@TemplateItemID, @TemplateID, @Sort, @CUser, @CDate, @CUser, @CDate)
		
		
		SET @UpdateSql = SUBSTRING(@UpdateSql, 0, CHARINDEX(' WHERE', @UpdateSql, 0))
		SET @UpdateSql = @UpdateSql + ' WHERE TemplateItemID = N''' + CAST(@TemplateItemID AS NVARCHAR(50)) + ''''
		EXEC spx_NBOLTemplateItem_UPDATE @TemplateID = @TemplateID, @TemplateItemID = @TemplateItemID, @UpdateSql = @UpdateSql
		
		DECLARE @OpCode NVARCHAR(200),
				@MaxOpCode INT
		SELECT @OpCode = Code FROM pNBOLTemplateItem WHERE TemplateItemID = @TemplateItemID
		SELECT @MaxOpCode = MAX(CAST(Code AS INT)) + 1 FROM pNBOLTemplateItem WHERE TemplateID = @TemplateID AND ISNUMERIC(Code) <> 0
		IF @MaxOpCode IS NULL SET @MaxOpCode = 1
		IF LEN(@OpCode) = 0 OR @OpCode IS NULL
		BEGIN
			SET @OpCode = RIGHT('0000' +  CAST(@MaxOpCode AS NVARCHAR(4)), 4)
			UPDATE pNBOLTemplateItem SET Code = @OpCode WHERE TemplateItemID = @TemplateItemID
		END
    END
END


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03533', GetDate())
GO
