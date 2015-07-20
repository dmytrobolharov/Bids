IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanning_pplanningtemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanning]'))
ALTER TABLE [dbo].[pPlanning] DROP CONSTRAINT [fk_pplanning_pplanningtemplate]
GO

ALTER TABLE [dbo].[pPlanning]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanning_pplanningtemplate] FOREIGN KEY([PlanningTemplateID])
REFERENCES [dbo].[pPlanningTemplate] ([PlanningTemplateId])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[pPlanning] CHECK CONSTRAINT [fk_pplanning_pplanningtemplate]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanning_pplanningtype]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanning]'))
ALTER TABLE [dbo].[pPlanning] DROP CONSTRAINT [fk_pplanning_pplanningtype]
GO

ALTER TABLE [dbo].[pPlanning]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanning_pplanningtype] FOREIGN KEY([PlanningTypeID])
REFERENCES [dbo].[pPlanningType] ([PlanningTypeID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[pPlanning] CHECK CONSTRAINT [fk_pplanning_pplanningtype]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningactivity_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningActivity]'))
ALTER TABLE [dbo].[pPlanningActivity] DROP CONSTRAINT [fk_pplanningactivity_pplanning]
GO

ALTER TABLE [dbo].[pPlanningActivity]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningactivity_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningActivity] CHECK CONSTRAINT [fk_pplanningactivity_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningactivity_pplanningactivitytype]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningActivity]'))
ALTER TABLE [dbo].[pPlanningActivity] DROP CONSTRAINT [fk_pplanningactivity_pplanningactivitytype]
GO

ALTER TABLE [dbo].[pPlanningActivity]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningactivity_pplanningactivitytype] FOREIGN KEY([PlanningActivityTypeID])
REFERENCES [dbo].[pPlanningActivityType] ([PlanningActivityTypeID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[pPlanningActivity] CHECK CONSTRAINT [fk_pplanningactivity_pplanningactivitytype]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningactivity_pseasonyear]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningActivity]'))
ALTER TABLE [dbo].[pPlanningActivity] DROP CONSTRAINT [fk_pplanningactivity_pseasonyear]
GO

ALTER TABLE [dbo].[pPlanningActivity]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningactivity_pseasonyear] FOREIGN KEY([SeasonYearID])
REFERENCES [dbo].[pSeasonYear] ([SeasonYearID])
GO

ALTER TABLE [dbo].[pPlanningActivity] CHECK CONSTRAINT [fk_pplanningactivity_pseasonyear]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningactivityview_pplanningactivity]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningActivityView]'))
ALTER TABLE [dbo].[pPlanningActivityView] DROP CONSTRAINT [fk_pplanningactivityview_pplanningactivity]
GO

ALTER TABLE [dbo].[pPlanningActivityView]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningactivityview_pplanningactivity] FOREIGN KEY([PlanningActivityID])
REFERENCES [dbo].[pPlanningActivity] ([PlanningActivityID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningActivityView] CHECK CONSTRAINT [fk_pplanningactivityview_pplanningactivity]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningbusiness_pbrand]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningBusiness]'))
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [fk_pplanningbusiness_pbrand]
GO

ALTER TABLE [dbo].[pPlanningBusiness]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningbusiness_pbrand] FOREIGN KEY([PlanningBrandID])
REFERENCES [dbo].[pBrand] ([CustomID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningBusiness] CHECK CONSTRAINT [fk_pplanningbusiness_pbrand]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningbusiness_icustom1]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningBusiness]'))
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [fk_pplanningbusiness_icustom1]
GO

ALTER TABLE [dbo].[pPlanningBusiness]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningbusiness_icustom1] FOREIGN KEY([PlanningDivisionID])
REFERENCES [dbo].[iCustom1] ([CustomID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningBusiness] CHECK CONSTRAINT [fk_pplanningbusiness_icustom1]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningbusiness_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningBusiness]'))
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [fk_pplanningbusiness_pplanning]
GO

ALTER TABLE [dbo].[pPlanningBusiness]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningbusiness_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningBusiness] CHECK CONSTRAINT [fk_pplanningbusiness_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningbusiness_pplanningfinancial]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningBusiness]'))
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [fk_pplanningbusiness_pplanningfinancial]
GO

