using OnlineShop.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class HomeAdminController : Controller
    {
        // GET: Admin/Home
        ShopEntities1 dbModel = new ShopEntities1();
        
        public ActionResult Index()
        {
            if(Session["Admin"]!=null){
                return View();
            }
            else
            {
                return Redirect("https://localhost:44353/Home/Login");
            }
        }
    }
}