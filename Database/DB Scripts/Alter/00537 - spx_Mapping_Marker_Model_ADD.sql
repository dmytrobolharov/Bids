
/****** Object:  StoredProcedure [dbo].[spx_Mapping_Marker_Model_ADD]    Script Date: 10/06/2010 12:35:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Mapping_Marker_Model_ADD') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Mapping_Marker_Model_ADD
GO

CREATE PROC  [dbo].[spx_Mapping_Marker_Model_ADD]

AS
BEGIN

IF NOT EXISTS( SELECT * FROM Mapping WHERE Map = '11111111-0000-0000-0000-000000000003')
BEGIN
INSERT INTO [dbo].[Mapping]
           ([Map]
           ,[MapDetail]
           ,[MapUrl]
           ,[MapEditUrl]
		   ,[MapFolder])
     
     VALUES
           ('11111111-0000-0000-0000-000000000003'
           ,'Body - Pattern Sheet'
           ,'Body_PatternSheet.aspx'
           ,'Body_PatternSheet_Edit.aspx'
		   ,'Body Folder')
END   
-------------------------------------------------------------------------------------------
IF NOT EXISTS( SELECT * FROM Mapping WHERE Map = '11111111-0000-0000-0000-000000000004')
BEGIN
INSERT INTO [dbo].[Mapping]
           ([Map]
           ,[MapDetail]
           ,[MapUrl]
           ,[MapEditUrl] 
		   ,[MapFolder])
     
     VALUES
           ('11111111-0000-0000-0000-000000000004'
           ,'Body - Marker'
           ,'Body_Marker.aspx'
           ,'Body_Marker_Edit.aspx'
		   ,'Body Folder')
END
---------------------------------------------------------------------------------------------
IF NOT EXISTS( SELECT * FROM Mapping WHERE Map = '40000000-0000-0000-0000-000000000023')
BEGIN
INSERT INTO [dbo].[Mapping]
           ([Map]
           ,[MapDetail]
           ,[MapUrl]
           ,[MapEditUrl] 
		   ,[MapFolder])
     
     VALUES
           ('40000000-0000-0000-0000-000000000023'
           ,'Style-Marker'
           ,'Style_Marker.aspx'
           ,'Style_Marker_Edit.aspx'
		   ,'Style Folder')
END
---------------------------------------------------------------------------------------------
IF NOT EXISTS( SELECT * FROM Mapping WHERE Map = '40000000-0000-0000-0000-000000000037')
BEGIN
INSERT INTO [dbo].[Mapping]
           ([Map]
           ,[MapDetail]
           ,[MapUrl]
           ,[MapEditUrl] 
		   ,[MapFolder])
     
     VALUES
           ('40000000-0000-0000-0000-000000000037'
           ,'Style-Model'
           ,'Style_Model.aspx'
           ,'Style_Model_Edit.aspx'
		   ,'Style Folder')
END
---------------------------------------------------------------------------------------------
END
EXEC [dbo].[spx_Mapping_Marker_Model_ADD]
GO
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '537', GetDate())
GO
