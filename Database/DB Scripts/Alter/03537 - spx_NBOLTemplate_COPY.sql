IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NBOLTemplate_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NBOLTemplate_COPY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_NBOLTemplate_COPY]
	(@NewTemplateId   uniqueidentifier,
	 @OldTemplateId  uniqueidentifier,
	 @CUser nvarchar(200),
	 @CDate datetime,
	 @Active int)
AS

DECLARE @nSort as int 
DECLARE @nMax as int 
DECLARE @nCount as int
DECLARE @vcCount as varchar (5)

BEGIN

	SELECT @nCount = COUNT(*) FROM pNBOLTemplateItem WITH (NOLOCK) WHERE TemplateID = @NewTemplateId
	SELECT @nMax = CAST(MAX(Sort) AS INT) FROM pNBOLTemplateItem WITH (NOLOCK) WHERE TemplateID = @NewTemplateId
	IF @nCount IS NULL   SET @nCount = 0 
	IF @nMax IS NULL SET @nMax = 0 
	IF @nCount > @nMax 	SET @nSort = @nCount 
	ELSE SET @nSort = @nMax 
	print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )
	
	--SET @nSort = @nSort + 1
	SET @vcCount =  RIGHT ( '00000' +  cast ( @nSort as nvarchar (5) ) , 5 )
	print  'vccount 1 = '  + @vcCount
	
	SELECT NEWID() AS TemplateItemID, TemplateItemID AS CopyTemplateItemID
	INTO #tmpTplItem
	FROM pNBOLTemplateItem
	WHERE TemplateId = @OldTemplateId AND ParentID IS NULL
	
	-- copy operations and macro headers
	INSERT INTO pNBOLTemplateItem (TemplateItemID, TemplateID, OperationID, OperationTypeID,
		MacroID, ParentID, MachineID,
		BaseRate, SAM, Name, Code, ImageID, 
		CUser, CDate, MUser, MDate, Active, Sort, Sort2)
	SELECT c.TemplateItemID, @NewTemplateId, OperationID, OperationTypeID, 
		MacroID, ParentID, MachineID,
		BaseRate, SAM, Name, Code, ImageID, 
		@CUser, @CDate, @CUser, @CDate, @Active, RIGHT ('00000' + CAST(CAST(@vcCount AS INT) + CAST(Sort AS INT) AS VARCHAR(5)), 5), Sort2
	FROM #tmpTplItem c
	INNER JOIN pNBOLTemplateItem i ON c.CopyTemplateItemID = i.TemplateItemID
	
	-- copy macro operations
	INSERT INTO pNBOLTemplateItem (TemplateItemID, TemplateID, OperationID, OperationTypeID,
		MacroID, ParentID, MachineID,
		BaseRate, SAM, Name, Code, ImageID, 
		CUser, CDate, MUser, MDate, Active, Sort, Sort2)
	SELECT NEWID(), @NewTemplateId, OperationID, OperationTypeID, 
		MacroID, c.TemplateItemID, MachineID,
		BaseRate, SAM, Name, Code, ImageID, 
		@CUser, @CDate, @CUser, @CDate, @Active, RIGHT ('00000' + CAST(CAST(@vcCount AS INT) + CAST(Sort AS INT) AS VARCHAR(5)), 5), Sort2
	FROM #tmpTplItem c
	INNER JOIN pNBOLTemplateItem i ON c.CopyTemplateItemID = i.ParentID
	
	DROP TABLE #tmpTplItem
END


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03537', GetDate())
GO