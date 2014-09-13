/****** Object:  StoredProcedure [dbo].[spx_LineFolder_MerchandiseBusiness_Logic_UPDATE]    Script Date: 07/07/2014 18:09:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_MerchandiseBusiness_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_MerchandiseBusiness_Logic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_MerchandiseBusiness_Logic_UPDATE]    Script Date: 07/07/2014 18:09:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_MerchandiseBusiness_Logic_UPDATE]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	EXEC spx_LineFolder_MerchandiseBusiness_PlanningLogic_UPDATE @LineFolderID
	
	EXEC spx_LineFolder_MerchandiseBusiness_DIPLogic_UPDATE @LineFolderID
	
	EXEC spx_LineFolder_MerchandiseBusiness_ActualLogic_UPDATE @LineFolderID
	
END






GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08244', GetDate())
GO