ALTER TABLE [dbo].[pPlanningBusiness]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningbusiness_pplanningfinancial] FOREIGN KEY([PlanningFinancialID])
REFERENCES [dbo].[pPlanningFinancial] ([PlanningFinancialID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[pPlanningBusiness] CHECK CONSTRAINT [fk_pplanningbusiness_pplanningfinancial]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningbusiness_pseasonyear]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningBusiness]'))
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [fk_pplanningbusiness_pseasonyear]
GO

ALTER TABLE [dbo].[pPlanningBusiness]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningbusiness_pseasonyear] FOREIGN KEY([SeasonYearID])
REFERENCES [dbo].[pSeasonYear] ([SeasonYearID])
GO

ALTER TABLE [dbo].[pPlanningBusiness] CHECK CONSTRAINT [fk_pplanningbusiness_pseasonyear]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningbusiness_pstylecategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningBusiness]'))
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [fk_pplanningbusiness_pstylecategory]
GO

ALTER TABLE [dbo].[pPlanningBusiness]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningbusiness_pstylecategory] FOREIGN KEY([PlanningStyleCategoryID])
REFERENCES [dbo].[pStyleCategory] ([StyleCategoryId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningBusiness] CHECK CONSTRAINT [fk_pplanningbusiness_pstylecategory]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningbusiness_pstyletype]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningBusiness]'))
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [fk_pplanningbusiness_pstyletype]
GO

ALTER TABLE [dbo].[pPlanningBusiness]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningbusiness_pstyletype] FOREIGN KEY([PlanningStyleTypeID])
REFERENCES [dbo].[pStyleType] ([StyleTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningBusiness] CHECK CONSTRAINT [fk_pplanningbusiness_pstyletype]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningbusiness_psubcategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningBusiness]'))
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [fk_pplanningbusiness_psubcategory]
GO

ALTER TABLE [dbo].[pPlanningBusiness]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningbusiness_psubcategory] FOREIGN KEY([PlanningSubCategoryID])
REFERENCES [dbo].[pSubCategory] ([CustomID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningBusiness] CHECK CONSTRAINT [fk_pplanningbusiness_psubcategory]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningcolor_pcolorfolder]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningColor]'))
ALTER TABLE [dbo].[pPlanningColor] DROP CONSTRAINT [fk_pplanningcolor_pcolorfolder]
GO

ALTER TABLE [dbo].[pPlanningColor]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningcolor_pcolorfolder] FOREIGN KEY([ColorFolderID])
REFERENCES [dbo].[pColorFolder] ([ColorFolderID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[pPlanningColor] CHECK CONSTRAINT [fk_pplanningcolor_pcolorfolder]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningcolor_pcolorpalette]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningColor]'))
ALTER TABLE [dbo].[pPlanningColor] DROP CONSTRAINT [fk_pplanningcolor_pcolorpalette]
GO

ALTER TABLE [dbo].[pPlanningColor]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningcolor_pcolorpalette] FOREIGN KEY([ColorPaletteID])
REFERENCES [dbo].[pColorPalette] ([ColorPaletteID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[pPlanningColor] CHECK CONSTRAINT [fk_pplanningcolor_pcolorpalette]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningcolor_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningColor]'))
ALTER TABLE [dbo].[pPlanningColor] DROP CONSTRAINT [fk_pplanningcolor_pplanning]
GO

ALTER TABLE [dbo].[pPlanningColor]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningcolor_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningColor] CHECK CONSTRAINT [fk_pplanningcolor_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningcolor_pseasonyear]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningColor]'))
ALTER TABLE [dbo].[pPlanningColor] DROP CONSTRAINT [fk_pplanningcolor_pseasonyear]
GO

ALTER TABLE [dbo].[pPlanningColor]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningcolor_pseasonyear] FOREIGN KEY([SeasonYearID])
REFERENCES [dbo].[pSeasonYear] ([SeasonYearID])
GO

