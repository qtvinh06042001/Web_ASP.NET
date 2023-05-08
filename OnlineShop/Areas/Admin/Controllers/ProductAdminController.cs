using OnlineShop.Context;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class ProductAdminController : Controller
    {
        // GET: Admin/ProductAdmin
        ShopEntities1 db = new ShopEntities1();

        #region Export
        [HttpPost]
        public ActionResult Export()
        {
            var gv = new GridView();
            gv.DataSource = this.db.Product.Select(n => new
            {
                Name = n.Name,
                Price = n.Price,
            }).OrderByDescending(p => p.Name).ToList();
            gv.DataBind();
            Response.Clear();
            Response.Buffer = true;
            //Response.AddHeader("content-disposition",
            // "attachment;filename=GridViewExport.xls");
            Response.Charset = "utf-8";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=Danh Sách Sản Phẩm.xls");
            //Mã hóa chữa sang UTF8
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.BinaryWrite(System.Text.Encoding.UTF8.GetPreamble());

            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            for (int i = 0; i < gv.Rows.Count; i++)
            {
                //Apply text style to each Row
                gv.Rows[i].Attributes.Add("class", "textmode");
            }
            //Add màu nền cho header của file excel
            gv.HeaderRow.BackColor = System.Drawing.Color.DarkBlue;
            //Màu chữ cho header của file excel
            gv.HeaderStyle.ForeColor = System.Drawing.Color.White;

            gv.HeaderRow.Cells[0].Text = "Tên";
            gv.HeaderRow.Cells[1].Text = "Giá";
            gv.RenderControl(hw);

            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
            var model = db.Product.OrderByDescending(p => p.Name)
                .ToList();
            return View("View", model);
        }
        #endregion

        #region Get

        [HttpGet]
        public IEnumerable<Product> GetAll()
        {
            return db.Product.ToList();
        }
        public ActionResult Index(string currentFilter, string SearchString, int? page)
        {
            if (Session["Admin"] != null)
            {
                var sp = new List<Product>();
                var countsp = GetAll().Count();
                ViewBag.count = countsp;
                if (SearchString != null)
                {
                    page = 1;
                }
                else
                {
                    SearchString = currentFilter;
                }
                if (!String.IsNullOrEmpty(SearchString))
                {
                    sp = db.Product.Include(b=>b.Category).Where(n => n.Name.Contains(SearchString)).ToList();
                }
                
                else
                {
                    sp = db.Product.Include(b=>b.Category).ToList();
                }
                ViewBag.CurrentFilter = SearchString;
                int pageSize = 3;
                int pageNumber = (page ?? 1);
                sp = sp.OrderByDescending(n => n.Id).ToList();
                return View(sp.ToPagedList(pageNumber, pageSize));
            }
            else
            {
                return Redirect("https://localhost:44353/Home/Login");
            }
            ViewBag.CategoryID = new SelectList(db.Category, "ID", "Name");
            return View();
        }
        #endregion

        #region Create
        [HttpGet]
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Category, "ID", "Name");
            return View();
        }
        [HttpPost]
        public ActionResult Create([Bind(Include = "ID,Name,Avatar,CategoryID,ShortDes,FullDescription,Price,ImageUpload")] Product sp)
        {
            try
            {
                {
                    string fileName = Path.GetFileNameWithoutExtension(sp.ImageUpload.FileName);
                    string extention = Path.GetExtension(sp.ImageUpload.FileName);
                    fileName = fileName + extention;
                    sp.Avatar = fileName;
                    sp.ImageUpload.SaveAs(Path.Combine(Server.MapPath("~/Content/images/"), fileName));
                }
                db.Product.Add(sp);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                ViewBag.Message = "Không thành công!";
            }
            ViewBag.CategoryID = new SelectList(db.Category, "ID", "Name", sp.CategoryId);
            return RedirectToAction("Index");
        }
        #endregion

        #region Detail
        [HttpGet]
        public ActionResult Details(int Id)
        {
            var sp = db.Product.Where(n => n.Id == Id).FirstOrDefault();
            return View(sp);
        }
        #endregion

        #region Delete
        [HttpGet]
        public ActionResult Delete(int Id)
        {
            var sp = db.Product.Where(n => n.Id == Id).FirstOrDefault();
            return View(sp);
        }
        [HttpPost]
        public ActionResult Delete(Product _sp)
        {
            var sp = db.Product.Where(n => n.Id == _sp.Id).FirstOrDefault();
            db.Product.Remove(sp);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        #endregion

        #region Edit
        [HttpGet]
        public ActionResult Edit(int Id)
        {
            ViewBag.CategoryID = new SelectList(db.Category, "ID", "Name");
            var sp = db.Product.Where(n => n.Id == Id).FirstOrDefault();
            return View(sp);
        }
        [HttpPost]
        public ActionResult Edit([Bind(Include = "ID,Name,Avatar,CategoryID,ShortDes,FullDescription,Price,ImageUpload")] Product sp, FormCollection form)
        {
            if (sp.ImageUpload != null)
            {

                string fileName = Path.GetFileNameWithoutExtension(sp.ImageUpload.FileName);
                string extention = Path.GetExtension(sp.ImageUpload.FileName);
                fileName = fileName + extention;
                sp.Avatar = fileName;
                sp.ImageUpload.SaveAs(Path.Combine(Server.MapPath("~/Content/images/"), fileName));
            }
            else
            {

                sp.Avatar = form["oldimage"];
            }
            db.Entry(sp).State = EntityState.Modified;
            db.SaveChanges();
            ViewBag.CategoryID = new SelectList(db.Category, "ID", "Name", sp.CategoryId);
            return RedirectToAction("Index");
            

        }
        #endregion
    }
}