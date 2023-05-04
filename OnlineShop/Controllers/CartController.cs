using Newtonsoft.Json.Linq;
using OnlineShop.Context;
using OnlineShop.Models;
using OnlineShop.Payment;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OnlineShop.Controllers
{
    public class CartController : Controller
    {
        // GET: Cart
        ShopEntities1 db = new ShopEntities1();
        public ActionResult Index()
        {
            if (Session["idUser"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            else {
                return View((List<Cart>)Session["cart"]);
            }
            
        }
        
        public ActionResult AddToCart(int id, int quantity)
        {
            if(Session["cart"] == null)
            {
                List<Cart> cart = new List<Cart>();
                cart.Add(new Cart { Product = db.Product.Find(id), Quantity = quantity });
                Session["cart"] = cart;
                Session["count"] = 1;
            }
            else
            {
                List<Cart> cart = (List<Cart>)Session["cart"];
                //Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
                int index = isExist(id);
                if(index != -1)
                {
                    //Nếu sản phẩm tồn tại trong giỏ hàng thì cộng thêm số lượng
                    cart[index].Quantity += quantity;
                }
                else
                {
                    //Nếu không tồn tại thì thêm vào giỏ hàng
                    cart.Add(new Cart { Product = db.Product.Find(id), Quantity = quantity });
                    //Tính lại số sản phẩm trong giỏ hàng
                    Session["count"] = Convert.ToInt32(Session["count"]) + 1;
                }
                Session["cart"] = cart;
            }
            return Json(new { Message = "Thành công", JsonRequestBehavior.AllowGet });
        }

        private int isExist(int id)
        {
            List<Cart> cart = (List<Cart>)Session["cart"];
            for(int i = 0; i < cart.Count; i++)
            {
                if (cart[i].Product.Id.Equals(id))
                {
                    return i;
                }
            }
            return -1;
        }
        public ActionResult Remove(int Id)
        {
            List<Cart> li = (List<Cart>)Session["cart"];
            li.RemoveAll(n => n.Product.Id == Id);
            Session["cart"] = li;
            Session["count"] = Convert.ToInt32(Session["count"]) - 1;
            return Json(new { Message = "Thành công", JsonRequestBehavior.AllowGet });
        }

        #region PaymentMoMo
        [HttpGet]
        public ActionResult Payment()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Payment(string Name, string Phone, string Address)
        {
            int tong = 0;
            if (Session["idUser"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            else
            {
                var lstCart = (List<Cart>)Session["cart"];
                Order objOrder = new Order();
                objOrder.Name = Name;
                objOrder.Phone = Phone;
                objOrder.Adress = Address;
                objOrder.UserId = int.Parse(Session["idUser"].ToString());
                objOrder.CreateOnUtc = DateTime.Now;
                objOrder.Status = 1;
                db.Order.Add(objOrder);
                db.SaveChanges();
                int intOrderId = objOrder.Id;
                List<OrderDetail> lstOrderDetail = new List<OrderDetail>();
                foreach (var item in lstCart)
                {
                    OrderDetail objOrderDetail = new OrderDetail();
                    objOrderDetail.Quantity = item.Quantity;
                    objOrderDetail.ProductId = item.Product.Id;
                    objOrderDetail.ProductName = item.Product.Name;
                    objOrderDetail.Price = item.Product.Price;
                    int gia = (int)objOrderDetail.Price;
                    int soluong = (int)objOrderDetail.Quantity;
                    int tien = gia * soluong;
                    tong = tong + tien;
                    objOrderDetail.OrderId = intOrderId;
                    lstOrderDetail.Add(objOrderDetail);
                }
                db.OrderDetail.AddRange(lstOrderDetail);
                db.SaveChanges();

                string endpoint = "https://test-payment.momo.vn/gw_payment/transactionProcessor";
                string partnerCode = "MOMOOJOI20210710";
                string accessKey = "iPXneGmrJH0G8FOP";
                string serectkey = "sFcbSGRSJjwGxwhhcEktCHWYUuTuPNDB";
                string orderInfo = "Thanh toán tiền hàng";
                string returnUrl = "https://localhost:44353/Cart/Success";
                string notifyurl = "https://4c8d-2001-ee0-5045-50-58c1-b2ec-3123-740d.ap.ngrok.io/Home/SavePayment"; //lưu ý: notifyurl không được sử dụng localhost, có thể sử dụng ngrok để public localhost trong quá trình test

                string amount = Convert.ToString(tong);
                string orderid = DateTime.Now.Ticks.ToString(); //mã đơn hàng
                string requestId = DateTime.Now.Ticks.ToString();
                string extraData = "";

                //Before sign HMAC SHA256 signature
                string rawHash = "partnerCode=" +
                    partnerCode + "&accessKey=" +
                    accessKey + "&requestId=" +
                    requestId + "&amount=" +
                    amount + "&orderId=" +
                    orderid + "&orderInfo=" +
                    orderInfo + "&returnUrl=" +
                    returnUrl + "&notifyUrl=" +
                    notifyurl + "&extraData=" +
                    extraData;

                MoMoSecurity crypto = new MoMoSecurity();
                //sign signature SHA256
                string signature = crypto.signSHA256(rawHash, serectkey);

                //build body json request
                JObject message = new JObject
            {
                { "partnerCode", partnerCode },
                { "accessKey", accessKey },
                { "requestId", requestId },
                { "amount", amount },
                { "orderId", orderid },
                { "orderInfo", orderInfo },
                { "returnUrl", returnUrl },
                { "notifyUrl", notifyurl },
                { "extraData", extraData },
                { "requestType", "captureMoMoWallet" },
                { "signature", signature }

            };

                string responseFromMomo = PaymentRequest.sendPaymentRequest(endpoint, message.ToString());

                JObject jmessage = JObject.Parse(responseFromMomo);
                lstCart.Clear();
                Session["count"] = 0;
                return Redirect(jmessage.GetValue("payUrl").ToString());
            }
        }

        #endregion

        #region PaymentCOD
        [HttpGet]
        public ActionResult PaymentCOD()
        {
            return View();
        }
        [HttpPost]
        public ActionResult PaymentCOD(string Name, string Phone, string Address)
        {
            int tong = 0;
            if (Session["idUser"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            else
            {
                var lstCart = (List<Cart>)Session["cart"];
                Order objOrder = new Order();
                objOrder.Name = Name;
                objOrder.Phone = Phone;
                objOrder.Adress = Address;
                objOrder.UserId = int.Parse(Session["idUser"].ToString());
                objOrder.CreateOnUtc = DateTime.Now;
                objOrder.Status = 0;
                db.Order.Add(objOrder);
                db.SaveChanges();
                int intOrderId = objOrder.Id;
                List<OrderDetail> lstOrderDetail = new List<OrderDetail>();
                foreach (var item in lstCart)
                {
                    OrderDetail objOrderDetail = new OrderDetail();
                    objOrderDetail.Quantity = item.Quantity;
                    objOrderDetail.ProductId = item.Product.Id;
                    objOrderDetail.ProductName = item.Product.Name;
                    objOrderDetail.Price = item.Product.Price;
                    int gia = (int)objOrderDetail.Price;
                    int soluong = (int)objOrderDetail.Quantity;
                    int tien = gia * soluong;
                    tong = tong + tien;
                    objOrderDetail.OrderId = intOrderId;
                    lstOrderDetail.Add(objOrderDetail);
                }
                db.OrderDetail.AddRange(lstOrderDetail);
                db.SaveChanges();
                lstCart.Clear();
                Session["count"] = 0;
            }
            return RedirectToAction("Success");
        }
        #endregion

        public ActionResult Success()
        {
            return View();
        }
    }
}