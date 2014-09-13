IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDimBOMColorMgmtMaterial_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDimBOMColorMgmtMaterial_Delete]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDimBOMColorMgmtMaterial_Delete](
	@StyleMaterialID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowItemId UNIQUEIDENTIFIER,
	@WorkflowId UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,	
	@StyleMaterialMiscID UNIQUEIDENTIFIER,	
	@CreatedDate DATETIME,
	@CreatedBy NVARCHAR(200)	
)

AS 

delete from pStyleBOMMiscItem where StyleMaterialID=@StyleMaterialID and 
StyleMaterialMiscID=@StyleMaterialMiscID and StyleBOMDimensionID=@StyleBOMDimensionID



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03639', GetDate())
GO