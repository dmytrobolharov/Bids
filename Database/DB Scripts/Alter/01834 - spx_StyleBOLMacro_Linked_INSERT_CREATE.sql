SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOLMacro_Linked_INSERT]
(@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@MacroId UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME,
@IsException INT )
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (4)

BEGIN

	SELECT @nCount = count(*) FROM pStyleBOLPageOperations WITH (NOLOCK) WHERE (StyleId = @StyleID)  AND  (StyleSet = @StyleSet) AND (MacroParentId IS NULL)
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pStyleBOLPageOperations WITH (NOLOCK) WHERE (StyleId = @StyleID)  AND  (StyleSet = @StyleSet) AND (MacroParentId IS NULL)
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '0000' +  cast ( @nSort as nvarchar (4) ) , 4 )
	print  'vccount 1 = '  + @vcCount

	INSERT INTO pStyleBOLPageOperations
	( StyleID, StyleSet, Sort, IsLinked, MacroId, CUser, CDate, MUser, MDate, IsException)
	SELECT @StyleID, @StyleSet, @vcCount, 1, @MacroId, @CUser, @CDate, @CUser, @CDate, @IsException
	FROM vw_pBOLMacro_Select WITH (NOLOCK)
	WHERE (MacroId = @MacroId)

	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01834'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01834', GetDate())
END

GO
