IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NBOLTemplateItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NBOLTemplateItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_NBOLTemplateItem_UPDATE]
	@TemplateID UNIQUEIDENTIFIER,
	@TemplateItemID UNIQUEIDENTIFIER,
	@UpdateSql nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    EXEC(@UpdateSql)
    
    UPDATE pNBOLTemplateItem SET BaseRate = ot.DefaultPrice, CurrencyType = ot.CurrencyType
    FROM pNBOLTemplateItem ti 
    INNER JOIN pNBOLOperationType ot ON ot.OperationTypeId = ti.OperationTypeID
    WHERE ti.TemplateItemID = @TemplateItemID AND ti.BaseRate IS NULL
    
    UPDATE t2 SET Sort = t1.Sort
    FROM pNBOLTemplateItem t1
    INNER JOIN pNBOLTemplateItem t2 ON t2.ParentID = t1.TemplateItemID
    WHERE t1.TemplateItemID = @TemplateItemID AND t1.Sort <> t2.Sort
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06993', GetDate())
GO
