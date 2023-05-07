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
            if (Session["Admin"] != null) {
                var user = dbModel.Users.ToList();
                ViewBag.User = user.Count();
                var product = dbModel.Product.ToList();
                ViewBag.Product = product.Count();
                var cart = dbModel.Order.ToList();
                ViewBag.Cart = cart.Count() - 1;
                var response = dbModel.Response.ToList();
                ViewBag.Res = response.Count();
                var An = dbModel.Product.Where(x => x.CategoryId == 7);
                ViewBag.An = An.Count();
                var Tam = dbModel.Product.Where(x => x.CategoryId == 8);
                ViewBag.Tam = Tam.Count();
                var Khach = dbModel.Product.Where(x => x.CategoryId == 9);
                ViewBag.Khach = Khach.Count();
                var Ngu = dbModel.Product.Where(x => x.CategoryId == 10);
                ViewBag.Ngu = Ngu.Count();
                return View();
            }
            else
            {
                return Redirect("https://localhost:44353/Home/Login");
            }
        }
    }
}