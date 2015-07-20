IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDimBOMTempQuickAdd_INSERTQE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDimBOMTempQuickAdd_INSERTQE]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDimBOMTempQuickAdd_INSERTQE]
(@StyleID nvarchar(50),
@StyleSet int,
@MaterialType int,
@WorkflowItemID nvarchar(50),
@WorkflowID nvarchar(50),
@StyleBOMDimensionId nvarchar(50),
@CreatedBy nvarchar(200),
@CreatedDate DateTime
)

AS 

INSERT INTO pStyleBOMTemp
    (MaterialID, MaterialType, StyleID,  StyleSet , WorkflowItemID, WorkflowID, StyleBOMDimensionId,QuickAdd, MDate, MUser, CUser, Cdate) 
values ('00000000-0000-0000-0000-000000000000', @MaterialType, @StyleID,  @StyleSet , @WorkflowItemID, @WorkflowID, @StyleBOMDimensionId,2, @CreatedDate, @CreatedBy,
@CreatedBy, @CreatedDate )
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03626', GetDate())
GO