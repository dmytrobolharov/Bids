UPDATE pBatchQueuePageType
SET BatchQueuepageXMLGridAlternating='BatchQ_StyleOneSeasonal_Image_Default.xml',
	BatchQueueGridAlternatingName='Thumbnail',
	BatchQueueGridXMLThumbnail='BatchQ_StyleOneSeasonal_Thumbnail.xml'
WHERE BatchQueuePageTypeID='44E5E4E3-DD70-E011-9039-8EF3DCCB61B4'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03651', GetDate())
GO