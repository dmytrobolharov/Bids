/****** Object:  StoredProcedure [dbo].[spx_pMaterialTemplateItem_INSERT]    Script Date: 04/18/2012 15:39:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pMaterialTemplateItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pMaterialTemplateItem_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_pMaterialTemplateItem_INSERT]    Script Date: 04/18/2012 15:39:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_pMaterialTemplateItem_INSERT]
(@MaterialTemplatePageID uniqueidentifier,
@MaterialTemplateID uniqueidentifier,
@Sort int,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)

AS

IF NOT EXISTS(SELECT MaterialTemplatePageID FROM pMaterialTemplateItem 
	WHERE MaterialTemplateID = @MaterialTemplateID AND MaterialTemplatePageID = @MaterialTemplatePageID)
BEGIN
	INSERT  INTO pMaterialTemplateItem(MaterialTemplateID, MaterialTemplatePageID, Sort, Active, Cuser, CDate, MUser, MDate)
	VALUES  (@MaterialTemplateID, @MaterialTemplatePageID, isnull(@Sort,0), 1, @CreatedBy, @CreatedDate,@CreatedBy, @CreatedDate) 
END
ELSE
BEGIN
	UPDATE dbo.pMaterialTemplateItem SET Sort = isnull(@Sort,0), MUser=@CreatedBy, MDate=@CreatedDate WHERE 
	MaterialTemplateID = @MaterialTemplateID AND MaterialTemplatePageID = @MaterialTemplatePageID 
END

GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03374', GetDate())

GO