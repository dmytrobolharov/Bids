IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_DN_Style_SizeConstructionGrid_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[rpx_DN_Style_SizeConstructionGrid_SELECT]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01462', GetDate())
GO