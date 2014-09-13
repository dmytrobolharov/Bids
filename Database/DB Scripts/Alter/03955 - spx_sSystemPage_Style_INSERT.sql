
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	--Material
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Component.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Component.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Material_Add_List.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Material_Add_List.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Material_Add_Review.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Material_Add_Review.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Material_Add_Core_List.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Material_Add_Core_List.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Material_Add_New.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Material_Add_New.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	---------
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Material_Add_Image.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Material_Add_Image.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	--
	--	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Component_Summary.aspx')
	--BEGIN
	--	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	--	VALUES ('Style_Component_Summary.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	--END
	--GO
	
	--Measurments and main WF items
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_WorkFlowItems.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_WorkFlowItems.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_WorkFlowItemsEdit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_WorkFlowItemsEdit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_WorkflowItemNew.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_WorkflowItemNew.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Copy_Search.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Copy_Search.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Copy_WorkflowItem.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Copy_WorkflowItem.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	--
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_WorkFlowItemsSort.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_WorkFlowItemsSort.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DevelopmentMeas.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DevelopmentMeas.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_MeasPOMTemplate.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_MeasPOMTemplate.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DevelopmentMeas_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DevelopmentMeas_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Seasonal Colorway
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ColorwaySeason.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ColorwaySeason.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ColorwaySeason_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ColorwaySeason_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	--- Colorway
	
			IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Colorway.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Colorway.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Colorway_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Colorway_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Design Detail
			IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DesignDetail.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DesignDetail.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
			IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DesignDetail_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DesignDetail_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Care
			IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Care.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Care.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
			IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Care_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Care_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Artwork
			IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Image_Artwork.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Image_Artwork.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Text-Image
			IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DesignDetailForm.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DesignDetailForm.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
			IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DesignDetailForm_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DesignDetailForm_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
			IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Image_Item.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Image_Item.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Process Details
			IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ConstructionDetail.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ConstructionDetail.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
			IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ConstructionDetail_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ConstructionDetail_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Style-Marker

				IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Marker.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Marker.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
				IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Marker_New.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Marker_New.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	 -- Style-Model
					IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Model.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Model.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	--Bill Of Labor

				IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_BOL_List.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_BOL_List.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
				IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_BOL_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_BOL_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Dimensional BOM 
	
				IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DimensionalBOM_Read.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DimensionalBOM_Read.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
				IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Component_Material.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Component_Material.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
				IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DimensionalBOM_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DimensionalBOM_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
				IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DimensionalBOM_DimBOM.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DimensionalBOM_DimBOM.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
				IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DimensionalMultiBOMselect.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DimensionalMultiBOMselect.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
				IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DimensionalBOM_Colorway.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DimensionalBOM_Colorway.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DimensionalBOM_Costing.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DimensionalBOM_Costing.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Header
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Workflow
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Schedule.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Schedule.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Images menu
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Image_Summary.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Image_Summary.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	--Image where used
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_List_Search_ForImageWhereUsed.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_List_Search_ForImageWhereUsed.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Attachment menu
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Document_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Document_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Costing menu
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Costing.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Costing.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Costing_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Costing_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Share menu
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ShareMain.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ShareMain.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ShareAgentPage.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ShareAgentPage.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	
	-- Style Desktop
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_List_Search.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_List_Search.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_SavedSearch_List.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_SavedSearch_List.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_New.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_New.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Copy Style
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_New_Copy_Search.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_New_Copy_Search.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_New_Copy_Final.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_New_Copy_Final.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Main
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Main.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Main.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Variation  
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_SizeRange_Variation.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_SizeRange_Variation.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	--Revision
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Revision.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Revision.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Bill Of Labor v.2 
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_NBOL.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_NBOL.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_NBOL_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_NBOL_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Colorway Images
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ColorwaySeasonal_Image.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ColorwaySeasonal_Image.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ColorwaySeasonal_Image_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ColorwaySeasonal_Image_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Licensee
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Image_License.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Image_License.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Design Detail Custom

		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DesignDetail_Custom.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DesignDetail_Custom.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DesignDetail_Custom_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DesignDetail_Custom_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Design Image

		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DesignDetail_FrontBack_Image_View.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DesignDetail_FrontBack_Image_View.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DesignDetail_FrontBack_Image.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DesignDetail_FrontBack_Image.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Artwork Image 
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_MaterialArtwork_Image.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_MaterialArtwork_Image.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_MaterialArtwork_Image_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_MaterialArtwork_Image_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- DevelopmentSpec
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DevelopmentSpec.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DevelopmentSpec.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DevelopmentSpec_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DevelopmentSpec_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Graded Spec
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_GradedMeasurment.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_GradedMeasurment.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_GradedMeasurment_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_GradedMeasurment_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Collection Group
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ColorGroup.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ColorGroup.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_ColorGroup_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_ColorGroup_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Temp Graded Spec
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_GradedMeasurTemp.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_GradedMeasurTemp.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_GradedMeasurTemp_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_GradedMeasurTemp_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	
	-- Size Construction

	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DetailGrid.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DetailGrid.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_DetailGrid_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_DetailGrid_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- RFQ Folder
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Quote_GRID.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Quote_GRID.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Quote_New.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Quote_New.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Quote_Variation_Add.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Quote_Variation_Add.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_Quote_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_Quote_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	-- Quote Folder
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Style_QuoteGroup_Grid.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Style_QuoteGroup_Grid.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Style'))
	END
	GO
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03955', GetDate())
GO
	
		