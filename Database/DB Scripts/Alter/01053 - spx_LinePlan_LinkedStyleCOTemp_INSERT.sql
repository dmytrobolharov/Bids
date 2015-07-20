IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_LinkedStyleCOTemp_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_LinkedStyleCOTemp_INSERT]
GO

CREATE PROCEDURE dbo.spx_LinePlan_LinkedStyleCOTemp_INSERT(
	@StyleID UNIQUEIDENTIFIER, 
	@TeamID UNIQUEIDENTIFIER,
	@ClientSessionID NVARCHAR(40)
)
AS 

	IF NOT EXISTS ( SELECT * FROM pLinePlanStyleLinkedTemp 
		WHERE TeamID = @TeamID AND StyleID = @StyleID  )
	BEGIN 
	
		INSERT INTO pLinePlanStyleLinkedTemp  ( TeamID, StyleID, ClientSessionID ) 
		VALUES ( @TeamID, @StyleID, @ClientSessionID ) 
	
	END 
	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01053', GetDate())
GO
	

