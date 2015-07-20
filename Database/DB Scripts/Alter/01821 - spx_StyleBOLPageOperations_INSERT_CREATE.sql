SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleBOLPageOperations_INSERT]
	(@PageOperationId uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@CreatedBy nvarchar(100),
	@CreatedDate datetime,
	@IsException int)
AS 

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (5)

BEGIN
IF @PageOperationId IS NOT NULL
BEGIN
	SELECT @nCount = count(*) FROM pStyleBOLPageOperations WITH (NOLOCK) WHERE (StyleId = @StyleID)  AND  (StyleSet = @StyleSet) AND (MacroParentId = @PageOperationId)
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pStyleBOLPageOperations WITH (NOLOCK) WHERE StyleId = @StyleID  AND  StyleSet = @StyleSet AND (MacroParentId = @PageOperationId)
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '00000' +  cast ( @nSort as nvarchar (5) ) , 5 )
	
	INSERT INTO pStyleBOLPageOperations
	(PageOperationId, StyleID, StyleSet, Sort, isLinked, MachineId, BaseRateId, CUser, CDate, MUser, MDate, ImageType, MacroParentId, IsException)
	VALUES (newid(), @StyleID, @StyleSet, @vcCount, 0, '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 'BOLS', @PageOperationId, @IsException)
END	
ELSE
BEGIN
	SELECT @nCount = count(*) FROM pStyleBOLPageOperations WITH (NOLOCK) WHERE (StyleId = @StyleID)  AND  (StyleSet = @StyleSet) AND (MacroParentId IS NULL)
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pStyleBOLPageOperations WITH (NOLOCK) WHERE (StyleId = @StyleID)  AND  (StyleSet = @StyleSet) AND (MacroParentId IS NULL)
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '0000' +  cast ( @nSort as nvarchar (4) ) , 4 )
	
	INSERT INTO pStyleBOLPageOperations
	(PageOperationId, StyleID, StyleSet, Sort, isLinked, MachineId, BaseRateId, CUser, CDate, MUser, MDate, ImageType, IsException)
	VALUES (newid(), @StyleID, @StyleSet, @vcCount, 0, '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 'BOLS', @IsException)
END

END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01821'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01821', GetDate())
END

GO