ALTER TABLE [dbo].[pPlanningColor] CHECK CONSTRAINT [fk_pplanningcolor_pseasonyear]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningconfig_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningConfig]'))
ALTER TABLE [dbo].[pPlanningConfig] DROP CONSTRAINT [fk_pplanningconfig_pplanning]
GO

ALTER TABLE [dbo].[pPlanningConfig]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningconfig_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningConfig] CHECK CONSTRAINT [fk_pplanningconfig_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningconfig_pseasonyear]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningConfig]'))
ALTER TABLE [dbo].[pPlanningConfig] DROP CONSTRAINT [fk_pplanningconfig_pseasonyear]
GO

ALTER TABLE [dbo].[pPlanningConfig]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningconfig_pseasonyear] FOREIGN KEY([SeasonYearID])
REFERENCES [dbo].[pSeasonYear] ([SeasonYearID])
GO

ALTER TABLE [dbo].[pPlanningConfig] CHECK CONSTRAINT [fk_pplanningconfig_pseasonyear]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningdivision_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningDivision]'))
ALTER TABLE [dbo].[pPlanningDivision] DROP CONSTRAINT [fk_pplanningdivision_pplanning]
GO

ALTER TABLE [dbo].[pPlanningDivision]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningdivision_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningDivision] CHECK CONSTRAINT [fk_pplanningdivision_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningdocument_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningDocument]'))
ALTER TABLE [dbo].[pPlanningDocument] DROP CONSTRAINT [fk_pplanningdocument_pplanning]
GO

ALTER TABLE [dbo].[pPlanningDocument]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningdocument_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningDocument] CHECK CONSTRAINT [fk_pplanningdocument_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningdocument_pseasonyear]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningDocument]'))
ALTER TABLE [dbo].[pPlanningDocument] DROP CONSTRAINT [fk_pplanningdocument_pseasonyear]
GO

ALTER TABLE [dbo].[pPlanningDocument]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningdocument_pseasonyear] FOREIGN KEY([SeasonYearID])
REFERENCES [dbo].[pSeasonYear] ([SeasonYearID])
GO

ALTER TABLE [dbo].[pPlanningDocument] CHECK CONSTRAINT [fk_pplanningdocument_pseasonyear]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Fk_pPlanningFlashEditQuickFillItemTemp_pPlanningFlashEditQuickFill]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningFlashEditQuickFillItemTemp]'))
ALTER TABLE [dbo].[pPlanningFlashEditQuickFillItemTemp] DROP CONSTRAINT [Fk_pPlanningFlashEditQuickFillItemTemp_pPlanningFlashEditQuickFill]
GO

ALTER TABLE [dbo].[pPlanningFlashEditQuickFillItemTemp]  WITH NOCHECK ADD  CONSTRAINT [Fk_pPlanningFlashEditQuickFillItemTemp_pPlanningFlashEditQuickFill] FOREIGN KEY([QuickFillID])
REFERENCES [dbo].[pPlanningFlashEditQuickFill] ([QuickFillID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningFlashEditQuickFillItemTemp] CHECK CONSTRAINT [Fk_pPlanningFlashEditQuickFillItemTemp_pPlanningFlashEditQuickFill]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanninghistory_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningHistory]'))
ALTER TABLE [dbo].[pPlanningHistory] DROP CONSTRAINT [fk_pplanninghistory_pplanning]
GO

ALTER TABLE [dbo].[pPlanningHistory]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanninghistory_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningHistory] CHECK CONSTRAINT [fk_pplanninghistory_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningitem_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningItem]'))
ALTER TABLE [dbo].[pPlanningItem] DROP CONSTRAINT [fk_pplanningitem_pplanning]
GO

ALTER TABLE [dbo].[pPlanningItem]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningitem_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningItem] CHECK CONSTRAINT [fk_pplanningitem_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningitem_pstylebomdimension]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningItem]'))
ALTER TABLE [dbo].[pPlanningItem] DROP CONSTRAINT [fk_pplanningitem_pstylebomdimension]
GO

