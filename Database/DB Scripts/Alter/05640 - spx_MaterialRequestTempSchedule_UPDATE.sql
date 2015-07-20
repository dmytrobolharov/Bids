IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestTempSchedule_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestTempSchedule_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestTempSchedule_UPDATE] (
@MaterialRequestGroupID UNIQUEIDENTIFIER,
@MaterialRequestWorkflowTempID UNIQUEIDENTIFIER,
@MaterialID  UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME 
)
AS



	IF (SELECT COUNT(*) FROM pMaterialRequestTemp  WHERE MaterialRequestGroupID = @MaterialRequestGroupID) <> 0 	
		BEGIN
			UPDATE pMaterialRequestTemp  SET 
				MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID,
				MaterialID = @MaterialID 
			WHERE MaterialRequestGroupID = @MaterialRequestGroupID
		END 
	ELSE
		BEGIN
			INSERT INTO  pMaterialRequestTemp  (MaterialRequestGroupID, MaterialID, MaterialRequestWorkflowTempID, 
				MaterialRequestWorkflowStartDate,  CUser, CDate) 
			VALUES (@MaterialRequestGroupID, @MaterialID, @MaterialRequestWorkflowTempID, 
				getdate(),  @CUser, @CDate ) 
		END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05640', GetDate())
GO
