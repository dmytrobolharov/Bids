IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOM_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_INSERT]    Script Date: 09/06/2011 12:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Stored Procedure

Create PROCEDURE [dbo].[spx_StyleBOM_INSERT]
(
@StyleID uniqueidentifier,
@Styleset int,
@WorkFlowID uniqueidentifier,
@WorkFlowItemID uniqueidentifier,
@ItemDim1 uniqueidentifier,
@ItemDim1Name nvarchar(50),
@ItemDim2 uniqueidentifier,
@ItemDim2Name nvarchar(50),
@ItemDim3 uniqueidentifier,
@ItemDim3Name nvarchar(50),
@MUser nvarchar(200),
@MDate datetime
)
AS 

BEGIN
	INSERT INTO pStyleBOMDimension 
		(WorkFlowID, WorkFlowItemID, StyleID, styleset, ItemDim1TypeId, ItemDim1TypeName, ItemDim2TypeId, ItemDim2TypeName, ItemDim3TypeId, 
		ItemDim3TypeName, CUser , CDate, MUser, MDate) 
	VALUES 
		(@WorkFlowID, @WorkFlowItemID, @StyleID, @Styleset, @ItemDim1, @ItemDim1Name, @ItemDim2, @ItemDim2Name, @ItemDim3, 
		@ItemDim3Name, @MUser , @MDate, @MUser, @MDate)
END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01867'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01867', GetDate())
END

GO