ALTER TABLE [dbo].[pPlanningItem]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningitem_pstylebomdimension] FOREIGN KEY([StyleBOMDimensionID])
REFERENCES [dbo].[pStyleBOMDimension] ([StyleBOMDimensionID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[pPlanningItem] CHECK CONSTRAINT [fk_pplanningitem_pstylebomdimension]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningitem_pstyleheader]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningItem]'))
ALTER TABLE [dbo].[pPlanningItem] DROP CONSTRAINT [fk_pplanningitem_pstyleheader]
GO

ALTER TABLE [dbo].[pPlanningItem]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningitem_pstyleheader] FOREIGN KEY([StyleID])
REFERENCES [dbo].[pStyleHeader] ([StyleID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningItem] CHECK CONSTRAINT [fk_pplanningitem_pstyleheader]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningitem_pstyleseasonyear]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningItem]'))
ALTER TABLE [dbo].[pPlanningItem] DROP CONSTRAINT [fk_pplanningitem_pstyleseasonyear]
GO

ALTER TABLE [dbo].[pPlanningItem]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningitem_pstyleseasonyear] FOREIGN KEY([StyleSeasonYearID])
REFERENCES [dbo].[pStyleSeasonYear] ([StyleSeasonYearID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[pPlanningItem] CHECK CONSTRAINT [fk_pplanningitem_pstyleseasonyear]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanninglinelistconfig_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningLineListConfig]'))
ALTER TABLE [dbo].[pPlanningLineListConfig] DROP CONSTRAINT [fk_pplanninglinelistconfig_pplanning]
GO

ALTER TABLE [dbo].[pPlanningLineListConfig]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanninglinelistconfig_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningLineListConfig] CHECK CONSTRAINT [fk_pplanninglinelistconfig_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanninglinelistconfig_pseasonyear]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningLineListConfig]'))
ALTER TABLE [dbo].[pPlanningLineListConfig] DROP CONSTRAINT [fk_pplanninglinelistconfig_pseasonyear]
GO

ALTER TABLE [dbo].[pPlanningLineListConfig]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanninglinelistconfig_pseasonyear] FOREIGN KEY([SeasonYearID])
REFERENCES [dbo].[pSeasonYear] ([SeasonYearID])
GO

ALTER TABLE [dbo].[pPlanningLineListConfig] CHECK CONSTRAINT [fk_pplanninglinelistconfig_pseasonyear]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningmaterial_pmaterial]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningMaterial]'))
ALTER TABLE [dbo].[pPlanningMaterial] DROP CONSTRAINT [fk_pplanningmaterial_pmaterial]
GO

ALTER TABLE [dbo].[pPlanningMaterial]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningmaterial_pmaterial] FOREIGN KEY([MaterialID])
REFERENCES [dbo].[pMaterial] ([MaterialID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[pPlanningMaterial] CHECK CONSTRAINT [fk_pplanningmaterial_pmaterial]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningmaterial_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningMaterial]'))
ALTER TABLE [dbo].[pPlanningMaterial] DROP CONSTRAINT [fk_pplanningmaterial_pplanning]
GO

ALTER TABLE [dbo].[pPlanningMaterial]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningmaterial_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningMaterial] CHECK CONSTRAINT [fk_pplanningmaterial_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningmaterial_pseasonyear]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningMaterial]'))
ALTER TABLE [dbo].[pPlanningMaterial] DROP CONSTRAINT [fk_pplanningmaterial_pseasonyear]
GO

ALTER TABLE [dbo].[pPlanningMaterial]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningmaterial_pseasonyear] FOREIGN KEY([SeasonYearID])
REFERENCES [dbo].[pSeasonYear] ([SeasonYearID])
GO

ALTER TABLE [dbo].[pPlanningMaterial] CHECK CONSTRAINT [fk_pplanningmaterial_pseasonyear]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningseasonyear_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningSeasonYear]'))
ALTER TABLE [dbo].[pPlanningSeasonYear] DROP CONSTRAINT [fk_pplanningseasonyear_pplanning]
GO

ALTER TABLE [dbo].[pPlanningSeasonYear]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningseasonyear_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningSeasonYear] CHECK CONSTRAINT [fk_pplanningseasonyear_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningseasonyear_pseasonyear]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningSeasonYear]'))
ALTER TABLE [dbo].[pPlanningSeasonYear] DROP CONSTRAINT [fk_pplanningseasonyear_pseasonyear]
GO

