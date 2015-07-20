IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestTemp_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestTemp_INSERT] (
@MaterialRequestGroupID UNIQUEIDENTIFIER,
@MaterialID  UNIQUEIDENTIFIER,
@SeasonYearID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME 
)
AS
	
	IF ( SELECT COUNT(*)  FROM pMaterialRequestTemp  WHERE MaterialRequestGroupID = @MaterialRequestGroupID) > 0 
	BEGIN 
		UPDATE pMaterialRequestTemp  SET MaterialID = @MaterialID, SeasonYearID = @SeasonYearID, MaterialRequestWorkflowStartDate = getdate()
		WHERE MaterialRequestGroupID = @MaterialRequestGroupID
	END 
	ELSE
	BEGIN
		INSERT INTO  pMaterialRequestTemp  (MaterialRequestGroupID, MaterialID,  SeasonYearID , MaterialRequestWorkflowStartDate, CUser, CDate ) 
		VALUES (@MaterialRequestGroupID, @MaterialID,  @SeasonYearID , getdate(), @CUser, @CDate ) 
	END 
	
	DELETE FROM pMaterialRequestSeasonColorTemp 
	WHERE MaterialRequestGroupID = @MaterialRequestGroupID
	AND   ( SeasonYearID <> @SeasonYearID  OR MaterialID <> @MaterialID ) 


	GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05641', GetDate())
GO
