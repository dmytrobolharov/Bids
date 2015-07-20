IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDevelopmentMeas_Sort_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDevelopmentMeas_Sort_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleDevelopmentMeas_Sort_UPDATE]
	@AmlMeasPomID UNIQUEIDENTIFIER,
	@AmlMeasHdrID UNIQUEIDENTIFIER,
	@PomSort INT,
	@MUser NVARCHAR(200),
	@MDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE pAMLMeasPOM SET SortId = @PomSort, MUser = @MUser, MDate = @MDate
	WHERE AmlMeasPomID = @AmlMeasPomID AND
	AmlMeasHdrID = @AmlMeasHdrID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03889', GetDate())
GO