ALTER TABLE [dbo].[pPlanningSeasonYear]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningseasonyear_pseasonyear] FOREIGN KEY([SeasonYearID])
REFERENCES [dbo].[pSeasonYear] ([SeasonYearID])
GO

ALTER TABLE [dbo].[pPlanningSeasonYear] CHECK CONSTRAINT [fk_pplanningseasonyear_pseasonyear]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningskuheader_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningSKUHeader]'))
ALTER TABLE [dbo].[pPlanningSKUHeader] DROP CONSTRAINT [fk_pplanningskuheader_pplanning]
GO

ALTER TABLE [dbo].[pPlanningSKUHeader]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningskuheader_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningSKUHeader] CHECK CONSTRAINT [fk_pplanningskuheader_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningskuheaderdimtype_pplanningskuheader]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningSKUHeaderDimType]'))
ALTER TABLE [dbo].[pPlanningSKUHeaderDimType] DROP CONSTRAINT [fk_pplanningskuheaderdimtype_pplanningskuheader]
GO

ALTER TABLE [dbo].[pPlanningSKUHeaderDimType]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningskuheaderdimtype_pplanningskuheader] FOREIGN KEY([PlanningSKUHeaderID])
REFERENCES [dbo].[pPlanningSKUHeader] ([PlanningSKUHeaderID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningSKUHeaderDimType] CHECK CONSTRAINT [fk_pplanningskuheaderdimtype_pplanningskuheader]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningstylecategorytosubcategory_division]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningStyleCategoryToSubCategory]'))
ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] DROP CONSTRAINT [fk_pplanningstylecategorytosubcategory_division]
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningstylecategorytosubcategory_division] FOREIGN KEY([PlanningDivisionID])
REFERENCES [dbo].[iCustom1] ([CustomID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] CHECK CONSTRAINT [fk_pplanningstylecategorytosubcategory_division]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningstylecategorytosubcategory_pbrand]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningStyleCategoryToSubCategory]'))
ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] DROP CONSTRAINT [fk_pplanningstylecategorytosubcategory_pbrand]
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningstylecategorytosubcategory_pbrand] FOREIGN KEY([PlanningBrandID])
REFERENCES [dbo].[pBrand] ([CustomID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] CHECK CONSTRAINT [fk_pplanningstylecategorytosubcategory_pbrand]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningstylecategorytosubcategory_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningStyleCategoryToSubCategory]'))
ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] DROP CONSTRAINT [fk_pplanningstylecategorytosubcategory_pplanning]
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningstylecategorytosubcategory_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] CHECK CONSTRAINT [fk_pplanningstylecategorytosubcategory_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningstylecategorytosubcategory_pseasonyear]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningStyleCategoryToSubCategory]'))
ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] DROP CONSTRAINT [fk_pplanningstylecategorytosubcategory_pseasonyear]
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningstylecategorytosubcategory_pseasonyear] FOREIGN KEY([SeasonYearID])
REFERENCES [dbo].[pSeasonYear] ([SeasonYearID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] CHECK CONSTRAINT [fk_pplanningstylecategorytosubcategory_pseasonyear]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningstylecategorytosubcategory_pstylecategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningStyleCategoryToSubCategory]'))
ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] DROP CONSTRAINT [fk_pplanningstylecategorytosubcategory_pstylecategory]
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningstylecategorytosubcategory_pstylecategory] FOREIGN KEY([PlanningStyleCategoryID])
REFERENCES [dbo].[pStyleCategory] ([StyleCategoryId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] CHECK CONSTRAINT [fk_pplanningstylecategorytosubcategory_pstylecategory]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningstylecategorytosubcategory_pstyletype]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningStyleCategoryToSubCategory]'))
ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] DROP CONSTRAINT [fk_pplanningstylecategorytosubcategory_pstyletype]
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningstylecategorytosubcategory_pstyletype] FOREIGN KEY([PlanningStyleTypeID])
REFERENCES [dbo].[pStyleType] ([StyleTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] CHECK CONSTRAINT [fk_pplanningstylecategorytosubcategory_pstyletype]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningstylecategorytosubcategory_psubcategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningStyleCategoryToSubCategory]'))
ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] DROP CONSTRAINT [fk_pplanningstylecategorytosubcategory_psubcategory]
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningstylecategorytosubcategory_psubcategory] FOREIGN KEY([SubCategoryID])
REFERENCES [dbo].[pSubCategory] ([CustomID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningStyleCategoryToSubCategory] CHECK CONSTRAINT [fk_pplanningstylecategorytosubcategory_psubcategory]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningtacalendar_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningTACalendar]'))
ALTER TABLE [dbo].[pPlanningTACalendar] DROP CONSTRAINT [fk_pplanningtacalendar_pplanning]
GO

