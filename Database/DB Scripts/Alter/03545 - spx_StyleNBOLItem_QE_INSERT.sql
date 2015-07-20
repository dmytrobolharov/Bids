IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLItem_QE_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLItem_QE_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleNBOLItem_QE_INSERT]
	@newId NVARCHAR(50),
	@StyleId UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowId UNIQUEIDENTIFIER,
	@WorkflowItemId UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@OperationId UNIQUEIDENTIFIER = NULL,
	@MacroId UNIQUEIDENTIFIER = NULL,
	@UpdateSql NVARCHAR(MAX) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF @OperationID IS NOT NULL
    BEGIN
		EXEC spx_StyleNBOLOperation_INSERT @OperationId = @OperationId,
			@StyleId = @StyleId, @StyleSet = @StyleSet, @WorkflowId = @WorkflowId, @WorkflowItemId = @WorkflowItemId,
			@CUser = @CUser, @CDate = @CDate, @IsException = 0
    END
    ELSE IF @MacroID IS NOT NULL
    BEGIN
		EXEC spx_StyleNBOLMacro_INSERT @MacroId = @MacroId,
			@StyleId = @StyleId, @StyleSet = @StyleSet, @WorkflowId = @WorkflowId, @WorkflowItemId = @WorkflowItemId,
			@CUser = @CUser, @CDate = @CDate, @IsException = 0
    END
    ELSE IF LEN(@UpdateSQL) > 0
    BEGIN
		--print @UpdateSQL
		DECLARE @StyleNBOLItemId UNIQUEIDENTIFIER = @newId,
				@nSort INT, 
				@nMax INT, 
				@nCount INT,
				@Sort NVARCHAR(5)
		
		SELECT @nCount = count(*) FROM pStyleNBOLItems WITH (NOLOCK) WHERE (StyleID = @StyleID)  AND  (StyleSet = @StyleSet) AND (WorkFlowItemID = @WorkflowItemId) AND (ParentID IS NULL)
		SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pStyleNBOLItems WITH (NOLOCK) WHERE (StyleID = @StyleID)  AND  (StyleSet = @StyleSet) AND (WorkFlowItemID = @WorkflowItemId) AND (ParentID IS NULL)
		IF  @nCount IS NULL   SET @nCount = 0 
		IF @nMax IS NULL SET @nMax = 0 
		IF @nCount > @nMax 	SET @nSort = @nCount 
		ELSE 	SET @nSort = @nMax 
		--print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
		
		SET @nSort = @nSort + 1
		SET @Sort =  RIGHT ( '0000' +  cast ( @nSort as nvarchar (4) ) , 4 )
		--print  'vccount 1 = '  + @vcCount
		
		INSERT INTO pStyleNBOLItems (StyleNBOLItemID, StyleID, StyleSet, WorkFlowID, WorkFlowItemID, IsLinked, Sort, CUser, CDate, MUser, MDate)
		VALUES (@StyleNBOLItemId, @StyleId, @StyleSet, @WorkflowId, @WorkflowItemId, 0, @Sort, @CUser, @CDate, @CUser, @CDate)
		
		
		SET @UpdateSql = SUBSTRING(@UpdateSql, 0, CHARINDEX(' WHERE', @UpdateSql, 0))
		SET @UpdateSql = @UpdateSql + ' WHERE StyleNBOLItemID = N''' + CAST(@StyleNBOLItemId AS NVARCHAR(50)) + ''''
		
		EXEC (@UpdateSql)
		
    END

END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03545', GetDate())
GO