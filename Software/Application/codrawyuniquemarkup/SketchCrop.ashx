<%@ WebHandler Language="C#" Class="SketchExport" %>

using System;
using System.Web;
using System.IO;

public class SketchExport : IHttpHandler 
{
	private string fileData = string.Empty;
    private string croppedImage = string.Empty;
    private string imageName = Guid.NewGuid() + ".png";
    
    public void ProcessRequest (HttpContext context) 
    {
        try
        {
            croppedImage = context.Server.MapPath(".") + "\\cropped\\" + imageName;
            
			fileData = context.Request.Form["imageData"];

            byte[] filebytes = Convert.FromBase64String(fileData);

            using (FileStream fs = new FileStream(croppedImage, FileMode.OpenOrCreate, FileAccess.Write,FileShare.None))
            {
                fs.Write(filebytes, 0, filebytes.Length);
            }

            context.Response.Write(imageName);
        }
        catch (Exception ex)
        {
            context.Response.Write(ex.Message);
        }
    }
 
    public bool IsReusable 
    {
        get 
        {
            return false;
        }
    }

}