IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_StyleBOMTemp_Redirect') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_StyleBOMTemp_Redirect
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMTemp_Redirect]
(@MainMaterial varchar(1),
@StyleID varchar(40),
@StyleMaterialID varchar(40),
@StyleSet varchar(1),
@MaterialCoreItemID varchar(40),
@WorkflowItemID nvarchar(40),
@WorkflowID nvarchar(40),
@StyleBOMDimensionId nvarchar(40),
@CreatedBy varchar(200),
@CreatedDate varchar(50),
@TradePartnerVendorID varchar(40) = NULL
)
AS 

DECLARE @MaterialID varchar(40)

SELECT @MaterialID = MaterialID FROM pMaterialCoreItem WHERE MaterialCoreItemID = @MaterialCoreItemID

EXEC spx_StyleBOMTemp_INSERT @MainMaterial, @StyleID, @StyleMaterialID, @StyleSet, @MaterialID, @WorkflowItemID, @WorkflowID, @StyleBOMDimensionId, @CreatedBy, @CreatedDate, @TradePartnerVendorID

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02064'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02064', GetDate())

END	 
GO 