IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CheckTechPackPageItemActive]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CheckTechPackPageItemActive]
GO

CREATE PROCEDURE [dbo].[spx_CheckTechPackPageItemActive](
	@ReportMapID UNIQUEIDENTIFIER,
	@ReportPageName NVARCHAR(200),
	@ReportFormName nVARCHAR(250),
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT
)
AS

DECLARE @Active AS INT = 1

IF @ReportFormName IN (
	'Style_DesignDetailGrid_Body_LLT',
	'Style_DesignDetailGrid_DesignDetail_Body_LLT',
	'Style_DesignDetailGrid_DesignDetailComments_Body_LLT')
	BEGIN
		IF (SELECT COUNT(*) FROM pStyleDetail WHERE StyleID = @StyleID AND (StyleSet = @StyleSet OR @StyleSet = 0)) = 0
			SET @Active = 0
	END

-- #01
--IF @ReportFormName IN (
--	'AEROPOSTALE_Style_DesignDetail_(Header_B)_Body_LLT',
--	'AEROPOSTALE_Style_DesignDetail_2_(Header_B)_Body_LLT')
--	BEGIN
--		IF (SELECT COUNT(*) FROM pStyleImageItem WHERE StyleID = @StyleID AND (StyleSet = @StyleSet OR @StyleSet = 0)) = 0
--			SET @Active = 0
--	END

SELECT @Active
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06938', GetDate())
GO
