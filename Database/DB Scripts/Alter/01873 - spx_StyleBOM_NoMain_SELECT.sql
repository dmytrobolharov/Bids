IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_NoMain_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOM_NoMain_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_NoMain_SELECT]    Script Date: 09/06/2011 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_StyleBOM_NoMain_SELECT] (
@StyleID UNIQUEIDENTIFIER, 
@StyleSet INT ,
@TeamID UNIQUEIDENTIFIER, 
@WorkflowID UNIQUEIDENTIFIER, 
@WorkflowItemID UNIQUEIDENTIFIER, 
@ComponentPackLabel INT 
)
AS 

	IF @ComponentPackLabel IS NOT NULL 
	BEGIN 
		SELECT * FROM pComponentType 
		WHERE ComponentTypeID IN ( 
			SELECT MaterialType FROM pStyleBOM Where Styleset = @StyleSet AND StyleID = @StyleID  
			AND WorkflowItemID = @WorkflowItemID
			AND WorkflowID = @WorkflowID			
			AND MainMaterial <> 1 ) 
		AND ComponentPackLabel = @ComponentPackLabel 
		ORDER BY ComponentOrder
	END 
	ELSE
	BEGIN
		SELECT * FROM pComponentType 
		WHERE ComponentTypeID IN ( 
			SELECT MaterialType FROM pStyleBOM Where Styleset = @StyleSet AND StyleID = @StyleID  
			AND WorkflowItemID = @WorkflowItemID
			AND WorkflowID = @WorkflowID AND MainMaterial <> 1 ) 
		ORDER BY ComponentOrder
	END 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01873'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01873', GetDate())
END

GO	
