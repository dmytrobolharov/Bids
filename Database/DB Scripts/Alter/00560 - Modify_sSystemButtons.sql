IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'sSystemButtons')
BEGIN

	DELETE FROM sSystemButtons

	------  Readd them
	------
	------
	------
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn.png', 'burn files', 'Icon_burncd.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add.gif', 'add', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_addAttribute.gif', 'add attribute', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_addcolor.gif', 'add color', 'icon_colorway.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_addMaterial.gif', 'add material', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_addquote.gif', 'add quote', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_addshowroom.gif', 'add showroom', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_addsize.gif', 'add size', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_addsizerange.gif', 'size range', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_addstyle.gif', 'add style', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_addTradepartner.gif', 'trade partner', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_addvendor.gif', 'vendor', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add_costing.gif', 'add costing', 'Icon_costing.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add_gray.gif', 'add', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add_small.gif', 'add', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_agentadd.gif', 'add agent', 'Icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_agentremove.gif', 'remove agent', 'Icon_delete.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_allocation.gif', 'allocation', 'icon_materialMulti.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_attachfile.gif', 'attach file', 'Icon_attach.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_autofit.gif', 'auto fit...', 'Icon_autoFormat.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_batch_update.gif', 'batch update', 'Icon_change.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_burnfile.gif', 'burn files', 'Icon_burncd.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_cal_day.gif', 'Day', 'Icon_day.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_cal_month.gif', 'Month', 'Icon_month.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_cal_week.gif', 'Week', 'Icon_week.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_cancel.gif', 'cancel', 'Icon_minus.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_carryover_add.gif', 'carry over', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_clearhistory.gif', 'clear history', 'Icon_minus.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_close.gif', 'close', 'Icon_close.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_collapse_all.gif', 'collapse all', 'Icon_folderDown.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_colorway.gif', 'colorway', 'icon_colorway.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_colorway_auto.gif', 'auto color', ' icon_colorway.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_color_folder.gif', 'color folder', 'Icon_color.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_color_rgb.gif', 'set RGB', 'Icon_colorwheel.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_comments.gif', 'comments', 'Icon_autoFormat.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_copy.gif', 'copy', 'Icon_copy.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_copyfrom.gif', 'copy from', 'Icon_copy.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_copy_small.gif', 'copy', 'Icon_copy.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_costing.gif', 'costing', 'Icon_costing.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_createimage.gif', 'create image', 'Icon_image.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_creatematerial.gif', 'create material', 'Icon_options.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_createstyle.gif', 'create style', 'Icon_options.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_create_pdf.gif', 'create...', 'Icon.pdf')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_customer.gif', 'customer', 'Team16.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_delete.gif', 'delete', 'Icon_delete.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_deletevariation.gif', 'variation', 'Icon_delete1.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_delMaterial.gif', 'delete material', 'Icon_delete.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_detailcomment.gif', 'detail comment', 'Icon_sample.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_devspec_update.gif', 'update dev spec', 'Icon_pending.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_done.gif', 'done!', 'Icon_update.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_download.gif', 'download', 'icon_folderDown.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_drop.gif', 'drop', 'Icon_drop.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_dropitem.gif', 'drop item', 'Icon_drop.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_dropsize.gif', 'drop size', 'Icon_down.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_edit.gif', 'edit', 'Icon_edit_file.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_edit_small.gif', 'edit', 'Icon_edit_file.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_email.gif', 'email', 'icon_mailsent.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_emailchange.gif', 'save & email', 'icon_mail_unread.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_expand_all.gif', 'expand all', 'icon_folderSelected.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_explode.gif', 'update grade rules', 'Icon_filegrid.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_explode1.gif', 'explode', 'Bomb.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_find.gif', 'find', 'Icon_magnify.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_fitcomment.gif', 'fit comment', 'Icon_sample.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_goto.gif', 'got to...', 'Icon_shortcut.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_graderulesedit.gif', 'edit grade rules', 'Icon_filegrid.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_graderulesrefresh.gif', 'refresh grade rules', 'Icon_refresh.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_graderulesupdate.gif', 'update grade rules', 'Icon_filegrid.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_group.gif', 'group', 'Icon_materialMulti.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_image.gif', 'image', 'Icon_image.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_image_edit.gif', 'edit image', 'icon_image_edit.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_image_link.gif', 'link image', 'Icon_link.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_image_select.gif', 'select image', 'Icon_image.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_issues.gif', 'issues', 'Icon_comment.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_LinePlan_Body_Alloc_Add.gif', 'add body', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_LinePlan_Color_Alloc_Add.gif', 'add color', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_lineplan_link.gif', 'link to lineplan', 'Icon_link.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_LinePlan_Material_Alloc_Add.gif', 'add material', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_link.gif', 'link', 'Icon_link.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_link_break.gif', 'break link', 'Icon_link.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_link_small.gif', 'link', 'Icon_link.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_lockfolder.gif', 'lock folder', 'Icon_lock32.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_log.gif', 'view log', 'Icon_bookopen.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_long.png', 'edit image', 'icon_image_edit.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_mostlikelyvendor.gif', 'most likely vendor', 'Icon_user_team.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_moveto.gif', 'move to...', 'icon_move.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_multicloth.gif', 'multi-cloth', 'Icon_filegrid.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_nav_down.gif', NULL, 'Icon_down.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_nav_first1.gif', NULL, 'Pg-first.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_nav_last1.gif', NULL, 'Pg-last.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_nav_next.gif', NULL, 'Pg-next.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_nav_prev.gif', NULL, 'Pg-prev.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_nav_up.gif', NULL, 'icon_release.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_new.gif', 'new', 'Icon_file.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_newstyle_add.gif', 'new style', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_newversion_add.gif', 'new version', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_new_task.gif', 'new task', 'Icon_newimage.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_next.gif', 'next...', 'Icon_arrow.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_no.gif', 'No', 'icon_reject.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_open.gif', 'open', 'Icon_open.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_openfile.gif', 'open file', 'icon_edit_file.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_openfolder.gif', 'open folder', 'Icon_folder_open.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_options.gif', 'options', 'Icon_fileline.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_password.gif', 'explode', 'Bomb.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pdf_off.gif', NULL, 'Icon_pdf_32.off.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pdf_on.gif', NULL, 'Icon_pdf_32.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pomlink.gif', 'link pom', 'Icon_related.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_add.gif', 'add pom', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_POM_break.gif', 'link image', 'Icon_link.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_critical.gif', 'critical pom', 'Icon_warning.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_delete.gif', 'delete pom', 'Icon_delete.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_library.gif', 'pom library', 'Icon_bookclose.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_linked.gif', 'linked pom', 'Icon_link.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_reconvert.gif', 'reconvert spec', 'Icon_refresh1.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_reconvert_gray.gif', 'reconvert spec', 'Icon_refresh1.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_remove.gif', 'remove pom', 'Icon_minus.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_template.gif', 'pom template', 'Icon_template.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_preview_pdf.gif', 'preview', 'Icon_pdf.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_print.gif', 'print', 'Icon_print.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_property_view.gif', 'view property', 'Icon_property.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_refresh.gif', 'refresh', 'Icon_refresh1.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_remove.gif', 'remove', 'Icon_minus.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_removecolor.gif', 'remove color', 'Icon_minus.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_removeMaterial.gif', 'remove material', 'Icon_delete.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_remove_color.gif', 'remove color', 'Icon_minus.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_replace_material.gif', 'replace material', 'Icon_refresh.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_reset_small.gif', 'reset', 'Icon_refresh1.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_rgb.gif', 'set rgb', 'Icon_colorwheel.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_samplesize.gif', 'sample size', 'Icon_edit_file.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_save.gif', 'save', 'Icon_save.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_save_all.gif', 'save all', 'Icon_save.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_save_close.gif', 'save & close', 'Icon_close_1.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_save_create.gif', 'save & create', 'icon_form_new.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_save_new.gif', 'save & new', 'icon_form_new.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_search.gif', 'search', 'Icon_magnify.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_search_small.gif', 'search', 'Icon_magnify.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_season.gif', 'season', 'Icon_season.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_seasonadd.gif', 'add season', 'Icon_season.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_select.gif', 'select', 'Icon_select.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_select_small.gif', 'select', 'Icon_shortcut.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_send.gif', 'send', 'icon_mailsent.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_settings.gif', 'settings', 'Icon_options.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_sizerange.gif', 'size range', 'Icon_edit_file.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_size_change.gif', 'change size', 'Icon_refresh.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_size_fix.gif', 'fix size', 'Icon_conflict.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_sketch.gif', 'mail...', 'Icon_mailRecipient.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_small.png', 'link', 'Icon_link.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_sort.gif', 'sort', 'Icon_sort.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_sourcing.gif', 'sourcing', 'icon_folder_globe.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_speccreate.gif', 'create spec', 'Icon_sample.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_spec_create.gif', 'create spec', 'icon_newimage.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_spec_remove.gif', 'remove spec', 'Icon_minus.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_status.gif', 'status', 'Icon_warning.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_status_hide.gif', 'hide status', 'icon_copyto.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_status_show.gif', 'show status', 'Icon_warning.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_styleset.gif', 'style set', 'Icon_edit_file.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_summary.gif', 'summary', 'Icon_documentMap.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_teamadd.gif', 'add team', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_techpack.gif', 'Tech Pack', 'Icon_package.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_template.gif', 'template', 'Icon_sample.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_template_add.gif', 'add template', 'icon_add.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_template_remove.gif', 'remove template', 'Icon_minus.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_template_select.gif', 'select template', 'Icon_shortcut.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_template_sort.gif', 'sort template', 'Icon_sort.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_tradepartner.gif', 'Trade Partner', 'Icon_globe.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_unlockfolder.gif', 'unlock folder', 'Icon_unlock32.png')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_update_flash.gif', 'update', 'Icon_warning.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_vendorquoteedit.gif', 'edit vendor quote', 'Icon_edit_file.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_vendor_replace.gif', 'replace vendor', 'Icon_refresh.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_view_tasks.gif', 'view tasks', 'Icon_task.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_wiz_back.gif', 'back', 'pg-prev.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_wiz_next.gif', 'next', 'Pg-next.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_workflow.gif', 'Workflow', 'Icon_options.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_yes.gif', 'Yes', 'Icon_update.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('button_100.png', NULL, NULL)
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('button_115.png', NULL, NULL)
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('button_85.png', NULL, NULL)

END
GO

----
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '560', GetDate())
GO
