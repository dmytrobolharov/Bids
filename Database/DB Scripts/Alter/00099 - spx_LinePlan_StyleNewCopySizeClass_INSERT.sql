IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_StyleNewCopySizeClass_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlan_StyleNewCopySizeClass_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlan_StyleNewCopySizeClass_INSERT](
@LinePlanItemID UNIQUEIDENTIFIER, 
@StyleID UNIQUEIDENTIFIER, 
@NewStyleID UNIQUEIDENTIFIER, 
@CreatedDate DATETIME, 
@CreatedBy NVARCHAR(200) ,
@AddComments INT 
)
AS
BEGIN



	DECLARE @SketchID UNIQUEIDENTIFIER
	DECLARE @SketchVersion INT 
	SELECT @SketchID = DesignSketchID, @SketchVersion = DesignSketchVersion FROM  pStyleHeader WHERE StyleID = @StyleID


	EXEC dbo.spx_StyleHeaderCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID, @DesignSketchID=@SketchID,  
		@DesignSketchVersion=@SketchVersion, @StyleVariation=@SketchVersion, @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate
	EXEC dbo.spx_StyleWorkflowScheaduleCopy_UPDATE @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy, @CreatedDate=@CreatedDate
	EXEC dbo.spx_StyleSizeClassRangeVariation_UPDATE @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy, @CreatedDate=@CreatedDate
	EXEC spx_StyleDetailGridCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate
	EXEC spx_StyleDetailVariation_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate
	
	EXEC spx_LinePlan_StyleMaterialVariation_INSERT @LinePlanItemID=@LinePlanItemID, @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate

	EXEC spx_StyleCareCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate
	EXEC spx_StyleDevelopmentSpecVariation_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate


END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '099', GetDate())

GO











