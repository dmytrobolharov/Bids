

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sSystemButtons_SystemButtonID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sSystemButtons] DROP CONSTRAINT [DF_sSystemButtons_SystemButtonID]
END

GO

/****** Object:  Table [dbo].[sSystemButtons]    Script Date: 09/02/2010 21:40:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sSystemButtons]') AND type in (N'U'))
DROP TABLE [dbo].[sSystemButtons]
GO


/****** Object:  Table [dbo].[sSystemButtons]    Script Date: 09/02/2010 21:40:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[sSystemButtons](
	[SystemButtonID] [uniqueidentifier] NOT NULL,
	[ButtonIcon] [varchar](200) NULL,
	[ButtonType] [varchar](200) NULL,
	[DesignString] [nvarchar](50) NULL,
	[da_DK] [nvarchar](30) NULL,
	[de_DE] [nvarchar](30) NULL,
	[en_US] [nvarchar](30) NULL,
	[en_GB] [nvarchar](30) NULL,
	[en_CA] [nvarchar](30) NULL,
	[fr_FR] [nvarchar](30) NULL,
	[fr_CA] [nvarchar](30) NULL,
	[es_ES] [nvarchar](30) NULL,
	[es_MX] [nvarchar](30) NULL,
	[hi_IN] [nvarchar](30) NULL,
	[it_IT] [nvarchar](30) NULL,
	[ja_JA] [nvarchar](30) NULL,
	[ko_KR] [nvarchar](30) NULL,
	[nl_NL] [nvarchar](30) NULL,
	[pl_PL] [nvarchar](30) NULL,
	[pt_PT] [nvarchar](30) NULL,
	[pt_BR] [nvarchar](30) NULL,
	[ru_RU] [nvarchar](30) NULL,
	[sv_FI] [nvarchar](30) NULL,
	[sv_SE] [nvarchar](30) NULL,
	[tr_TR] [nvarchar](30) NULL,
	[zh_CHS] [nvarchar](30) NULL,
	[zh_CHT] [nvarchar](30) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_sSystemButtons] PRIMARY KEY CLUSTERED 
(
	[SystemButtonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[sSystemButtons] ADD  CONSTRAINT [DF_sSystemButtons_SystemButtonID]  DEFAULT (newsequentialid()) FOR [SystemButtonID]
GO

INSERT INTO sSystemButtons (DesignString) VALUES ('btn.png')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_add.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_addAttribute.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_addcolor.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_addMaterial.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_addquote.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_addshowroom.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_addsize.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_addsizerange.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_addstyle.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_addTradepartner.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_addvendor.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_add_costing.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_add_gray.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_add_small.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_agentadd.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_agentremove.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_allocation.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_attachfile.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_autofit.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_batch_update.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_burnfile.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_cal_day.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_cal_month.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_cal_week.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_cancel.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_carryover_add.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_clearhistory.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_close.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_collapse_all.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_colorway.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_colorway_auto.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_color_folder.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_color_rgb.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_comments.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_copy.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_copyfrom.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_copy_small.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_costing.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_createimage.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_creatematerial.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_createstyle.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_create_pdf.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_customer.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_delete.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_deletevariation.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_delMaterial.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_detailcomment.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_devspec_update.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_done.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_download.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_drop.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_dropitem.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_dropsize.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_edit.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_edit_small.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_email.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_emailchange.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_expand_all.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_explode.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_explode1.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_find.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_fitcomment.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_goto.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_graderulesedit.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_graderulesrefresh.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_graderulesupdate.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_group.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_image.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_image_edit.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_image_link.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_image_select.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_issues.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_LinePlan_Body_Alloc_Add.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_LinePlan_Color_Alloc_Add.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_lineplan_link.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_LinePlan_Material_Alloc_Add.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_link.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_link_break.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_link_small.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_lockfolder.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_log.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_long.png')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_mostlikelyvendor.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_moveto.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_multicloth.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_nav_down.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_nav_first1.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_nav_last1.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_nav_next.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_nav_prev.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_nav_up.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_new.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_newstyle_add.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_newversion_add.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_new_task.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_next.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_no.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_open.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_openfile.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_openfolder.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_options.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_password.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pdf_off.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pdf_on.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pomlink.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pom_add.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_POM_break.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pom_critical.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pom_delete.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pom_library.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pom_linked.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pom_reconvert.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pom_reconvert_gray.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pom_remove.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_pom_template.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_preview_pdf.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_print.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_property_view.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_refresh.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_remove.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_removecolor.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_removeMaterial.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_remove_color.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_replace_material.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_reset_small.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_rgb.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_samplesize.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_save.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_save_all.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_save_close.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_save_create.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_save_new.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_search.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_search_small.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_season.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_seasonadd.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_select.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_select_small.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_send.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_settings.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_sizerange.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_size_change.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_size_fix.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_sketch.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_small.png')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_sort.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_sourcing.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_speccreate.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_spec_create.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_spec_remove.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_status.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_status_hide.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_status_show.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_styleset.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_summary.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_teamadd.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_techpack.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_template.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_template_add.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_template_remove.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_template_select.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_template_sort.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_tradepartner.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_unlockfolder.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_update_flash.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_vendorquoteedit.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_vendor_replace.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_view_tasks.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_wiz_back.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_wiz_next.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_workflow.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('btn_yes.gif')
INSERT INTO sSystemButtons (DesignString) VALUES ('button_100.png')
INSERT INTO sSystemButtons (DesignString) VALUES ('button_115.png')
INSERT INTO sSystemButtons (DesignString) VALUES ('button_85.png')
GO
