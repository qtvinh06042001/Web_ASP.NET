using OnlineShop.Context;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineShop.Areas.Admin.Controllers
{
    public class OrderAdminController : Controller
    {
        // GET: Admin/OrderAdmin
        ShopEntities1 db = new ShopEntities1();

        #region Get
        public ActionResult Index()
        {
            if (Session["Admin"] != null)
            {
                var cus = db.Order.ToList();
                Order_OrderDetail obj = new Order_OrderDetail();
                obj.lstOrder = cus;
                return View(obj);
            }
            else
            {
                return Redirect("https://localhost:44353/Home/Login");
            }
            
        }
        #endregion

        #region Delete
        [HttpGet]
        public ActionResult Delete(int Id)
        {
            var cus = db.Order.Where(n => n.Id == Id).FirstOrDefault();
            return View(cus);
        }
        [HttpPost]
        public ActionResult Delete(Order order)
        {
            var cus = db.Order.Where(n => n.Id == order.Id).FirstOrDefault();
            db.Order.Remove(cus);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        #endregion

        #region Detail
        public ActionResult Details(Order order)
        {
            var objOrder = db.Order.Where(n => n.Id == order.Id).FirstOrDefault();
            var objOrderDetail = db.OrderDetail.Where(n => n.OrderId == order.Id).FirstOrDefault();
            var lstOrder = db.Order.ToList();
            var lstOrderDetail = db.OrderDetail.Where(n=>n.OrderId==order.Id).ToList();
            var lstproduct = db.Product.Where(n => n.Id == objOrderDetail.ProductId).ToList();
            Order_OrderDetail obj = new Order_OrderDetail();
            obj.objOrderDetail = objOrderDetail;
            obj.objOrder = objOrder;
            obj.lstOrder = lstOrder;
            obj.lstProduct = lstproduct;
            obj.lstOrderDetail = lstOrderDetail;
            return View(obj);
        }
        #endregion

        #region Export

        [HttpPost]
        public ActionResult Export()
        {
            var gv = new GridView();
            gv.DataSource = this.db.OrderDetail.Select(n => new
            {
                NameCus = n.Order.Name,
                Phone = "+"+ n.Order.Phone,
                Address = n.Order.Adress,
                Time = n.Order.CreateOnUtc,
                NameProduct = n.ProductName,
                Quantity = n.Quantity,
                Price = n.Price,
                Money = n.Quantity * n.Price
            }).OrderByDescending(p => p.Time).ToList();
            gv.DataBind();
            Response.Clear();
            Response.Buffer = true;
            //Response.AddHeader("content-disposition",
            // "attachment;filename=GridViewExport.xls");
            Response.Charset = "utf-8";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=Danh Sách Đơn.xls");
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

            gv.HeaderRow.Cells[0].Text = "Tên khách hàng";
            gv.HeaderRow.Cells[1].Text = "Số điện thoại";
            gv.HeaderRow.Cells[2].Text = "Địa chỉ";
            gv.HeaderRow.Cells[3].Text = "Thời gian đặt hàng";
            gv.HeaderRow.Cells[4].Text = "Tên sản phẩm";
            gv.HeaderRow.Cells[5].Text = "Số lượng";
            gv.HeaderRow.Cells[6].Text = "Giá";
            gv.HeaderRow.Cells[7].Text = "Thành tiền";
            gv.RenderControl(hw);

            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
            var model = db.OrderDetail.OrderByDescending(p => p.Order.CreateOnUtc)
                .ToList();
            return View("View", model);
        }
        #endregion
    }
}