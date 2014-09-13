/****** Object:  StoredProcedure [dbo].[spx_NBOLMacroToTemplate_INSERT]    Script Date: 12/05/2012 12:49:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NBOLMacroToTemplate_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NBOLMacroToTemplate_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NBOLMacroToTemplate_INSERT]    Script Date: 12/05/2012 12:49:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_NBOLMacroToTemplate_INSERT] 
	(@TemplateId   uniqueidentifier,
	@MacroId  uniqueidentifier,
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
	
-- TemplateItemId of inserted Macro
DECLARE @TemplateItemId uniqueidentifier = NEWID()

INSERT INTO pNBOLTemplateItem
    (TemplateItemID, TemplateID, MacroID, ImageID, Code, Name, CUser, CDate, MUser, MDate, Active, Sort)
SELECT @TemplateItemId, @TemplateId, @MacroId, ImageID, MacroCode, MacroName, @CUser, @CDate, @CUser, @CDate, @Active, @vcCount
FROM pNBOLMacro
WHERE MacroID = @MacroId


INSERT INTO pNBOLTemplateItem
    (TemplateID, ParentID, OperationID, ImageID, Code, Name, MachineID, OperationTypeID, BaseRate, CUser, CDate, MUser, MDate, Active, Sort, Sort2)
SELECT @TemplateId, @TemplateItemId, o.OperationID, o.ImageID, o.OperationCode, o.OperationName, o.MachineID, o.OperationTypeID, ot.DefaultPrice, @CUser, @CDate, @CUser, @CDate, @Active, @vcCount, otm.Sort
FROM pNBOLOpToMacro otm 
INNER JOIN pNBOLOperation o	ON otm.OperationID = o.OperationID
LEFT JOIN pNBOLOperationType ot ON o.OperationTypeID = ot.OperationTypeID
WHERE otm.MacroID = @MacroId


END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04543', GetDate())
GO