<%@ WebHandler Language="C#" Class="LocalImage" %>

using System;
using System.Web;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

public class LocalImage : IHttpHandler 
{
    private string path = string.Empty;
    //private string width = string.Empty;
    //private string height = string.Empty;
    private string sideLimit = string.Empty;
    
    public void ProcessRequest (HttpContext context)
    {
        path = context.Request.Params["p"];
        //width = context.Request.Params["w"];
        //height = context.Request.Params["h"];
        sideLimit = context.Request.Params["sl"];

        FileInfo fi = new FileInfo(path);
        
        if (!string.IsNullOrEmpty(path) && (fi.Extension.ToLower() == ".jpg" || fi.Extension.ToLower() == ".jpeg"))
        {
            Image img = Image.FromFile(path);
            Size sz = new Size();

            int biggerOrigSize = img.Height > img.Width ? img.Height : img.Width;

            if (!string.IsNullOrEmpty(sideLimit) && Convert.ToInt32(sideLimit) < biggerOrigSize)
            {
                if (img.Height > img.Width)
                {
                    sz.Width = Convert.ToInt32(Convert.ToInt32(sideLimit) * img.Width / img.Height);
                    sz.Height = Convert.ToInt32(sideLimit);
                }
                else 
                {
                    sz.Height = Convert.ToInt32(Convert.ToInt32(sideLimit) * img.Height / img.Width);
                    sz.Width = Convert.ToInt32(sideLimit);
                }
                  
            }
            /*
            else if (!string.IsNullOrEmpty(width))
            {
                sz.Height = Convert.ToInt32(Convert.ToInt32(width) * img.Height / img.Width);
                sz.Width = Convert.ToInt32(width);
            }
            else if (!string.IsNullOrEmpty(height))
            {
                sz.Width = Convert.ToInt32(Convert.ToInt32(height) * img.Width / img.Height);
                sz.Height = Convert.ToInt32(height);
            }
            */
            else
            {
                sz.Height = img.Height;
                sz.Width = img.Width;
            }
            
            string str = "w=" + sz.Width.ToString() + "\n h=" + sz.Height.ToString();

            MemoryStream ms = new MemoryStream();
            new Bitmap(img, sz).Save(ms, ImageFormat.Jpeg);
            byte[] bitmapData = ms.ToArray();

            TimeSpan refresh = new TimeSpan(0, 15, 0);
            context.Response.Cache.SetExpires(DateTime.Now.Add(refresh));
            context.Response.Cache.SetMaxAge(refresh);
            context.Response.Cache.SetCacheability(HttpCacheability.Public);
            context.Response.Cache.SetValidUntilExpires(true);
            
            context.Response.ContentType = "image/jpeg";
            context.Response.BinaryWrite(bitmapData);

            ms.Close();
            ms.Dispose();
            img.Dispose();
        } 
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}