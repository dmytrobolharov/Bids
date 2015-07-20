/****** Object:  StoredProcedure [dbo].[spx_MaterialContent_COPY_INSERT]    Script Date: 02/20/2013 13:24:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialContent_COPY_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialContent_COPY_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialContent_COPY_INSERT]    Script Date: 02/20/2013 13:24:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialContent_COPY_INSERT]
	@MasterMaterialID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO dbo.pMaterialContent( MaterialContentId, MaterialID ,  MaterialContentCode, MaterialContentPerc, MaterialContentName, MUser, MDate  ) 
	SELECT NEWID(), @MaterialID, MaterialContentCode, MaterialContentPerc, MaterialContentName, MUser, MDate
	FROM pMaterialContent
	WHERE MaterialId = @MasterMaterialID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05071', GetDate())
GO
