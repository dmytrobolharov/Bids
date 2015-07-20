IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pBOLOperationToTemplate_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_pBOLOperationToTemplate_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_pBOLOperationToTemplate_INSERT] 
	(@TemplateId   uniqueidentifier,
	@OperationId  uniqueidentifier,
	@CUser nvarchar(200),
	@CDate datetime,
	@Active int)
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (5)

BEGIN

	SELECT @nCount = count(*) FROM pBOLTemplateEntries WITH (NOLOCK) WHERE TemplateId = @TemplateId
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pBOLTemplateEntries WITH (NOLOCK) WHERE TemplateId = @TemplateId
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '00000' +  cast ( @nSort as nvarchar (5) ) , 5 )
	print  'vccount 1 = '  + @vcCount

INSERT INTO pBOLTemplateEntries
    (TemplateId, OperationId, CUser, CDate, MUser, MDate, Active, Sort)
VALUES (@TemplateId, @OperationId, @CUser, @CDate, @CUser, @CDate, @Active, @vcCount)

END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01839'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01839', GetDate())
END

GO
