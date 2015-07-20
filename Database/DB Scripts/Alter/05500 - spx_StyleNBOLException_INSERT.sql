IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLException_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLException_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleNBOLException_INSERT] 
	(@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkflowId uniqueidentifier,
	@WorkflowItemId uniqueidentifier,
	@CUser nvarchar(200),
	@CDate datetime,
	@Active int = 1)
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (5)

BEGIN 

	SELECT @nCount = count(*) FROM pStyleNBOLException WITH (NOLOCK) WHERE StyleID = @StyleId AND StyleSet = @StyleSet AND WorkflowItemID = @WorkflowItemId
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pStyleNBOLException WITH (NOLOCK) WHERE StyleID = @StyleId AND StyleSet = @StyleSet AND WorkflowItemID = @WorkflowItemId
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	--print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '00000' +  cast ( @nSort as nvarchar (5) ) , 5 )
	--print  'vccount 1 = '  + @vcCount

INSERT INTO pStyleNBOLException
    (ExceptionName, StyleID, StyleSet, WorkflowID, WorkflowItemID, CUser, CDate, MUser, MDate, Active, Sort)
VALUES ('Exception' + cast (@nSort as nvarchar (5)), @StyleId, @StyleSet, @WorkflowId, @WorkflowItemId, @CUser, @CDate, @CUser, @CDate, @Active, @vcCount)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05500', GetDate())
GO
