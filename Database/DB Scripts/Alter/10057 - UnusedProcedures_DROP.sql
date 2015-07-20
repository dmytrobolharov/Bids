DECLARE @ReportName NVARCHAR(MAX)

SET @ReportName = '[dbo].[dpx_SeasonalFabricColorway_Tracking_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[dpx_StyleFolder_WorkflowUserToDoList_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_AHG_Style_Header_Image_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_AME_Costing_Rollup_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_AME_LineFolder_Image_4x0_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_AME_Material_Color_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_AME_Open_Art]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_BB_FashionBibleReport_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_BB_FashionBibleReport_Sub_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_BB_ImageCatalog_Customer_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_BB_ImageCatalog_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_BB_ImageCatalog_Single_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_CB_ImageCatalog_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_CB_ImageCatalog_Single_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_CB_LineFolder_Image_4x0_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_CB_LineFolder_MainMaterial_Active_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_CB_LineFolder_MainMaterial_Image_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_CB_LineFolder_MainMaterial_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_CHF_Material_Color_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_GH_Costing_Desktop_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_GH_LineFolder_Image_4x0_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_GH_PhotoSampleRequest_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_GH_SampleRequest_Tracking_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_GH_Style_DesignDetail_FirstImage_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_Request_For_Quote_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_Showroom_Alloc_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_Style_Header_Image_JPG_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_Style_SeasonalMaterialColorwayProd_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_Style_SeasonalMaterialColorwaySample_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_TBQ_Pkg_WhereUsed_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_TBQ_PkgStyle_DesignDetail_Image_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_TBQ_PkgStyle_Header_Image_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

SET @ReportName = '[dbo].[rpx_TBQ_PkgStyle_MaterialArtwork_SELECT]'
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ReportName) AND type in (N'P', N'PC'))
EXEC ('DROP PROCEDURE ' + @ReportName)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10057', GetUTCDate())
GO