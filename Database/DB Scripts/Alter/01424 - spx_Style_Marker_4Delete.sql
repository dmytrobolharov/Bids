IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Marker_4Delete]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Style_Marker_4Delete]
GO
/****** Object:  StoredProcedure [dbo].[spx_Style_Marker_4Delete]    Script Date: 03/28/2011 11:57:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROC  [dbo].[spx_Style_Marker_4Delete]
(
 @StyleID uniqueidentifier,
 @StyleSet int,
 @Imperial nvarchar(2)
)
AS

BEGIN
if Len(@Imperial)= 0

		begin

		select	ID, Marker_Code, Marker_Name,Marker_Description 
			,ISNULL(CAST(ROUND(Marker_Width, 4) AS NVARCHAR(20)), '') + ' IN' AS Width
	        ,ISNULL(CAST(ROUND(Marker_Length / 36, 4) AS NVARCHAR(20)), '') + ' YD' AS [Length]
		
		 
			from pBodyMarker where StyleId =@StyleID AND StyleSet = @StyleSet and IsActive =1 
			group by  Marker_Name,Marker_Width, Marker_Length, ID,Marker_Code,Marker_Description
			
		end
		
	else
		begin
			select	ID, Marker_Code, Marker_Name,Marker_Description 			
			,ISNULL(CAST(ROUND(Marker_Width * 2.54, 4) AS NVARCHAR(20)), '') + ' CM' AS Width
			,ISNULL(CAST(ROUND((Marker_Length / 36) * 0.9144, 4) AS NVARCHAR(20)), '') + ' M' AS [Length]
	
			
		 
			from pBodyMarker where StyleId =@StyleID AND StyleSet = @StyleSet and IsActive =1 
			group by Marker_Name,Marker_Width, Marker_Length, ID,Marker_Code,Marker_Description
			
		end
		
		
End
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01424', GetDate())

GO