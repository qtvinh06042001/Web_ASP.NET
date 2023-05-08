using OnlineShop.Context;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class CategoryAdminController : Controller
    {
        ShopEntities1 dbObj = new ShopEntities1();
        // GET: Admin/Category
        public ActionResult Index()
        {
            if (Session["Admin"] != null)
            {
                var lstCategory = dbObj.Category.ToList();
                return View(lstCategory);
            }
            else
            {
                return Redirect("https://localhost:44353/Home/Login");
            }
            
        }
        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(Category objCategory)
        {
            try
            {
                if (objCategory.ImageUpload != null)
                {
                    string fileName = Path.GetFileNameWithoutExtension(objCategory.ImageUpload.FileName);
                    string extention = Path.GetExtension(objCategory.ImageUpload.FileName);
                    fileName = fileName + extention;
                    objCategory.Avatar = fileName;
                    objCategory.ImageUpload.SaveAs(Path.Combine(Server.MapPath("~/Content/images/"), fileName));
                }
                dbObj.Category.Add(objCategory);
                dbObj.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                return RedirectToAction("Index");
            }
            
        }
        [HttpGet]
        public ActionResult Details(int Id)
        {
            var objCategory = dbObj.Category.Where(n => n.Id == Id).FirstOrDefault();
            return View(objCategory);
        }
        [HttpGet]
        public ActionResult Delete(int Id)
        {
            var objCategory = dbObj.Category.Where(n => n.Id == Id).FirstOrDefault();
            return View(objCategory);
        }
        [HttpPost]
        public ActionResult Delete(Category objCate)
        {
            var objCategory = dbObj.Category.Where(n => n.Id == objCate.Id).FirstOrDefault();
            dbObj.Category.Remove(objCategory);
            dbObj.SaveChanges();
            return RedirectToAction("Index");
        }
        [HttpGet]
        public ActionResult Edit(int Id)
        {
            var objCategory = dbObj.Category.Where(n => n.Id == Id).FirstOrDefault();
            return View(objCategory);
        }
        [HttpPost]
        public ActionResult Edit(Category objCategory, FormCollection form)
        {
                if (objCategory.Avatar != null)
                {
                    string fileName = Path.GetFileNameWithoutExtension(objCategory.ImageUpload.FileName);
                    string extention = Path.GetExtension(objCategory.ImageUpload.FileName);
                    fileName = fileName + extention;
                    objCategory.Avatar = fileName;
                    objCategory.ImageUpload.SaveAs(Path.Combine(Server.MapPath("~/Content/images/"), fileName));
                }
                else
                {
                    objCategory.Avatar = form["oldimage"];
                }
            dbObj.Entry(objCategory).State = EntityState.Modified;
            dbObj.SaveChanges();
            
            return RedirectToAction("Index");
            
        }
    }
}