ALTER TABLE [dbo].[pPlanningTACalendar]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningtacalendar_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningTACalendar] CHECK CONSTRAINT [fk_pplanningtacalendar_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningtacalendar_pseasonyear]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningTACalendar]'))
ALTER TABLE [dbo].[pPlanningTACalendar] DROP CONSTRAINT [fk_pplanningtacalendar_pseasonyear]
GO

ALTER TABLE [dbo].[pPlanningTACalendar]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningtacalendar_pseasonyear] FOREIGN KEY([SeasonYearID])
REFERENCES [dbo].[pSeasonYear] ([SeasonYearID])
GO

ALTER TABLE [dbo].[pPlanningTACalendar] CHECK CONSTRAINT [fk_pplanningtacalendar_pseasonyear]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pplanningtacalendar_ptacaltemplate]') AND parent_object_id = OBJECT_ID(N'[dbo].[pPlanningTACalendar]'))
ALTER TABLE [dbo].[pPlanningTACalendar] DROP CONSTRAINT [fk_pplanningtacalendar_ptacaltemplate]
GO

ALTER TABLE [dbo].[pPlanningTACalendar]  WITH NOCHECK ADD  CONSTRAINT [fk_pplanningtacalendar_ptacaltemplate] FOREIGN KEY([TACalTemplateID])
REFERENCES [dbo].[pTACalTemplate] ([TACalTemplateId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pPlanningTACalendar] CHECK CONSTRAINT [fk_pplanningtacalendar_ptacaltemplate]
GO




IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pstyleskuitem_pplanningskuheader]') AND parent_object_id = OBJECT_ID(N'[dbo].[pStyleSKUItem]'))
ALTER TABLE [dbo].[pStyleSKUItem] DROP CONSTRAINT [fk_pstyleskuitem_pplanningskuheader]
GO

ALTER TABLE [dbo].[pStyleSKUItem]  WITH NOCHECK ADD  CONSTRAINT [fk_pstyleskuitem_pplanningskuheader] FOREIGN KEY([PlanningSKUHeaderID])
REFERENCES [dbo].[pPlanningSKUHeader] ([PlanningSKUHeaderID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[pStyleSKUItem] CHECK CONSTRAINT [fk_pstyleskuitem_pplanningskuheader]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_plinefolder_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pLineFolder]'))
ALTER TABLE [dbo].[pLineFolder] DROP CONSTRAINT [fk_plinefolder_pplanning]
GO

ALTER TABLE [dbo].[pLineFolder]  WITH NOCHECK ADD  CONSTRAINT [fk_plinefolder_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[pLineFolder] CHECK CONSTRAINT [fk_plinefolder_pplanning]
GO



IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_pimagecatalog_pplanning]') AND parent_object_id = OBJECT_ID(N'[dbo].[pImageCatalog]'))
ALTER TABLE [dbo].[pImageCatalog] DROP CONSTRAINT [fk_pimagecatalog_pplanning]
GO

ALTER TABLE [dbo].[pImageCatalog]  WITH NOCHECK ADD  CONSTRAINT [fk_pimagecatalog_pplanning] FOREIGN KEY([PlanningID])
REFERENCES [dbo].[pPlanning] ([PlanningID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[pImageCatalog] CHECK CONSTRAINT [fk_pimagecatalog_pplanning]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08947', GetDate())
GO
