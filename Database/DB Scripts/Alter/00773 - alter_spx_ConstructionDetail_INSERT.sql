
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spx_ConstructionDetail_INSERT]
	(@WorkflowID uniqueidentifier,
	@WorkFlowItemId uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@CreatedBy nvarchar(100),
	@CreatedDate datetime)
AS 

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (4)

BEGIN
	SELECT @nCount = count(*) FROM pConPageDetail WITH (NOLOCK) WHERE StyleId = @StyleID  AND  StyleSet = @StyleSet  AND  WorkFlowItemId = @WorkFlowItemId
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
	(ConstructionDetailID, StyleID, WorkflowID, WorkFlowItemId, StyleSet, Sort, Linked, CUser, CDate, MUser, MDate)
	VALUES (newid(), @StyleID, @WorkflowID, @WorkFlowItemId, @StyleSet, @vcCount, 0, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '773', GetDate())

GO