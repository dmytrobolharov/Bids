IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Marker_4Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Marker_4Delete]
GO

Create PROC  [dbo].[spx_Style_Marker_4Delete]
	(
	 @StyleID uniqueidentifier,
	 @StyleSet int,
	 @Imperial nvarchar(2),
	 @SqlFilter NVARCHAR(MAX) = NULL,
	 @PageNo INT = NULL,
	 @PageSize INT = NULL,
	 @SortOrder NVARCHAR(MAX) = NULL
	)
	AS

	BEGIN
	DECLARE @sqlString  NVARCHAR(MAX)
	if Len(@Imperial)= 0

			begin

			select	ID, Marker_Code, Marker_Name,Marker_Description 
				,ISNULL(CAST(ROUND(Marker_Width, 4) AS NVARCHAR(20)), '') + ' IN' AS Width
				,ISNULL(CAST(ROUND(Marker_Length / 36, 4) AS NVARCHAR(20)), '') + ' YD' AS [Length]
		
				INTO #tmp0
				from pBodyMarker where StyleId =@StyleID AND StyleSet = @StyleSet and IsActive =1 
				group by  Marker_Name,Marker_Width, Marker_Length, ID,Marker_Code,Marker_Description
				set @sqlString = dbo.fnx_CreatePagingString('#tmp0',@PageNo,@PageSize,@SortOrder, @SqlFilter)
			end
		
		else
			begin
				select	ID, Marker_Code, Marker_Name,Marker_Description 			
				,ISNULL(CAST(ROUND(Marker_Width * 2.54, 4) AS NVARCHAR(20)), '') + ' CM' AS Width
				,ISNULL(CAST(ROUND((Marker_Length / 36) * 0.9144, 4) AS NVARCHAR(20)), '') + ' M' AS [Length]
	
			
				INTO #tmp1
				from pBodyMarker where StyleId =@StyleID AND StyleSet = @StyleSet and IsActive =1 
				group by Marker_Name,Marker_Width, Marker_Length, ID,Marker_Code,Marker_Description
				set @sqlString = dbo.fnx_CreatePagingString('#tmp1',@PageNo,@PageSize,@SortOrder, @SqlFilter)
			end	
		
		
	End
	exec sp_executesql @sqlString
	
	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09885', GetDate())
GO