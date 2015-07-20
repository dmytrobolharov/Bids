/****** Object:  StoredProcedure [dbo].[spx_StyleNBOLOperation_INSERT]    Script Date: 12/05/2012 13:29:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLOperation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLOperation_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleNBOLOperation_INSERT]    Script Date: 12/05/2012 13:29:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleNBOLOperation_INSERT]
(@OperationId UNIQUEIDENTIFIER,
@StyleId UNIQUEIDENTIFIER,
@StyleSet INT,
@WorkflowId UNIQUEIDENTIFIER,
@WorkflowItemId UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME,
@IsException INT )
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (4)

BEGIN

	SELECT @nCount = count(*) FROM pStyleNBOLItems WITH (NOLOCK) WHERE (StyleID = @StyleID)  AND  (StyleSet = @StyleSet) AND (WorkFlowItemID = @WorkflowItemId) AND (ParentID IS NULL)
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pStyleNBOLItems WITH (NOLOCK) WHERE (StyleID = @StyleID)  AND  (StyleSet = @StyleSet) AND (WorkFlowItemID = @WorkflowItemId) AND (ParentID IS NULL)
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '0000' +  cast ( @nSort as nvarchar (4) ) , 4 )
	print  'vccount 1 = '  + @vcCount
	


	DECLARE @NewItemID AS UNIQUEIDENTIFIER = NEWID()

	INSERT INTO pStyleNBOLItems
	(StyleNBOLItemID, StyleID, StyleSet, WorkFlowID, WorkFlowItemID, TemplateItemID,
	 Sort, IsLinked, OperationId, Code, Name, ImageID, MachineID, OperationTypeID, BaseRate,
	 CUser, CDate, MUser, MDate, IsException)
	SELECT @NewItemID, @StyleID, @StyleSet, @WorkflowId, @WorkflowItemId, @NewItemID,
	 @vcCount, 0, @OperationId, OperationCode, OperationName, ImageID, MachineID, o.OperationTypeID, ot.DefaultPrice,
	 @CUser, @CDate, @CUser, @CDate, @IsException
	FROM pNBOLOperation o WITH (NOLOCK)
	LEFT JOIN pNBOLOperationType ot ON o.OperationTypeID = ot.OperationTypeID
	WHERE (o.OperationId = @OperationId)

	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04546', GetDate())
GO