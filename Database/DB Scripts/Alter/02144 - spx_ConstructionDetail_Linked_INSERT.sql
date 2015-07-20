
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ConstructionDetail_Linked_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ConstructionDetail_Linked_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ConstructionDetail_Linked_INSERT]
(@Level3ID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@WorkflowID UNIQUEIDENTIFIER,
@WorkFlowItemId UNIQUEIDENTIFIER,
@StyleSet int,
@CUser NVARCHAR(200),
@CDate DATETIME )
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (4)

BEGIN

	SELECT @nCount = count(*) FROM pConPageDetail WITH (NOLOCK) WHERE StyleId = @StyleID  AND  StyleSet = @StyleSet AND  WorkFlowItemId = @WorkFlowItemId
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pConPageDetail WITH (NOLOCK) WHERE StyleId = @StyleID  AND  StyleSet = @StyleSet AND  WorkFlowItemId = @WorkFlowItemId
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '0000' +  cast ( @nSort as nvarchar (4) ) , 2 )
	print  'vccount 1 = '  + @vcCount


	INSERT INTO pConPageDetail
	( StyleID, WorkflowID, WorkFlowItemId, Sort, StyleSet, Detail, OrigOperationSN, Level0Desc, Level1Desc, Level2Desc, Level3Desc, ImageID, AuxField1, AuxField2, AuxField3, 
      AuxField4, AuxField5, Linked, Level0ID, Level1ID, Level2ID, Level3ID, CUser, CDate, MUser, MDate)
	SELECT @StyleID, @WorkflowID, @WorkFlowItemId, @vcCount, @StyleSet, Detail, SerialNumber, Level0Desc, Level1Desc, Level2Desc, Level3Desc, ImageID, AuxField1, AuxField2, AuxField3, 
	AuxField4, AuxField5, 1, Level0ID, Level1ID, Level2ID, Level3ID, @CUser, @CDate, @CUser, @CDate
	FROM vwx_Control_CDFeature_SELECT WITH (NOLOCK)
	WHERE (Level3ID = @Level3ID)


	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02144'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '02144', GetDate())
	END
GO