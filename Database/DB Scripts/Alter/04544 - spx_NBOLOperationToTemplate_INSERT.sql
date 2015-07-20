/****** Object:  StoredProcedure [dbo].[spx_NBOLOperationToTemplate_INSERT]    Script Date: 12/05/2012 11:47:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NBOLOperationToTemplate_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NBOLOperationToTemplate_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NBOLOperationToTemplate_INSERT]    Script Date: 12/05/2012 11:47:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_NBOLOperationToTemplate_INSERT] 
	(@TemplateId   uniqueidentifier,
	@OperationId  uniqueidentifier,
	@CUser nvarchar(200),
	@CDate datetime,
	@Active int = 1)
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (5)

BEGIN

	SELECT @nCount = count(*) FROM pNBOLTemplateItem WITH (NOLOCK) WHERE TemplateID = @TemplateId AND ParentID IS NULL
	SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pNBOLTemplateItem WITH (NOLOCK) WHERE TemplateID = @TemplateId AND ParentID IS NULL
	IF  @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE 	SET @nSort = @nMax 
	print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
	
	SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '00000' +  cast ( @nSort as nvarchar (5) ) , 5 )
	print  'vccount 1 = '  + @vcCount

INSERT INTO pNBOLTemplateItem
    (TemplateID, OperationID, ImageID, Code, Name, MachineID, OperationTypeID, BaseRate, CUser, CDate, MUser, MDate, Active, Sort)
SELECT @TemplateId, @OperationId, ImageID, OperationCode, OperationName, MachineID, o.OperationTypeID, ot.DefaultPrice, @CUser, @CDate, @CUser, @CDate, @Active, @vcCount
	FROM pNBOLOperation o LEFT JOIN pNBOLOperationType ot ON o.OperationTypeID = ot.OperationTypeID
	WHERE OperationID = @OperationId

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04544', GetDate())
GO